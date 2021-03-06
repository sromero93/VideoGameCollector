//
//  VideoGameViewController.swift
//  VideoGameCollector
//
//  Created by Stephen Romero on 2/1/17.
//  Copyright © 2017 Stephen Romero. All rights reserved.
//

import UIKit

class VideoGameViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //allows for user to add a photo from their camera roll
    var imagePicker = UIImagePickerController()
    var game : Game? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //allows image picker to send picture to itself
        imagePicker.delegate = self

                
        if game != nil
        {
           gameImageView.image = UIImage(data: game!.image as! Data)
            titleTextField.text = game!.title
            print("We have a game")
            addupdatebutton.setTitle("Update", for: .normal)
        }
        else {
            
            deleteButton.isHidden = true
            print("We have no game")
        }
    }
    @IBAction func photoTapped(_ sender: Any)
    {
        //takes user to their pictures
      imagePicker.sourceType = .photoLibrary
        //grabs photo and goes back to app but doesnt do anything after
        present(imagePicker, animated: true, completion: nil)
        
    }
    //function that deals with the selected photo
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        //the image selected from the camera roll will then show up on the gameImageView
        gameImageView.image = image
        //goes back to image viewController
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func cameraTapped(_ sender: Any)
    {
        
        //takes user to their camera from the iphone
        imagePicker.sourceType = .camera
        //grabs photo and goes back to app but doesnt do anything after
        present(imagePicker, animated: true, completion: nil)

    }
    
    //image placeholder where the picture selected goes
    @IBOutlet weak var gameImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBOutlet weak var addupdatebutton: UIButton!
    
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    @IBAction func addTapped(_ sender: Any)
    {
        
        if game != nil
        {
            
            game!.title = titleTextField.text
            game!.image = UIImagePNGRepresentation(gameImageView.image!) as NSData!
           
        }
         else {
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //grabs the entities from the core data
       let game = Game(context: context)
        //lets user enter text for title of video game
        game.title = titleTextField.text
        game.image = UIImagePNGRepresentation(gameImageView.image!) as NSData!
        
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
   
    }
    
        
    @IBAction func deleteTapped(_ sender: Any)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(game!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        
        
    }
        
    
}

/**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */
 
 //tested working with MeshAlarm Arduino connected D1 mini


import processing.serial.*;
import processing.sound.*;

SoundFile lane1;
SoundFile lane2;
SoundFile start;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port
int x = 0;

void setup() 
{
  size(900, 500);
  //String portName = "/dev/ttyACM0";
  String portName = "/dev/ttyUSB0";
  myPort = new Serial(this, portName, 115200); 
  
    background(0, 255, 0);             // Set background to green
    myPort.write("a"); //set engaged
    println("Start");
    
    lane1 = new SoundFile(this, "LANE1.wav");
    lane2 = new SoundFile(this, "LANE2.wav");
    start = new SoundFile(this, "startEngines.wav");
    textSize(100);
   
}

void keyPressed(){
  if(key=='a'){
    
    //start.play();
}
}
void draw()
{
  
  if(mousePressed){
     //start.play();
    background(0, 255, 0);
    text("START", width/2-width/6, height/2);
    myPort.write("a"); //reset
    println("mouse");
    start.play();
   
  }
  //myPort.write("a");
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read(); // read it and store it in val
    println(val);
    if(val == 48){ //ascii 0
    background(255, 0, 0);
    text("WINNER: 1", width/2-width/6, height/2);
    lane1.play();
    //delay(100);
    //background(0, 255, 0);
    //myPort.write("a");
    
    //delay(1000); //doesn't work, why?
    //start.play();
    //background(0, 255, 0);
    //text("START", width/2-width/6, height/2);
  } else {
    background(0, 0, 255);
    text("WINNER: 2", width/2-width/6, height/2);
    lane2.play();
    //delay(100);
    //background(0, 255, 0);
    //myPort.write("a");
     
    //delay(1000);
    //start.play();
    //background(0, 255, 0);
    //text("START", width/2-width/6, height/2);
  }
  
  }
  
  //old code:
//  if (val == 0) {              // If the serial value is 0,
//    fill(0);                   // set fill to black
//  } 
//  else {      // If the serial value is not 0,
//    text(val, 10, x);
//    x=x+10;
//    
//    if(x>height){
//      background(255, 0, 0);
//      x=0;
//    }
//    //fill(204);                 // set fill to light gray
//  }
//  //rect(50, 50, 100, 100);
}



/*

// Wiring / Arduino Code
// Code for sensing a switch status and writing the value to the serial port.

int switchPin = 4;                       // Switch connected to pin 4

void setup() {
  pinMode(switchPin, INPUT);             // Set pin 0 as an input
  Serial.begin(9600);                    // Start serial communication at 9600 bps
}

void loop() {
  if (digitalRead(switchPin) == HIGH) {  // If switch is ON,
    Serial.write(1);               // send 1 to Processing
  } else {                               // If the switch is not ON,
    Serial.write(0);               // send 0 to Processing
  }
  delay(100);                            // Wait 100 milliseconds
}

*/

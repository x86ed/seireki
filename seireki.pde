int ACPin = 9;    // LED connected to digital pin 9
int DCPin = 11;
char incomingByte;
boolean acInput = false;
boolean dcInput = false;
char acVal[4] = {'0','0','0','\0'};
char dcVal[4] = {'0','0','0','\0'};
int valIndex =0;

int AC = 0;
int DC = 0;

int intFromChar(char* missingImportantShit){
  int length = 3;
  int result = 0;
  for(int i = 0; i < length; i ++){
    int factor  = 0;
    switch(missingImportantShit[i]){
    case 48: factor = 0; break;
    case 49: factor = 1; break;
    case 50: factor = 2; break;
    case 51: factor = 3; break;
    case 52: factor = 4; break;
    case 53: factor = 5; break;
    case 54: factor = 6; break;
    case 55: factor = 7; break;
    case 56: factor = 8; break;
    case 57: factor = 9; break;
    case 65: factor = 10; break;
    case 66: factor = 11; break;
    case 67: factor = 12; break;
    case 68: factor = 13; break;
    case 69: factor = 14; break;
    case 70: factor = 15; break;
    case 97: factor = 10; break;
    case 98: factor = 11; break;
    case 99: factor = 12; break;
    case 100: factor = 13; break;
    case 101: factor = 14; break;
    case 102: factor = 15; break;
    }
    result = result + (factor * pow(10,(length-1)-i ));
  }
  return result;
}

void setup(){
  Serial.begin(9600);
  pinMode(ACPin, OUTPUT);  
  pinMode(DCPin, OUTPUT);  
}

void loop()  {
  
if (Serial.available() > 0) {
		// read the incoming byte:
		incomingByte = Serial.read();
                if(acInput || dcInput){
                  if(int(incomingByte) > 47 && int(incomingByte) < 58){
                    if(valIndex < 3){
                      if(acInput){
                        acVal[valIndex] = char(incomingByte);
                      }
                       if(dcInput){
                        dcVal[valIndex] = char(incomingByte)
                        ;
                      }
                      valIndex ++;
                    }
                    if(valIndex >=3)
                    {
                      
                      if(acInput){
                        AC = intFromChar(acVal);
                        if(AC > 255){
                          AC = 255;
                        }
                        if(AC < 0){
                          AC= 0;
                        }
                        Serial.print("AC==>");
                        Serial.println(AC);
                        acInput = false;
                      }
                      if(dcInput){
                        DC =  intFromChar(dcVal);
                        ;
                        if(DC > 255){
                          DC = 255;
                        }
                        if(DC < 0){
                          DC= 0;
                        }
                        Serial.print("DC==>");
                        Serial.println(DC);
                        dcInput = false;
                      }
                      valIndex = 0;
                    }
                    
                  }
                }
                
                if (incomingByte == 97){            //detects ac input with "a"
                  Serial.println("AC input");
                  acInput = true;
                }
                 if (incomingByte == 100){          //detects dc input with "d"
                  Serial.println("DC input");
                  dcInput = true;
                }
                 if (incomingByte == 98){          //detects dual input with "b"
                  Serial.println("Dual input");
                  acInput = true;
                  dcInput = true;
                }
		// say what you got:
	}

 analogWrite(ACPin, AC);//2 seems to be the floor for the ac bulb
 analogWrite(DCPin, DC);//28 seems to be the floor for the flaslight bulb
}



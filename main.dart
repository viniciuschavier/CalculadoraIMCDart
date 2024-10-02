import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  String _resultado = "";

  void _reset() {
    pesoController.text = "";
    alturaController.text = "";

    setState(() {
      _resultado = "";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calcularImc() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text);

      double imc = peso / (altura * altura);
      String imcFormatado = imc.toStringAsFixed(2);
      if (imc < 16) {
        _resultado = 'IMC: $imcFormatado Abaixo do peso';
      } else if (imc > 16 && imc < 17) {
        _resultado = 'IMC: $imcFormatado Magreza Moderada';
      } else if (imc > 17 && imc < 18.5) {
        _resultado = 'IMC: $imcFormatado Magreza Leve';
      } else if (imc > 18.5 && imc < 25) {
        _resultado = 'IMC: $imcFormatado Saudável';
      } else if (imc > 25 && imc < 30) {
        _resultado = 'IMC: $imcFormatado Sobrepeso';
      } else if (imc > 30 && imc < 35) {
        _resultado = 'IMC: $imcFormatado Obesidade grau I';
      } else if (imc > 35 && imc < 40) {
        _resultado = 'IMC: $imcFormatado Obesidade grau II';
      } else if (imc >= 40) {
        _resultado = 'IMC: $imcFormatado Obesidade grau III';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora de IMC",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _reset();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 150.0, 10.0, 0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: pesoController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe o Peso (kg)";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Peso (kg)",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black, fontSize: 26.0),
              ),
              TextFormField(
                controller: alturaController,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe a altura";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Altura (m)",
                  labelStyle: TextStyle(color: Colors.black),
                ),
                style: TextStyle(color: Colors.black, fontSize: 26.0),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Container(
                  height: 40.0,
                  child: ElevatedButton(
                    child: Text(
                      "Calcular IMC",
                      style: TextStyle(
                          color: Colors.lightBlue[900], fontSize: 15.0),
                    ),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calcularImc();
                      }
                    },
                  ),
                ),
              ),
              Text(_resultado,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 22.0))
            ],
          ),
        ),
      ),
    );
  }
}

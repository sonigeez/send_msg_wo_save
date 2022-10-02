import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String countryCode = '+91';

  void _launchUrl(url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String mobileNumber = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Direct Message'),
        centerTitle: true,
        backgroundColor: const Color(0xff075E55),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Mobile Number',
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (String val) {
                        setState(() {
                          mobileNumber = val;
                        });
                      },
                      validator: (String? value) {
                        if (value == null ||
                            value.isEmpty ||
                            !isNumeric(value) ||
                            value.length < 10) {
                          return 'Please enter a valid phone number';
                        }
                        if (value.isEmpty ||
                            !isNumeric(value) ||
                            value.length > 10) {
                          return 'Please remove Country Code';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 35),
                    ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff075E55)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10))),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;
                          final Uri whatsappUrl = Uri.parse(
                              'https://wa.me/$countryCode$mobileNumber');
                          _launchUrl(whatsappUrl);
                        },
                        icon: const FaIcon(FontAwesomeIcons.whatsapp),
                        label: const Text('Open WhatsApp chat')),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            const Text("Made with ❤️ by Bharat")
          ],
        ),
      ),
    );
  }
}

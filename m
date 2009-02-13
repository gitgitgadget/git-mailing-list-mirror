From: Jordi Bunster <jordi@bunster.org>
Subject: git status "short circuit"?
Date: Fri, 13 Feb 2009 12:34:50 -0500
Message-ID: <BF509531-D8A4-4F5F-894F-735252AA4C26@bunster.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; boundary=Apple-Mail-3-688736372; micalg=sha1; protocol="application/pkcs7-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 18:36:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY1xe-0004rj-SV
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 18:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbZBMRey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 12:34:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbZBMRey
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 12:34:54 -0500
Received: from an-out-0708.google.com ([209.85.132.251]:28009 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbZBMRex (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 12:34:53 -0500
Received: by an-out-0708.google.com with SMTP id c2so706052anc.1
        for <git@vger.kernel.org>; Fri, 13 Feb 2009 09:34:51 -0800 (PST)
Received: by 10.100.136.15 with SMTP id j15mr1386101and.129.1234546491699;
        Fri, 13 Feb 2009 09:34:51 -0800 (PST)
Received: from ?IPv6:::1? (bunster.org [75.127.72.230])
        by mx.google.com with ESMTPS id b7sm2229075ana.39.2009.02.13.09.34.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Feb 2009 09:34:51 -0800 (PST)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109764>


--Apple-Mail-3-688736372
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

I have a prompt snippet that shows me if there's something staged/ 
changed/untracked (as different characters).

It parses the output of git status. Since I don't really need to know  
*all* that is staged/dirty/untracked, I was wondering if there's  
something faster I could use. Something that stops at the first  
occurrence of each category, perhaps.

Any ideas?

P.S.: I'm not subscribed, please Cc.

--
	Jordi


--Apple-Mail-3-688736372
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIID0zCCA88w
ggK3oAMCAQICBTFBkKucMA0GCSqGSIb3DQEBBQUAMIGCMQswCQYDVQQGEwJVUzEeMBwGA1UECxMV
d3d3LnhyYW1wc2VjdXJpdHkuY29tMSQwIgYDVQQKExtYUmFtcCBTZWN1cml0eSBTZXJ2aWNlcyBJ
bmMxLTArBgNVBAMTJFhSYW1wIEdsb2JhbCBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0wODEx
MTYwMzIwMDlaFw0wOTExMTYwMzIwMDlaMGYxIDAeBgkqhkiG9w0BCQEWEWpvcmRpQGJ1bnN0ZXIu
b3JnMRYwFAYDVQQDEw1Kb3JkaSBCdW5zdGVyMRAwDgYDVQQHEwdEZWNhdHVyMQswCQYDVQQIEwJH
QTELMAkGA1UEBhMCVVMwgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMJEsMRTHaw0UEdnHCIA
unjp4UcH4CidS6MTp+Lsux5EKJOc+UWCrOt+AInizQWcwLDlWu27lSp48czqujiAE5kQNZehpRU3
Ffp8lr/fswDuQkNz72DQWCV/2HTflGPhJHFaK7l3yYSHJqEHo7aPMvevxJgkg/QmbdqDfy27DCQz
AgMBAAGjgeowgecwCQYDVR0TBAIwADAdBgNVHQ4EFgQULxnaMqxm4qKu0Zjh15AupFBvwe0wHwYD
VR0jBBgwFoAUxk+iPQZjhAmczmLkBKyNXLXpthswCwYDVR0PBAQDAgWgMBMGA1UdJQQMMAoGCCsG
AQUFBwMEMDQGA1UdHwQtMCswKaAnoCWGI2h0dHA6Ly9jcmwuc2VjdXJldHJ1c3QuY29tL1hHQ0Eu
Y3JsMEIGA1UdIAQ7MDkwNwYKYIZIAYb9ZAICATApMCcGCCsGAQUFBwIBFhtodHRwOi8vc3NsLnRy
dXN0d2F2ZS5jb20vQ0EwDQYJKoZIhvcNAQEFBQADggEBAIcs50dxR109cYiyo1MtsOIOOb4tQpEN
8dwmZfFHGbXSivm0bNWSNOem/BfLeEuFxFk05RHAJw9SFlMoH+OnyIxI6kjeh3WTfCROskHof85H
XP9G05mA5Mr4qRzkYxi5hAsBWDebRd11Mr2+3IfcxFWLFb7X3blj6BZS5ey7ymoego6j5FCStdG5
fIU7AHOjVlb3yVt2W6WJC8sd0XxC2apEgShTW2M2H7txoFyCV3zk7UXsLxdS1EU9gHgaqDfyx9Sh
I5H07b/TsT8JguFxrCVoYxX6XizGVIe9JR91ASVQd7blJMrELu6rCDpjb0MyMVocEsOTOOAJushy
dPXZQJMxggLWMIIC0gIBATCBjDCBgjELMAkGA1UEBhMCVVMxHjAcBgNVBAsTFXd3dy54cmFtcHNl
Y3VyaXR5LmNvbTEkMCIGA1UEChMbWFJhbXAgU2VjdXJpdHkgU2VydmljZXMgSW5jMS0wKwYDVQQD
EyRYUmFtcCBHbG9iYWwgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkCBTFBkKucMAkGBSsOAwIaBQCg
ggGfMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA5MDIxMzE3MzQ1
MFowIwYJKoZIhvcNAQkEMRYEFIkXukfvKX4KI/Nb7iTjtPVoSnC+MIGdBgkrBgEEAYI3EAQxgY8w
gYwwgYIxCzAJBgNVBAYTAlVTMR4wHAYDVQQLExV3d3cueHJhbXBzZWN1cml0eS5jb20xJDAiBgNV
BAoTG1hSYW1wIFNlY3VyaXR5IFNlcnZpY2VzIEluYzEtMCsGA1UEAxMkWFJhbXAgR2xvYmFsIENl
cnRpZmljYXRpb24gQXV0aG9yaXR5AgUxQZCrnDCBnwYLKoZIhvcNAQkQAgsxgY+ggYwwgYIxCzAJ
BgNVBAYTAlVTMR4wHAYDVQQLExV3d3cueHJhbXBzZWN1cml0eS5jb20xJDAiBgNVBAoTG1hSYW1w
IFNlY3VyaXR5IFNlcnZpY2VzIEluYzEtMCsGA1UEAxMkWFJhbXAgR2xvYmFsIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5AgUxQZCrnDANBgkqhkiG9w0BAQEFAASBgC2S0iDpOWobs5rSLKra2aq0YHyH
F5P+n/M/0pm9/8rij0qrQSVF8VH2YWsCQTaibGwoXwIu6OqOexpF7qIHZhonnWrZm9vnnx7ny2al
f9ccIeZmFBfVoP9EQAy31JFBU+iZaMWMLyXYQqM8q4K6PuX1lCgdn8t2daSCcqLO3Qb7AAAAAAAA

--Apple-Mail-3-688736372--

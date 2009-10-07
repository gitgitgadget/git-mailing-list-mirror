From: Lars Rasmusson <Lars.Rasmusson@sics.se>
Subject: gitweb calls the project ".git"
Date: Wed, 7 Oct 2009 18:31:48 +0200
Message-ID: <E66B0797-4EF0-49FC-AA01-8FD4C884A7E9@sics.se>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: multipart/signed; boundary=Apple-Mail-24--399482135; micalg=sha1; protocol="application/pkcs7-signature"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 07 18:37:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvZW4-0003r7-2V
	for gcvg-git-2@lo.gmane.org; Wed, 07 Oct 2009 18:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934311AbZJGQc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Oct 2009 12:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934308AbZJGQc7
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Oct 2009 12:32:59 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:2132 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934309AbZJGQc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Oct 2009 12:32:58 -0400
Received: by ey-out-2122.google.com with SMTP id 4so1062414eyf.19
        for <git@vger.kernel.org>; Wed, 07 Oct 2009 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:from:to
         :content-type:mime-version:subject:date:x-mailer;
        bh=mJEQY6JFLY8xcutS+HhXUUqDE2mwR45n7KQPvWAgnZU=;
        b=LwCABvU36OtmF0s3rTdCbXcF3Dxqa0G2EDv0txUBMI8HBlxmILzr2+3B/wSdEYwLY1
         XeI0pmeAlbjjv50ni7voRnWIfSE9E2ThESrUdDChp1bHun9TFEq6Eq14LkhXE3uZXKvQ
         AMsn0+yvKSYGas6dE48UHI+gKmqqxSjd40tIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:from:to:content-type:mime-version:subject:date
         :x-mailer;
        b=f6A0C2c10QriaUXHnO/r99mG1HpQZO4MKcDlLGDSTxxxQoxrqLycrdOurXSlvHGMpx
         GRiFACGwuX6qKgGLtL7cnPnHeZxKA1KQoq4pbkDgwVuGbDs48+uNMDj/rfKHeFIZaHaO
         g0sfBBjRoJHr/pr5WTA6ADBZhZe56sNEyS010=
Received: by 10.216.86.195 with SMTP id w45mr38507wee.82.1254933110802;
        Wed, 07 Oct 2009 09:31:50 -0700 (PDT)
Received: from stolichnaya.sics.se (stolichnaya.sics.se [193.10.67.151])
        by mx.google.com with ESMTPS id 5sm446897eyh.24.2009.10.07.09.31.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Oct 2009 09:31:50 -0700 (PDT)
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129650>


--Apple-Mail-24--399482135
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Hi, I am serving a repository with "git instaweb".

In the web browser, the name in the Project column is only ".git", and  
not the "myrepo.git"
which I would like to have, and as it is on http://repo.or.cz/ (which  
is a site that also uses gitweb).

How do I configure it to serve the project directory (or even better,  
all the repos in a directory), and name them appropriately?

(Is it possible to do with instaweb, or can it only be done with a  
more heavy approach like using apache?)

Thanks for any quick ideas, cheers,
/Lars




--Apple-Mail-24--399482135
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGLTCCAuYw
ggJPoAMCAQICEHxQzrd/wmpu5XNt+Exr06AwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA5MDUyMTIxMDk1N1oXDTEwMDUyMTIxMDk1
N1owSDEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjElMCMGCSqGSIb3DQEJARYWTGFy
cy5SYXNtdXNzb25Ac2ljcy5zZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALbaCI0C
5h6nNrpxTiHL0a3o4jnTDqIgqSek24kZWnWtvJ2pEDLilPFfMdAn/gHWj85nqZIBrFbsO335Jk2w
1a1eB50F79uH4SQI15nPH5vYHf/4oE7xWcryaQOApaNbx/R50AKpKdk8XoctpoyTHdeIyv0VyTbw
caVP8Y+w1zxBJrGA0rScLIlYNiOh997SSiFbGTea+IIK44P2+1/AfqkGc+B2V5nQZiyuG5uRUB3o
ea7KD6Wd/LwuSHQT8AEb91KVYMqH+bJVgcNJ0SS8jZ5KCRp0z/xuYs2xaqdV22mZgaZzhkorixKW
mGgioBGPfXtme6sXT3IelWXSAO26/KkCAwEAAaMzMDEwIQYDVR0RBBowGIEWTGFycy5SYXNtdXNz
b25Ac2ljcy5zZTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBAGww2079DNWT6Hfz32jV
oO4P9hYYayvfdxHlSqz0tw7cu+ce67C4Pxm5HAb+NkS6FQkmrlzylXAU/wVArJ+w1aQJy/DFeUaa
HgameI6Zct4uklxapU61m65CIML3WIBADprmZ1EXwRtc/btUrQsTup1rvXt1pwdCii5+4oltLkby
MIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkExFTATBgNVBAgT
DFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3dGUgQ29uc3Vs
dGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEkMCIGA1UEAxMb
VGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJzb25hbC1mcmVl
bWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVowYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1Ro
YXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCB
iQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU5VAKMNcCY1os
iRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTXp6a7n2XRxSpU
hQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYBAf8CAQAwQwYDVR0f
BDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNvbmFsRnJlZW1haWxD
QS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2YXRlTGFiZWwy
LTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+whehQ5aUnX9MIbj4Nh+q
LZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3dqZw5jowgT2Vfldr3
94fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCAxAwggMMAgEBMHYwYjELMAkG
A1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhB8UM63f8JqbuVzbfhMa9OgMAkG
BSsOAwIaBQCgggFvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTA5
MTAwNzE2MzE0OFowIwYJKoZIhvcNAQkEMRYEFGXJMaRsVJw/4MyN5C0YF0XDUQjbMIGFBgkrBgEE
AYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5
KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQfFDO
t3/Cam7lc234TGvToDCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQK
ExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwg
RnJlZW1haWwgSXNzdWluZyBDQQIQfFDOt3/Cam7lc234TGvToDANBgkqhkiG9w0BAQEFAASCAQBB
L+0CVW5VATLjAUSleyvl7t8cgNL53fqsaFme4Ww1uxDqwDk2MccLnHh7qGHRpjPk+IM6GKUQK0Go
gr4WYmte2f5baUQeeqbjjCEsONZVVlGJ5RBxky+4g2JnTuQ629k2KVLHCN7duCHzaTemg/NqqbVj
1w23XU81yiROrUS4YcaOCBKC02n8c87uUnBhfuP5TV9p/s/j+ntywxVRmfu34SleIYEL3Wot4pOE
mDmWyQ0YIg9ITth69DX/6JewJIVAF2NcGVejxkqnZDFp9ZuFCABzGJX2a/8Cq7soTMZ4Q+v8mFN+
A7a+yxIwxdpFeA5JDfo4BaL4XD+GhVNBKsECAAAAAAAA

--Apple-Mail-24--399482135--

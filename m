From: David Reitter <david.reitter@gmail.com>
Subject: Re: Importing Bzr revisions
Date: Mon, 23 Mar 2009 11:18:06 -0400
Message-ID: <D05262B5-9B18-49C9-8312-E69926F967AF@gmail.com>
References: <90DBD254-1810-4B11-AA9F-C5661A028FA5@gmail.com> <7veiwo8xz7.fsf@gitster.siamese.dyndns.org> <03AC7EDA-2A9F-4626-A67B-CE9F2A88FC7D@gmail.com> <4123DB23-39C4-4651-A3B5-C7876A781365@frim.nl>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; boundary=Apple-Mail-30--331235076; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pieter de Bie <pieter@frim.nl>
X-From: git-owner@vger.kernel.org Mon Mar 23 16:22:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LllwN-000674-6H
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 16:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376AbZCWPSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 11:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755559AbZCWPSR
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 11:18:17 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:48728 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755459AbZCWPSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 11:18:16 -0400
Received: by fxm2 with SMTP id 2so1846011fxm.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 08:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:mime-version:subject:date:references
         :x-mailer;
        bh=slsIuczb0SOqTioDK/cgw2t0DQMJbgXgmEl7un40v8Y=;
        b=iEE/5qcTO+QXR01/0iCdTR8rtAwmZWWEFgIuE68TeBNwk3LUIUrtrsuynZCW0xzGKS
         sr323jR1h37NWxTuO6so7XPpGXB6wASm+Lu26BgI0LWfZkSoH7wIj6dzKCdyX7tySRYJ
         G9C13pTGzNdC2pKVusuTgMOdLGa6Z5tpkh2Es=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:mime-version:subject
         :date:references:x-mailer;
        b=r7axVpeE/EDQemCDiWDDobkJjLtQrUR0FSW2gbKNKhVoLyKxaKxnM+YdwNOTLUligy
         Kw8CbcWa4QrVf7KtYTBnzE/vasAPWvKDQI+lrOL6jSvQya7a5SsBXeMHSdXPm9Es1yvo
         q08ECaSCwHyjxWXH0Y14huxmLAptvLekmRDl4=
Received: by 10.103.227.10 with SMTP id e10mr3131250mur.30.1237821493716;
        Mon, 23 Mar 2009 08:18:13 -0700 (PDT)
Received: from CMU-276608.WV.CC.CMU.EDU (CMU-276608.WV.CC.CMU.EDU [128.237.227.214])
        by mx.google.com with ESMTPS id n10sm10225589mue.9.2009.03.23.08.18.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 08:18:11 -0700 (PDT)
In-Reply-To: <4123DB23-39C4-4651-A3B5-C7876A781365@frim.nl>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114324>


--Apple-Mail-30--331235076
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Mar 23, 2009, at 10:18 AM, Pieter de Bie wrote:
>
> You might want to take a look at git-bzr (http://github.com/pieter/git-bzr/tree/master 
> ) it allows incremental bidirectional interaction between git and  
> bzr using the fast-export/import, so it might just work in your  
> case. There are some issues with it, so you might want to check the  
> 'network' part on github and use one of the other variants.
>
> That said, it's a 100 line script that hasn't been used much, so  
> good luck :)

Thanks, this appears to be useful.

AFter reading your script, I tried incremental exports on the bzr  
side: It still supports --import-marks and this seems to work quickly  
enough for my small test project.

Could you update the documentation as to how to install the git-bzr  
script?
(I searched for "plugin" in the git user manual, and google, and  
didn't find anything.  I haven't used git much, so I'm a bit naive as  
regards to such a question.)



--Apple-Mail-30--331235076
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFxDCCAn0w
ggHmoAMCAQICED6shx13jEDrq0eL8FRq5ykwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MTIwOTAyMDgwMVoXDTA5MTIwOTAyMDgw
MVowYjEQMA4GA1UEBBMHUmVpdHRlcjEOMAwGA1UEKhMFRGF2aWQxFjAUBgNVBAMTDURhdmlkIFJl
aXR0ZXIxJjAkBgkqhkiG9w0BCQEWF2RhdmlkLnJlaXR0ZXJAZ21haWwuY29tMIGfMA0GCSqGSIb3
DQEBAQUAA4GNADCBiQKBgQDOdo6kAwlkBxUb8dj4saMbYg4SVng8CUePFn3cjjWrakBTbUVa4Z0n
wlUxr7AitEeKhBy5nGhu96+jKUPrCwYNRCZ0l2ovvuGq4z1m1nZ5/c8WvFlVhieuxXMUfmb/O7D3
IojoX6iS8n5MNNU2IWNNT/AD3vOl6DKgOtOw4J9y+QIDAQABozQwMjAiBgNVHREEGzAZgRdkYXZp
ZC5yZWl0dGVyQGdtYWlsLmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBAIjI8yEW
wkiEfA9PMgpjnD6KyCXT0iZjHhW2PkR53yZZLUoTboHnKgsFwYp/gzzIL8J5cvZaRUyMUzXDufPP
dRmxxCs2jXXLDD/8bvdvOuMzqgYoFA73fAfsC8S6qUL1PayZ90J8CZHNhDwqWqOA56T+DdKUegJT
sqoHKh6OnypTMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkEx
FTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3
dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEk
MCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJz
b25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVow
YjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEB
AQUAA4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU
5VAKMNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTX
p6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYBAf8C
AQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNvbmFs
RnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2
YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+whehQ5aU
nX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3dqZw5
jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCAo8wggKLAgEB
MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4x
LDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA+rIcdd4xA66tH
i/BUaucpMAkGBSsOAwIaBQCgggFvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTA5MDMyMzE1MTgwNlowIwYJKoZIhvcNAQkEMRYEFDlLF4zjn7bURV+TkDYcrnPDUaEW
MIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQQIQPqyHHXeMQOurR4vwVGrnKTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpB
MSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQPqyHHXeMQOurR4vwVGrnKTANBgkqhkiG9w0B
AQEFAASBgF5EqtCMYyMEPdDSfIkcBpt3QlnSuTQae4NXQXfu84bqWcdsThvDvnjwYVE4aun5Jp6t
yUyjnoG3qGUP+/fdcTBEjAbDX126SLLTtRI4IaZPls05cvRderGPfEUqZatJW55gvYMNe1/tpVK2
vuZbwFTwgYN2sD9/obBPcCyHxdP+AAAAAAAA

--Apple-Mail-30--331235076--

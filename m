From: David Reitter <david.reitter@gmail.com>
Subject: Re: Importing Bzr revisions
Date: Mon, 23 Mar 2009 17:00:36 -0400
Message-ID: <056D9E7A-92CE-4924-BEA8-A28A25C3B914@gmail.com>
References: <90DBD254-1810-4B11-AA9F-C5661A028FA5@gmail.com> <7veiwo8xz7.fsf@gitster.siamese.dyndns.org> <03AC7EDA-2A9F-4626-A67B-CE9F2A88FC7D@gmail.com> <4123DB23-39C4-4651-A3B5-C7876A781365@frim.nl> <D05262B5-9B18-49C9-8312-E69926F967AF@gmail.com> <CF094EC6-72B6-4523-92ED-6582ADC4C1EE@frim.nl>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; boundary=Apple-Mail-45--310684417; micalg=sha1; protocol="application/pkcs7-signature"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pieter de Bie <pieter@frim.nl>
X-From: git-owner@vger.kernel.org Mon Mar 23 22:03:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlrIN-0004ab-1t
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 22:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753981AbZCWVAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 17:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753766AbZCWVAp
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 17:00:45 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:41332 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752475AbZCWVAn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 17:00:43 -0400
Received: by an-out-0708.google.com with SMTP id d14so1719546and.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:mime-version:subject:date:references
         :x-mailer;
        bh=jCQIPqEn2W6ycULF2uOhnzPcmpt6D26RIGHwi0hHqVw=;
        b=g7xX7Ptv+m/iR8D3E1aEgXROqj8RUZXJim9RVIGxvTVPipU2F6kBI7m/f23mi8z/aO
         goEVErwpHC7GMtmdMhmpwp3ZMRZLEReFSr/Gn0rGj9bbvK7Ks28FwBzdbDq/nURzvhyB
         /ct2ChCrderm/WQSctKr2sjXiU8loxQSkLBzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:mime-version:subject
         :date:references:x-mailer;
        b=UrS9VS11KAcA5aesPRFWYA0E7e+bzRpHBLZ46pPC/gVykJnYK1qu8sAjPOvd4yKqIw
         Bfk3LhuEON7BwHrjR2lvm3TwQQCrap+/UufV+AIyBkpa9LAdP3hlTyBUABtsrntGScvA
         WTKCqysGOlFWTi9XOctFcwl/L8VmSZ3Qfs/Zg=
Received: by 10.100.14.2 with SMTP id 2mr6908008ann.79.1237842040304;
        Mon, 23 Mar 2009 14:00:40 -0700 (PDT)
Received: from SCARLETT.PSY.CMU.EDU (SCARLETT.PSY.CMU.EDU [128.2.249.106])
        by mx.google.com with ESMTPS id c23sm6815845ana.12.2009.03.23.14.00.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 14:00:39 -0700 (PDT)
In-Reply-To: <CF094EC6-72B6-4523-92ED-6582ADC4C1EE@frim.nl>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114349>


--Apple-Mail-45--310684417
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Mar 23, 2009, at 4:15 PM, Pieter de Bie wrote:
>> Could you update the documentation as to how to install the git-bzr  
>> script?
>> (I searched for "plugin" in the git user manual, and google, and  
>> didn't find anything.  I haven't used git much, so I'm a bit naive  
>> as regards to such a question.)
>
> There's nothing to install, just call the script.. if you run it  
> without commands it should give some usage information. The README  
> in the repository should tell the rest. If you'd like to call it  
> using 'git bzr' rather than 'git-bzr', you have to put it somewhere  
> in your PATH

Sure, okay, thanks.  (In my bzr mindset I didn't realize that "git  
bzr" just elegantly translated to "git-bzr".)

I'm currently attempting to convert those 100k revisions from the  
emacs repository, averaging 5.5min/1000 revisions.  Judging from CPU  
load (if that's a valid thing to do), I see a 9:1 distribution of the  
workload (bzr, reading, vs. git, writing).

Thanks for helping me out with this so far.
--Apple-Mail-45--310684417
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
AQkFMQ8XDTA5MDMyMzIxMDAzN1owIwYJKoZIhvcNAQkEMRYEFGMf6NfVjZaOoN8N/naGJm6lRSUz
MIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQQIQPqyHHXeMQOurR4vwVGrnKTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpB
MSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQPqyHHXeMQOurR4vwVGrnKTANBgkqhkiG9w0B
AQEFAASBgBRnf9vDDJSWA6WzIQ8pjAmXEaj/Vqojl3ggk5q7HLHLKzTsE0fWVDyt0U39+V+jdhm+
1pnAn+2/lakCCtHzCxGsyKEWRFtMIXdT6Wa3ax4eNovw/4DA3o7iglxesbjyIsJpgPwpU1o4cARQ
8HX8l3INSF+yJpNdJ3uDBK9L0UFbAAAAAAAA

--Apple-Mail-45--310684417--

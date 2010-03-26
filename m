From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] rebase: Squelch the "fatal: Not an error." message
Date: Fri, 26 Mar 2010 16:31:13 -0700
Message-ID: <F8E395F5-C248-4A95-B2EF-A36E941FFDCF@sb.org>
References: <C07F26A5-6BAD-433D-B1FF-A08DC8E0EA74@sb.org> <7vy6helwbq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: multipart/signed; boundary=Apple-Mail-1--718702470; protocol="application/pkcs7-signature"; micalg=sha1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 00:31:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvIzo-00053l-Lm
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 00:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab0CZXbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 19:31:15 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:37044 "EHLO
	randymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752934Ab0CZXbO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 19:31:14 -0400
Received: from [10.0.1.14] (unknown [24.130.32.253])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a1.g.dreamhost.com (Postfix) with ESMTP id 1BE4C18CEFA;
	Fri, 26 Mar 2010 16:31:14 -0700 (PDT)
In-Reply-To: <7vy6helwbq.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143300>


--Apple-Mail-1--718702470
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 26, 2010, at 12:25 PM, Junio C Hamano wrote:

> Hmm, since "git format-patch HEAD" simply exits with success, I am
> inclined to think that we should fix "format-patch HEAD..HEAD" to do =
the
> same instead.  I didn't check how involved such a change might be,
> though.

Actually it doesn't. The line `git format-patch --ignore-if-in-upstream =
HEAD` gives the same error (the flag seems to be necessary to get the =
error in the first place). In any case, I'll see if I can't figure out =
why it's giving that error.

-Kevin Ballard

--=20
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com




--Apple-Mail-1--718702470
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGMjCCAusw
ggJUoAMCAQICEEBvNCHopKrFMn5Q80vZpuswDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA5MDUwNzA1MDYyNloXDTEwMDUwNzA1MDYy
NlowVzEQMA4GA1UEBBMHQmFsbGFyZDEOMAwGA1UEKhMFS2V2aW4xFjAUBgNVBAMTDUtldmluIEJh
bGxhcmQxGzAZBgkqhkiG9w0BCQEWDGtldmluQHNiLm9yZzCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAKOBiOuMZxNp5ygOJZo2JaBVm5auXMJJmdmTeaSSA8BhvZ98mXzXnaNrXOYSeZHo
hkv4o5bM6LX3Ck38OmsgCcQMIfH4Kt39BvDokfA9ECq1J3HRNKuQ6ZSgZPaRWEy7TUeSHTx1ljxY
tzUt8uAwSsOKiHgLIDi+vtLK0KjGXH1sJP6ajvlrkxQ3bbcmaDXTkpvUl5NEAKv+yK4+KqwTgtwV
6ee2X4jjLjIgn/5Mm6pssaWuZtuEGRdQGkLcFVy+Wgo+5hpHf8fMXOSWsSp3/af6eSieL39M2Tit
E1vTuYRpYjpL0Aevubmm6wens4OTOYKILOTBJDYNfF4HmkK9sMsCAwEAAaMpMCcwFwYDVR0RBBAw
DoEMa2V2aW5Ac2Iub3JnMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAC6/X6Dgj4qoU
XSEZ1LmYkPgSLbRqIIRIgzTy52EnXL8ZQDVntI39lnn0VU8rnDY3sol9wr3feAG62AEa3LyTUxI0
6bWEiNMhPWRHnRoCqiV3F0FqqD8bZJ4J8TgJkRH6IL3MDMUSdGEEzef5KwdGt7ERv/Vk0LBc1ayb
y4FA1O4wggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0ZSBD
b25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQwIgYD
VQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNvbmFs
LWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBiMQsw
CQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEBBQAD
gY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTlUAow
1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNenpruf
ZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBD
BgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVl
bWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVM
YWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0wh
uPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBP
ZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEwdjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEEBvNCHopKrFMn5Q80vZ
puswCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMTAwMzI2MjMzMTEzWjAjBgkqhkiG9w0BCQQxFgQUf/TgAjrBIrnGLncXsoxmrByqHBMwgYUG
CSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5n
IChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENB
AhBAbzQh6KSqxTJ+UPNL2abrMIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkExJTAj
BgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJz
b25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhBAbzQh6KSqxTJ+UPNL2abrMA0GCSqGSIb3DQEBAQUA
BIIBAB75xD6O7xSZq7gmtUvDeTHHS9Z7Bd1iymGxu+C9nolG46vOevcnB/dWAhkwn32sMHFyloY3
AbwdmpxlUa0NcdyNsGapyuOq3cqIyFmcJNXd1QOW0Sj0fm+HvXj3aN5i4b8Y6X4xB20yAqoB+hPo
CpJHqlhBdsU+10iFoIZpovoLrYJ0up1ycPrSvoZwr0YjkAOYeXcr9getrNSpTyLrRoppSUM13hcl
+bvoXxRpCnYKGSTvRUINf6nSDicdysOyHL7fJ1rjmI1LQYfSRrWGvmHJ1+owST7kj4RV2I4o1B9l
TUILfc+BQJ4313nIdT/wklb8s/YnVtXEZRXk7hWROMEAAAAAAAA=

--Apple-Mail-1--718702470--

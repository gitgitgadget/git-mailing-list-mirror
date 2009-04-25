From: Michael Gaber <Michael.Gaber@gmx.net>
Subject: Re: [PATCH v2] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Sat, 25 Apr 2009 20:38:02 +0200
Message-ID: <49F3588A.4000707@gmx.net>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <200904232116.10769.j6t@kdbg.org> <alpine.DEB.1.00.0904251155130.10279@pacific.mpi-cbg.de> <7vbpqkznjs.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0904251039460.3101@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms070602000809020706040801"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Apr 25 20:46:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxmtB-0003DJ-3f
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 20:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbZDYSiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 14:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbZDYSiJ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 14:38:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:34286 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751865AbZDYSiI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 14:38:08 -0400
Received: (qmail invoked by alias); 25 Apr 2009 18:38:06 -0000
Received: from unknown (EHLO [192.168.178.2]) [95.222.249.246]
  by mail.gmx.net (mp035) with SMTP; 25 Apr 2009 20:38:06 +0200
X-Authenticated: #1286246
X-Provags-ID: V01U2FsdGVkX19wMsdWRQxw4uRx3TfT3XtS7b1h4QQl4ZN1qheagA
	ZEm8wmSQsXC3qt
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <alpine.LFD.2.00.0904251039460.3101@localhost.localdomain>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117568>

This is a cryptographically signed message in MIME format.

--------------ms070602000809020706040801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds schrieb:
> 
> On Sat, 25 Apr 2009, Junio C Hamano wrote:
>> @@ -2225,7 +2225,9 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
>>  {
>>  	int ret = 0;
>>  
>> -	if (link(tmpfile, filename))
>> +	if (unreliable_hardlinks)
>> +		goto try_rename;
> 
> Much better.
> 
> 		Linus

http://www.cs.utexas.edu/users/EWD/ewd02xx/EWD215.PDF

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


--------------ms070602000809020706040801
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKdjCC
BTcwggMfoAMCAQICAwa1/DANBgkqhkiG9w0BAQUFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0wOTA0
MTAxNzIzNDlaFw0xMTA0MTAxNzIzNDlaMD4xFjAUBgNVBAMTDU1pY2hhZWwgR2FiZXIxJDAi
BgkqhkiG9w0BCQEWFU1pY2hhZWwuR2FiZXJAZ214Lm5ldDCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBANlvNCEKkhAhmwIpzXamq89nexUPZxbvGR05bN8NlABb/ZkrsUzq56ni
E4uA61Uuwz3stsXXPN5SOV+oJABDWgvgUsk4fZavEMbP7Kk5iJpZf+ZYDc+z+cYEgxLcQ/v2
I3j5r7sdT8L6KuB4mvJaQ2WLMcAzyE4J3b39IzPHjrKkTWHyNQP8UUVEJ8qIZ3oCNAYYkTar
2nKv9uCz//ne40luTpPaEi4vrV5x3F9VKLVLWp1pjceE2xC6wSRlF9ZouOhk6aefTeJ0zMCK
yiCxhk/4pDM5GfXePU7a05uP7NWtvFPPVt8ahIXoX4J4mRdxByijW1wIAqP2ghjL0IHWHlcC
AwEAAaOCAQEwgf4wDAYDVR0TAQH/BAIwADBWBglghkgBhvhCAQ0ESRZHVG8gZ2V0IHlvdXIg
b3duIGNlcnRpZmljYXRlIGZvciBGUkVFIGhlYWQgb3ZlciB0byBodHRwOi8vd3d3LkNBY2Vy
dC5vcmcwQAYDVR0lBDkwNwYIKwYBBQUHAwQGCCsGAQUFBwMCBgorBgEEAYI3CgMEBgorBgEE
AYI3CgMDBglghkgBhvhCBAEwMgYIKwYBBQUHAQEEJjAkMCIGCCsGAQUFBzABhhZodHRwOi8v
b2NzcC5jYWNlcnQub3JnMCAGA1UdEQQZMBeBFU1pY2hhZWwuR2FiZXJAZ214Lm5ldDANBgkq
hkiG9w0BAQUFAAOCAgEAZy8jWlhd7lK824fomYsYCfGMwjgvJs8iW72U1ewbrc8FAd9974aS
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
ChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlD
QSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2Vy
dC5vcmcCAwa1/DAJBgUrDgMCGgUAoIIB2zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0wOTA0MjUxODM4MDJaMCMGCSqGSIb3DQEJBDEWBBTKR6pgUxex5tx2
GXFg+KpWtcK9STBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIA
gDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBkQYJKwYBBAGCNxAE
MYGDMIGAMHkxEDAOBgNVBAoTB1Jvb3QgQ0ExHjAcBgNVBAsTFWh0dHA6Ly93d3cuY2FjZXJ0
Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhvcml0eTEhMB8GCSqGSIb3DQEJ
ARYSc3VwcG9ydEBjYWNlcnQub3JnAgMGtfwwgZMGCyqGSIb3DQEJEAILMYGDoIGAMHkxEDAO
BgNVBAoTB1Jvb3QgQ0ExHjAcBgNVBAsTFWh0dHA6Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UE
AxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhvcml0eTEhMB8GCSqGSIb3DQEJARYSc3VwcG9ydEBj
YWNlcnQub3JnAgMGtfwwDQYJKoZIhvcNAQEBBQAEggEAl4pROwxt475c6RXF6qlqmkPtqdvL
fmJZSTAoBCQMQbI0f4EILomjWXN6rOEnLp/cCF+2DRwufF58+jqbPfI8hudBKBaSp8F0a+gO
+1lFaSn0ei1lUUYmtf0G+YYzSVVjsOCJ0nOhBD2qYjSc71JMbo9RqIm0Ozup8YoDNYWHwFA7
V5wKMHQI8Ok/FMzfnzH0WY/310HCyvlaWxLXRN33aMXS/3UWjCRN9u8BQGorMdc+a0JtMZe9
fADst4qRBFOFz59PZIxliKviG7a60c1sQrg2LFKcV0w2oPRTS4jpQA/QDK1OHs6m+pq2Cqps
0syhGhl43nmsgS5YLPVu6mwYlwAAAAAAAA==
--------------ms070602000809020706040801--

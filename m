From: Phillip Hutchings <sitharus@sitharus.com>
Subject: Re: Using git-svn with svnsync mirror
Date: Tue, 16 Nov 2010 20:31:32 +1300
Message-ID: <AC576A1A-98E4-4710-91B8-7777DBC65B9B@sitharus.com>
References: <loom.20101116T030410-656@post.gmane.org> <20101116042312.GB24344@mail.stoakes.net>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: multipart/signed; boundary=Apple-Mail-1195-200363368; protocol="application/pkcs7-signature"; micalg=sha1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 16 08:32:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIG1I-0004Mh-MI
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 08:32:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410Ab0KPHbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 02:31:44 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59960 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759426Ab0KPHbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 02:31:42 -0500
Received: by pwi9 with SMTP id 9so55099pwi.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 23:31:41 -0800 (PST)
Received: by 10.143.34.4 with SMTP id m4mr6051209wfj.18.1289892699815;
        Mon, 15 Nov 2010 23:31:39 -0800 (PST)
Received: from [10.0.1.4] (121-98-80-7.bitstream.orcon.net.nz [121.98.80.7])
        by mx.google.com with ESMTPS id y42sm1012977wfd.22.2010.11.15.23.31.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 23:31:38 -0800 (PST)
In-Reply-To: <20101116042312.GB24344@mail.stoakes.net>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161546>


--Apple-Mail-1195-200363368
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii


On 16/11/2010, at 5:23 PM, Tim Stoakes wrote:

> Phillip Hutchings(sitharus@sitharus.com)@161110-02:08:
>> Hi,
>> 
>> I've got an svnsync mirror of a large repository, and I'm trying to do
>> a git-svn clone from the mirror as the main server is off site. This
>> works well until I try to dcommit or use git svn info.
>> 
>> My investigations show that working_head_info in git-svn doesn't
>> account for using svnsync properties, so it cannot find a log entry
>> that matches a config entry.
>> 
>> My perl isn't good enough to patch this yet, so I was wondering if
>> anyone else had encountered it.
>> 
>> I could change the config URL to match, but I'm worried this will
>> break things.
> 
> You want to use rewriteRoot option so that changing the URL does not
> break things (the URL is stored in each git commit's log).
> 
> I use something like this all the time:
> [svn-remote "svn"]
>  rewriteRoot = svn://svn.foo.com/repo/blah   <-- the master
>  url = svn://svn-mirror.foo.com/repo/somewhere/else/blah  <-- a slave
> 
> If you've imported from the mirror without this option, then you're
> stuck I think. You could work around it by swapping the URLs in the
> rewriteRoot and url fields (essentially rewriting the URLs in the wrong
> order), but this is strictly 'wrong'.


I cloned using --use-svnsync-props, this resulted in the log entries
having the correct url to the master, but git-svn being unable to
link that url back to the config entry.

Guess I'm in for a recloning then.

--
Phillip Hutchings
sitharus@sitharus.com




--Apple-Mail-1195-200363368
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFjTCCBYkw
ggNxoAMCAQICAwkrAjANBgkqhkiG9w0BAQUFADB5MRAwDgYDVQQKEwdSb290IENBMR4wHAYDVQQL
ExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmluZyBBdXRob3Jp
dHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0xMDA5MTEwNjQ1MjVaFw0x
MTAzMTAwNjQ1MjVaMG8xGDAWBgNVBAMTD0NBY2VydCBXb1QgVXNlcjEkMCIGCSqGSIb3DQEJARYV
c2l0aGFydXNAc2l0aGFydXMuY29tMS0wKwYJKoZIhvcNAQkBFh5waGlsbGlwLmh1dGNoaW5nc0Bz
aXRoYXJ1cy5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC9NHv4coeVolY+Cy9u
LKXBmojUv+cAOw7G1JYuruQJrf1JfRcLKwLq5Nmv1kgEEwgTUCb8j2D4WC6bRqT7erCY2PpGLheO
b4hLACXJhxjGgBCbFMzJGOrjR1KFNYb2KZ732qY5zngDwYtZlE82Mfuh3nCFMoT5I9+MSqF4YCGZ
5CxwA+De6XnHFFnL3UipGGgvro+dvw3luf1PgNi9LpEjmzRUO3ylCQs8uFHmGqXe/NG7jtk/oRFc
tvjebkXb1d2jCeqrZE9FL3J+uT5vzCgo9N5WOvMAUWf+G0F3NH+oKKyQJ0EFweSeFWCLLg31dW+Z
pUVPjsoFinWdth61B5vxAgMBAAGjggEiMIIBHjAMBgNVHRMBAf8EAjAAMFYGCWCGSAGG+EIBDQRJ
FkdUbyBnZXQgeW91ciBvd24gY2VydGlmaWNhdGUgZm9yIEZSRUUgaGVhZCBvdmVyIHRvIGh0dHA6
Ly93d3cuQ0FjZXJ0Lm9yZzBABgNVHSUEOTA3BggrBgEFBQcDBAYIKwYBBQUHAwIGCisGAQQBgjcK
AwQGCisGAQQBgjcKAwMGCWCGSAGG+EIEATAyBggrBgEFBQcBAQQmMCQwIgYIKwYBBQUHMAGGFmh0
dHA6Ly9vY3NwLmNhY2VydC5vcmcwQAYDVR0RBDkwN4EVc2l0aGFydXNAc2l0aGFydXMuY29tgR5w
aGlsbGlwLmh1dGNoaW5nc0BzaXRoYXJ1cy5jb20wDQYJKoZIhvcNAQEFBQADggIBALB2lIbH+UyN
0X1R3zfx/EvSPO7LabIIGlKhkY2KYBvkeqmRKPBKXP2RajQTo12x5WhCRNCYVitCQjSYT/fjIU1u
wn1MOwzofojxrDK5AHqsyp0MSRJDOU003CWIe4vBizx7k3K+iD2aXUbzQ2/VQIU8E51nhvaK5d67
/B2nIOtOEq6tkaE30Np5hfNuoV8zh2ATQJPXJZ8Gvue4drcDu/0yhquFbvf0YVAS/QobgIuUfT2l
1mAnsIi0qujGjVCwWHmt+RVfYv5gBeCg7tntJenSbEBMhizJpGGS55fJbMwfGJS3C8+ULkb+iM3o
DbkgxAc/kgtvXzD/071ZTMbwingW6g1QACslZmT1Lr7oZwMFX4Txz+7nBjCgXuF2eZX6Rkc0S6jS
Ztbg1+qZ5g4hh+GgfP1uf3wqQZaXyRH5tsFJn6qvG2WyVfyMMzXu/LFSl5Bn6q9+jaOKduJpWjOF
6xCeOKe2Z0SXNxCySwnsztDc6V62YFss361BxAfFO4edlX96SHVfSIUhSkVijHQL6M0H7IjUi7yv
JGPirxX7pudbSYQlPVPeS66xLYys4j0yw084IjSuZKt+FCh1NM6vQ5ud3+INZLh9oX+MnB+xX/gH
Wem+B3beLM+gH0IX9jRLEXqGb7WhmP48rFB/4cQgVBuN0J6JM/3Zi5PNjdE6vBT0MYIDMzCCAy8C
AQEwgYAweTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNlcnQub3Jn
MSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcNAQkBFhJzdXBw
b3J0QGNhY2VydC5vcmcCAwkrAjAJBgUrDgMCGgUAoIIBhzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0xMDExMTYwNzMxMzJaMCMGCSqGSIb3DQEJBDEWBBTcCMgNemQO
NAjGjD884yclXyccNTCBkQYJKwYBBAGCNxAEMYGDMIGAMHkxEDAOBgNVBAoTB1Jvb3QgQ0ExHjAc
BgNVBAsTFWh0dHA6Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1
dGhvcml0eTEhMB8GCSqGSIb3DQEJARYSc3VwcG9ydEBjYWNlcnQub3JnAgMJKwIwgZMGCyqGSIb3
DQEJEAILMYGDoIGAMHkxEDAOBgNVBAoTB1Jvb3QgQ0ExHjAcBgNVBAsTFWh0dHA6Ly93d3cuY2Fj
ZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhvcml0eTEhMB8GCSqGSIb3DQEJ
ARYSc3VwcG9ydEBjYWNlcnQub3JnAgMJKwIwDQYJKoZIhvcNAQEBBQAEggEAjjkPz8ilxbfF0xKG
UqLaiDqnYZhiNQ2bS/jsNNjnLyAvktoEgFlYseENvqb8cuNr0s1Jdycs7FJUugk8MRDtEk44dapZ
g6X0JBifvOCNtH5IG8sjKD+BluioH4UuVc8MHisYuGSjEAu9XfSBFiwIohxNYEK9K2q0wsoOVjOy
qF5A+LiOBUxJJh2GTTBIon2xDi0bbJB9O1CMg0W+vD78GZs9QcCXUqJkRkG1bxq0qBiPtl7mH986
0tIJ9+KlZN39tR39K4jXoQW8r1v618USrpmm5/OyA+z3Ud/+igNzkSA7/MKZ22XNIklVIUXA1Swq
r+C5XmhhKL5ZJYQr2OqwoAAAAAAAAA==

--Apple-Mail-1195-200363368--

From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Re: Questions/investigations on git-subtree and tags
Date: Tue, 12 Mar 2013 11:02:25 +0100 (CET)
Message-ID: <2131964232.420820.1363082545306.JavaMail.root@openwide.fr>
References: <886271566.251606.1362763771332.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_420817_60500446.1363082545304"
Cc: Paul Campbell <pcampbell@kemitix.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 11:02:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFM2o-0006cC-Mz
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 11:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182Ab3CLKC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 06:02:28 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:36932 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab3CLKC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 06:02:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 219FC2804A;
	Tue, 12 Mar 2013 11:02:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W--y5bJzxnV1; Tue, 12 Mar 2013 11:02:25 +0100 (CET)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 897AA28006;
	Tue, 12 Mar 2013 11:02:25 +0100 (CET)
In-Reply-To: <886271566.251606.1362763771332.JavaMail.root@openwide.fr>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC25 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217942>

------=_Part_420817_60500446.1363082545304
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul, I'm not quite sure where I should go from here...

should I send you a patch so you make it a V3 of your patch ? should I
send a patch superseeding yours ?=20

I have also found a similar problem in git-subtree pull, which needs=20
the same fix.=20

in the mean time, attached is the current version of my changes

    Cordialement

    J=C3=A9r=C3=A9my Rosen

fight key loggers : write some perl using vim


------=_Part_420817_60500446.1363082545304
Content-Type: text/x-patch;
 name=0001-git-subtree-make-sure-the-SHA-saved-as-ancestor-is-a.patch
Content-Disposition: attachment;
 filename=0001-git-subtree-make-sure-the-SHA-saved-as-ancestor-is-a.patch
Content-Transfer-Encoding: base64

RnJvbSAxMjQ5MDcyNGFlOTU1NzE5Njk0ZDgyNWRmZjRmYTllMGQyNzA5YzFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/Sj1DMz1BOXI9QzM9QTlteT0yMFJvc2VuPz0g
PGplcmVteS5yb3NlbkBvcGVud2lkZS5mcj4KRGF0ZTogVHVlLCAxMiBNYXIgMjAxMyAxMDo1Njo1
NCArMDEwMApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBnaXQtc3VidHJlZTogbWFrZSBzdXJlIHRoZSBT
SEEgc2F2ZWQgYXMgYW5jZXN0b3IgaXMgYQogY29tbWl0Ck1JTUUtVmVyc2lvbjogMS4wCkNvbnRl
bnQtVHlwZTogdGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29k
aW5nOiA4Yml0CgpXaGVuIGFkZGluZyBvciBtZXJnaW5nIHRoZSBmaXJzdCBwYXJhbWV0ZXIgbWln
aHQgbm90IGJlIGEgY29tbWl0LCBpdCBjYW4gYWxzbyBiZSBhIHRhZyBTSEEuClRoaXMgbmVlZHMg
dG8gYmUgZml4ZWQgYnkgdXNpbmcgdGhlIHVuZGVybHlpbmcgY29tbWl0IG9yIHRoZSBhbmNlc3Rv
ciBmaW5kaW5nIGNvZGUgd2lsbCBjcm9hayBhdCBzcGxpdCB0aW1lCgoKU2lnbmVkLW9mZi1ieTog
SsOpcsOpbXkgUm9zZW4gPGplcmVteS5yb3NlbkBvcGVud2lkZS5mcj4KLS0tCiBjb250cmliL3N1
YnRyZWUvZ2l0LXN1YnRyZWUuc2ggfCAgICA0ICsrLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvY29udHJpYi9zdWJ0cmVlL2dp
dC1zdWJ0cmVlLnNoIGIvY29udHJpYi9zdWJ0cmVlL2dpdC1zdWJ0cmVlLnNoCmluZGV4IDhhMjNm
NTguLjhiOWQxMTQgMTAwNzU1Ci0tLSBhL2NvbnRyaWIvc3VidHJlZS9naXQtc3VidHJlZS5zaAor
KysgYi9jb250cmliL3N1YnRyZWUvZ2l0LXN1YnRyZWUuc2gKQEAgLTUzMSw3ICs1MzEsNyBAQCBj
bWRfYWRkX3JlcG9zaXRvcnkoKQogCiBjbWRfYWRkX2NvbW1pdCgpCiB7Ci0JcmV2cz0kKGdpdCBy
ZXYtcGFyc2UgJGRlZmF1bHQgLS1yZXZzLW9ubHkgIiRAIikgfHwgZXhpdCAkPworCXJldnM9JChn
aXQgcmV2LXBhcnNlICRkZWZhdWx0IC0tcmV2cy1vbmx5ICIkMV57Y29tbWl0fSIpIHx8IGV4aXQg
JD8KIAlzZXQgLS0gJHJldnMKIAlyZXY9IiQxIgogCQpAQCAtNjU1LDcgKzY1NSw3IEBAIGNtZF9z
cGxpdCgpCiAKIGNtZF9tZXJnZSgpCiB7Ci0JcmV2cz0kKGdpdCByZXYtcGFyc2UgJGRlZmF1bHQg
LS1yZXZzLW9ubHkgIiRAIikgfHwgZXhpdCAkPworCXJldnM9JChnaXQgcmV2LXBhcnNlICRkZWZh
dWx0IC0tcmV2cy1vbmx5ICIkMV57Y29tbWl0fSIpIHx8IGV4aXQgJD8KIAllbnN1cmVfY2xlYW4K
IAkKIAlzZXQgLS0gJHJldnMKLS0gCjEuNy4xMC40Cgo=
------=_Part_420817_60500446.1363082545304
Content-Type: text/x-patch;
 name=0002-git-subtree-use-ls-remote-to-check-the-refspec-passe.patch
Content-Disposition: attachment;
 filename=0002-git-subtree-use-ls-remote-to-check-the-refspec-passe.patch
Content-Transfer-Encoding: base64

RnJvbSAwNWQxZGQ1NjIxN2JlNTlkNjk5NTJhNDFkOTdlMjA0Y2M3ODIxOTQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/Sj1DMz1BOXI9QzM9QTlteT0yMFJvc2VuPz0g
PGplcmVteS5yb3NlbkBvcGVud2lkZS5mcj4KRGF0ZTogVHVlLCAxMiBNYXIgMjAxMyAxMDo1Nzo1
NiArMDEwMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBnaXQtc3VidHJlZTogdXNlIGxzLXJlbW90ZSB0
byBjaGVjayB0aGUgcmVmc3BlYyBwYXNzZWQKIHRvIHB1bGwgYW5kIGFkZApNSU1FLVZlcnNpb246
IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFu
c2Zlci1FbmNvZGluZzogOGJpdAoKbHMtcmVtb3RlIGlzIHRoZSBjb3JyZWN0IHdheSB0byBjaGVj
ayB0aGF0IGEgcGFyYW1ldGVyIGlzIGEgdmFsaWQgZmV0Y2hhYmxlIHRhcmdldAoKClNpZ25lZC1v
ZmYtYnk6IErDqXLDqW15IFJvc2VuIDxqZXJlbXkucm9zZW5Ab3BlbndpZGUuZnI+Ci0tLQogY29u
dHJpYi9zdWJ0cmVlL2dpdC1zdWJ0cmVlLnNoIHwgICAxMSArKysrLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9jb250
cmliL3N1YnRyZWUvZ2l0LXN1YnRyZWUuc2ggYi9jb250cmliL3N1YnRyZWUvZ2l0LXN1YnRyZWUu
c2gKaW5kZXggOGI5ZDExNC4uNjFkNGVhYiAxMDA3NTUKLS0tIGEvY29udHJpYi9zdWJ0cmVlL2dp
dC1zdWJ0cmVlLnNoCisrKyBiL2NvbnRyaWIvc3VidHJlZS9naXQtc3VidHJlZS5zaApAQCAtNTAz
LDEzICs1MDMsOCBAQCBjbWRfYWRkKCkKIAogCSAgICAiY21kX2FkZF9jb21taXQiICIkQCIKIAll
bGlmIFsgJCMgLWVxIDIgXTsgdGhlbgotCSAgICAjIFRlY2huaWNhbGx5IHdlIGNvdWxkIGFjY2Vw
dCBhIHJlZnNwZWMgaGVyZSBidXQgd2UncmUKLQkgICAgIyBqdXN0IGdvaW5nIHRvIHR1cm4gYXJv
dW5kIGFuZCBhZGQgRkVUQ0hfSEVBRCB1bmRlciB0aGUKLQkgICAgIyBzcGVjaWZpZWQgZGlyZWN0
b3J5LiAgQWxsb3dpbmcgYSByZWZzcGVjIG1pZ2h0IGJlCi0JICAgICMgbWlzbGVhZGluZyBiZWNh
dXNlIHdlIHdvbid0IGRvIGFueXRoaW5nIHdpdGggYW55IG90aGVyCi0JICAgICMgYnJhbmNoZXMg
ZmV0Y2hlZCB2aWEgdGhlIHJlZnNwZWMuCi0JICAgIGdpdCByZXYtcGFyc2UgLXEgLS12ZXJpZnkg
IiQyXntjb21taXR9IiA+L2Rldi9udWxsIHx8Ci0JICAgIGRpZSAiJyQyJyBkb2VzIG5vdCByZWZl
ciB0byBhIGNvbW1pdCIKKwkJZ2l0IGxzLXJlbW90ZSAtLWV4aXQtY29kZSAiJDEiICIkMiIgfHwK
KwkJZGllICInJDInIGlzIG5vdCBhIGNvcnJlY3QgcmVmZXJlbmNlIG9uICckMSciCiAKIAkgICAg
ImNtZF9hZGRfcmVwb3NpdG9yeSIgIiRAIgogCWVsc2UKQEAgLTcwMCw2ICs2OTUsOCBAQCBjbWRf
bWVyZ2UoKQogY21kX3B1bGwoKQogewogCWVuc3VyZV9jbGVhbgorCWdpdCBscy1yZW1vdGUgLS1l
eGl0LWNvZGUgIiQxIiAiJDIiIHx8CisJCWRpZSAiJyQyJyBpcyBub3QgYSBjb3JyZWN0IHJlZmVy
ZW5jZSBvbiAnJDEnIgogCWdpdCBmZXRjaCAiJEAiIHx8IGV4aXQgJD8KIAlyZXZzPUZFVENIX0hF
QUQKIAlzZXQgLS0gJHJldnMKLS0gCjEuNy4xMC40Cgo=
------=_Part_420817_60500446.1363082545304--

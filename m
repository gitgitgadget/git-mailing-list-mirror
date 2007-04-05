From: "Dana How" <danahow@gmail.com>
Subject: [PATCH 01/13] Fix lseek(2) calls with args 2 and 3 swapped
Date: Thu, 5 Apr 2007 15:23:29 -0700
Message-ID: <56b7f5510704051523l30c422c6ie2ba561577fecb73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_58939_26733031.1175811809042"
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:23:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZaMg-0003Me-PF
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:23:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767206AbXDEWXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767215AbXDEWXb
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:23:31 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:3242 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767206AbXDEWXb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:23:31 -0400
Received: by ik-out-1112.google.com with SMTP id c21so474537ika
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 15:23:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=FsbYOvM8PgGbBxvUA5mUoArrj9BMtrZIXcqgPuTs5+plB+aqR8jYTZrqLLOfqiwyJV4eAxnY2R0obj5BqppZlev+GSKDF3fuDuZ0iqmOzrtzuWMNNQdsGVWsyKRL265gAExd39zzuAuVVeE53aQwc6ulHu36xDog771ZfXHiHnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=CW6fAq0UpcT1dlko4QzHQZHR2lx1juu8pmAN75C7IUlhMFwGVVEnUiezjIuL3LGfCVfreJI26xG3+z+6ACy3jBeav/6XhfOiaxcg1skJz4Bw85jbKxBfzWrKbwtibKKTo2syXlpxCkGSJbXAkYjExEGCIhNllFuDM6C5yjkNSfI=
Received: by 10.114.205.1 with SMTP id c1mr942962wag.1175811809080;
        Thu, 05 Apr 2007 15:23:29 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 15:23:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43864>

------=_Part_58939_26733031.1175811809042
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---
 http-fetch.c |    2 +-
 http-push.c  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

------=_Part_58939_26733031.1175811809042
Content-Type: text/plain; name="0001-Fix-lseek-2-calls-with-args-2-and-3-swapped.patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Fix-lseek-2-calls-with-args-2-and-3-swapped.patch.txt"
X-Attachment-Id: f_f05rz3p0

RnJvbSBhZmFhM2ZhNzU0ZDhhYmMyOTYyNjEyNzUzMzllYzUwMTgyOTgzZGQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5hIEhvdyA8aG93QGRlYXRodmFsbGV5LmNzd2l0Y2guY29t
PgpEYXRlOiBUaHUsIDUgQXByIDIwMDcgMTI6MDU6NTcgLTA3MDAKU3ViamVjdDogW1BBVENIIDAx
LzEzXSBGaXggbHNlZWsoMikgY2FsbHMgd2l0aCBhcmdzIDIgYW5kIDMgc3dhcHBlZAoKLS0tCiBo
dHRwLWZldGNoLmMgfCAgICAyICstCiBodHRwLXB1c2guYyAgfCAgICAyICstCiAyIGZpbGVzIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9odHRw
LWZldGNoLmMgYi9odHRwLWZldGNoLmMKaW5kZXggNTU3YjQwMy4uMDliYWVkYyAxMDA2NDQKLS0t
IGEvaHR0cC1mZXRjaC5jCisrKyBiL2h0dHAtZmV0Y2guYwpAQCAtMTk4LDcgKzE5OCw3IEBAIHN0
YXRpYyB2b2lkIHN0YXJ0X29iamVjdF9yZXF1ZXN0KHN0cnVjdCBvYmplY3RfcmVxdWVzdCAqb2Jq
X3JlcSkKIAkJU0hBMV9Jbml0KCZvYmpfcmVxLT5jKTsKIAkJaWYgKHByZXZfcG9zbj4wKSB7CiAJ
CQlwcmV2X3Bvc24gPSAwOwotCQkJbHNlZWsob2JqX3JlcS0+bG9jYWwsIFNFRUtfU0VULCAwKTsK
KwkJCWxzZWVrKG9ial9yZXEtPmxvY2FsLCAwLCBTRUVLX1NFVCk7CiAJCQlmdHJ1bmNhdGUob2Jq
X3JlcS0+bG9jYWwsIDApOwogCQl9CiAJfQpkaWZmIC0tZ2l0IGEvaHR0cC1wdXNoLmMgYi9odHRw
LXB1c2guYwppbmRleCA3MjQ3MjBjLi5lM2Y3Njc1IDEwMDY0NAotLS0gYS9odHRwLXB1c2guYwor
KysgYi9odHRwLXB1c2guYwpAQCAtMzEyLDcgKzMxMiw3IEBAIHN0YXRpYyB2b2lkIHN0YXJ0X2Zl
dGNoX2xvb3NlKHN0cnVjdCB0cmFuc2Zlcl9yZXF1ZXN0ICpyZXF1ZXN0KQogCQlTSEExX0luaXQo
JnJlcXVlc3QtPmMpOwogCQlpZiAocHJldl9wb3NuPjApIHsKIAkJCXByZXZfcG9zbiA9IDA7Ci0J
CQlsc2VlayhyZXF1ZXN0LT5sb2NhbF9maWxlbm8sIFNFRUtfU0VULCAwKTsKKwkJCWxzZWVrKHJl
cXVlc3QtPmxvY2FsX2ZpbGVubywgMCwgU0VFS19TRVQpOwogCQkJZnRydW5jYXRlKHJlcXVlc3Qt
PmxvY2FsX2ZpbGVubywgMCk7CiAJCX0KIAl9Ci0tIAoxLjUuMS5yYzIuMTguZzljODgtZGlydHkK
Cg==
------=_Part_58939_26733031.1175811809042--

From: "Dana How" <danahow@gmail.com>
Subject: [PATCH 13/13] recognize new options in git-{repack,pack-objects}
Date: Thu, 5 Apr 2007 15:42:31 -0700
Message-ID: <56b7f5510704051542o49cead12rbc318352462a6783@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_59151_29016344.1175812951359"
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:42:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZaf6-0000vY-GV
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767240AbXDEWmd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767381AbXDEWmd
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:42:33 -0400
Received: from nz-out-0506.google.com ([64.233.162.238]:15426 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767240AbXDEWmc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:42:32 -0400
Received: by nz-out-0506.google.com with SMTP id s1so403830nze
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 15:42:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Ub2nTG5klPVVb/U3//OARAf4RXWjcHAfVrb+LOj0qMJ3ZU42M760aX/1cG90YGyXN5MumKPHzaEzR2OspHlC3Sj1n5xKcxZIoN7pf+se/1ci3qM1kC1BiMJITgNP2qU9W6ZVpjGF/dWx0vMVIYbrheQMWs6cmaR5eoQkcDpPX2A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=NxcttONCc9a8pKS9K2qwiKMvxjSQ2uffP4C6tE1RUxVcThmvXae6lkwZkxZNWZm950NXb6s5wyR+Ik/oqMyzKsQugCIk6y/JlJoxe9pGm2qtXAVQrCcg/fA/7eep1PHF72C2ne6LwMJaSuULW55PuSwX6HPhU6ZzZFljtTAlvTI=
Received: by 10.115.32.1 with SMTP id k1mr951367waj.1175812951397;
        Thu, 05 Apr 2007 15:42:31 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 15:42:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43876>

------=_Part_59151_29016344.1175812951359
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---
 builtin-pack-objects.c |   41 +++++++++++++++++++++++++++++++++++++++--
 git-repack.sh          |   12 ++++++++----
 2 files changed, 47 insertions(+), 6 deletions(-)

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

------=_Part_59151_29016344.1175812951359
Content-Type: text/plain; name="0013-recognize-new-options-in-git-repack-pack-objects.patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0013-recognize-new-options-in-git-repack-pack-objects.patch.txt"
X-Attachment-Id: f_f05so1g2

RnJvbSBhNmEyNDNjNTRmOWJmMWQ2NjM3NDc4MjdmOWQzYjM2Y2JjNmE1YWVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5hIEhvdyA8aG93QGRlYXRodmFsbGV5LmNzd2l0Y2guY29t
PgpEYXRlOiBUaHUsIDUgQXByIDIwMDcgMTU6MDY6MzQgLTA3MDAKU3ViamVjdDogW1BBVENIIDEz
LzEzXSByZWNvZ25pemUgbmV3IG9wdGlvbnMgaW4gZ2l0LXtyZXBhY2sscGFjay1vYmplY3RzfQoK
LS0tCiBidWlsdGluLXBhY2stb2JqZWN0cy5jIHwgICA0MSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLQogZ2l0LXJlcGFjay5zaCAgICAgICAgICB8ICAgMTIgKysrKysr
KystLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0p
CgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi1wYWNrLW9iamVjdHMuYyBiL2J1aWx0aW4tcGFjay1vYmpl
Y3RzLmMKaW5kZXggMzIyOWRmOC4uOTI4YWQzMCAxMDA2NDQKLS0tIGEvYnVpbHRpbi1wYWNrLW9i
amVjdHMuYworKysgYi9idWlsdGluLXBhY2stb2JqZWN0cy5jCkBAIC0xNCw4ICsxNCw4IEBACiAj
aW5jbHVkZSAibGlzdC1vYmplY3RzLmgiCiAKIHN0YXRpYyBjb25zdCBjaGFyIHBhY2tfdXNhZ2Vb
XSA9ICJcCi1naXQtcGFjay1vYmplY3RzIFt7IC1xIHwgLS1wcm9ncmVzcyB8IC0tYWxsLXByb2dy
ZXNzIH1dIFxuXAotCVstLWxvY2FsXSBbLS1pbmNyZW1lbnRhbF0gWy0td2luZG93PU5dIFstLWRl
cHRoPU5dIFxuXAorZ2l0LXBhY2stb2JqZWN0cyBbeyAtcSB8IC0tcHJvZ3Jlc3MgfCAtLWFsbC1w
cm9ncmVzcyB9XSBbLS1wYWNrLWxpbWl0Wz1OXV1cblwKKwlbLS1ibG9iLWxpbWl0PU5dIFstLWxv
Y2FsXSBbLS1pbmNyZW1lbnRhbF0gWy0td2luZG93PU5dIFstLWRlcHRoPU5dXG5cCiAJWy0tbm8t
cmV1c2UtZGVsdGFdIFstLWRlbHRhLWJhc2Utb2Zmc2V0XSBbLS1ub24tZW1wdHldIFxuXAogCVst
LXJldnMgWy0tdW5wYWNrZWQgfCAtLWFsbF0qXSBbLS1yZWZsb2ddIFstLXN0ZG91dCB8IGJhc2Ut
bmFtZV0gXG5cCiAJWzxyZWYtbGlzdCB8IDxvYmplY3QtbGlzdF0iOwpAQCAtMTY4Niw2ICsxNjg2
LDcgQEAgaW50IGNtZF9wYWNrX29iamVjdHMoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2LCBj
b25zdCBjaGFyICpwcmVmaXgpCiAJY29uc3QgY2hhciAqKnJwX2F2OwogCWludCBycF9hY19hbGxv
YyA9IDY0OwogCWludCBycF9hYzsKKwlpbnQgYWRkZWQgPSAwOwogCiAJcnBfYXYgPSB4Y2FsbG9j
KHJwX2FjX2FsbG9jLCBzaXplb2YoKnJwX2F2KSk7CiAKQEAgLTE3MTQsNiArMTcxNSwyNCBAQCBp
bnQgY21kX3BhY2tfb2JqZWN0cyhpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNvbnN0IGNo
YXIgKnByZWZpeCkKIAkJCWluY3JlbWVudGFsID0gMTsKIAkJCWNvbnRpbnVlOwogCQl9CisJCWlm
ICghc3RyY21wKCItLXBhY2stbGltaXQiLCBhcmcpKSB7CisJCQlvZmZzZXRfbGltaXQgPSAxVUwg
PDwgMzE7CisJCQljb250aW51ZTsKKwkJfQorCQlpZiAoIXByZWZpeGNtcChhcmcsICItLXBhY2st
bGltaXQ9IikpIHsKKwkJCWNoYXIgKmVuZDsKKwkJCW9mZnNldF9saW1pdCA9IHN0cnRvdWwoYXJn
KzEzLCAmZW5kLCAwKTsKKwkJCWlmICghYXJnWzEzXSB8fCAqZW5kKQorCQkJCXVzYWdlKHBhY2tf
dXNhZ2UpOworCQkJY29udGludWU7CisJCX0KKwkJaWYgKCFwcmVmaXhjbXAoYXJnLCAiLS1ibG9i
LWxpbWl0PSIpKSB7CisJCQljaGFyICplbmQ7CisJCQlibG9iX2xpbWl0ID0gc3RydG91bChhcmcr
MTMsICZlbmQsIDApOworCQkJaWYgKCFhcmdbMTNdIHx8ICplbmQpCisJCQkJdXNhZ2UocGFja191
c2FnZSk7CisJCQljb250aW51ZTsKKwkJfQogCQlpZiAoIXByZWZpeGNtcChhcmcsICItLXdpbmRv
dz0iKSkgewogCQkJY2hhciAqZW5kOwogCQkJd2luZG93ID0gc3RydG91bChhcmcrOSwgJmVuZCwg
MCk7CkBAIC0xNzc3LDYgKzE3OTYsMjQgQEAgaW50IGNtZF9wYWNrX29iamVjdHMoaW50IGFyZ2Ms
IGNvbnN0IGNoYXIgKiphcmd2LCBjb25zdCBjaGFyICpwcmVmaXgpCiAJCX0KIAkJdXNhZ2UocGFj
a191c2FnZSk7CiAJfQorCWlmICggb2Zmc2V0X2xpbWl0ICYmICFibG9iX2xpbWl0ICYmICFwYWNr
X3RvX3N0ZG91dCApIHsKKwkJLyogbmVlZCB0byBsaW1pdCBibG9iIHNpemUgd2hlbiBjcmVhdGlu
ZyBib3VuZGVkIHBhY2tzIG9uIGRpc2sgKi8KKwkJYmxvYl9saW1pdCA9IG9mZnNldF9saW1pdCA+
PiAyOworCQlhZGRlZCB8PSAyOworCX0KKwlpZiAoIG9mZnNldF9saW1pdCAmJiAhbm9fcmV1c2Vf
ZGVsdGEgKSB7CisJCS8qIGRpZG4ndCBhdWRpdCB0aGlzIGNhc2UgeWV0ICovCisJCW5vX3JldXNl
X2RlbHRhID0gMTsKKwkJYWRkZWQgfD0gMTsKKwl9CisJaWYgKCBhZGRlZCApIHsKKwkJZnByaW50
ZihzdGRlcnIsICJBZGRlZCB0byBjb21tYW5kIGxpbmU6Iik7CisJCWlmICggYWRkZWQgJiAxICkK
KwkJCWZwcmludGYoc3RkZXJyLCAiIC0tbm8tcmV1c2UtZGVsdGEiKTsKKwkJaWYgKCBhZGRlZCAm
IDIgKQorCQkJZnByaW50ZihzdGRlcnIsICIgLS1ibG9iLWxpbWl0PSV1IiwgYmxvYl9saW1pdCk7
CisJCWZwcmludGYoc3RkZXJyLCAiXG4iKTsKKwl9CiAKIAkvKiBUcmFkaXRpb25hbGx5ICJwYWNr
LW9iamVjdHMgW29wdGlvbnNdIGJhc2UgZXh0cmEiIGZhaWxlZDsKIAkgKiB3ZSB3b3VsZCBob3dl
dmVyIHdhbnQgdG8gdGFrZSByZWZzIHBhcmFtZXRlciB0aGF0IHdvdWxkCmRpZmYgLS1naXQgYS9n
aXQtcmVwYWNrLnNoIGIvZ2l0LXJlcGFjay5zaAppbmRleCBkZGZhOGI0Li4wMjk5ZmYxIDEwMDc1
NQotLS0gYS9naXQtcmVwYWNrLnNoCisrKyBiL2dpdC1yZXBhY2suc2gKQEAgLTE4LDYgKzE4LDkg
QEAgZG8KIAktcSkJcXVpZXQ9LXEgOzsKIAktZikJbm9fcmV1c2VfZGVsdGE9LS1uby1yZXVzZS1k
ZWx0YSA7OwogCS1sKQlsb2NhbD0tLWxvY2FsIDs7CisJLS1wYWNrLWxpbWl0KSBleHRyYT0iJGV4
dHJhICQxIiA7OworCS0tcGFjay1saW1pdD0qKSBleHRyYT0iJGV4dHJhICQxIiA7OworCS0tYmxv
Yi1saW1pdD0qKSBleHRyYT0iJGV4dHJhICQxIiA7OwogCS0td2luZG93PSopIGV4dHJhPSIkZXh0
cmEgJDEiIDs7CiAJLS1kZXB0aD0qKSBleHRyYT0iJGV4dHJhICQxIiA7OwogCSopCXVzYWdlIDs7
CkBAIC02MiwxMSArNjUsMTIgQEAgY2FzZSAiLCRhbGxfaW50b19vbmUsIiBpbgogZXNhYwogCiBh
cmdzPSIkYXJncyAkbG9jYWwgJHF1aWV0ICRub19yZXVzZV9kZWx0YSRleHRyYSIKLW5hbWU9JChn
aXQtcGFjay1vYmplY3RzIC0tbm9uLWVtcHR5IC0tYWxsIC0tcmVmbG9nICRhcmdzIDwvZGV2L251
bGwgIiRQQUNLVE1QIikgfHwKK25hbWVzPSQoZ2l0LXBhY2stb2JqZWN0cyAtLW5vbi1lbXB0eSAt
LWFsbCAtLXJlZmxvZyAkYXJncyA8L2Rldi9udWxsICIkUEFDS1RNUCIpIHx8CiAJZXhpdCAxCi1p
ZiBbIC16ICIkbmFtZSIgXTsgdGhlbgoraWYgWyAteiAiJG5hbWVzIiBdOyB0aGVuCiAJZWNobyBO
b3RoaW5nIG5ldyB0byBwYWNrLgotZWxzZQorZmkKK2ZvciBuYW1lIGluICRuYW1lcyA7IGRvCiAJ
Y2htb2QgYS13ICIkUEFDS1RNUC0kbmFtZS5wYWNrIgogCWNobW9kIGEtdyAiJFBBQ0tUTVAtJG5h
bWUuaWR4IgogCWlmIHRlc3QgIiRxdWlldCIgIT0gJy1xJzsgdGhlbgpAQCAtOTIsNyArOTYsNyBA
QCBlbHNlCiAJCWV4aXQgMQogCX0KIAlybSAtZiAiJFBBQ0tESVIvb2xkLXBhY2stJG5hbWUucGFj
ayIgIiRQQUNLRElSL29sZC1wYWNrLSRuYW1lLmlkeCIKLWZpCitkb25lCiAKIGlmIHRlc3QgIiRy
ZW1vdmVfcmVkdW5kYW50IiA9IHQKIHRoZW4KLS0gCjEuNS4xLnJjMi4xOC5nOWM4OC1kaXJ0eQoK

------=_Part_59151_29016344.1175812951359--

From: "Dana How" <danahow@gmail.com>
Subject: [PATCH 06/13] small source reorderings to prepare for --pack-limit
Date: Thu, 5 Apr 2007 15:32:14 -0700
Message-ID: <56b7f5510704051532q15ac161am413fc5a3cdf1c93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_59019_30458159.1175812334455"
Cc: git@vger.kernel.org, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:32:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZaVA-00069S-4R
	for gcvg-git@gmane.org; Fri, 06 Apr 2007 00:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767370AbXDEWcQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 18:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767373AbXDEWcQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 18:32:16 -0400
Received: from nz-out-0506.google.com ([64.233.162.228]:12491 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767370AbXDEWcP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 18:32:15 -0400
Received: by nz-out-0506.google.com with SMTP id s1so402595nze
        for <git@vger.kernel.org>; Thu, 05 Apr 2007 15:32:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=VYaRfghbIRC6J9Q/o4xq0+Jv+iaFLa0/YiYDRQbjiO33HrLiC0ufyrH28iXm2wFgWSdGo8fTnecQ1rTpv0OyvzNhZSAyqHst6n1+GmYkXDLe+gS183XJqRzegoekAK0m4SV2PjjhXOvthqVOwwDpKwa5TuW7Fm/bko9WdtSrfeg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=nHY7zFzkyo3WhT5+svpyBQ/6dnzhddGj7vpxYKDPBLqPXMixSl+lfbyGexWrDPeB4dTRBJaijlIhbF1AodY784Pt+FKvzSJb+hs/eEgRqmwP8tPDESdVAi0sEAnxe7dbwxPRBAgtL0sINdIC3YcbApru7GzGpF3Okql5T3pDhzs=
Received: by 10.115.106.7 with SMTP id i7mr943867wam.1175812334525;
        Thu, 05 Apr 2007 15:32:14 -0700 (PDT)
Received: by 10.114.46.4 with HTTP; Thu, 5 Apr 2007 15:32:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43869>

------=_Part_59019_30458159.1175812334455
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

---
 builtin-pack-objects.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell

------=_Part_59019_30458159.1175812334455
Content-Type: text/plain; name="0006-small-source-reorderings-to-prepare-for-pack-limit.patch.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0006-small-source-reorderings-to-prepare-for-pack-limit.patch.txt"
X-Attachment-Id: f_f05saqdp

RnJvbSBhMThkYTE2ZjIyY2IyODg4Y2FkM2Q2Y2U2YzU1MzMyODY1ZWViYjI1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYW5hIEhvdyA8aG93QGRlYXRodmFsbGV5LmNzd2l0Y2guY29t
PgpEYXRlOiBUaHUsIDUgQXByIDIwMDcgMTM6NDc6NTMgLTA3MDAKU3ViamVjdDogW1BBVENIIDA2
LzEzXSBzbWFsbCBzb3VyY2UgcmVvcmRlcmluZ3MgdG8gcHJlcGFyZSBmb3IgLS1wYWNrLWxpbWl0
CgotLS0KIGJ1aWx0aW4tcGFjay1vYmplY3RzLmMgfCAgIDIyICsrKysrKysrKysrKysrLS0tLS0t
LS0KIDEgZmlsZXMgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9idWlsdGluLXBhY2stb2JqZWN0cy5jIGIvYnVpbHRpbi1wYWNrLW9iamVjdHMu
YwppbmRleCA3ZGEwNmE4Li4wYTlkZWIwIDEwMDY0NAotLS0gYS9idWlsdGluLXBhY2stb2JqZWN0
cy5jCisrKyBiL2J1aWx0aW4tcGFjay1vYmplY3RzLmMKQEAgLTUxOSw2ICs1MTksMTYgQEAgc3Rh
dGljIG9mZl90IHdyaXRlX29uZShzdHJ1Y3Qgc2hhMWZpbGUgKmYsCiAJcmV0dXJuIG9mZnNldCAr
IHdyaXRlX29iamVjdChmLCBlKTsKIH0KIAordHlwZWRlZiBpbnQgKCplbnRyeV9zb3J0X3QpKGNv
bnN0IHN0cnVjdCBvYmplY3RfZW50cnkgKiwgY29uc3Qgc3RydWN0IG9iamVjdF9lbnRyeSAqKTsK
Kworc3RhdGljIGVudHJ5X3NvcnRfdCBjdXJyZW50X3NvcnQ7CisKKy8qIGZvcndhcmQgZGVjbGFy
YXRpb25zIGZvciB3cml0ZV9wYWNrX2ZpbGUgKi8KKy8qIChwcm9iYWJseSBzaG91bGQgbW92ZSBz
b3J0aW5nIHN0dWZmIHVwIGhlcmUpICovCitzdGF0aWMgaW50IHNvcnRfY29tcGFyYXRvcihjb25z
dCB2b2lkICpfYSwgY29uc3Qgdm9pZCAqX2IpOworc3RhdGljIGludCBzaGExX3NvcnQoY29uc3Qg
c3RydWN0IG9iamVjdF9lbnRyeSAqYSwgY29uc3Qgc3RydWN0IG9iamVjdF9lbnRyeSAqYik7Citz
dGF0aWMgdm9pZCB3cml0ZV9pbmRleF9maWxlKHZvaWQpOworCiBzdGF0aWMgdm9pZCB3cml0ZV9w
YWNrX2ZpbGUodm9pZCkKIHsKIAl1aW50MzJfdCBpOwpAQCAtNTYzLDYgKzU3MywxMCBAQCBzdGF0
aWMgdm9pZCB3cml0ZV9wYWNrX2ZpbGUodm9pZCkKIAlpZiAod3JpdHRlbiAhPSBucl9yZXN1bHQp
CiAJCWRpZSgid3JvdGUgJXUgb2JqZWN0cyB3aGlsZSBleHBlY3RpbmcgJXUiLCB3cml0dGVuLCBu
cl9yZXN1bHQpOwogCXNoYTFjbG9zZShmLCBwYWNrX2ZpbGVfc2hhMSwgMSk7CisJaWYgKCFwYWNr
X3RvX3N0ZG91dCkgeworCQl3cml0ZV9pbmRleF9maWxlKCk7CisJCXB1dHMoc2hhMV90b19oZXgo
b2JqZWN0X2xpc3Rfc2hhMSkpOworCX0KIH0KIAogc3RhdGljIHZvaWQgd3JpdGVfaW5kZXhfZmls
ZSh2b2lkKQpAQCAtMTEwNywxMCArMTEyMSw2IEBAIHN0YXRpYyB2b2lkIGdldF9vYmplY3RfZGV0
YWlscyh2b2lkKQogCX0KIH0KIAotdHlwZWRlZiBpbnQgKCplbnRyeV9zb3J0X3QpKGNvbnN0IHN0
cnVjdCBvYmplY3RfZW50cnkgKiwgY29uc3Qgc3RydWN0IG9iamVjdF9lbnRyeSAqKTsKLQotc3Rh
dGljIGVudHJ5X3NvcnRfdCBjdXJyZW50X3NvcnQ7Ci0KIHN0YXRpYyBpbnQgc29ydF9jb21wYXJh
dG9yKGNvbnN0IHZvaWQgKl9hLCBjb25zdCB2b2lkICpfYikKIHsKIAlzdHJ1Y3Qgb2JqZWN0X2Vu
dHJ5ICphID0gKihzdHJ1Y3Qgb2JqZWN0X2VudHJ5ICoqKV9hOwpAQCAtMTY5OSwxMCArMTcwOSw2
IEBAIGludCBjbWRfcGFja19vYmplY3RzKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwgY29u
c3QgY2hhciAqcHJlZml4KQogCQkJcHJvZ3Jlc3NfdXBkYXRlID0gMDsKIAkJfQogCQl3cml0ZV9w
YWNrX2ZpbGUoKTsKLQkJaWYgKCFwYWNrX3RvX3N0ZG91dCkgewotCQkJd3JpdGVfaW5kZXhfZmls
ZSgpOwotCQkJcHV0cyhzaGExX3RvX2hleChvYmplY3RfbGlzdF9zaGExKSk7Ci0JCX0KIAl9CiAJ
aWYgKHByb2dyZXNzKQogCQlmcHJpbnRmKHN0ZGVyciwgIlRvdGFsICV1IChkZWx0YSAldSksIHJl
dXNlZCAldSAoZGVsdGEgJXUpXG4iLAotLSAKMS41LjEucmMyLjE4Lmc5Yzg4LWRpcnR5Cgo=
------=_Part_59019_30458159.1175812334455--

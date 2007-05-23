From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix the progress code to output LF only when it is really needed
Date: Wed, 23 May 2007 18:07:25 +0200
Message-ID: <81b0412b0705230907x482a0f52n6e6b2302f0f20d04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_64068_33133292.1179936445689"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 23 18:07:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqtN7-0004Lp-Ai
	for gcvg-git@gmane.org; Wed, 23 May 2007 18:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756670AbXEWQH2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 May 2007 12:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756921AbXEWQH2
	(ORCPT <rfc822;git-outgoing>); Wed, 23 May 2007 12:07:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:55172 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756670AbXEWQH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2007 12:07:27 -0400
Received: by ug-out-1314.google.com with SMTP id j3so576810ugf
        for <git@vger.kernel.org>; Wed, 23 May 2007 09:07:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=NEGh6B8bWP3WLk62DNJPjQHV+nA19BUxm7ua3Q1vy86RqFelPPqSSov2cT0sxKfRMAQGLRW7Hvy1CnUcKg6THQqL0y7sYpxuJf6YAdFU8XiroA4hktwl5EeFQXThJI+XGUupRYq625cjSs/GE338WLhQRXo/CwDNbDYAJDY8f3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=huJR8KuAK/vbn/kPDqqqx0/73fayp746V5Vp7HOsyJ9r7U1+cE/Py1tpnZaENJKqlvdeekJaKfrlf6tQ19oKLGuTBr90FF2RewZZDDP1FCjh+wToHLTilRnIRQckyYmnZDHSH25H9gad3D70Hhyg777FWnbvCYewrqJT91QC2aI=
Received: by 10.78.162.4 with SMTP id k4mr158095hue.1179936445713;
        Wed, 23 May 2007 09:07:25 -0700 (PDT)
Received: by 10.78.97.16 with HTTP; Wed, 23 May 2007 09:07:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48163>

------=_Part_64068_33133292.1179936445689
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

I was wondering about why git-reset --hard now prints an empty
line between the command and the oneline commit description.

 progress.c |    6 +++++-
 progress.h |    1 +
 2 files changed, 6 insertions(+), 1 deletions(-)

------=_Part_64068_33133292.1179936445689
Content-Type: text/plain; 
	name=0001-Fix-the-progress-code-to-output-LF-only-when-it-is-rea.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f21znfsd
Content-Disposition: attachment; filename="0001-Fix-the-progress-code-to-output-LF-only-when-it-is-rea.txt"

RnJvbSAxMzljNTk3ZmVjYmI5ZGRmMThjNDdiMTJjYzk3YzQyNzYzYTEzM2JmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDIzIE1heSAyMDA3IDE3OjU1OjI4ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gRml4IHRo
ZSBwcm9ncmVzcyBjb2RlIHRvIG91dHB1dCBMRiBvbmx5IHdoZW4gaXQgaXMgcmVhbGx5IG5lZWRl
ZAoKClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFpbC5jb20+Ci0tLQog
cHJvZ3Jlc3MuYyB8ICAgIDYgKysrKystCiBwcm9ncmVzcy5oIHwgICAgMSArCiAyIGZpbGVzIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9wcm9n
cmVzcy5jIGIvcHJvZ3Jlc3MuYwppbmRleCAwNWY3ODkwLi40MzQ0ZjRlIDEwMDY0NAotLS0gYS9w
cm9ncmVzcy5jCisrKyBiL3Byb2dyZXNzLmMKQEAgLTYyLDExICs2MiwxMyBAQCBpbnQgZGlzcGxh
eV9wcm9ncmVzcyhzdHJ1Y3QgcHJvZ3Jlc3MgKnByb2dyZXNzLCB1bnNpZ25lZCBuKQogCQkJZnBy
aW50ZihzdGRlcnIsICIlcyU0dSUlICgldS8ldSkgZG9uZVxyIiwKIAkJCQlwcm9ncmVzcy0+cHJl
Zml4LCBwZXJjZW50LCBuLCBwcm9ncmVzcy0+dG90YWwpOwogCQkJcHJvZ3Jlc3NfdXBkYXRlID0g
MDsKKwkJCXByb2dyZXNzLT5uZWVkX2xmID0gMTsKIAkJCXJldHVybiAxOwogCQl9CiAJfSBlbHNl
IGlmIChwcm9ncmVzc191cGRhdGUpIHsKIAkJZnByaW50ZihzdGRlcnIsICIlcyV1XHIiLCBwcm9n
cmVzcy0+cHJlZml4LCBuKTsKIAkJcHJvZ3Jlc3NfdXBkYXRlID0gMDsKKwkJcHJvZ3Jlc3MtPm5l
ZWRfbGYgPSAxOwogCQlyZXR1cm4gMTsKIAl9CiAJcmV0dXJuIDA7CkBAIC04MCw2ICs4Miw3IEBA
IHZvaWQgc3RhcnRfcHJvZ3Jlc3Moc3RydWN0IHByb2dyZXNzICpwcm9ncmVzcywgY29uc3QgY2hh
ciAqdGl0bGUsCiAJcHJvZ3Jlc3MtPnRvdGFsID0gdG90YWw7CiAJcHJvZ3Jlc3MtPmxhc3RfcGVy
Y2VudCA9IC0xOwogCXByb2dyZXNzLT5kZWxheSA9IDA7CisJcHJvZ3Jlc3MtPm5lZWRfbGYgPSAw
OwogCWlmIChzbnByaW50ZihidWYsIHNpemVvZihidWYpLCB0aXRsZSwgdG90YWwpKQogCQlmcHJp
bnRmKHN0ZGVyciwgIiVzXG4iLCBidWYpOwogCXNldF9wcm9ncmVzc19zaWduYWwoKTsKQEAgLTk1
LDEyICs5OCwxMyBAQCB2b2lkIHN0YXJ0X3Byb2dyZXNzX2RlbGF5KHN0cnVjdCBwcm9ncmVzcyAq
cHJvZ3Jlc3MsIGNvbnN0IGNoYXIgKnRpdGxlLAogCXByb2dyZXNzLT5kZWxheWVkX3BlcmNlbnRf
dHJlc2hvbGQgPSBwZXJjZW50X3RyZXNob2xkOwogCXByb2dyZXNzLT5kZWxheWVkX3RpdGxlID0g
dGl0bGU7CiAJcHJvZ3Jlc3MtPmRlbGF5ID0gZGVsYXk7CisJcHJvZ3Jlc3MtPm5lZWRfbGYgPSAw
OwogCXNldF9wcm9ncmVzc19zaWduYWwoKTsKIH0KIAogdm9pZCBzdG9wX3Byb2dyZXNzKHN0cnVj
dCBwcm9ncmVzcyAqcHJvZ3Jlc3MpCiB7CiAJY2xlYXJfcHJvZ3Jlc3Nfc2lnbmFsKCk7Ci0JaWYg
KHByb2dyZXNzLT50b3RhbCkKKwlpZiAocHJvZ3Jlc3MtPm5lZWRfbGYpCiAJCWZwdXRjKCdcbics
IHN0ZGVycik7CiB9CmRpZmYgLS1naXQgYS9wcm9ncmVzcy5oIGIvcHJvZ3Jlc3MuaAppbmRleCA1
YWUxYTg5Li5hN2MxN2NhIDEwMDY0NAotLS0gYS9wcm9ncmVzcy5oCisrKyBiL3Byb2dyZXNzLmgK
QEAgLTgsNiArOCw3IEBAIHN0cnVjdCBwcm9ncmVzcyB7CiAJdW5zaWduZWQgZGVsYXk7CiAJdW5z
aWduZWQgZGVsYXllZF9wZXJjZW50X3RyZXNob2xkOwogCWNvbnN0IGNoYXIgKmRlbGF5ZWRfdGl0
bGU7CisJaW50IG5lZWRfbGY7CiB9OwogCiBpbnQgZGlzcGxheV9wcm9ncmVzcyhzdHJ1Y3QgcHJv
Z3Jlc3MgKnByb2dyZXNzLCB1bnNpZ25lZCBuKTsKLS0gCjEuNS4yLjc4Ny5nNTY3NzAKCg==
------=_Part_64068_33133292.1179936445689--

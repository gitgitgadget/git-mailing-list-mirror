From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] add tests for --quiet option of diff programs
Date: Thu, 15 Mar 2007 00:12:09 +0100
Message-ID: <81b0412b0703141612g70cc77bdn9d81251ed3214b8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_20894_6715832.1173913929852"
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 15 00:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRcdw-0007nu-3G
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 00:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbXCNXMM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 19:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbXCNXMM
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 19:12:12 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:17911 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964771AbXCNXML (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 19:12:11 -0400
Received: by nf-out-0910.google.com with SMTP id o25so433640nfa
        for <git@vger.kernel.org>; Wed, 14 Mar 2007 16:12:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=AY8siiRsa03W0MLlHQIpdt9b/T1gvAJy8yygMO3xDIizEC+nzOeDhJlPv/YO5byUipm/2AviMfZiJ2J717bTss56VhoZ+7VXXn62eQaXeuWu6x7nGKgb47MePQrz5VJazYxGdaRLb4idjX5fxZHcP8nVVqwPGl4NReJqCLcQWRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=tmz4NT7vZFS6SekoLlgFBjMm0mNt4gjKMgezlisIB9ip5sXypJFv82Hvj4/g8zi3W0dG7d6TI8PsyCZtxklxsnNiL+7Q9a0b3DpxWqlhc53LQXVyNyQS74Pfyg3N2vxOBvEQaHDeZ+NOmzC5RMhqeAY9mBXvmHrveL0xmbo103s=
Received: by 10.78.166.7 with SMTP id o7mr860988hue.1173913929879;
        Wed, 14 Mar 2007 16:12:09 -0700 (PDT)
Received: by 10.78.138.5 with HTTP; Wed, 14 Mar 2007 16:12:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42247>

------=_Part_20894_6715832.1173913929852
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
This is almost the same test for exit code, it just also
counts the line on the output.

 t/t4017-quiet.sh |   79 ++++++++++++++++++++++++++
 1 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100755 t/t4017-quiet.sh

------=_Part_20894_6715832.1173913929852
Content-Type: text/x-patch; 
	name=0001-Add-tests-for-quiet-option-of-diff-programs.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ezae06lz
Content-Disposition: attachment; filename="0001-Add-tests-for-quiet-option-of-diff-programs.patch"

RnJvbSBiMTQ0YjQ4ZjcwYTk2MGQyNDdhYzAyNDQ1NGEzZWM4NzA3MGQwZjhlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhQHN0ZWVsLmhvbWU+CkRhdGU6IFdl
ZCwgMTQgTWFyIDIwMDcgMjM6NTc6MjMgKzAxMDAKU3ViamVjdDogW1BBVENIXSBBZGQgdGVzdHMg
Zm9yIC0tcXVpZXQgb3B0aW9uIG9mIGRpZmYgcHJvZ3JhbXMKClNpZ25lZC1vZmYtYnk6IEFsZXgg
Umllc2VuIDxyYWEubGttbEBnbWFpbC5jb20+Ci0tLQogdC90NDAxNy1xdWlldC5zaCB8ICAgODAg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAx
IGZpbGVzIGNoYW5nZWQsIDgwIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiBjcmVhdGUg
bW9kZSAxMDA3NTUgdC90NDAxNy1xdWlldC5zaAoKZGlmZiAtLWdpdCBhL3QvdDQwMTctcXVpZXQu
c2ggYi90L3Q0MDE3LXF1aWV0LnNoCm5ldyBmaWxlIG1vZGUgMTAwNzU1CmluZGV4IDAwMDAwMDAu
LmU3NDdlODQKLS0tIC9kZXYvbnVsbAorKysgYi90L3Q0MDE3LXF1aWV0LnNoCkBAIC0wLDAgKzEs
ODAgQEAKKyMhL2Jpbi9zaAorCit0ZXN0X2Rlc2NyaXB0aW9uPSdSZXR1cm4gdmFsdWUgb2YgZGlm
ZnMnCisKKy4gLi90ZXN0LWxpYi5zaAorCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdzZXR1cCcgJwor
CWVjaG8gMSA+YSAmJgorCWdpdCBhZGQgLiAmJgorCWdpdCBjb21taXQgLW0gZmlyc3QgJiYKKwll
Y2hvIDIgPmIgJiYKKwlnaXQgYWRkIC4gJiYKKwlnaXQgY29tbWl0IC1hIC1tIHNlY29uZAorJwor
Cit0ZXN0X2V4cGVjdF9zdWNjZXNzICdnaXQgZGlmZi10cmVlIEhFQUReIEhFQUQnICcKKwlnaXQg
ZGlmZi10cmVlIC0tcXVpZXQgSEVBRF4gSEVBRCA+Y250CisJdGVzdCAkPyA9IDEgJiYgdGVzdCAk
KHdjIC1sIDxjbnQpID0gMAorJwordGVzdF9leHBlY3Rfc3VjY2VzcyAnZ2l0IGRpZmYtdHJlZSBI
RUFEXiBIRUFEIC0tIGEnICcKKwlnaXQgZGlmZi10cmVlIC0tcXVpZXQgSEVBRF4gSEVBRCAtLSBh
ID5jbnQKKwl0ZXN0ICQ/ID0gMCAmJiB0ZXN0ICQod2MgLWwgPGNudCkgPSAwCisnCit0ZXN0X2V4
cGVjdF9zdWNjZXNzICdnaXQgZGlmZi10cmVlIEhFQUReIEhFQUQgLS0gYicgJworCWdpdCBkaWZm
LXRyZWUgLS1xdWlldCBIRUFEXiBIRUFEIC0tIGIgPmNudAorCXRlc3QgJD8gPSAxICYmIHRlc3Qg
JCh3YyAtbCA8Y250KSA9IDAKKycKKyMgdGhpcyBkaWZmIG91dHB1dHMgb25lIGxpbmU6IHNoYTEg
b2YgdGhlIGdpdmVuIGhlYWQKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2VjaG8gSEVBRCB8IGdpdCBk
aWZmLXRyZWUgLS1zdGRpbicgJworCWVjaG8gJChnaXQgcmV2LXBhcnNlIEhFQUQpIHwgZ2l0IGRp
ZmYtdHJlZSAtLXF1aWV0IC0tc3RkaW4gPmNudAorCXRlc3QgJD8gPSAxICYmIHRlc3QgJCh3YyAt
bCA8Y250KSA9IDEKKycKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2dpdCBkaWZmLXRyZWUgSEVBRCBI
RUFEJyAnCisJZ2l0IGRpZmYtdHJlZSAtLXF1aWV0IEhFQUQgSEVBRCA+Y250CisJdGVzdCAkPyA9
IDAgJiYgdGVzdCAkKHdjIC1sIDxjbnQpID0gMAorJwordGVzdF9leHBlY3Rfc3VjY2VzcyAnZ2l0
IGRpZmYtZmlsZXMnICcKKwlnaXQgZGlmZi1maWxlcyAtLXF1aWV0ID5jbnQKKwl0ZXN0ICQ/ID0g
MCAmJiB0ZXN0ICQod2MgLWwgPGNudCkgPSAwCisnCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdnaXQg
ZGlmZi1pbmRleCAtLWNhY2hlZCBIRUFEJyAnCisJZ2l0IGRpZmYtaW5kZXggLS1xdWlldCAtLWNh
Y2hlZCBIRUFEID5jbnQKKwl0ZXN0ICQ/ID0gMCAmJiB0ZXN0ICQod2MgLWwgPGNudCkgPSAwCisn
Cit0ZXN0X2V4cGVjdF9zdWNjZXNzICdnaXQgZGlmZi1pbmRleCAtLWNhY2hlZCBIRUFEXicgJwor
CWdpdCBkaWZmLWluZGV4IC0tcXVpZXQgLS1jYWNoZWQgSEVBRF4gPmNudAorCXRlc3QgJD8gPSAx
ICYmIHRlc3QgJCh3YyAtbCA8Y250KSA9IDAKKycKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2dpdCBk
aWZmLWluZGV4IC0tY2FjaGVkIEhFQUReJyAnCisJZWNobyB0ZXh0ID4+YiAmJgorCWVjaG8gMyA+
YyAmJgorCWdpdCBhZGQgLiAmJiB7CisJCWdpdCBkaWZmLWluZGV4IC0tcXVpZXQgLS1jYWNoZWQg
SEVBRF4gPmNudAorCQl0ZXN0ICQ/ID0gMSAmJiB0ZXN0ICQod2MgLWwgPGNudCkgPSAwCisJfQor
JwordGVzdF9leHBlY3Rfc3VjY2VzcyAnZ2l0IGRpZmYtdHJlZSAtU3RleHQgSEVBRF4gSEVBRCAt
LSBiJyAnCisJZ2l0IGNvbW1pdCAtbSAidGV4dCBpbiBiIiAmJiB7CisJCWdpdCBkaWZmLXRyZWUg
LS1xdWlldCAtU3RleHQgSEVBRF4gSEVBRCAtLSBiID5jbnQKKwkJdGVzdCAkPyA9IDEgJiYgdGVz
dCAkKHdjIC1sIDxjbnQpID0gMAorCX0KKycKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ2dpdCBkaWZm
LXRyZWUgLVNub3QtZm91bmQgSEVBRF4gSEVBRCAtLSBiJyAnCisJZ2l0IGRpZmYtdHJlZSAtLXF1
aWV0IC1Tbm90LWZvdW5kIEhFQUReIEhFQUQgLS0gYiA+Y250CisJdGVzdCAkPyA9IDAgJiYgdGVz
dCAkKHdjIC1sIDxjbnQpID0gMAorJwordGVzdF9leHBlY3Rfc3VjY2VzcyAnZ2l0IGRpZmYtZmls
ZXMnICcKKwllY2hvIDMgPj5jICYmIHsKKwkJZ2l0IGRpZmYtZmlsZXMgLS1xdWlldCA+Y250CisJ
CXRlc3QgJD8gPSAxICYmIHRlc3QgJCh3YyAtbCA8Y250KSA9IDAKKwl9CisnCit0ZXN0X2V4cGVj
dF9zdWNjZXNzICdnaXQgZGlmZi1pbmRleCAtLWNhY2hlZCBIRUFEJyAnCisJZ2l0IHVwZGF0ZS1p
bmRleCBjICYmIHsKKwkJZ2l0IGRpZmYtaW5kZXggLS1xdWlldCAtLWNhY2hlZCBIRUFEID5jbnQK
KwkJdGVzdCAkPyA9IDEgJiYgdGVzdCAkKHdjIC1sIDxjbnQpID0gMAorCX0KKycKKwordGVzdF9k
b25lCi0tIAoxLjUuMC4zLjU0NS5nNWQzYmEKCg==
------=_Part_20894_6715832.1173913929852--

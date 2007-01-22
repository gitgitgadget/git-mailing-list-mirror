From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH 2/3] Force Activestate Perl to tie git command pipe handle to a handle class
Date: Mon, 22 Jan 2007 17:25:10 +0100
Message-ID: <81b0412b0701220825w2560ec47uf0e074442242af32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_156865_24745566.1169483110545"
Cc: "Junio C Hamano" <junkio@cox.net>, "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 22 17:25:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H91zK-0005E5-Mm
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 17:25:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbXAVQZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 11:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751948AbXAVQZU
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 11:25:20 -0500
Received: from an-out-0708.google.com ([209.85.132.242]:50721 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbXAVQZS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 11:25:18 -0500
Received: by an-out-0708.google.com with SMTP id b33so409453ana
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 08:25:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=hwgrmcXnd7LNalrH/XUAR0OPadioZka6nVOODl8PXodiNpdxE0orzJPqufAwSGvWRmrg/cscSN0kTIibAh+d86VlJ+ECV+tE9Saj7AE0Rx2vz0SV//AHCobmWQNv6HtsfvmC8Tgq8hrE/hhUCs4dBMzQbL3cgzW6WNfIeP4YipU=
Received: by 10.48.210.20 with SMTP id i20mr6925424nfg.1169483110591;
        Mon, 22 Jan 2007 08:25:10 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 22 Jan 2007 08:25:10 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37424>

------=_Part_156865_24745566.1169483110545
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Otherwise it tries to tie it to a scalar and complains about missing
method. Dunno why, may be ActiveState brokenness again.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
Acked-by: Petr Baudis <pasky@suse.cz>

---
 perl/Git.pm |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

------=_Part_156865_24745566.1169483110545
Content-Type: application/xxxxx; name="0002-Force-Activestate-Perl-to-tie-git-command-pipe-handle-to-a-handle-class.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0002-Force-Activestate-Perl-to-tie-git-command-pipe-handle-to-a-handle-class.patch"
X-Attachment-Id: f_ex942ltt

RnJvbSAyYjhhNzE2YzY0NGMzYTRjYTg1NDQ2MDA3ZGFlZTBlNzkyNzAzODIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBNb24sIDIyIEphbiAyMDA3IDE3OjE2OjA1ICswMTAwClN1YmplY3Q6IFtQQVRDSCAyLzNdIEZv
cmNlIEFjdGl2ZXN0YXRlIFBlcmwgdG8gdGllIGdpdCBjb21tYW5kIHBpcGUgaGFuZGxlIHRvIGEg
aGFuZGxlIGNsYXNzCgpPdGhlcndpc2UgaXQgdHJpZXMgdG8gdGllIGl0IHRvIGEgc2NhbGFyIGFu
ZCBjb21wbGFpbnMgYWJvdXQgbWlzc2luZwptZXRob2QuIER1bm5vIHdoeSwgbWF5IGJlIEFjdGl2
ZVN0YXRlIGJyb2tlbm5lc3MgYWdhaW4uCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFh
LmxrbWxAZ21haWwuY29tPgpBY2tlZC1ieTogUGV0ciBCYXVkaXMgPHBhc2t5QHN1c2UuY3o+Cgot
LS0KIHBlcmwvR2l0LnBtIHwgICAgOCArKysrKysrLQogMSBmaWxlcyBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcGVybC9HaXQucG0gYi9wZXJs
L0dpdC5wbQppbmRleCA1ODQxNGUzLi4yZjZiNTlhIDEwMDY0NAotLS0gYS9wZXJsL0dpdC5wbQor
KysgYi9wZXJsL0dpdC5wbQpAQCAtNzQyLDcgKzc0MiwxMyBAQCBzdWIgX2NvbW1hbmRfY29tbW9u
X3BpcGUgewogCQkjCXdhcm4gJ2lnbm9yaW5nIFNUREVSUiBvcHRpb24gLSBydW5uaW5nIHcvIEFj
dGl2ZVN0YXRlJzsKIAkJJGRpcmVjdGlvbiBlcSAnLXwnIG9yCiAJCQlkaWUgJ2lucHV0IHBpcGUg
Zm9yIEFjdGl2ZVN0YXRlIG5vdCBpbXBsZW1lbnRlZCc7Ci0JCXRpZSAoJGZoLCAnR2l0OjphY3Rp
dmVzdGF0ZV9waXBlJywgJGNtZCwgQGFyZ3MpOworCQkjIHRoZSBzdHJhbmdlIGNvbnN0cnVjdGlv
biB3aXRoICpBQ1BJUEUgaXMganVzdCB0bworCQkjIGV4cGxhaW4gdGhlIHRpZSBiZWxvdyB0aGF0
IHdlIHdhbnQgdG8gYmluZCB0bworCQkjIGEgaGFuZGxlIGNsYXNzLCBub3Qgc2NhbGFyLiBJdCBp
cyBub3Qga25vd24gaWYKKwkJIyBpdCBpcyBzb21ldGhpbmcgc3BlY2lmaWMgdG8gQWN0aXZlU3Rh
dGUgUGVybCBvcgorCQkjIGp1c3QgYSBQZXJsIHF1aXJrLgorCQl0aWUgKCpBQ1BJUEUsICdHaXQ6
OmFjdGl2ZXN0YXRlX3BpcGUnLCAkY21kLCBAYXJncyk7CisJCSRmaCA9ICpBQ1BJUEU7CiAKIAl9
IGVsc2UgewogCQlteSAkcGlkID0gb3BlbigkZmgsICRkaXJlY3Rpb24pOwotLSAKMS41LjAucmMy
LmczZjFhCgo=
------=_Part_156865_24745566.1169483110545--

From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [RESEND PATCH 2/3] Force Activestate Perl to tie git command pipe handle to a handle class
Date: Mon, 22 Jan 2007 18:12:15 +0100
Message-ID: <81b0412b0701220912qde73d90y7c2b7529cbfad314@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_157598_9821178.1169485935157"
Cc: "Junio C Hamano" <junkio@cox.net>, "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 22 18:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H92iX-0000oL-6X
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 18:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbXAVRMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 12:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbXAVRMW
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 12:12:22 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:21111 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbXAVRMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 12:12:21 -0500
Received: by an-out-0708.google.com with SMTP id b33so421075ana
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 09:12:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=QwvG2CZPTiSDf1b+LmAYyddODVjNdf07cCRxHM2qZLTFsm7EdfRbdV85jc65/OYxDxmz94184So5raZCrycSAyxMhuL48FwcoGdYV7eh0nVZEwmFbaybutHiF/mFoTAJu3ToCzhBpwRBaY6TafwBKZd37kZklCMqEDM4I9E3D60=
Received: by 10.49.90.4 with SMTP id s4mr7007497nfl.1169485940004;
        Mon, 22 Jan 2007 09:12:20 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 22 Jan 2007 09:12:15 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37429>

------=_Part_157598_9821178.1169485935157
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Otherwise it tries to tie it to a scalar and complains about missing
method. Dunno why, may be ActiveState brokenness again.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 perl/Git.pm |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

------=_Part_157598_9821178.1169485935157
Content-Type: text/plain; name="0002-Force-Activestate-Perl-to-tie-git-command-pipe-handle-to-a-handle-class.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0002-Force-Activestate-Perl-to-tie-git-command-pipe-handle-to-a-handle-class.txt"
X-Attachment-Id: f_ex95r6kr

RnJvbSAyYjhhNzE2YzY0NGMzYTRjYTg1NDQ2MDA3ZGFlZTBlNzkyNzAzODIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBNb24sIDIyIEphbiAyMDA3IDE3OjE2OjA1ICswMTAwClN1YmplY3Q6IFtQQVRDSCAyLzNdIEZv
cmNlIEFjdGl2ZXN0YXRlIFBlcmwgdG8gdGllIGdpdCBjb21tYW5kIHBpcGUgaGFuZGxlIHRvIGEg
aGFuZGxlIGNsYXNzCgpPdGhlcndpc2UgaXQgdHJpZXMgdG8gdGllIGl0IHRvIGEgc2NhbGFyIGFu
ZCBjb21wbGFpbnMgYWJvdXQgbWlzc2luZwptZXRob2QuIER1bm5vIHdoeSwgbWF5IGJlIEFjdGl2
ZVN0YXRlIGJyb2tlbm5lc3MgYWdhaW4uCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFh
LmxrbWxAZ21haWwuY29tPgotLS0KIHBlcmwvR2l0LnBtIHwgICAgOCArKysrKysrLQogMSBmaWxl
cyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
cGVybC9HaXQucG0gYi9wZXJsL0dpdC5wbQppbmRleCA1ODQxNGUzLi4yZjZiNTlhIDEwMDY0NAot
LS0gYS9wZXJsL0dpdC5wbQorKysgYi9wZXJsL0dpdC5wbQpAQCAtNzQyLDcgKzc0MiwxMyBAQCBz
dWIgX2NvbW1hbmRfY29tbW9uX3BpcGUgewogCQkjCXdhcm4gJ2lnbm9yaW5nIFNUREVSUiBvcHRp
b24gLSBydW5uaW5nIHcvIEFjdGl2ZVN0YXRlJzsKIAkJJGRpcmVjdGlvbiBlcSAnLXwnIG9yCiAJ
CQlkaWUgJ2lucHV0IHBpcGUgZm9yIEFjdGl2ZVN0YXRlIG5vdCBpbXBsZW1lbnRlZCc7Ci0JCXRp
ZSAoJGZoLCAnR2l0OjphY3RpdmVzdGF0ZV9waXBlJywgJGNtZCwgQGFyZ3MpOworCQkjIHRoZSBz
dHJhbmdlIGNvbnN0cnVjdGlvbiB3aXRoICpBQ1BJUEUgaXMganVzdCB0bworCQkjIGV4cGxhaW4g
dGhlIHRpZSBiZWxvdyB0aGF0IHdlIHdhbnQgdG8gYmluZCB0bworCQkjIGEgaGFuZGxlIGNsYXNz
LCBub3Qgc2NhbGFyLiBJdCBpcyBub3Qga25vd24gaWYKKwkJIyBpdCBpcyBzb21ldGhpbmcgc3Bl
Y2lmaWMgdG8gQWN0aXZlU3RhdGUgUGVybCBvcgorCQkjIGp1c3QgYSBQZXJsIHF1aXJrLgorCQl0
aWUgKCpBQ1BJUEUsICdHaXQ6OmFjdGl2ZXN0YXRlX3BpcGUnLCAkY21kLCBAYXJncyk7CisJCSRm
aCA9ICpBQ1BJUEU7CiAKIAl9IGVsc2UgewogCQlteSAkcGlkID0gb3BlbigkZmgsICRkaXJlY3Rp
b24pOwotLSAKMS41LjAucmMyLmczZjFhCgo=
------=_Part_157598_9821178.1169485935157--

From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [RESEND PATCH 3/3] Cleanup uninitialized value in chomp
Date: Mon, 22 Jan 2007 18:13:09 +0100
Message-ID: <81b0412b0701220913k381ce400sd317f103064406f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_157610_29549366.1169485989223"
Cc: "Junio C Hamano" <junkio@cox.net>, "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 22 18:13:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H92jO-00010o-Ta
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 18:13:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbXAVRNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 12:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbXAVRNQ
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 12:13:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:15940 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbXAVRNP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 12:13:15 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1106974uga
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 09:13:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=cv5GEU2djgNJrIaLkHPodhSqcH19oSV24j7KxhDLd1lkF3GyNcsLRr5DuLUjA3qjsTBmxYHpkp8MTKjJGCYxSVjRzBvuLjaYagRAIIG/Y8wLt4G3bClLzvPjJsLpA+RbYf2Q83bmE6C4504PofpSMgbdW6McrnIxWFwv9sMI6rM=
Received: by 10.82.138.6 with SMTP id l6mr5366021bud.1169485989302;
        Mon, 22 Jan 2007 09:13:09 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 22 Jan 2007 09:13:09 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37430>

------=_Part_157610_29549366.1169485989223
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

which happens if you use ActiveState Perl and a
pipe workaround specially for it.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 perl/Git.pm |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

------=_Part_157610_29549366.1169485989223
Content-Type: text/plain; name="0003-Cleanup-uninitialized-value-in-chomp.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0003-Cleanup-uninitialized-value-in-chomp.txt"
X-Attachment-Id: f_ex95sccn

RnJvbSBkOGZiY2E3ODNkNzI3YWZmMGM3MDc4MzMwYjdlYzNkMDg5NGU5MDkzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBNb24sIDIyIEphbiAyMDA3IDE1OjU4OjAzICswMTAwClN1YmplY3Q6IFtQQVRDSCAzLzNdIENs
ZWFudXAgdW5pbml0aWFsaXplZCB2YWx1ZSBpbiBjaG9tcAoKd2hpY2ggaGFwcGVucyBpZiB5b3Ug
dXNlIEFjdGl2ZVN0YXRlIFBlcmwgYW5kIGEKcGlwZSB3b3JrYXJvdW5kIHNwZWNpYWxseSBmb3Ig
aXQuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgotLS0K
IHBlcmwvR2l0LnBtIHwgICAgMiArLQogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcGVybC9HaXQucG0gYi9wZXJsL0dpdC5wbQpp
bmRleCAyZjZiNTlhLi5jMTcyOWJhIDEwMDY0NAotLS0gYS9wZXJsL0dpdC5wbQorKysgYi9wZXJs
L0dpdC5wbQpAQCAtMjc1LDcgKzI3NSw3IEBAIHN1YiBjb21tYW5kIHsKIAogCX0gZWxzZSB7CiAJ
CW15IEBsaW5lcyA9IDwkZmg+OwotCQljaG9tcCBAbGluZXM7CisJCWRlZmluZWQgYW5kIGNob21w
IGZvciBAbGluZXM7CiAJCXRyeSB7CiAJCQlfY21kX2Nsb3NlKCRmaCwgJGN0eCk7CiAJCX0gY2F0
Y2ggR2l0OjpFcnJvcjo6Q29tbWFuZCB3aXRoIHsKLS0gCjEuNS4wLnJjMi5nM2YxYQoK
------=_Part_157610_29549366.1169485989223--

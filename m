From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH 3/3] Cleanup uninitialized value in chomp
Date: Mon, 22 Jan 2007 17:25:55 +0100
Message-ID: <81b0412b0701220825j260dc412i3c2501cc6737fcfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_156881_18605036.1169483155669"
Cc: "Junio C Hamano" <junkio@cox.net>, "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 22 17:26:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H91zi-0005Jy-U8
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 17:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbXAVQ0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 11:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbXAVQ0A
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 11:26:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:11494 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbXAVQZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 11:25:59 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1361041nfa
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 08:25:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=LeH2D8JKotUe/BeD+vieuwnPSChh+cM2JfZnTXEzjQidXhwW/cRV4OdH98ymVVSdSp7XNa+XLIMDA96gOeHOlbhDN5ta76Sz7KnW+fQZrGyDJFgnYsJfu1c20wbHILXkRea5XV4r9mB0x3hyfuuOKj0Znd+6P0EJ6v3kpV7X7fE=
Received: by 10.48.216.8 with SMTP id o8mr2455920nfg.1169483156072;
        Mon, 22 Jan 2007 08:25:56 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 22 Jan 2007 08:25:55 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37425>

------=_Part_156881_18605036.1169483155669
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

which happens if you use ActiveState Perl and a
pipe workaround specially for it.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 perl/Git.pm |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

------=_Part_156881_18605036.1169483155669
Content-Type: application/xxxxx; 
	name=0003-Cleanup-uninitialized-value-in-chomp.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ex943okc
Content-Disposition: attachment; filename="0003-Cleanup-uninitialized-value-in-chomp.patch"

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
------=_Part_156881_18605036.1169483155669--

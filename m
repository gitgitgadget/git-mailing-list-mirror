From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Handle missing prefix for "Subject:" as if no prefix given
Date: Wed, 4 Jul 2007 12:41:04 +0200
Message-ID: <81b0412b0707040341l62474c01iba64ba136bd29d95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_93459_7430246.1183545664635"
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Adam Roben" <aroben@apple.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 12:41:12 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I62IK-0005Yj-5J
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 12:41:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758276AbXGDKlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 06:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758169AbXGDKlI
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 06:41:08 -0400
Received: from ik-out-1112.google.com ([66.249.90.179]:61571 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757980AbXGDKlG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 06:41:06 -0400
Received: by ik-out-1112.google.com with SMTP id b32so1601519ika
        for <git@vger.kernel.org>; Wed, 04 Jul 2007 03:41:04 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=jPB34A7WRyAnKZUGffZ5QrfMSFmapnQstj8c2aOHT8u1svfb1dIqpBG2cYaxCMEkQRzGLJ9j9txO+lfHHXMXAO4bMCANUFAvehin1kIbCOCcKaDLthoZxqSxugnRD2u0oVuM6b+D/QwNUx6Sv3cqBbjs+lcm7IjX1B6OuyhBZPw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Beb7T65NPvMjFG77B492CV/hob488KrXysbdT4KLv72nw/lsT2vTndVGJYrpC7LOrMP+nSPjj46KPEQ0KL230qdhd+n+CHATyBS6lzFaG6tzYnAGCk1o+Xf6NNcY2a+czAQDAdSee3Ai9DmaXqWtHgc83DnrhwSD8clru+Ed2II=
Received: by 10.78.81.20 with SMTP id e20mr4027751hub.1183545664663;
        Wed, 04 Jul 2007 03:41:04 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Wed, 4 Jul 2007 03:41:04 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51589>

------=_Part_93459_7430246.1183545664635
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 log-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

------=_Part_93459_7430246.1183545664635
Content-Type: text/plain; name="0001-Handle-missing-prefix-for-Subject-as-if-no-prefix.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Handle-missing-prefix-for-Subject-as-if-no-prefix.txt"
X-Attachment-Id: f_f3poko6n

RnJvbSBhZmQzZDdkNjI2MDdmY2RkOTg2NmMyMjY0MWM4NjIzNzExYWI2MTQ3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhQGxpbWJvLmxvY2FsZG9tYWluPgpE
YXRlOiBXZWQsIDQgSnVsIDIwMDcgMTI6MzM6NDYgKzAyMDAKU3ViamVjdDogW1BBVENIXSBIYW5k
bGUgbWlzc2luZyBwcmVmaXggZm9yICJTdWJqZWN0OiIgYXMgaWYgbm8gcHJlZml4IGdpdmVuCgot
LS0KIGxvZy10cmVlLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9sb2ctdHJlZS5jIGIvbG9nLXRyZWUuYwpp
bmRleCBjZWQzZjMzLi44NjI0ZDVhIDEwMDY0NAotLS0gYS9sb2ctdHJlZS5jCisrKyBiL2xvZy10
cmVlLmMKQEAgLTIwMCw3ICsyMDAsNyBAQCB2b2lkIHNob3dfbG9nKHN0cnVjdCByZXZfaW5mbyAq
b3B0LCBjb25zdCBjaGFyICpzZXApCiAJCQkJCWRpZ2l0c19pbl9udW1iZXIob3B0LT50b3RhbCks
CiAJCQkJCW9wdC0+bnIsIG9wdC0+dG90YWwpOwogCQkJc3ViamVjdCA9IGJ1ZmZlcjsKLQkJfSBl
bHNlIGlmIChvcHQtPnRvdGFsID09IDApIHsKKwkJfSBlbHNlIGlmIChvcHQtPnRvdGFsID09IDAg
JiYgb3B0LT5zdWJqZWN0X3ByZWZpeCAmJiAqb3B0LT5zdWJqZWN0X3ByZWZpeCkgewogCQkJc3Rh
dGljIGNoYXIgYnVmZmVyWzI1Nl07CiAJCQlzbnByaW50ZihidWZmZXIsIHNpemVvZihidWZmZXIp
LAogCQkJCQkiU3ViamVjdDogWyVzXSAiLAotLSAKMS41LjIuMi42NjkuZ2FkMzE2Cgo=
------=_Part_93459_7430246.1183545664635--

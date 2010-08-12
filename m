From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv4 2/2] pull --rebase: Avoid spurious conflicts and
 reapplying unnecessary patches
Date: Thu, 12 Aug 2010 16:40:20 +0200
Message-ID: <AANLkTi=a51EOCmLCbJTbLg5bcN=96HR5yWMruRjVnM-J@mail.gmail.com>
References: <1281592569-740-1-git-send-email-newren@gmail.com>
 <1281592569-740-3-git-send-email-newren@gmail.com> <AANLkTimHiYUPyNTtT4SwapqN8YZGB1wjxJPwTTaPZhEa@mail.gmail.com>
 <AANLkTikLhe9+6ovLT99qG9wwDjXVmT8_81xuN8P31eve@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364c654fa90bb3048da159b9
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	martinvz <martin.von.zweigbergk@gmail.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 16:40:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjYxb-0006WJ-CY
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 16:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760203Ab0HLOkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 10:40:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35346 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753798Ab0HLOkk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 10:40:40 -0400
Received: by pwi4 with SMTP id 4so151879pwi.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 07:40:40 -0700 (PDT)
Received: by 10.114.79.1 with SMTP id c1mr212865wab.1.1281624040339; Thu, 12
 Aug 2010 07:40:40 -0700 (PDT)
Received: by 10.114.195.14 with HTTP; Thu, 12 Aug 2010 07:40:20 -0700 (PDT)
In-Reply-To: <AANLkTikLhe9+6ovLT99qG9wwDjXVmT8_81xuN8P31eve@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153378>

--0016364c654fa90bb3048da159b9
Content-Type: text/plain; charset=ISO-8859-1

And now the attachment.

Santi

--0016364c654fa90bb3048da159b9
Content-Type: text/x-patch; charset=US-ASCII; 
	name="pull-rebase-Avoid-spurious-conflicts-and-reapplying.diff"
Content-Disposition: attachment; 
	filename="pull-rebase-Avoid-spurious-conflicts-and-reapplying.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gcrpu4qu0

ZGlmZiAtLWdpdCBjL2dpdC1wdWxsLnNoIHcvZ2l0LXB1bGwuc2gKaW5kZXggYTA5YTQ0ZS4uYzE2
MTdkNSAxMDA3NTUKLS0tIGMvZ2l0LXB1bGwuc2gKKysrIHcvZ2l0LXB1bGwuc2gKQEAgLTIxNCw3
ICsyMTQsMTAgQEAgdGVzdCB0cnVlID0gIiRyZWJhc2UiICYmIHsKIAlkbwogCQlpZiB0ZXN0ICIk
cmVmbG9nIiA9ICIkKGdpdCBtZXJnZS1iYXNlICRyZWZsb2cgJGN1cnJfYnJhbmNoKSIKIAkJdGhl
bgotCQkJb2xkcmVtb3RlcmVmPSIkcmVmbG9nIgorCQkJaWYgdGVzdCAiJHJlZmxvZyIgIT0gJChn
aXQgbWVyZ2UtYmFzZSAkcmVmbG9nICRyZW1vdGVyZWYpCisJCQl0aGVuCisJCQkJb2xkcmVtb3Rl
cmVmPSIkcmVmbG9nIgorCQkJZmkKIAkJCWJyZWFrCiAJCWZpCiAJZG9uZQpAQCAtMjczLDYgKzI3
NiwxNCBAQCB0aGVuCiAJZXhpdAogZmkKIAoraWYgdGVzdCB0cnVlID0gIiRyZWJhc2UiCit0aGVu
CisJaWYgdGVzdCAiJG9sZHJlbW90ZXJlZiIgPSAkKGdpdCBtZXJnZS1iYXNlICRvbGRyZW1vdGVy
ZWYgJG1lcmdlX2hlYWQpCisJdGhlbgorCQl1bnNldCBvbGRyZW1vdGVyZWYKKwlmaQorZmkKKwog
bWVyZ2VfbmFtZT0kKGdpdCBmbXQtbWVyZ2UtbXNnICRsb2dfYXJnIDwiJEdJVF9ESVIvRkVUQ0hf
SEVBRCIpIHx8IGV4aXQKIGNhc2UgIiRyZWJhc2UiIGluCiB0cnVlKQo=
--0016364c654fa90bb3048da159b9--

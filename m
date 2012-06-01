From: Jiang Xin <worldhello.net@gmail.com>
Subject: Please pull git-l10n updates on master branch
Date: Fri, 1 Jun 2012 18:20:35 +0800
Message-ID: <CANYiYbF3sbtKVTZJOTbQ-aOjBKGKFZfq-xQDwyOvR56C7akrLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Marco Paolone <marcopaolone@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 12:20:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaOyI-0007Lq-LT
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 12:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756689Ab2FAKUh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 06:20:37 -0400
Received: from mail-gh0-f180.google.com ([209.85.160.180]:54050 "EHLO
	mail-gh0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361Ab2FAKUg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 06:20:36 -0400
Received: by ghbz12 with SMTP id z12so1851255ghb.11
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 03:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uOTOz19YbZBq93XiDIQuopwJjBTZB/ZKFhwIm9s1QsA=;
        b=s8qq+7KMswrGPRTd3bNmuUNZY/9/WINjPgkjpzJW9vQXdtgTNTTC5az1vot8nCcqdv
         s2r03q/r/Bqf5Rqcz4VEIMw4s7Xoj7D+zh9kcIn1yMM5qbUX514mQ2SZ3vcKjnqzGSVd
         H8KspQVt2FVio3EgnK00GmPaRmYKZ+pxIeRB/EeS9KJQajcPXf2CW/FqK+X+zUk/6T1A
         bIsnv52AT8oYyU94ujexbBufi1Fx/S2aGzHV44u9WCF7GLCV+qP23oub3MBdlykm+ijb
         kAPqotkjS65m/aIWCzNbNhqcyPVTlzvB7cCTtWM3rOqHoCIcFBJKL0+SECgnMrTwD5h7
         HQoQ==
Received: by 10.43.126.1 with SMTP id gu1mr1097199icc.6.1338546035678; Fri, 01
 Jun 2012 03:20:35 -0700 (PDT)
Received: by 10.50.111.194 with HTTP; Fri, 1 Jun 2012 03:20:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198973>

Hi Junio,

As usual, this pull is for master branch. In this pull, both 'it.po'
and 'zh_CN.po'
have fuzzy translations. One translation in 'zh_CN.po' intends to be fu=
zzy,
because it is hard to translate right, and I sent a patch for this yest=
erday.

    #: builtin/apply.c:3266
    #, fuzzy, c-format
    msgid "new mode (%o) of %s does not match old mode (%o)%s%s"
    msgstr "%2$s =B5=C4=D0=C2=C4=A3=CA=BD=A3=A8%1$o=A3=A9=BA=CD=BE=C9=C4=
=A3=CA=BD=A3=A8%3$o=A3=A9%4$s%5$s =B2=BB=C6=A5=C5=E4"

=46uzzy translations won't be compiled to '.mo' files, for we don't pas=
s
-f/--use-fuzzy
option to msgfmt when compile '.po' to '.mo'.

The following changes since commit 9de96815493b577ae791d5113a3e354142ff=
bcae:

  Merge git://github.com/git-l10n/git-po (2012-05-17 15:35:35 -0700)

are available in the git repository at:


  https://github.com/git-l10n/git-po/ master

for you to fetch changes up to 5ae481e0ad61f3cdf0b0f6bc3f57bae23574db16=
:

  l10n: Set nplurals of zh_CN.po from 1 to 2 (2012-06-01 17:43:38 +0800=
)

----------------------------------------------------------------
Jiang Xin (5):
      l10n: Update git.pot (41 new messages)
      Merge branch 'maint'
      l10n: zh.CN.po: update by msgmerge git.pot
      l10n: zh_CN.po: translate 323 new messages
      l10n: Set nplurals of zh_CN.po from 1 to 2

Marco Paolone (1):
      l10n: New it.po file with 504 translations

Peter Krefting (1):
      Update Swedish translation (728t0f0u)

Tran Ngoc Quan (2):
      Init translation for Vietnamese
      First release translation for Vietnamese

 po/TEAMS    |    8 +
 po/git.pot  |  171 +-
 po/it.po    | 5144 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
 po/sv.po    |  536 +++---
 po/vi.po    | 5360 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 po/zh_CN.po | 2418 ++++++++++++++++++++++-----
 6 files changed, 12945 insertions(+), 692 deletions(-)
 create mode 100644 po/it.po
 create mode 100644 po/vi.po

--
Jiang Xin

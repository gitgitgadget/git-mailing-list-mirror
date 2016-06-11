From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 2.9.0 rc0
Date: Sun, 12 Jun 2016 06:13:54 +0800
Message-ID: <CANYiYbG_DaLX1ipRh4To2iPDtuYxRMMtxWrFbEY1GyrrRCbfdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Changwoo Ryu <cwryu@debian.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 12 00:14:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBrAW-0004Y3-4J
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 00:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbcFKWN5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jun 2016 18:13:57 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:33371 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbcFKWN4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jun 2016 18:13:56 -0400
Received: by mail-qg0-f45.google.com with SMTP id l44so51290055qgd.0
        for <git@vger.kernel.org>; Sat, 11 Jun 2016 15:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=QXLaVTUoleOKkAWc/mV2r817nJol/oSSKeOm2bop4+0=;
        b=BUC+6haSQIJSp5eABX8nnIvuH78q8OXlfldARDJdMmGbFe5sV0/2sL/6OyI0ifmb3l
         KJL7UFzcfaqrrSvXGGQAmX+7y5YbOL0L9gT29Icl9tEig9HIM0ggQOr+nQ+VaqLZOhE3
         Wwv+TmEY8StOa0YYCEisJyBsxaCoS8dLGoSGVlf2GEJYs7ShdUcrU83nJFLCGI9GL23N
         RCzrqzpUoWPYfRDPS7BGb/JGHwdbcYJzMYow2DBY4HXfjJNu83l+ARwtVAPE9KxcMXXT
         lThu+dvnEbv3Qye4L1XCXxvfBl7hJL1zymYY72t0JMpjMmRCZYDnXay0X++NbdoFgAhb
         tMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=QXLaVTUoleOKkAWc/mV2r817nJol/oSSKeOm2bop4+0=;
        b=jYAhS6IF3wOiRbEuo36YoVzUtKBtskXJg+NCDo4iGeqmYF1WnVnmn5Vm5xiBIQ/RvT
         l9nb0JMCI3nqBclNurl7iudyHsY/EtD3Gx0ULKoGkewOGmK1BHF1quokFU1ELCccbebA
         6D2GXiojzs+PyNvcOS+LYVZ7vnxPJ5AwBpV/w/79LguKDhGLEDQQjU3CMqnCvZ3SUvYm
         muWfmI74hYe4ixfrNhb3+xSJpl1HqSiIZckiOvQ/I7kKEFbKzVUPnlMSA9v7sXmCidX1
         p6A7A13ao3VNenguDSMSkwwFCFdV5qZ2vXJ9B9V12dp+IL9jC4gpKXmsjic4zcHVgtSS
         Ntrg==
X-Gm-Message-State: ALyK8tI5lmetYTmpxzH43VmtslKepeCY93T8zyhwu60dmXROMAzVNlcrOd1jJSU8ixMfEhdq9jrtYolSzxQ/ww==
X-Received: by 10.140.159.12 with SMTP id f12mr8101840qhf.61.1465683235448;
 Sat, 11 Jun 2016 15:13:55 -0700 (PDT)
Received: by 10.55.74.2 with HTTP; Sat, 11 Jun 2016 15:13:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297101>

Hi Junio,

Please pull the following git l10n updates.

The following changes since commit 3a0f269e7c82aa3a87323cb7ae04ac5f129f=
036b:

  Git 2.9-rc0 (2016-05-23 15:02:48 -0700)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.9.0-rc0

for you to fetch changes up to ad583ebe0813c5d6a8e7c263d72d934770083d83=
:

  l10n: ko.po: Update Korean translation (2016-06-12 01:25:58 +0900)

----------------------------------------------------------------
l10n-2.9.0-rc0

----------------------------------------------------------------
Alexander Shopov (1):
      l10n: Updated Bulgarian translation of git (2597t,0f,0u)

Antonin (1):
      l10n: fr.po Fixed grammar mistake

Changwoo Ryu (1):
      l10n: ko.po: Update Korean translation

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Jean-Noel Avila (1):
      l10n: fr.po v2.9.0rnd1

Jiang Xin (5):
      l10n: git.pot: v2.9.0 round 1 (104 new, 37 removed)
      Merge branch 'fix_fr' of git://github.com/jnavila/git
      Merge branch 'v2.9.0_rnd1_fr' of git://github.com/jnavila/git
      l10n: zh_CN: for git v2.9.0 l10n round 1
      Merge branch 'russian-l10n' of https://github.com/DJm00n/git-po-r=
u

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (2597t0f0u)

Ralf Thielow (1):
      l10n: de.po: translate 104 new messages

Ray Chen (1):
      l10n: zh_CN: review for git v2.9.0 l10n round 1

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: Updated Vietnamese translation (2597t)

Vasco Almeida (3):
      l10n: pt_PT: merge git.pot file
      l10n: pt_PT: update according to git-gui glossary
      l10n: pt_PT: update Portuguese translation

 po/bg.po    | 4689 +++++++++++++++++++++++++++++++++------------------=
--------
 po/de.po    | 3310 +++++++++++++++++++++++------------------
 po/fr.po    | 3252 +++++++++++++++++++++++------------------
 po/git.pot  | 3078 ++++++++++++++++++++++-----------------
 po/ko.po    | 3192 ++++++++++++++++++++++------------------
 po/pt_PT.po | 3893 +++++++++++++++++++++++++++----------------------
 po/ru.po    | 3171 ++++++++++++++++++++++------------------
 po/sv.po    | 3269 +++++++++++++++++++++++------------------
 po/vi.po    | 3274 +++++++++++++++++++++++------------------
 po/zh_CN.po | 3375 ++++++++++++++++++++++--------------------
 10 files changed, 19378 insertions(+), 15125 deletions(-)

--
Jiang Xin

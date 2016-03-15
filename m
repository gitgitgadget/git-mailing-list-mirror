From: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git v2.8.0 l10n round 3
Date: Wed, 16 Mar 2016 01:03:51 +0800
Message-ID: <CANYiYbErntR1b3bsvwM5heXeKVccZk=Hyfw5PeBPkKu3xprbqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
	Marco Paolone <marcopaolone@gmail.com>,
	Changwoo Ryu <cwryu@debian.org>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 18:03:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afsNy-0004iV-Ep
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 18:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbcCORDz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Mar 2016 13:03:55 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38890 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161AbcCORDx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2016 13:03:53 -0400
Received: by mail-wm0-f49.google.com with SMTP id l68so36027762wml.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=qf6KlrQqViNN/uPH+F/5IwFKXanz7dpZF6aL3i16eYI=;
        b=xnJEvFXoVjnSqHqHyOjRapUrwbU8lgluBXEPkRsq5BGst/OIXBqRIs/BPpcB3iouZ2
         ZbkJZVQjVdPSi79VMI7aQcosRxOaRyam9pe1V6XDjVndzcbQcpiTDEgHWaw05mutN2v5
         ayUTmzoXnI2Zk0WUv+2qQgB2YM2lOGjCO9pJOYcFII//Zxo5u0Sx+j5DNCWnsY0qbTXE
         mOiOZfS0yNcmGLUWnHLCx2FAXT2FBIyn/B/LYKV41k0rX0PUGeG/88dJkjL1W+LBAoAC
         2oj2mI9uaT3lJm2kRfPAjdmxAxyJWHLcztSS6NnZxmAiNS+mNu3xoh9pOWhZ0biwEFE3
         YLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc
         :content-transfer-encoding;
        bh=qf6KlrQqViNN/uPH+F/5IwFKXanz7dpZF6aL3i16eYI=;
        b=CZJNegYnw0rjriJ15eu2ML0FWzplPPwgS2biY6W8Y6mFo4UkZ3PavhK+CCYdOHJuWR
         K/nT6QRY4JB1GGesGx6M3kmrJE1+LRbVayVggr/v6RnYvFSFBj+r9GGdUYk9fsPIj78i
         H16536sHsd6JYxCDiGsCebjrntTdTtEFJFZpKUU8R7fpTfm4ZZ3ehY6Rw5KlFBxWS61C
         FGX+MEpPGQbiCYHzP4ACeIkVeqf6YWd7Noc53rWtTlYGc5m0N926HEYvCE7B8YKsyWL6
         CdW5mSydemVIaDaBGJfa3BuLKOgYeeHnqgg2EqsS7lJrPGNZ4KPeClwzlpvT3st1hV/n
         /P6Q==
X-Gm-Message-State: AD7BkJLU8uxJdiSSlc9nC+kIJHcm+l72202l4/mb4viDepBknC9qRJHlnQu6qmXxRlHHLb0WukuYGOXlRKvwMA==
X-Received: by 10.194.216.40 with SMTP id on8mr34228928wjc.40.1458061431156;
 Tue, 15 Mar 2016 10:03:51 -0700 (PDT)
Received: by 10.194.54.8 with HTTP; Tue, 15 Mar 2016 10:03:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288882>

Hi guys,

One tiny update triggered this round of l10n. Wait for your merge reque=
st.
Thank you.

---------- Forwarded message ----------
=46rom: Jiang Xin <worldhello.net@gmail.com>
Date: 2016-03-16 0:51 GMT+08:00
Subject: [GIT PULL] l10n updates for 2.8.0 round 2
To: Junio C Hamano <gitster@pobox.com>


Hi Junio,

The following changes since commit db6696f653b917509dac1ac13b922e12773a=
84ff:

  Merge branch 'mg/wt-status-mismarked-i18n' (2016-03-14 10:46:17 -0700=
)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.8.0-rnd2

for you to fetch changes up to 5c0c220c53823e2a9ebe8e566e649ca30cd7e8e0=
:

  l10n: zh_CN: for git v2.8.0 l10n round 3 (2016-03-16 00:27:40 +0800)

----------------------------------------------------------------
l10n-2.8.0-rnd2

----------------------------------------------------------------
Audric Schiltknecht (1):
      l10n: fr.po: Correct case in sentence

Changwoo Ryu (2):
      l10n: ko.po: Update Korean translation
      l10n: ko: Update Korean translation

Christoph Hoopmann (1):
      l10n: de.po: fix typo

Dimitriy Ryazantcev (2):
      l10n: ru.po: update Russian translation
      l10n: ru.po: update Russian translation

Jean-Noel Avila (2):
      l10n: fr.po v2.8.0 round 1 2509t
      l10n: fr.po v2.8.0 round 2

Jiang Xin (12):
      l10n: git.pot: v2.8.0 round 1 (48 new, 16 removed)
      Merge branch 'master' of https://github.com/vnwildman/git
      Merge branch 'ko/merge-l10n' of https://github.com/changwoo/git-l=
10n-ko
      Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
      l10n: zh_CN: for git v2.8.0 l10n round 1
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: v2.8.0 round 2 (21 new, 1 removed)
      Merge branch 'russian-l10n' of https://github.com/DJm00n/git-po-r=
u
      l10n: zh_CN: for git v2.8.0 l10n round 2
      Merge branch 'master' of git://github.com/git-l10n/git-po
      l10n: git.pot: Add one new message for Git 2.8.0
      l10n: zh_CN: for git v2.8.0 l10n round 3

Peter Krefting (2):
      l10n: sv.po: Fix inconsistent translation of "progress meter"
      l10n: sv.po: Update Swedish translation (2509t0f0u)

Ralf Thielow (5):
      l10n: TEAMS: update Ralf Thielow's email address
      l10n: de.po: add space to abbreviation "z. B."
      l10n: de.po: fix interactive rebase message
      l10n: de.po: translate "command" as "Befehl"
      l10n: de.po: translate 48 new messages

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (1):
      l10n: vi.po (2509t): Updated Vietnamese translation

 po/TEAMS    |    2 +-
 po/de.po    | 2993 +++++++++++++++++++++++++++++----------------------=
-----
 po/fr.po    | 3033 +++++++++++++++++++++++++++++++--------------------=
------
 po/git.pot  | 2881 +++++++++++++++++++++++++++++----------------------=
---
 po/ko.po    | 3106 ++++++++++++++++++++++++++++++++-------------------=
--------
 po/ru.po    | 3018 ++++++++++++++++++++++++++++++---------------------=
------
 po/sv.po    | 2895 +++++++++++++++++++++++++++++----------------------=
----
 po/vi.po    | 2894 +++++++++++++++++++++++++++++----------------------=
----
 po/zh_CN.po | 3011 +++++++++++++++++++++++++++++++--------------------=
------
 9 files changed, 12830 insertions(+), 11003 deletions(-)

--
Jiang Xin

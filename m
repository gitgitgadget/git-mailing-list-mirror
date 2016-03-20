From: Jiang Xin <worldhello.net@gmail.com>
Subject: [GIT PULL] l10n updates for 2.8.0 round 3
Date: Sun, 20 Mar 2016 19:08:15 +0800
Message-ID: <CANYiYbGCLE5xrNYPjvTfp9cho8ccb3xuNv0kMaFVt8jkmHfd_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Changwoo Ryu <cwryu@debian.org>,
	Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>,
	Jean-Noel Avila <jn.avila@free.fr>,
	Jiang Xin <worldhello.net@gmail.com>,
	Peter Krefting <peter@softwolves.pp.se>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 12:08:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahbDZ-000718-NS
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 12:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212AbcCTLIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 07:08:18 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35570 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbcCTLIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 07:08:16 -0400
Received: by mail-wm0-f41.google.com with SMTP id l68so77817716wml.0
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 04:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=mkFl2FWaM81AGrvjEsblL6+ulbCYcBtz4qx3r1ohUN4=;
        b=evMHiJmQdhugyL+STNLkayq3ZrfLYzf3lOhE99srP6u/s2JupZIcpYPLpA2M+9YSac
         /FdRTnfgEPKAQO+5nno9HvJFeqiOMf2PT4ekCGvKZcCTuXito/Rc9pkGvcY8aikFe9Zm
         x3wVxue/IIISh3b18Wzv7GLxQBtrvl/lorVSItnEf82OuZ6RRmnREaNrUllHeEB0+Tfz
         JktRXQTpU1zZLAkK1h8HBOnf7XlDb6AJ4+U4YQEylm04It0eKx7lpI+tOp1THARTq0IV
         Zpp4beLtQg76SBo+d9De0+Tcq65PrpgapjsPuwcPjcRtMt0D7xkIWlt7ETMt/sTkaU0I
         htpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=mkFl2FWaM81AGrvjEsblL6+ulbCYcBtz4qx3r1ohUN4=;
        b=WdjX00Xi8BAQijctCXtsWUkPrLxIYd/KRc22pRH0IKmxEouM7ALhtAxe+4HunkTBV1
         M6ParYzoslD/IhOkIZwvP5bpPo/Spz1wbUSHSVdJWId+jKC6GPTNHubvzhY9gfJZFUZP
         xBnQ2hY6G/hRUZlTQZxyCBYzp/RzFx6byaX51Zwv/qtCb7adK8XbcxP2nr4PsnQbK/kA
         GpA/EDjNSCPtvgmFxHIRdvYxju03YS8EOWF79zqiUqfp63LCISKrlGfiVyF6C34T5nLP
         9jgfpa+QnphmZkDdunNGW7BDjRS+pS5dMIToiURFyPzr1ao/piqQEHzLZcFiAg6Ev8f9
         1VFw==
X-Gm-Message-State: AD7BkJKREgJWgQYOU7k9DZ1Iv0tuqRHNHJeYB4vK3XlJlcUDLNhyQeZpNiA/TkMmR1WmeiPpwztkMW/IWZcMsw==
X-Received: by 10.194.103.227 with SMTP id fz3mr21200280wjb.43.1458472095192;
 Sun, 20 Mar 2016 04:08:15 -0700 (PDT)
Received: by 10.194.54.8 with HTTP; Sun, 20 Mar 2016 04:08:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289346>

Hi Junio,

The following changes since commit 5c0c220c53823e2a9ebe8e566e649ca30cd7e8e0:

  l10n: zh_CN: for git v2.8.0 l10n round 3 (2016-03-16 00:27:40 +0800)

are available in the git repository at:

  git://github.com/git-l10n/git-po tags/l10n-2.8.0-rnd3

for you to fetch changes up to 26e4cbec4558ea21cd572bfc915a462f63c1ebb4:

  l10n: zh_CN: review for git v2.8.0 l10n round 2 (2016-03-20 18:46:02 +0800)

----------------------------------------------------------------
l10n-2.8.0-rnd3

----------------------------------------------------------------
Changwoo Ryu (1):
      l10n: ko.po: Update Korean translation

Dimitriy Ryazantcev (1):
      l10n: ru.po: update Russian translation

Jean-Noel Avila (1):
      l10n: fr.po v2.8.0 round 3

Jiang Xin (3):
      Merge branch 'master' of git://github.com/nafmo/git-l10n-sv
      Merge branch 'ko/merge-l10n' of https://github.com/changwoo/git-l10n-ko
      Merge branch 'fr_v2.8.0_r3' of git://github.com/jnavila/git

Peter Krefting (1):
      l10n: sv.po: Update Swedish translation (2530t0f0u)

Ralf Thielow (2):
      l10n: de.po: translate 22 new messages
      l10n: de.po: add missing newlines

Ray Chen (1):
      l10n: zh_CN: review for git v2.8.0 l10n round 2

 po/de.po    | 172 +++++++++++++++++++++++++++++++++++++++++++++++-------------
 po/fr.po    |  12 +++--
 po/ko.po    |  10 ++--
 po/ru.po    |   8 ++-
 po/sv.po    | 153 ++++++++++++++++++++++++++++++++++++++++++-----------
 po/zh_CN.po |  10 ++--
 6 files changed, 283 insertions(+), 82 deletions(-)

--
Jiang Xin

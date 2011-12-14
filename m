From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [REQUEST PULL] git-gui
Date: Wed, 14 Dec 2011 00:05:37 +0000
Message-ID: <87d3bs2f1q.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 14 01:12:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RacSn-00054I-F6
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 01:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957Ab1LNAMn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Dec 2011 19:12:43 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:54344 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753329Ab1LNAMm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 19:12:42 -0500
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111214001240.ZHNI11752.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Wed, 14 Dec 2011 00:12:40 +0000
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RacSe-0007hY-Hr; Wed, 14 Dec 2011 00:12:40 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 785FB20A79; Wed, 14 Dec 2011 00:05:38 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=IkcTkHD0fZMA:10 a=BKB4hTfATD1S3bI5s5kA:9 a=LmVI-IegMmjvk-DkLFoA:7 a=QEXdDO2ut3YA:10 a=ygrxFxvRaxsys9lH:21 a=34jrqHGfEunmsWnl:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187082>

The following changes since commit 843d6597fbacfae02b8af7d6840992c92d08=
63f8:

  git-gui: incremental goto line in blame view (2011-10-15 23:14:13 +01=
00)

are available in the git repository at:

  git://repo.or.cz/git-gui.git master

for you to fetch changes up to 942e6baa92846e5628752c65a22bc4957d8de4d0=
:

  git-gui 0.16 (2011-12-13 23:44:30 +0000)

----------------------------------------------------------------
Bert Wesarg (14):
      git-gui: fix multi selected file operation
      git-gui: handle config booleans without value
      git-gui: add smart case search mode in searchbar
      git-gui: add regexp search mode to the searchbar
      git-gui: add search history to searchbar
      git-gui: fix unintended line break in message string
      git-gui: use "untracked" for files which are not known to git
      git-gui: new config to control staging of untracked files
      git-gui: fix display of path in browser title
      git-gui: use a tristate to control the case mode in the searchbar
      git-gui: span widgets over the full file output area in the blame=
 view
      git-gui: include the file path in guitools confirmation dialog
      git-gui: make config gui.warndetachedcommit a boolean
      git-gui: don't warn for detached head when rebasing

Dejan Ribi=C4=8D (1):
      git-gui: fix spelling error in sshkey.tcl

Pat Thoyts (12):
      git-gui: include the number of untracked files to stage when aski=
ng the user
      git-gui: theme the search and line-number entry fields on blame s=
creen
      git-gui: catch invalid or complete regular expressions and treat =
as no match.
      git-gui: enable the smart case sensitive search only if gui.searc=
h.smartcase is true
      Merge branch 'bw/searching'
      git-gui: set suitable extended window manager hints.
      git-gui: support underline style when parsing diff output
      git-gui: sort the numeric ansi codes
      git-gui: set whitespace warnings appropriate to this project
      git-gui: added config gui.gcwarning to disable the gc hint messag=
e
      git-gui: handle shell script text filters when loading for blame.
      git-gui 0.16

Samuel Bronson (1):
      git-gui: Set both 16x16 and 32x32 icons on X to pacify Xming.

Tilman Vogel (1):
      git-gui: add config value gui.diffopts for passing additional dif=
f options

 .gitattributes     |    1 +
 GIT-VERSION-GEN    |    2 +-
 git-gui.sh         |   56 ++++++++++++++++++++++--
 lib/blame.tcl      |   29 ++++++------
 lib/browser.tcl    |    8 +++-
 lib/choose_rev.tcl |    1 +
 lib/class.tcl      |    1 +
 lib/commit.tcl     |    4 +-
 lib/diff.tcl       |    5 +-
 lib/index.tcl      |   24 ++++++++---
 lib/line.tcl       |    2 +-
 lib/option.tcl     |   20 ++++++++
 lib/search.tcl     |  123 ++++++++++++++++++++++++++++++++++++++++++++=
++-----
 lib/sshkey.tcl     |    2 +-
 lib/themed.tcl     |   99 ++++++++++++++++++++++++++++++++++++++++--
 lib/tools.tcl      |   10 +++-
 lib/transport.tcl  |    1 +
 17 files changed, 339 insertions(+), 49 deletions(-)

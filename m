From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: REQUEST PULL: git-gui
Date: Sun, 16 Jun 2013 00:05:21 +0100
Message-ID: <87ehc3m0um.fsf@fox.patthoyts.tk>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Haller <stefan@haller-berlin.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 16 01:05:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnzXF-0002GO-TY
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 01:05:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754759Ab3FOXF0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Jun 2013 19:05:26 -0400
Received: from know-smtprelay-omc-11.server.virginmedia.net ([80.0.253.75]:33578
	"EHLO know-smtprelay-omc-11.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754752Ab3FOXFZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Jun 2013 19:05:25 -0400
Received: from fox.patthoyts.tk ([94.171.229.22])
	by know-smtprelay-11-imp with bizsmtp
	id on5N1l0070VeUS601n5PzE; Sun, 16 Jun 2013 00:05:23 +0100
X-Originating-IP: [94.171.229.22]
X-Spam: 0
X-Authority: v=2.0 cv=UIaFh1jy c=1 sm=1 a=qXJDgLqI18Q8M6O+O33hhA==:17
 a=F0HhOJWMmYsA:10 a=CtgcEeagiGAA:10 a=8nJEP1OIZ-IA:10 a=FP58Ms26AAAA:8
 a=sK3aKL2g48YA:10 a=hl0QTzpM02xoorrjmvkA:9 a=wPNLvfGTeEIA:10
 a=qXJDgLqI18Q8M6O+O33hhA==:117
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id AAC4224030; Sun, 16 Jun 2013 00:05:22 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227975>

The following changes since commit f6dd784ed4c1705d465b1238f9a5971f2733=
e582:

  git-gui 0.17 (2012-10-17 21:57:29 +0100)

are available in the git repository at:

  git://repo.or.cz/git-gui.git tags/gitgui-0.18.0

for you to fetch changes up to 8a383db4b28059becc3ebfd1b402299e34c3151f=
:

  git-gui 0.18 (2013-06-15 23:53:34 +0100)

----------------------------------------------------------------
git-gui 0.18.0

----------------------------------------------------------------
Christian Couder (1):
      Makefile: replace "echo 1>..." with "echo >..."

Grahack (1):
      French translation:=C2=A0copy -> copie.

Heiko Voigt (1):
      git-gui: allow "\ No newline at end of file" for linewise staging

John Keeping (1):
      git-gui: fix file name handling with non-empty prefix

Kirill Smelkov (1):
      git-gui: Fix parsing of <rev> <path-which-not-present-in-worktree=
>

Pat Thoyts (4):
      git-gui: fix the mergetool launcher for the Beyond Compare tool.
      git-gui: change dialog button positions for Windows to suit platf=
orm.
      git-gui: avoid an error message when removing the last remote
      git-gui 0.18

Stefan Haller (1):
      git-gui: bring wish process to front on Mac

 GIT-VERSION-GEN           |  2 +-
 Makefile                  |  6 +++---
 git-gui.sh                | 27 +++++++++++++++++----------
 lib/choose_repository.tcl |  4 +++-
 lib/diff.tcl              | 11 +++++++++--
 lib/mergetool.tcl         |  4 ++--
 lib/remote.tcl            |  6 ++++--
 po/fr.po                  |  2 +-
 8 files changed, 40 insertions(+), 22 deletions(-)

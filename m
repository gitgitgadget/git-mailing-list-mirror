From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PULL REQUEST]: Please pull git-gui
Date: Wed, 17 Oct 2012 23:16:04 +0100
Message-ID: <87d30gzqvv.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 00:17:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TObvt-0006sU-HN
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 00:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab2JQWRe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2012 18:17:34 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:4944 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751801Ab2JQWRe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2012 18:17:34 -0400
Received: from know-smtpout-1.server.virginmedia.net ([62.254.123.1])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20121017221732.GIEB26256.mtaout03-winn.ispmail.ntl.com@know-smtpout-1.server.virginmedia.net>;
          Wed, 17 Oct 2012 23:17:32 +0100
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-1.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1TObuI-0005to-OJ; Wed, 17 Oct 2012 23:16:06 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 28BD420C31; Wed, 17 Oct 2012 23:16:06 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=AUhbpHVS+xhHrj9wLCYAQoYnFLYUZdbP8UM0GmH2jwk= c=1 sm=0 a=O9HYxzjLEG8A:10 a=HL6A0-_58CgA:10 a=CtgcEeagiGAA:10 a=8nJEP1OIZ-IA:10 a=TuTkHzy0x2fPOqGbHOgA:9 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207945>

The following changes since commit 942e6baa92846e5628752c65a22bc4957d8d=
e4d0:

  git-gui 0.16 (2011-12-13 23:44:30 +0000)

are available in the git repository at:

  git://repo.or.cz/git-gui.git tags/gitgui-0.17.0

for you to fetch changes up to f6dd784ed4c1705d465b1238f9a5971f2733e582=
:

  git-gui 0.17 (2012-10-17 21:57:29 +0100)

----------------------------------------------------------------
git-gui 0.17.0

----------------------------------------------------------------
Andrew Wong (2):
      git-gui: Detect full path when parsing arguments
      git-gui: Don't prepend the prefix if value looks like a full path

Beat Bolli (2):
      git-gui: Fix a loose/lose mistake
      git-gui: remove .git/CHERRY_PICK_HEAD after committing

Benjamin Kerensa (1):
      git-gui: fix a typo in po/ files

Clemens Buchacher (1):
      git-gui: fix git-gui crash due to uninitialized variable

Heiko Voigt (1):
      git-gui: open console when using --trace on windows

Marcus Karlsson (1):
      git-gui: Use PWD if it exists on Mac OS X

Pat Thoyts (3):
      git-gui: preserve commit messages in utf-8
      Merge branch 'rt/trans'
      git-gui 0.17

Ralf Thielow (3):
      git-gui: de.po: consistently add untranslated hook names within b=
races
      git-gui: de.po: translate "bare" as "blo=DF"
      git-gui: de.po: translate "remote" as "extern"

Vitaly _Vi Shukela (1):
      git-gui: Fix semi-working shortcuts for unstage and revert

 GIT-VERSION-GEN    |  2 +-
 git-gui.sh         | 36 ++++++++++++++++++++++++++++++------
 lib/commit.tcl     |  3 ++-
 lib/status_bar.tcl |  1 +
 macosx/AppMain.tcl |  4 +++-
 po/de.po           | 38 +++++++++++++++++++-------------------
 po/fr.po           |  2 +-
 po/git-gui.pot     |  2 +-
 po/hu.po           |  2 +-
 po/it.po           |  2 +-
 po/ja.po           |  2 +-
 po/nb.po           |  2 +-
 po/pt_br.po        |  2 +-
 po/ru.po           |  2 +-
 po/sv.po           |  2 +-
 15 files changed, 65 insertions(+), 37 deletions(-)

From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: Update git-gui tree please?
Date: Sat, 26 Mar 2011 10:46:16 +0000
Message-ID: <87hbaqqhvr.fsf@fox.patthoyts.tk>
References: <7vlj06gziu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 11:46:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3R0l-0000LL-5S
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 11:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab1CZKqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 06:46:21 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:13573 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751129Ab1CZKqT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Mar 2011 06:46:19 -0400
X-Greylist: delayed 120879 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Mar 2011 06:46:19 EDT
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.1])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20110326104617.OLFJ13167.mtaout03-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Sat, 26 Mar 2011 10:46:17 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1Q3R0b-00055o-Iq; Sat, 26 Mar 2011 10:46:17 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id E18B3204DC; Sat, 26 Mar 2011 10:46:16 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <7vlj06gziu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 22 Mar 2011 22:46:17 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=O9HYxzjLEG8A:10 a=pRC9RsYq6G4A:10 a=kj9zAlcOel0A:10 a=ybZZDoGAAAAA:8 a=VwQbUJbxAAAA:8 a=g9efXKfsFV3UH4hgK5YA:9 a=ZosIQ3w7MLnK1G7HSj8A:7 a=yBEH29XJkYG_PIa77dsmkXm_FHAA:4 a=CjuIK1q_8ugA:10 a=qIVjreYYsbEA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170049>

Junio C Hamano <gitster@pobox.com> writes:

>As Sebastian's addition of BeyondCompare-3 as a new backend for mergetool
>has graduated to my 'master' branch, could you fetch from me and merge the
>tip of ss/git-gui-mergetool branch to git-gui repository, like this?
>
>	git fetch git://git.kernel.org/pub/scm/git/git.git next
>	git branch ss/git-gui-mergetool f3768a6714e667205d68475
>        git merge ss/git-gui-mergetool
>
>Also I'll hopefully tagging 1.7.5-rc0 by the end of the month or the
>middle of April at the latest, so please start planning to wrap up the
>enhancements and fixes meant for the next release and throw me a pull
>request when your tree is in a good shape to do so.  I realize that I am
>already behind your tip 4c2519e (git-gui: fetch/prune all entry appears
>last, 2011-02-22), but I'll wait until I hear from you.
>
>Thanks.

I have merged your ss/git-gui-mergetool branch in and tagged it so
please pull:

The following changes since commit 8f85599aba6b569de5c559994704a416f52bc031:

  git-gui: apply color information from git diff output (2010-10-27 23:47:28 +0100)

are available in the git repository at:
  git://repo.or.cz/git-gui.git maint

Alex Riesen (2):
      git-gui: update russian translation
      git-gui: update russian translation

Alexandre Erwin Ittner (1):
      git-gui: add Brazilian Portuguese (pt-BR) translation

Bert Wesarg (16):
      git-gui: fix ANSI-color parsing
      git-gui: respect conflict marker size
      git-gui: fix browsers [Up To Parent] in sub-sub-directories.
      git-gui: Fix use of renamed tag.
      git-gui: Fix use of hunk tag for non-hunk content.
      git-gui: fix typo in image data
      git-gui: remove 'no such variable' for s error when encounter unknown file states
      git-gui: learn more type change states
      git-gui: rework handling of diff header
      git-gui: handle index lines only in the diff header
      git-gui: name also new symlinks so
      git-gui: there is no "mode *" diff header line
      git-gui: move 3way diff autodetect up
      git-gui: always reset the current tag
      git-gui: handle special content lines only in the diff header section
      git-gui: handle meta diff header lines only in the header section

Heiko Voigt (9):
      git gui: keep selected branch when remote is changed in push dialog
      git-gui: scroll down to default selection for push dialog
      git-gui: instead of defaulting to home directory use working directory
      git-gui: fix deleting item from all_remotes variable
      git-gui: always default to the last merged branch in remote delete
      git-gui: refactor remote submenu creation into subroutine
      git-gui: teach fetch/prune menu to do it for all remotes
      git-gui: fetch/prune all entry only for more than one entry
      git-gui: fetch/prune all entry appears last

Pat Thoyts (3):
      git-gui: Include version check and test for tearoff menu entry
      git-gui: detect the use of MUI langauge packs on Windows
      Merge branch 'ss/git-gui-mergetool'

Sebastian Schuberth (2):
      mergetool--lib: Sort tools alphabetically for easier lookup
      mergetool--lib: Add Beyond Compare 3 as a tool

Serge Ziryukin (1):
      git-gui: fix russian translation typos

Skip (1):
      git-gui: spelling fixes in russian translation

Stefan Naewe (1):
      git-gui: use --exclude-standard to check for untracked files

 git-gui.sh                   |   61 +-
 lib/browser.tcl              |    2 +-
 lib/choose_repository.tcl    |   14 +-
 lib/commit.tcl               |    9 +-
 lib/diff.tcl                 |  115 ++-
 lib/index.tcl                |   10 +-
 lib/merge.tcl                |    2 +
 lib/mergetool.tcl            |  101 +-
 lib/remote.tcl               |   91 ++-
 lib/remote_branch_delete.tcl |    9 +-
 lib/transport.tcl            |   34 +-
 po/glossary/pt_br.po         |  169 +++
 po/pt_br.po                  | 2568 ++++++++++++++++++++++++++++++++++++++++++
 po/ru.po                     |  623 ++++++-----
 14 files changed, 3371 insertions(+), 437 deletions(-)
 create mode 100644 po/glossary/pt_br.po
 create mode 100644 po/pt_br.po

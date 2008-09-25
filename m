From: Petr Baudis <pasky@suse.cz>
Subject: [ANNOUNCE] TopGit v0.4
Date: Thu, 25 Sep 2008 15:19:10 +0200
Message-ID: <20080925131910.GM10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 15:20:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kiqlc-0003O9-UL
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 15:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbYIYNTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Sep 2008 09:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbYIYNTN
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 09:19:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53525 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209AbYIYNTM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 09:19:12 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 48A5B3939B42; Thu, 25 Sep 2008 15:19:10 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96760>

  Hi!

  This is TopGit v0.4, continuing the mission of practical usability.
I have managed to somehow use this to actually manage a rather large
and non-trivial system of git-gui patches, recently submitted to git@.
(I send out the mail series using tg export --quilt and quilt mail
so far though, and I'm actually finding that quite convenient.)


  TopGit is meant as a fresh start in the steps of StGIT, quilt-in-git
and others, of course in an attempt to Get It Right this time around.
TopGit is absolutely minimal porcelain layer that will manage your
patch queue for you using topic branches, one patch per branch,
never rewriting the history in order to enable fully distributed
workflow.  You can get TopGit at

	http://repo.or.cz/w/topgit.git

and read up on its design, usage and implementation at:

	http://repo.or.cz/w/topgit.git?a=3Dblob;f=3DREADME


  The nicest thing about this release is Kirill's new 'tg mail' command=
,
'tg export --quilt -b' to create quilt series from arbitrary set of
topic branches and 'tg depend add', which has actually quite trivial
implementation, though. Then there's the usual bunch of small
enhancements and fixes.

Kirill Smelkov (3):
      tg help: <something>: improve readability
      tg import: fix + make more robust
      tg mail: new command for mailing patches

Petr Baudis (19):
      tg.sh: Typo fix (incanation -> incantation)
      .gitignore: Add tg-import, tg-remote
      Makefile: Changing Makefile means executables need to be regenera=
ted too
      tg import: Require clean working tree and index
      tg import: Check out new files as we go
      tg delete: Allow branch delete if we aren't on symbolic HEAD
      tg remote README: Add 'git push --all' caveat warning
      tg info: Carry over missing Subject line in topmsg
      tg info, tg patch: Work on top-base HEAD too
      Ignore vim swp files
      tg mail: Tidyup
      tg mail: Simplify array usage
      tg export: Fix exporting remote-based branches
      tg delete: Fix spurious output
      tg depend add: Add dependency
      tg update: Fix resume message
      tg mail -s SEND_EMAIL_ARGS: Pass arguments to git send-email
      tg export: With quilt driver, accept explicit list of branches
      TopGit-0.4

Uwe Kleine-K=C4=82=C5=9Bnig (1):
      Use git-mailinfo to extract author informations from .topmsg


  Have fun,

--=20
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates

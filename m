From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Fri, 18 May 2007 22:24:48 -0700
Message-ID: <7vveepz8pr.fsf@assigned-by-dhcp.cox.net>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
	<7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 07:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpHR3-0006h0-UQ
	for gcvg-git@gmane.org; Sat, 19 May 2007 07:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756842AbXESFYv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 19 May 2007 01:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756659AbXESFYv
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 01:24:51 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63206 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756121AbXESFYt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 May 2007 01:24:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519052450.LWPE6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 01:24:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0tQo1X00F1kojtg0000000; Sat, 19 May 2007 01:24:49 -0400
X-maint-at: 97925fde00743e557fa5e792004483a27e31fbd8
X-master-at: 404fdef22f1084141aeef5781d5a322554fed481
In-Reply-To: <7vhcqccnbm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 16 May 2007 17:21:01 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47715>

I've done release 1.5.1.5, which hopefully would be the second
from the last release in 1.5.1 maintenance series (I somehow
ended up missing documentation formatting updates from Matthias
Kestenholz, which fix longstanding ugly formatting mistakes in
some manual pages).

The tip of 'master' will be tagged v1.5.2 hopefully in 24 hours.
Nothing earth shattering since the last message of this series.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

 J. Bruce Fields (10):
  user-manual: revise birdseye-view chapter
  glossary: expand and clarify some definitions, prune cross-references
  user-manual: move quick-start to an appendix
  Documentation: remove howto's now incorporated into manual
  user-manual: move howto/make-dist.txt into user manual
  user-manual: move howto/using-topic-branches into manual
  user-manual: add a "counting commits" example
  user-manual: introduce git
  user-manual: listing commits reachable from some refs not others
  user-manual: reorganize public git repo discussion

 Johannes Schindelin (1):
  Add a birdview-on-the-source-code section to the user manual

 Junio C Hamano (1):
  GIT v1.5.1.5

 Matthias Kestenholz (2):
  Documentation: Added [verse] to SYNOPSIS where necessary
  Documentation: Reformatted SYNOPSIS for several commands

 Michael Hendricks (2):
  git-send-email: allow leading white space on mutt aliases
  Document core.excludesfile for git-add

 Petr Baudis (1):
  Documentation: git-rev-list's "patterns"


* The 'master' branch has these since the last announcement
  in addition to the above.

 Andy Parkins (1):
  Fix crlf attribute handling to match documentation

 Jakub Narebski (2):
  gitweb: Fix error in git_patchset_body for deletion in merge commit
  gitweb: Fix "Use of uninitialized value" warning in git_feed

 Junio C Hamano (3):
  gitweb: fix another use of undefined value
  Add link to 1.5.1.5 release notes.
  Documentation/git.txt: Update links to older documentation pages.

 Petr Baudis (4):
  gitweb: Normalize searchbar font size
  gitweb: Add support for grep searches
  gitweb: Allow arbitrary strings to be dug with pickaxe
  gitweb: Remove redundant $searchtype setup

 Ren=C3=A9 Scharfe (1):
  git-archive: convert archive entries like checkouts do

 Shawn O. Pearce (1):
  git-gui: Gracefully handle bad TCL_PATH at compile time

 Steffen Prohaska (1):
  Optimized cvsexportcommit: calling 'cvs status' once instead of once =
per touched file.

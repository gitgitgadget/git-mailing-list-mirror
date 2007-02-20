From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Mon, 19 Feb 2007 23:32:22 -0800
Message-ID: <7vbqjp1dyx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 08:32:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJPUA-0003uP-Uo
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 08:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbXBTHcY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 02:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbXBTHcY
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 02:32:24 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:39588 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964851AbXBTHcX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 02:32:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220073223.VPNT21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 02:32:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RjYN1W0031kojtg0000000; Tue, 20 Feb 2007 02:32:23 -0500
X-maint-at: e326bce65c2a8b10f40c1869e13c7450a243b109
X-master-at: 1e592d65b50dbec87fde9f4ef1b7fd8d90bf7b8c
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40206>

* The 'maint' branch has these fixes since v1.5.0.1

 Christian Schlotter (1):
  git-clone: Sync documentation to usage note.

 Jason Riedy (2):
  Add a compat/strtoumax.c for Solaris 8.
  Obey NO_C99_FORMAT in fast-import.c.


* The 'master' branch has these since the last announcement, in
  addition to the above.

 Andy Parkins (1):
  Have git-cvsserver call hooks/update before really altering the ref

 Fredrik Kuivinen (2):
  Read the config in rev-list
  Documentation/i18n.txt: it is i18n.commitencoding not core.commitencoding

 Johannes Schindelin (2):
  name-rev: introduce the --refs=<pattern> option
  diff --check: use colour

 Junio C Hamano (9):
  Make gitk work reasonably well on Cygwin.
  gitk: Use show-ref instead of ls-remote
  remotes.not-origin.tagopt
  pretend-sha1: grave bugfix.
  git-merge: minor fix for no_trivial_merge_strategies.
  Do not take mode bits from index after type change.
  Update draft release notes for 1.5.0.1
  Update draft release notes for 1.5.1
  GIT 1.5.0.1

 Mark Levedahl (3):
  gitk - remove trailing whitespace from a few lines.
  Make gitk save and restore the user set window position.
  Make gitk save and restore window pane position on Linux and Cygwin.

 Paul Mackerras (1):
  Change git repo-config to git config

 Shawn O. Pearce (2):
  Attempt to improve git-rebase lead-in description.
  Convert update-index references in docs to add.

 Theodore Ts'o (1):
  Teach git-remote to update existing remotes by fetching from them

 Tommi Kyntola (1):
  git-blame: prevent argument parsing segfault

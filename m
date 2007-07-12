From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.2.4
Date: Thu, 12 Jul 2007 13:57:39 -0700
Message-ID: <7v7ip5tk58.fsf@assigned-by-dhcp.cox.net>
References: <7vodjf1gxl.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 22:57:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I95jO-0002Zu-Di
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 22:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbXGLU5m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 16:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759923AbXGLU5m
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 16:57:42 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:53444 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758332AbXGLU5l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 16:57:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070712205740.UNRT1358.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Jul 2007 16:57:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Nkxf1X00l1kojtg0000000; Thu, 12 Jul 2007 16:57:40 -0400
In-Reply-To: <7vodjf1gxl.fsf@assigned-by-dhcp.pobox.com> (Junio C. Hamano's
	message of "Sat, 16 Jun 2007 18:57:26 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52333>

The latest maintenance release GIT 1.5.2.4 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.2.4.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.2.4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.2.4.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.2.4-1.$arch.rpm	(RPM)

----------------------------------------------------------------

GIT v1.5.2.4 Release Notes
==========================

Fixes since v1.5.2.3
--------------------

 * Bugfixes

   - "git-gui" bugfixes, including a handful fixes to run it
     better on Cygwin/MSYS.

   - "git checkout" failed to switch back and forth between
     branches, one of which has "frotz -> xyzzy" symlink and
     file "xyzzy/filfre", while the other one has a file
     "frotz/filfre".

   - "git prune" used to segfault upon seeing a commit that is
     referred to by a tree object (aka "subproject").

   - "git diff --name-status --no-index" mishandled an added file.

   - "git apply --reverse --whitespace=warn" still complained
     about whitespaces that a forward application would have
     introduced.

 * Documentation Fixes and Updates

   - A handful documentation updates.

----------------------------------------------------------------

Changes since v1.5.2.3 are as follows:

Andy Parkins (2):
      Make git-prune submodule aware (and fix a SEGFAULT in the process)
      user-manual: grammar and style fixes

Gerrit Pape (1):
      git-gui: properly popup error if gitk should be started but is not installed

J. Bruce Fields (2):
      tutorial: Fix typo
      user-manual: more explanation of push and pull usage

Jim Meyering (1):
      Don't smash stack when $GIT_ALTERNATE_OBJECT_DIRECTORIES is too long

Johannes Schindelin (3):
      diff --no-index: fix --name-status with added files
      glossary: add 'reflog'
      Fix "apply --reverse" with regard to whitespace

Junio C Hamano (2):
      Teach read-tree 2-way merge to ignore intermediate symlinks
      GIT 1.5.2.4

Michael Hendricks (1):
      Correctly document the name of the global excludes file configuration

Miklos Vajna (1):
      Document -<n> for git-format-patch

Shawn O. Pearce (10):
      git-gui: Unlock the index when cancelling merge dialog
      git-gui: Don't bind F5/M1-R in all windows
      git-gui: Bind M1-P to push action
      git-gui: Include a Push action on the left toolbar
      git-gui: Ensure windows shortcuts always have .bat extension
      git-gui: Skip nicknames when selecting author initials
      git-gui: Correct ls-tree buffering problem in browser
      git-gui: Don't linewrap within console windows
      Clarify documentation of fast-import's D subcommand
      git-gui: Work around bad interaction between Tcl and cmd.exe on ^{tree}

William Pursell (1):
      user-manual: fix directory name in git-archive example

From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.3.rc4
Date: Sun, 03 May 2009 14:59:45 -0700
Message-ID: <7vbpq9luem.fsf@alter.siamese.dyndns.org>
References: <7vhc0acxes.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 00:00:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0jj5-0004wT-3g
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 23:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbZECV7t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2009 17:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753642AbZECV7r
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 17:59:47 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47676 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519AbZECV7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 17:59:46 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090503215946.JNHH17135.fed1rmmtao104.cox.net@fed1rmimpo03.cox.net>;
          Sun, 3 May 2009 17:59:46 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id n9zl1b0024aMwMQ049zlrw; Sun, 03 May 2009 17:59:45 -0400
X-Authority-Analysis: v=1.0 c=1 a=VwQbUJbxAAAA:8 a=61BYfe8WDedVoHIt8lEA:9
 a=VS4gyZqJFirYrQ9iTIMA:7 a=3mmyFEIdo_7EOmxncbbssRHcgmwA:4
X-CM-Score: 0.00
In-Reply-To: <7vhc0acxes.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 27 Apr 2009 01\:29\:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118194>

A release candidate GIT 1.6.3.rc4 is available at the usual places
for testing:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.3.rc4.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.3.rc4.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.3.rc4.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  testing/git-*-1.6.3.rc4-1.fc9.$arch.rpm	(RPM)

This is hopefully the final rc before the real thing; it includes the
updates to git-gui and gitk.

----------------------------------------------------------------

Changes since v1.6.3-rc3 are as follows:

Alex Riesen (3):
      git-gui: Update Russian translation
      improve error message in config.c
      gitk: Add Russian translation

Alexander Gavrilov (3):
      git-gui: Fix post-commit status with subject in non-locale encodi=
ng
      git-gui: Avoid an infinite rescan loop in handle_empty_diff.
      git-gui: Support more git version notations.

Allan Caffee (2):
      builtin-merge: fix a typo in an error message
      Documentation: fix a grammatical error in api-builtin.txt

Benjamin Kramer (1):
      daemon.c: fix segfault on OS X

Christian Stimming (1):
      gitk: Mark forgotten string for translation

Daniel A. Steffen (2):
      gitk: Fixes for Mac OS X TkAqua
      git-gui: Fixes for Mac OS X TkAqua

Eric Blake (2):
      Makefile: installing git in cygwin 1.7.0
      doc: consistently use ASCIIDOC_EXTRA

=46elipe Contreras (2):
      git config: error when editing a repo config and not being in one
      Fix a bunch of pointer declarations (codestyle)

=46erry Huberts (1):
      git-gui: Ensure consistent usage of mergetool.keepBackup

Giuseppe Bilotta (1):
      gitk: Provide a window icon if possible

Jeff King (1):
      Makefile: fix NO_PERL bug with gitweb

Jens Lehmann (4):
      git-gui: Fix merge conflict display error when filename contains =
spaces
      git-gui: When calling post-commit hook wrong variable was cleared=
=2E
      git-gui: run post-checkout hook on checkout
      git-gui: run post-checkout hook after clone

Joerg Bornemann (1):
      git-gui: fix use of undeclared variable diff_empty_count

Johannes Schindelin (2):
      t5701: do not get stuck in empty-push/
      Rename core.unreliableHardlinks to core.createObject

Johannes Sixt (1):
      prune-packed: advanced progress even for non-existing fan-out dir=
ectories

Junio C Hamano (3):
      diff -c -p: do not die on submodules
      merge-recursive: do not die on a conflicting submodule
      GIT 1.6.3-rc4

Linus Torvalds (1):
      grep: fix segfault when "git grep '('" is given

Mark Drago (1):
      Add semicolon to curly brace group in main Makefile

Markus Heidelberg (5):
      git-gui: don't hide the Browse button when resizing the repo choo=
ser
      git-gui: fix deleting from the context menu with empty selection
      git-gui: use `git --html-path` to get the location of installed H=
TML docs
      git-gui (Win): make "Explore Working Copy" more robust
      git-gui (Win): make starting via "Git GUI Here" on .git/ possible

Michele Ballabio (2):
      gitk: Mark some more strings for translation
      gitk: Map KP_Divide to focus the search box

Pat Thoyts (4):
      gitk: Handle blobs containing a DOS end-of-file marker
      gitk: Remember and restore the window state with the geometry
      gitk: Handle external diff tool with spaces in the path
      gitk: Avoid crash if closed while reading references

Patrick Welche (1):
      NetBSD compilation fix

Paul Mackerras (4):
      gitk: Add a way to mark a commit, plus a "find descendant" comman=
d
      gitk: Add a command to compare two strings of commits
      gitk: Make .gitk a hidden file under windows
      gitk: Fix compare-commits function when we have local changes

Phil Lawrence (1):
      Append ampersand to "Target" of lnk files created by do_cygwin_sh=
ortcut

Ren=C3=A9 Scharfe (1):
      ctype.c: fix typo in comment

Sam Hocevar (2):
      git-gui: various French translation fixes
      git-gui: minor spelling fix and string factorisation.

Sam Vilain (1):
      SubmittingPatches: itemize and reflect upon well written changes

Stephen Boyd (1):
      gitk: Provide a 32x32 window icon based on the git logo

Uwe Kleine-K=C3=B6nig (1):
      parseopt: fix documentation for --keep-dashdash

From: Junio C Hamano <junkio@cox.net>
Subject: [ANNOUNCE] GIT 1.5.0.5
Date: Sun, 18 Mar 2007 18:19:24 -0700
Message-ID: <7vvegym3mr.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vwt2ec32p.fsf@assigned-by-dhcp.cox.net>
	<7vabz0j7td.fsf@assigned-by-dhcp.cox.net>
	<7vlkic2xc8.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 02:24:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT6bu-0005B8-Li
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 02:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbXCSBY3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Mar 2007 21:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbXCSBY3
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 21:24:29 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58089 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbXCSBY1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Mar 2007 21:24:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319012428.HVVP748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Mar 2007 21:24:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cRQS1W01L1kojtg0000000; Sun, 18 Mar 2007 21:24:27 -0400
In-Reply-To: <7vlkic2xc8.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 04 Mar 2007 19:17:11 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42555>

The latest maintenance release GIT 1.5.0.5 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.0.5.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.0.5.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.0.5.tar.{gz,bz2}		(preformatted docs)
  RPMS/$arch/git-*-1.5.0.5-1.$arch.rpm	(RPM)

I didn't send announcements for 1.5.0.4 for workload and time
constraints, but Santi found and fixed a rather embarrasing
regression in 1.5.0.4 soon after it was tagged anyway, so here
it is.  The changelog below is relative to 1.5.0.3.

----------------------------------------------------------------

Changes since v1.5.0.3 are as follows:

Alexandre Julliard (2):
      git.el: Avoid appending a signoff line that is already present.
      git.el: Retrieve commit log information from .dotest directory.

Avi Kivity (1):
      git-send-email: Document configuration options

Brian Gernhardt (1):
      Fix diff-options references in git-diff and git-format-patch

=46rank Lichtenheld (1):
      cvsserver: asciidoc formatting changes

J. Bruce Fields (7):
      glossary: fix overoptimistic automatic linking of defined terms
      user-manual: fix inconsistent example
      user-manual: fix inconsistent use of pull and merge
      user-manual: fix missing colon in git-show example
      user-manual: fix rendering of history diagrams
      user-manual: install user manual stylesheet with other web docume=
nts
      git-merge: warn when -m provided on a fast forward

Jeff King (2):
      Documentation: s/seperator/separator/
      fast-import: grow tree storage more aggressively

Johannes Schindelin (2):
      Begin SubmittingPatches with a check list
      make t8001 work on Mac OS X again

Junio C Hamano (4):
      git-commit: cd to top before showing the final stat
      git-checkout: fix "eval" used for merge labelling.
      GIT 1.5.0.4
      GIT 1.5.0.5

Matthias Kestenholz (1):
      Adjust reflog filemode in shared repository

Matthias Lederhofer (1):
      setup_git_directory_gently: fix off-by-one error

Santi B=C3=A9jar (1):
      git-merge: finish when git-read-tree fails

Shawn O. Pearce (13):
      git-gui: Relocate the menu/transport menu code.
      git-gui: Add Reset to the Branch menu.
      git-gui: Don't create empty (same tree as parent) commits.
      git-gui: Remove unnecessary /dev/null redirection.
      fast-import: Avoid infinite loop after reset
      fast-import: Fail if a non-existant commit is used for merge
      git-gui: Make 'make' quieter by default
      Catch write_ref_sha1 failure in receive-pack
      git-gui: Allow committing empty merges
      git-gui: Revert "Don't modify CREDITS-FILE if it hasn't changed."
      git-gui: Revert "git-gui: Display all authors of git-gui."
      git-gui: Allow 'git gui version' outside of a repository
      Don't package the git-gui credits file anymore

Theodore Ts'o (1):
      Add definition of <commit-ish> to the main git man page.

Yann Dirson (1):
      Clarify doc for git-config --unset-all.

From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Sat, 06 Jan 2007 23:43:46 -0800
Message-ID: <7vac0v46z1.fsf@assigned-by-dhcp.cox.net>
References: <7vzm9247go.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Jan 07 08:44:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3ShD-0003Lv-DB
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 08:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbXAGHns convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 7 Jan 2007 02:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbXAGHns
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 02:43:48 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:33373 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932355AbXAGHnr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jan 2007 02:43:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070107074347.CKBT16632.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>;
          Sun, 7 Jan 2007 02:43:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 87k21W00B1kojtg0000000; Sun, 07 Jan 2007 02:44:02 -0500
To: git@vger.kernel.org
X-maint-at: 8977c110b5bbd230c28c727ddb85856067d55cfb
X-master-at: 13e86efbeae5994a85cc482b3964db7298c5c6ea
In-Reply-To: <7vzm9247go.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 01 Jan 2007 16:07:19 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36133>

I'll do v1.4.4.4 from 'maint' to have grave bugfixes in an
"officially released version" tomorrow, although we will be in
stabilation period for v1.5.0 shortly.

* The 'maint' branch has these fixes since the last announcement.

   Junio C Hamano (2):
      Fix infinite loop when deleting multiple packed refs.
      pack-check.c::verify_packfile(): don't run SHA-1 update on huge d=
ata


* The 'master' branch has these since the last announcement.

   Alexandre Julliard (3):
      git-clean: Fix the -q option.
      git.el: Don't use --info-only when resolving a file.
      git.el: Avoid setting font lock keywords before entering log-edit=
 mode.

   Andy Whitcroft (1):
      send pack check for failure to send revisions list

   Brian Gernhardt (1):
      Add documentation for git-branch's color configuration.

   Eric Wong (6):
      instaweb: load Apache mime and dir modules if they are needed
      git-svn: make multi-init less confusing
      git-svn: update documentation for multi-{init|fetch}
      git-svn: make --repack work consistently between fetch and multi-=
fetch
      Documentation/git-svn: clarify dcommit, rebase vs pull/merge
      git-svn: fix show-ignore

   Fredrik Kuivinen (1):
      instaweb: Nicer error message when the http daemon isn't found

   J. Bruce Fields (1):
      Documentation: tutorial editing

   Jakub Narebski (9):
      gitweb: Fix error in git_project_index subroutine
      gitweb: Fix bug in git_difftree_body (was '!=3D' instead of 'ne')
      gitweb: There can be empty patches (in git_patchset_body)
      gitweb: Fix "Use of uninitialized value" warning in git_tags_body
      gitweb: Fix error in git_patchest_body for file creation/deletion=
 patch
      gitweb: Fix error in "rename to"/"copy to" git diff header output
      gitweb: Fix errors in git_patchset_body for empty patches
      Revert "gitweb: There can be empty patches (in git_patchset_body)=
"
      gitweb: Fix split patches output (e.g. file to symlink)

   Junio C Hamano (9):
      Remove unused variable (git-commit.sh)
      fetch-pack: do not use lockfile structure on stack.
      Fix infinite loop when deleting multiple packed refs.
      tutorial: misc updates.
      git-verify-tag: make sure we remove temporary file.
      pack-check.c::verify_packfile(): don't run SHA-1 update on huge d=
ata
      rerere: Fix removal of already resolved path.
      builtin-prune: memory diet.
      Fix timestamp for test-tick

   Lars Hjemli (2):
      Skip excessive blank lines before commit body
      Refactor print-functions in builtin-branch

   Luben Tuikov (1):
      Blame "linenr" link jumps to previous state at "orig_lineno"

   Ren=E9 Scharfe (3):
      Make check target depend on common-cmds.h
      Remove shadowing variable from traverse_trees()
      Set default "tar" umask to 002 and owner.group to root.root

   Robert Fitzsimons (1):
      gitweb: Fix shortlog only showing HEAD revision.

   Santi B=E9jar (2):
      Documentation/tutorial: misc updates
      git-tag: add flag to verify a tag

   Sasha Khapyorsky (2):
      git-svnimport: support for incremental import
      git-svnimport: clean svn path when accessing SVN repo

   Steven Grimm (2):
      Describe git-clone's actual behavior in the summary
      Print a more accurate error message when we fail to create a lock=
 file.

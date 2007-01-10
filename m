From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git (stable)
Date: Wed, 10 Jan 2007 00:23:46 -0800
Message-ID: <7vy7obcmst.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jan 10 09:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Yln-0002Mo-SI
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 09:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbXAJIXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 10 Jan 2007 03:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbXAJIXt
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 03:23:49 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:37574 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932735AbXAJIXs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jan 2007 03:23:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110082347.IIZE97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 03:23:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9LNw1W00F1kojtg0000000; Wed, 10 Jan 2007 03:22:57 -0500
To: git@vger.kernel.org
X-maint-at: 6534141151f7fd4334f62827d9234acf3974ca4d
X-master-at: e05db0fd4f31dde7005f075a84f96b360d05984b
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36488>

* The 'maint' branch has these fixes since the last announcement.

  Junio C Hamano (2):
     Do not ignore a detected patchfile brokenness.
     Fix "Do not ignore a detected patchfile brokenness."

* The 'master' branch has these since the last announcement.

  Two rather big changes are included: sliding mmap; UTF-8 is
  default for e-mail acceptance tools.  I am slightly worried
  about the interaction of the latter with git-rebase, though...


  Alexandre Julliard (3):
     git-apply: Remove directories that have become empty after deletin=
g a file.
     git-clone: Make sure the master branch exists before running cat o=
n it.
     git.el: Define the propertize function if needed, for XEmacs compa=
tibility.

  Andy Whitcroft (5):
     ssh-upload: prevent buffer overrun
     short i/o: clean up the naming for the write_{in,or}_xxx family
     short i/o: fix calls to read to use xread or read_in_full
     short i/o: fix calls to write to use xwrite or write_in_full
     short i/o: fix config updates to use write_in_full

  Brian Gernhardt (2):
     Ignore git-init and git-remote
     Auto-quote config values in config.c:store_write_pair()

  Eric Wong (2):
     git-svn: add --prefix=3D option to multi-init
     git-svn: pass an unambiguous ref to rev-list when grafting-branche=
s

  J. Bruce Fields (2):
     Documentation: clarify definition of "reachable"
     Documentation: add git-remote man page

  Jakub Narebski (2):
     gitweb: Remove superfluous "|" in "commit" view
     gitweb: Fix git_patchset_body not closing <div class=3D"patch">

  Jeff King (1):
     get_tree_entry: map blank requested entry to tree root

  Junio C Hamano (21):
     pack-objects: fix use of use_pack().
     mmap: set FD_CLOEXEC for file descriptors we keep open for mmap()
     git-remote
     builtin-prune: make file-scope static struct to an argument.
     builtin-prune: separate ref walking from reflog walking.
     Move traversal of reachable objects into a separate library.
     reflog expire --fix-stale
     reflog --fix-stale: do not check the same trees and commits repeat=
edly.
     diff-index --cached --raw: show tree entry on the LHS for unmerged=
 entries.
     git-reset <tree> -- <path> restores absense of <path> in <tree>
     Spell default packedgitlimit slightly differently
     --utf8 is now default for 'git-am'
     --prune is now default for 'pack-refs'
     rm git-rerere.perl -- it is now a built-in.
     merge-base: do not leak commit list
     Do not ignore a detected patchfile brokenness.
     Fix "Do not ignore a detected patchfile brokenness."
     builtin-archive: do not free a tree held by the object layer.
     git-am: should work when "--no-utf8 --utf8" is given
     -u is now default for 'git-applymbox'
     -u is now default for 'git-mailinfo'.

  J=FCrgen R=FChle (5):
     Clarify syntax and role of git-add in status output
     Improve "nothing to commit" part of status output
     Support --amend on initial commit in status output
     Improve cached content header of status output
     Remove unnecessary git-rm --cached reference from status output

  Martin Langhoff (6):
     cvsimport: skip commits that are too recent
     cvsimport: skip commits that are too recent (option and documentat=
ion)
     cvsimport: document -S and -L options
     cvsimport: cleanup temporary cvsps file
     cvsserver: detect early of we are up to date and avoid costly rev-=
list
     cvsserver: fix revision number during file adds

  Michael Loeffler (1):
     git-commit: do not fail to print the diffstat even if there is a f=
ile named HEAD

  Nicolas Pitre (1):
     "init-db" can really be just "init"

  Pavel Roskin (1):
     Fix warnings in sha1_file.c - use C99 printf format if available

  Sasha Khapyorsky (1):
     git-svnimport: fix edge revisions double importing

  Shawn O. Pearce (25):
     Replace unpack_entry_gently with unpack_entry.
     Introduce new config option for mmap limit.
     Refactor packed_git to prepare for sliding mmap windows.
     Use off_t for index and pack file lengths.
     Create read_or_die utility routine.
     Refactor how we open pack files to prepare for multiple windows.
     Replace use_packed_git with window cursors.
     Loop over pack_windows when inflating/accessing data.
     Document why header parsing won't exceed a window.
     Unmap individual windows rather than entire files.
     Fully activate the sliding window pack access.
     Load core configuration in git-verify-pack.
     Ensure core.packedGitWindowSize cannot be less than 2 pages.
     Improve error message when packfile mmap fails.
     Support unmapping windows on 'temporary' packfiles.
     Create pack_report() as a debugging aid.
     Test suite for sliding window mmap implementation.
     Default core.packdGitWindowSize to 1 MiB if NO_MMAP.
     Release pack windows before reporting out of memory.
     Replace mmap with xmmap, better handling MAP_FAILED.
     Cleanup read_cache_from error handling.
     Fix random segfaults in pack-objects.
     Update packedGit config option documentation.
     Increase packedGit{Limit,WindowSize} on 64 bit systems.
     Don't die in git-http-fetch when fetching packs.

  Stefan-W. Hahn (1):
     Replacing the system call pread() with lseek()/xread()/lseek() seq=
uence.

  Steven Grimm (1):
     Update git-svn manpage to remove the implication that SVN::* is op=
tional.

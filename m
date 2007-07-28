From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Sat, 28 Jul 2007 01:47:12 -0700
Message-ID: <7vvec4synj.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v4pmgqrut.fsf@assigned-by-dhcp.cox.net>
	<7vhcqccnbm.fsf@assigned-by-dhcp.cox.net>
	<7vveepz8pr.fsf@assigned-by-dhcp.cox.net>
	<7vmyzv1acz.fsf@assigned-by-dhcp.cox.net>
	<7vejl0546b.fsf@assigned-by-dhcp.cox.net>
	<7v4plqoyg5.fsf@assigned-by-dhcp.cox.net>
	<7v7iqgtt1j.fsf@assigned-by-dhcp.cox.net>
	<7vk5u7d38h.fsf@assigned-by-dhcp.pobox.com>
	<7vy7idydqa.fsf@assigned-by-dhcp.pobox.com>
	<7v7ipsz7vr.fsf@assigned-by-dhcp.pobox.com>
	<7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net>
	<7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 10:47:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEhxH-0002EA-8C
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 10:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137AbXG1IrQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 28 Jul 2007 04:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbXG1IrQ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 04:47:16 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:51881 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbXG1IrO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2007 04:47:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070728084713.PBLL14885.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 28 Jul 2007 04:47:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UwnC1X00L1kojtg0000000; Sat, 28 Jul 2007 04:47:13 -0400
X-maint-at: 281a53bb79786a6d7e54f9715cc8ad46fc2bdb0e
X-master-at: 83b3df7d582429d9036f34d2c95abfff7bf0ab24
In-Reply-To: <7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 12 Jul 2007 23:06:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54010>

It's been a while since I sent this the last time.

We are nearing 1.5.3 final; I pulled gitk updates tonight, and
expect git-gui updates to 0.8.0 over the weekend.  There are a
handful trivial fixes since 1.5.3-rc3.

I am hoping one topic (bs/lock) to graduate from 'next' and
another from nowhere (js/worktree) before 1.5.3-rc4, probably by
mid next-week.

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

Julian Phillips (1):
  Force listingblocks to be monospaced in manpages

Junio C Hamano (1):
  Do not expect unlink(2) to fail on a directory.


* The 'master' branch has these since the last announcement
  in addition to the above.

Adam Roben (1):
  Add GIT_EDITOR environment and core.editor configuration variables

Alex Riesen (1):
  Fix git-rebase -i to allow squashing of fast-forwardable commits

Alexandre Julliard (2):
  git.el: Support for incremental status updates.
  git.el: Pass an explicit argument to enable smerge-mode.

Brian Gernhardt (1):
  Document commit.template configuration variable.

Carlos Rica (1):
  Rename read_pipe() with read_fd() and make its buffer
      nul-terminated.

David Kastrup (2):
  contrib/emacs/Makefile: Also install .el files.
  Documentation/gitignore.txt: Fix the seriously misleading priority
      explanation

Emil Medve (1):
  Use $(RM) in Makefiles instead of 'rm -f'

Eric Wong (2):
  git-svn: remove leading slashes from fetch lines in the generate
      config
  git-svn: fix commiting renames over DAV with funky file names

=46rancis Moreau (1):
  Fix git-branch documentation when using remote refs

Greg KH (1):
  make git-send-email.perl handle email addresses with no names when
      Email::Valid is present

Jakub Narebski (3):
  gitweb cleanup: Move @diff_opts declaration earlier
  gitweb: Fix support for legacy gitweb config for snapshots
  gitweb: More detailed error messages for snapshot format

Jim Meyering (2):
  git-cvsserver: detect/diagnose write failure, etc.
  pretty-options.txt: tiny doc fix

Johannes Schindelin (13):
  filter-branch: get rid of "set -e"
  rebase -i: call editor just once for a multi-squash
  fsck --lost-found: write blob's contents, not their SHA-1
  mailinfo: fix 'fatal: cannot convert from utf-8 to utf-8'
  Shut "git rebase -i" up when no --verbose was given
  rebase -i: exchange all "if [ .. ]" by "if test .."
  filter-branch: Big syntax change; support rewriting multiple refs
  Teach revision machinery about --no-walk
  git log -g: Complain, but do not fail, when no reflogs are there
  Teach approxidate() to understand "never"
  git am: skip pine's internal folder data
  rebase -i: fix overzealous output redirection
  rebase -i: fix interrupted squashing

Josh Triplett (1):
  Remove useless uses of cat, and replace with filename arguments

Junio C Hamano (24):
  Make show_rfc2822_date() just another date output format.
  Wire new date formats to --date=3D<format> parser.
  Document new --date=3D<format>
  Add contrib/stats/mailmap.pl script
  Update .mailmap
  Documentation/git-commit-tree: remove description of a nonexistent
      limitation
  GIT v1.5.3-rc2
  Update INSTALL
  Fix VISUAL/EDITOR preference order in Documentation/config.txt.
  Synonyms: -i =3D=3D --regexp-ignore-case, -E =3D=3D --extended-regexp
  Mark user-manual as UTF-8
  user-manual: fix typolets.
  t9200: Be careful when checking CVS/Entries
  GIT 1.5.3-rc3
  Make sure git-stash works from subdirectory.
  gitweb: fix broken snapshot
  git-submodule module_name: avoid using unwieldy "value_regexp"
      feature.
  git-submodule: remove redundant call to git-describe
  When locking in a symlinked repository, try to lock the original.
  git_mkstemp(): be careful not to overflow the path buffer.
  Update description of -z option.
  git-stash: do not remove a ref by hand.
  Fix git-stash apply --index
  git-stash apply --index: optimize postprocessing

Kumar Gala (1):
  send-email: Update regex parsing for pine aliases

Linus Torvalds (2):
  Do a better job at guessing unknown character sets
  Fix up duplicate parents removal

Marco Costalba (1):
  Avoid to duplicate commit message when is not encoded

Marius Storm-Olsen (1):
  Fix git-p4 on Windows to not use the Posix sysconf function.

Mark Levedahl (1):
  gitk: Ignore ctrl-z as EOF on windows

Matt McCutchen (1):
  gitweb: snapshot cleanups & support for offering multiple formats

Matthieu Moy (1):
  More permissive "git-rm --cached" behavior without -f.

Nanako Shiraishi (2):
  Document "git stash message..."
  git-stash: Make sure reflog is created for refs/stash

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  git-write-tree should not crash if prefix does not exist

Paul Mackerras (5):
  gitk: Fix bug introduced by previous commit
  gitk: Show changes in index and changes in working directory
      separately
  gitk: Make the fake commit for the index changes green rather than
      magenta
  gitk: Wait for the window to become visible after creating it
  gitk: Fix bugs in the Find function

Peter Hagervall (1):
  Make every builtin-*.c file #include "builtin.h"

Ren=C3=A9 Scharfe (2):
  filter-branch: fix dash complaining about "Missing '))'"
  cleanup unpack-trees.c: shrink struct tree_entry_list

Richard MUSIL (1):
  git-svn: Minimalistic patch which allows svn usernames with
      space(s).

Robin Rosenberg (3):
  Support output ISO 8601 format dates
  cvsexportcommit: avoid racy CVS problem.
  Document --unified/-U option

Scott Lamb (2):
  git-p4: use subprocess in p4CmdList
  git-p4: input to "p4 files" by stdin instead of arguments

Sean Estabrooks (3):
  Remove "WITH_P4IMPORT" knob from the Makefile
  Remove p4 rpm from git.spec.in.
  Demote git-p4import to contrib status.

Shawn O. Pearce (3):
  Correct trivial typo in fast-import documentation
  Teach fast-import to recursively copy files/directories
  gitk: Bind keyboard actions to the command key on Mac OS

Simon Hausmann (4):
  git-p4: Cleanup, make listExistingP4Branches a global function for
      later use.
  git-p4: Fix upstream branch detection for submit/rebase with
      multiple branches.
  git-p4: Cleanup, used common function for listing imported p4
      branches
  git-p4: Fix p4 user cache population on Windows.

Stephen Rothwell (1):
  send-email: discard blank around address in extract_valid_address
      as well.

Steven Grimm (2):
  Document how to tell git to not launch a pager
  Teach git-commit about commit message templates.

Sven Verdoolaege (2):
  lockfile.c: schedule remove_lock_file only once.
  unpack-trees.c: assume submodules are clean during check-out

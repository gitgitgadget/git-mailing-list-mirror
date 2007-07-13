From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git
Date: Thu, 12 Jul 2007 23:06:44 -0700
Message-ID: <7vzm20q1l7.fsf_-_@assigned-by-dhcp.cox.net>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 08:06:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9EIr-00086Y-Ow
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 08:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988AbXGMGGr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 13 Jul 2007 02:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751642AbXGMGGr
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 02:06:47 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:40487 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbXGMGGq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jul 2007 02:06:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070713060645.IARW1393.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 13 Jul 2007 02:06:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Nu6k1X00L1kojtg0000000; Fri, 13 Jul 2007 02:06:45 -0400
X-maint-at: ffb293b63d13b3b06b454a5f9f0ff6802ef15f0d
X-master-at: af83bed6903256c581f081ba7bba372f19804b30
In-Reply-To: <7vk5tj3bj1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 01 Jul 2007 17:16:34 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52363>

Executive summary:

 * (maint) hopefully the last maintenance release for v1.5.2
   codebase, v1.5.2.4, is out.

 * (master) v1.5.3 is nicely progressing and we have v1.5.3-rc1
   out, but it has a serious last minute glitch in pack-objects,
   so please do not use "git-gc", or "git-repack" from vanilla
   v1.5.3-rc1.

   v1.5.3-rc1-1-g7d7baa5 or later should be Ok.

 * (next/pu) No topics are cooking in 'next' right now, although
   I might apply a few series I did not pick up from the list in
   the past few days, just to keep them from getting lost.

As usual, v1.5.3-rc1 means:

 * I personally will be using 'master' version for my work until
   v1.5.3 final (I usually run 'next', and switch to 'master'
   after -rc0); I ask contributors to do the same to shake out
   the last minute bugs from 'master'.

 * No more features and large code churning on 'master' until
   v1.5.3 final.

 * Bugfixes and documenation updates are always welcomed, but
   even more so than usual until v1.5.3 final.

I'll send out a draft release notes for v1.5.3 in a separate
message.

----------------------------------------------------------------

* The 'maint' branch spawned 1.5.2.4 with accumulated fixes.
  Most notably, we are in sync with git-gui 0.7.5.

* The 'master' branch has these since the last announcement;=20
  we are at v1.5.3-rc1 plus a few fixes.

Adam Roben (1):
  format-patch: Add format.subjectprefix config option

Alecs King (1):
  fix remote.origin.url in tutorial.txt

Alex Riesen (4):
  Handle missing prefix for "Subject:" as if no prefix given
  Handle format.subjectprefix for every command which accepts
      --pretty
  Fix t5516 to create test repo without hooks
  Add -v|--verbose to git remote to show remote url

Andrew Ruder (2):
  Remove USE_PAGER from git-pickaxe and git-annotate
  Add urls.txt to git-clone man page

Brian Downing (10):
  pack-objects: Prefer shallower deltas if the size is equal
  gitk: Fix for tree view ending in nested directories
  Pack information tool
  Correct shebang line for contrib/stats/packinfo.pl
  Don't try to delta if target is much smaller than source
  Support fetching the memory usage of a delta index
  Add functions for parsing integers with size suffixes
  Add pack-objects window memory usage limit
  Add --window-memory option to git-repack
  Add documentation for --window-memory, pack.windowMemory

Brian Gernhardt (1):
  Add core.pager config variable.

CJ van den Berg (1):
  git-submodule: Fix two instances of the same typo

Carlos Rica (5):
  t7004: Skip tests for signed tags in an old version of gpg.
  t0030: Remove repeated instructions and add missing &&
  t0030: Add tests with consecutive text lines and others with spaces
      added.
  t7004: Add tests for the git tag -n option.
  Function stripspace now gets a buffer instead file descriptors.

Daniel Barkalow (2):
  Add allocation and freeing functions for struct refs
  Some cosmetic changes to remote library

David Kastrup (1):
  Add missing functions to contrib/emacs/vc-git.el

Emil Medve (1):
  git-submodule: Instead of using only annotated tags, use any tags.

Eric Wong (2):
  git-svn: allow dcommit to retain local merge information
  git-svn: fix blocking with svn:// servers after do_switch

=46rank Lichtenheld (1):
  cvsserver: always initialize state in argsplit()

Gerrit Pape (1):
  git-commit: don't add multiple Signed-off-by: from the same
      identity

Jakub Narebski (3):
  Update git-merge documentation.
  Document long options '--message=3D<msg>' and '--no-commit'
  Document git commit --untracked-files and --verbose

James Bowes (1):
  stash: allow running from a subdirectory

Jeff King (6):
  git-stash: fix "no arguments" case in documentation
  git-stash: fix "can't shift that many" with no arguments
  git-stash: don't complain when listing in a repo with no stash
  Documentation: quote {non-attributes} for asciidoc
  Documentation: quote {non-attributes} for asciidoc
  Documentation: minor cleanups to branch/checkout wording

Jeffrey C. Ollie (2):
  Add an option to quiet git-init.
  Quiet the output from git-init when cloning, if requested.

Johannes Schindelin (28):
  Move the pick_author code to git-sh-setup
  Teach rebase an interactive mode
  rebase -i: several cleanups
  rebase -i: provide reasonable reflog for the rebased branch
  Teach rebase -i about --preserve-merges
  Make '!' aliases more useful
  git-fsck: add --lost-found option
  Document git-filter-branch
  Add diff-option --ext-diff
  filter-branch: add a test for the commit removal example
  filter-branch: make output nicer
  filter-branch: a few more touch ups to the man page
  filter-branch documentation: clarify which filters are eval'ed
  filter-branch: fail gracefully when a filter fails
  Future-proof source for changes in xdemitconf_t
  Teach git-stash to "apply --index"
  Enable "git rerere" by the config variable rerere.enabled
  git-branch: default to --track
  branch.autosetupmerge: allow boolean values, or "all"
  rebase -i: handle --continue more like non-interactive rebase
  rebase -i: actually show the diffstat when being verbose
  rebase -i: remember the settings of -v, -s and -p when interrupted
  rebase -i: put a nice warning into the todo list
  rerere: record resolution even if file is not in merge base
  Fix core.sharedRepository =3D 2
  Fix --cherry-pick with given paths
  Add for_each_remote() function, and extend remote_find_tracking()
  branch --track: code cleanup and saner handling of local branches

Johannes Sixt (4):
  Test 'git add' for unmerged entries when core.symlinks=3Dfalse.
  filter-branch: Avoid an error message in the map function.
  filter-branch documentation: some more touch-ups.
  Allow rebase to run if upstream is completely merged

Jonas Fonseca (1):
  fsck --lost-found writes to subdirectories in .git/lost-found/

Junio C Hamano (30):
  diffcore_count_changes: pass diffcore_filespec
  diffcore_filespec: add is_binary
  diffcore-delta.c: update the comment on the algorithm.
  diffcore-delta.c: Ignore CR in CRLF for text files
  git-stash: require "save" to be explicit and update documentation
  Update public documentation links for 1.5.2.3
  "git-push $URL" without refspecs pushes only matching branches
  Rewrite "git-frotz" to "git frotz"
  git-stash: make "save" the default action again.
  Mark disused commit walkers officially deprecated.
  Update draft Release Notes for 1.5.3
  Update reflog message created for stashes
  Do not check if getcwd() result begins with a slash.
  Fix git-stash(1) markup.
  git-stash: allow more descriptive reminder message when saving
  Introduce diff_filespec_is_binary()
  Per-path attribute based hunk header selection.
  Fix configuration syntax to specify customized hunk header
      patterns.
  diff: honor binariness specified in attributes
  gitweb: make repeated calls to git_get_project_owner() bearable
  diff.c: make built-in hunk header pattern a separate table
  git-gui: use "blame -w -C -C" for "where did it come from,
      originally?"
  git-stash: try reusing cached stat info as much as possible
  Fix merge-one-file for our-side-added/our-side-removed cases
  Document custom hunk header selection
  revision.c: remove duplicated parents after history simplification
  Revert 88494423 (removal of duplicate parents in the output
      codepath)
  Re-code builtin-branch.c in UTF-8
  Update list of older git docs
  GIT v1.5.3-rc1

Lars Hjemli (1):
  git-submodule(1): update description and key names

Linus Torvalds (1):
  Start deprecating "git-command" in favor of "git command"

Marcus Fritzsch (1):
  Fixed a formulation mistake in Documentation/user-manual.txt

Matt Kraai (3):
  Prefer EMAIL to username@hostname.
  Change "added.moved or removed" to "added, moved or removed" in
  Add [verse] to the SYNOPSIS section of git-submodule.txt.

Matt McCutchen (3):
  gitweb: make search form generate pathinfo-style URLs
  gitweb: make "No commits" in project list gray, not bold green
  Makefile: rebuild git.o on version change, clean up git$X flags

Matthias Lederhofer (5):
  ignore git-rebase--interactive
  getenv/setenv: use constants if available
  git-init: set core.worktree if GIT_WORK_TREE is specified
  git-clone: split up long &&-command-chain and use a function for
      cleanup
  make git-clone GIT_WORK_TREE aware

Michael Hendricks (2):
  git-send-email: allow an email alias for --from
  gitweb: configurable width for the projects list Description column

Miklos Vajna (2):
  gitweb: prefer git_get_project_owner() over get_file_owner()
  gitweb: new cgi parameter: opt

Nanako Shiraishi (2):
  Add git-stash script
  Document git-stash

Nicolas Pitre (4):
  apply delta depth bias to already deltified objects
  script to display a distribution of longest common hash prefixes
  reduce git-pack-objects memory usage a little more
  Pack-objects: properly initialize the depth value

Paul Mackerras (6):
  gitk: Fix the find and highlight functions
  gitk: Fix bug in the anc_or_desc routine
  gitk: Remove the unused stopfindproc function
  gitk: Fix bug causing "can't read commitrow(0,n)" error
  gitk: Use git log and add support for --left-right
  gitk: Improve handling of -- and ambiguous arguments

Ren=C3=A9 Scharfe (1):
  diff-lib.c: don't strdup twice

Sean Estabrooks (1):
  Alter git-checkout reflog message to include "from" branch

Shawn O. Pearce (36):
  git-gui: Start blame windows as tall as possible
  git-gui: Correct resizing of remote branch delete dialog
  git-gui: Honor rerere.enabled configuration option
  git-gui: New Git version check support routine
  git-gui: Teach class system to support [$this cmd] syntax
  git-gui: Abstract the revision picker into a mega widget
  git-gui: Refactor the delete branch dialog to use class system
  git-gui: Optimize for newstyle refs/remotes layout
  git-gui: Maintain remote and source ref for tracking branches
  git-gui: Allow users to match remote branch names locally
  git-gui: Fast-forward existing branch in branch create dialog
  git-gui: Enhance choose_rev to handle hundreds of branches
  git-gui: Sort tags descending by tagger date
  git-gui: Option to default new branches to match tracking branches
  git-gui: Automatically refresh tracking branches when needed
  git-gui: Better handling of detached HEAD
  git-gui: Refactor our ui_status_value update technique
  git-gui: Refactor branch switch to support detached head
  git-gui: Unabbreviate commit SHA-1s prior to display
  git-gui: Default selection to first matching ref
  git-gui: Allow double-click in checkout dialog to start checkout
  git-gui: Extract blame viewer status bar into mega-widget
  git-gui: Change the main window progress bar to use status_bar
  git-gui: Show a progress meter for checking out files
  git-gui: Always use absolute path to all git executables
  git-gui: Correct gitk installation location
  git-gui: Assume unfound commands are known by git wrapper
  git-gui: Treat `git version` as `git --version`
  git-gui: Perform our own magic shbang detection on Windows
  git-gui: Teach console widget to use git_read
  git-gui: Improve the Windows and Mac OS X shortcut creators
  git-gui: Paper bag fix for Cygwin shortcut creation
  git-gui: Use sh.exe in Cygwin shortcuts
  git-gui: Include a space in Cygwin shortcut command lines
  Support wholesale directory renames in fast-import
  git-gui: Change prior tree SHA-1 verification to use git_read

Steffen Prohaska (1):
  filter-branch: added missing warn function

Steven Walter (1):
  Documentation for git-log --follow

Sven Verdoolaege (2):
  git-submodule: provide easy way of adding new submodules
  git-clone: fetch possibly detached HEAD over dumb http

Uwe Kleine-K=C3=B6nig (2):
  stash: end commit log with a newline
  repack: don't report "Nothing new to pack." if -q is given

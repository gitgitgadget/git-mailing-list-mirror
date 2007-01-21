From: Junio C Hamano <junkio@cox.net>
Subject: [Announce] GIT v1.5.0-rc2
Date: Sun, 21 Jan 2007 00:56:25 -0800
Message-ID: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 21 09:56:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8YVD-0000OX-GG
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 09:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbXAUI42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 21 Jan 2007 03:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbXAUI42
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 03:56:28 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40831 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbXAUI41 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jan 2007 03:56:27 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070121085626.CJDA15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Sun, 21 Jan 2007 03:56:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DkvW1W00H1kojtg0000000; Sun, 21 Jan 2007 03:55:31 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37312>

This hopefully is pretty much it for 1.5.0 modulo potential bugs
especially in newer topics.  Aside from many bugfixes, changes
since -rc1 are:

 - 'git log' is now reflog aware, and 'git show-branch' which
   knew about reflog already has become much more useful with
   reflogs.

 - the porcelain/ancillary/plumbing categorization in the git
   main documentation has been reviewed and updated.

 - merge and pull operations are much less chatty.

 - operation in a bare repositories is more pleasant.

 - the default file extension for format-patch output is .patch
   now.

----------------------------------------------------------------

Bob Proulx (1):
      git-revert: Fix die before git-sh-setup defines it.

Chris Wedgwood (1):
      cache.h; fix a couple of prototypes

David K=E5gedal (2):
      Shell syntax fix in git-reset
      Document --ignore-if-in-upstream in git-format-patch

Doug Maxey (1):
      gitk: add current directory to main window title

Eric Wong (2):
      git-svn: fix tests to work with older svn
      git-svn: print and flush authentication prompts to STDERR

Jason Riedy (4):
      Start all test scripts with /bin/sh.
      Set _ALL_SOURCE for AIX, but avoid its struct list.
      Replace "echo -n" with printf in shell scripts.
      Solaris 5.8 returns ENOTDIR for inappropriate renames.

Jeff King (1):
      git-pull: disallow implicit merging to detached HEAD

Johannes Schindelin (9):
      Fix spurious compile error
      config_set_multivar(): disallow newlines in keys
      show_date(): fix relative dates
      apply --cached: fix crash in subdirectory
      Do not verify filenames in a bare repository
      Teach the revision walker to walk by reflogs with --walk-reflogs
      --walk-reflogs: disallow uninteresting commits
      --walk-reflogs: actually find the right commit by date.
      --walk-reflogs: do not crash with cyclic reflog ancestry

Junio C Hamano (69):
      reflog-expire: brown paper bag fix.
      merge-recursive: do not report the resulting tree object name
      Explain "Not a git repository: '.git'".
      glossary typofix
      Make git-prune-packed a bit more chatty.
      Define cd_to_toplevel shell function in git-sh-setup
      Use cd_to_toplevel in scripts that implement it by hand.
      Allow whole-tree operations to be started from a subdirectory
      Use log output encoding in --pretty=3Demail headers.
      t3901: test "format-patch | am" pipe with i18n
      git-commit documentation: -a adds and also removes
      Consistent message encoding while reusing log from an existing co=
mmit.
      More tests in t3901.
      git log documentation: teach -<n> form.
      Add describe test.
      Documentation: merge-output is not too verbose now.
      Use merge-recursive in git-revert/git-cherry-pick
      git reflog expire: document --stale-fix option.
      Fix git-fetch while on detached HEAD not to give needlessly alarm=
ing
        errors
      git-push documentation: remaining bits
      git-rm documentation: remove broken behaviour from the example.
      tutorial: shorthand for remotes but show distributed nature of gi=
t
      git-commit documentation: remove comment on unfixed git-rm
      Use merge-recursive in git-checkout -m (branch switching)
      Document where configuration files are in config.txt
      git-commit: document log message formatting convention
      Documentation/SubmittingPatches: Gnus tips
      Documentation/git-tag: the command can be used to also verify a t=
ag.
      Documentation/git-tools.txt: mention tig and refer to wiki
      Documentation/git-tar-tree.txt: default umask is now 002
      Documentation/git-status.txt: mention color configuration
      Documentation/git-whatchanged.txt: show -<n> instead of --max-cou=
nt.
      Documentation/git-sh-setup.txt: programmer's docs
      Documentation: detached HEAD
      Make a short-and-sweet "git-add -i" synonym for "git-add --intera=
ctive"
      Documentation: describe shallow repository
      Documentation/glossary.txt: unpacked objects are loose.
      Documentation/glossary.txt: describe remotes/ tracking and packed=
-refs
      Introduce 'git-format-patch --suffix=3D.patch'
      git-format-patch: do not crash with format.headers without value.
      Documentation/git-resolve: deprecated.
      Documentation: suggest corresponding Porcelain-level in plumbing =
docs.
      Documentation: m can be relative in "git-blame -Ln,m"
      Documentation/git-parse-remote.txt: we deal with config vars as w=
ell
      git-format-patch -3
      Add --summary to git-format-patch by default
      git-format-patch: make --binary on by default
      git-format-patch: the default suffix is now .patch, not .txt
      Use fixed-size integers for .idx file I/O
      Documentation: move command list in git.txt into separate files.
      Documentation: sync git.txt command list and manual page title
      Documentation: Generate command lists.
      for_each_reflog_ent: do not leak FILE *
      refs.c::read_ref_at(): fix bogus munmap() call.
      Documentation: generated cmds-*.txt does not depend on git.txt
      Documentation/git.txt: command re-classification
      dwim_ref(): Separate name-to-ref DWIM code out.
      Extend read_ref_at() to be usable from places other than sha1_nam=
e.
      show-branch --reflog: show the reflog message at the top.
      show-branch --reflog: tighten input validation.
      show-branch --reflog: fix show_date() call
      Stop ignoring Documentation/README
      git-tag -d: allow deleting multiple tags at once.
      branch -f: no reason to forbid updating the current branch in a
        bare repo.
      git-rebase: allow rebasing a detached HEAD.
      log --walk-reflog: documentation
      reflog-walk: build fixes
      Fix --walk-reflog with --pretty=3Doneline
      GIT v1.5.0-rc2

Linus Torvalds (2):
      Clean up write_in_full() users
      Fix up totally buggered read_or_die()

Matthias Lederhofer (2):
      prune-packed: add -q to usage
      prune: --grace=3Dtime

Michael S. Tsirkin (1):
      fix documentation for git-commit --no-verify

Nicolas Pitre (4):
      use 'init' instead of 'init-db' for shipped docs and tools
      simplify the "no changes added to commit" message
      some doc updates
      sanitize content of README file

Peter Baumann (1):
      Make gitk work when launched in a subdirectory

Quy Tonthat (1):
      git-remote: no longer silent on unknown commands.

Ren=E9 Scharfe (1):
      Documentation: a few spelling fixes

Santi B=E9jar (1):
      tutorial: Use only separate layout

Shawn O. Pearce (18):
      Improve merge performance by avoiding in-index merges.
      Hide output about SVN::Core not being found during tests.
      Remove read_or_die in favor of better error messages.
      Remove unnecessary call_depth parameter in merge-recursive.
      Allow the user to control the verbosity of merge-recursive.
      Enable output buffering in merge-recursive.
      Display a progress meter during merge-recursive.
      Convert output messages in merge-recursive to past tense.
      Always perfer annotated tags in git-describe.
      Hash tags by commit SHA1 in git-describe.
      Use binary searching on large buckets in git-describe.
      Improve git-describe performance by reducing revision listing.
      Correct priority of lightweight tags in git-describe.
      Remove hash in git-describe in favor of util slot.
      Use nice names in conflict markers during cherry-pick/revert.
      Document the master@{n} reflog query syntax.
      Refer users to git-rev-parse for revision specification syntax.
      Document pack .idx file format upgrade strategy.

Simon 'corecode' Schubert (2):
      Use fixed-size integers for the on-disk pack structure.
      Use standard -t option for touch.

Uwe Kleine-K=F6nig (4):
      document --exec for git-push
      Update documentation of fetch-pack, push and send-pack
      make --exec=3D... option to git-push configurable
      rename --exec to --receive-pack for push and send-pack

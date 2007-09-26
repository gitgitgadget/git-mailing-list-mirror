From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 26 Sep 2007 13:05:47 -0700
Message-ID: <7vhclhyyxw.fsf@gitster.siamese.dyndns.org>
References: <7v3axsch0d.fsf@gitster.siamese.dyndns.org>
	<7v3axhd0lr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 26 22:06:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iad8z-0007ee-6K
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 22:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbXIZUFy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Sep 2007 16:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbXIZUFx
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 16:05:53 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:46021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbXIZUFw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2007 16:05:52 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 5A8ED13C915;
	Wed, 26 Sep 2007 16:06:11 -0400 (EDT)
X-maint-at: bce92405aebf217a4738bab0df89516910818e68
X-master-at: 5166810b1e16b22e342f2181a3535e70c6e7a119
In-Reply-To: <7v3axhd0lr.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 14 Sep 2007 03:04:32 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59243>

Nothing earth-shattering in 'maint', except:

 - if you are on FreeBSD and use its default shell, git scripts
   might work better for you;

 - comes with updated user-manual;

 - send-email would not incorrectly issue duplicated message IDs
   even if you fire many messages within one second;

 - "git rm this-file && git commit this-file" should work
   better;

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

Benoit Sigoure (1):
  Add test to check recent fix to "git add -u"

David Brown (1):
  Detect exec bit in more cases.

David Kastrup (1):
  Supplant the "while case ... break ;; esac" idiom

Eric Wong (2):
  Documentation/git-svn: updated design philosophy notes
  git-svn: don't attempt to spawn pager if we don't want one

Gerrit Pape (1):
  git-gui: lib/index.tcl: handle files with % in the filename
      properly

Glenn Rempe (1):
  Fixed minor typo in t/t9001-send-email.sh test command line.

J. Bruce Fields (14):
  user-manual: adjust section levels in "git internals"
  user-manual: move object format details to hacking-git chapter
  user-manual: rename "git internals" to "git concepts"
  user-manual: create new "low-level git operations" chapter
  user-manual: rewrite index discussion
  user-manual: reorder commit, blob, tree discussion
  user-manual: rewrite object database discussion
  user-manual: move packfile and dangling object discussion
  user-manual: fix introduction to packfiles
  user-manual: todo updates and cleanup
  documentation: replace Discussion section by link to user-manual
      chapter
  core-tutorial: minor cleanup
  git-apply: fix whitespace stripping
  user-manual: don't assume refs are stored under .git/refs

Jakub Narebski (2):
  gitweb: Remove parse_from_to_diffinfo code from git_patchset_body
  gitweb: No difftree output for trivial merge

Jari Aalto (1):
  Documentation/git-archive.txt: a couple of clarifications.

Jeff King (1):
  git-push: documentation and tests for pushing only branches

Jim Meyering (2):
  unexpected Make output (e.g. from --debug) causes build failure
  Do not over-quote the -f envelopesender value.

Johannes Schindelin (2):
  revision walker: --cherry-pick is a limited operation
  apply --index-info: fall back to current index for mode changes

Johannes Sixt (2):
  gitattributes.txt: Remove a duplicated paragraph about 'ident' and
      'crlf' interaction.
  gitattributes.txt: Be more to the point in the filter driver
      description.

Junio C Hamano (11):
  diff --no-index: do not forget to run diff_setup_done()
  Documentation/git-config.txt: AsciiDoc tweak to avoid leading dot
  Split grep arguments in a way that does not requires to add
      /dev/null.
  git-sh-setup: typofix in comments
  send-email: make message-id generation a bit more robust
  git-commit: Allow partial commit of file removal.
  git-commit: partial commit of paths only removed from the index
  Document ls-files --with-tree=3D<tree-ish>
  t/t4014: test "am -3" with mode-only change.
  GIT 1.5.3.2
  Documentation/git-lost-found.txt: drop unnecessarily duplicated
      name.

Linus Torvalds (1):
  Fix the rename detection limit checking

Matt Kraai (2):
  Move the paragraph specifying where the .idx and .pack files should
      be
  Conjugate "search" correctly in the git-prune-packed man page.

Matthias Urlichs (1):
  git-svnimport: Use separate arguments in the pipe for git-rev-parse

Michael Smith (1):
  user-manual: Explain what submodules are good for.

Michele Ballabio (2):
  git-gui: show unstaged symlinks in diff viewer
  git-gui: handle "deleted symlink" diff marker

Miklos Vajna (1):
  User Manual: add a chapter for submodules

Pierre Habouzit (1):
  Fix lapsus in builtin-apply.c

Randy Dunlap (1):
  core-tutorial: correct URL

Shawn Bohrer (1):
  Fix spelling of overridden in documentation

Shawn O. Pearce (13):
  git-gui: Correct starting of git-remote to handle -w option
  git-gui: Fix detaching current branch during checkout
  git-gui: Properly set the state of "Stage/Unstage Hunk" action
  git-gui: Disable Tk send in all git-gui sessions
  git-gui: Avoid use of libdir in Makefile
  git-gui: Assume untracked directories are Git submodules
  git-gui: Trim trailing slashes from untracked submodule names
  git-gui: Don't delete send on Windows as it doesn't exist
  git-gui: Make backporting changes from i18n version easier
  git-gui: Font chooser to handle a large number of font families
  git-gui: Provide 'uninstall' Makefile target to undo an
      installation
  git-gui: Paper bag fix "Commit->Revert" format arguments
  git-gui: Disable native platform text selection in "lists"

V=C3=A4in=C3=B6 J=C3=A4rvel=C3=A4 (1):
  Fixed update-hook example allow-users format.


* The 'master' branch has these since the last announcement
  in addition to the above.

Carlos Rica (3):
  Add tests for documented features of "git reset".
  Move make_cache_entry() from merge-recursive.c into read-cache.c
  Make "git reset" a builtin.

Christian Couder (4):
  rev-list --bisect: Move finding bisection into do_find_bisection.
  rev-list --bisect: Move some bisection code into best_bisection.
  rev-list --bisect: Bisection "distance" clean up.
  rev-list --bisect: Fix best =3D=3D NULL case.

David Kastrup (3):
  diff-delta.c: pack the index structure
  diff-delta.c: Rationalize culling of hash buckets
  git-commit.sh: Shell script cleanup

Dmitry Potapov (1):
  preserve executable bits in zip archives

Jeff King (1):
  contrib/fast-import: add perl version of simple example

Johannes Schindelin (7):
  Teach "git remote" a mirror mode
  verify-tag: also grok CR/LFs in the tag signature
  apply: get rid of --index-info in favor of --build-fake-ancestor
  rebase -i: commit when continuing after "edit"
  rebase -i: style fixes and minor cleanups
  rebase -i: Fix numbers in progress report
  rebase -i: avoid exporting GIT_AUTHOR_* variables

Josh England (2):
  Add post-merge hook, related documentation, and tests.
  Added example hook script to save/restore permissions/ownership.

Junio C Hamano (8):
  Keep last used delta base in the delta window
  git-commit: Allow partial commit of file removal.
  An additional test for "git-reset -- path"
  Simplify cache API
  git-commit: partial commit of paths only removed from the index
  Document ls-files --with-tree=3D<tree-ish>
  builtin-pack-objects.c: avoid bogus gcc warnings
  Start RelNotes for 1.5.4

Lars Hjemli (3):
  git-svn: add support for --first-parent
  git-svn: always use --first-parent
  Make merge-recursive honor diff.renamelimit

Matt Kraai (2):
  Move convert-objects to contrib.
  rebase -i: create .dotest-merge after validating options.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
  contrib/fast-import: add simple shell example

Nicolas Pitre (10):
  straighten the list of objects to deltify
  localize window memory usage accounting
  rearrange delta search progress reporting
  basic threaded delta search
  threaded delta search: refine work allocation
  threaded delta search: better chunck split point
  threaded delta search: specify number of threads at run time
  fix threaded delta search locking
  threaded delta search: add pack.threads config variable
  threaded delta search: proper locking for cache accounting

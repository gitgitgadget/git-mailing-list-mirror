From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.9.0-rc1
Date: Tue, 31 May 2016 14:53:27 -0700
Message-ID: <xmqq4m9d51yg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue May 31 23:53:49 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1b7rbY-0002La-I3
	for glk-linux-kernel-3@plane.gmane.org; Tue, 31 May 2016 23:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbcEaVxg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 31 May 2016 17:53:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61762 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751341AbcEaVxb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2016 17:53:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 18EC11E8B3;
	Tue, 31 May 2016 17:53:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=fraRHcSDjWtcpKURqlGFm+59s
	WA=; b=fO9YhQHPoTKXec3oY3WdfyqciHQ1aTmjCyEgsTzK7Eve0VmL/hxX06Qem
	wslBwuxELf9Op5fcUrhsGe7MQkNthPWNy3mYbKYbtGwnrgDxXuSh+jXyB/1DEu6S
	hBSWIEssQeZIj8v07duK0ZGnrVJx0BfQkVPPVuaKq7uGHhJJnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=baoJfPjtLQD7i5q/vLX
	/dxPx8oB8CQog9A3vxlDQXBuodu3HBUK30Un5+kawXNOHQREY30fN//f4XZqxDoZ
	gcGNcOPWz/5twVmyU+DHyo/DkbzhIeQXmbrBmaOf6TF/oqD8DFM+s7S19ROuYvaQ
	O3mgsxRGa/dSmADGzUtcSrX0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1154D1E8B2;
	Tue, 31 May 2016 17:53:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5418B1E8B0;
	Tue, 31 May 2016 17:53:29 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1C2C565A-277A-11E6-853F-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296017>

A release candidate Git v2.9.0-rc1 is now available for testing
at the usual places.  It is comprised of 462 non-merge commits
since v2.8.0, contributed by 63 people, 24 of which are new faces.

There still are a few topics yet to be merged to 'master' for the
upcoming release, but otherwise this is pretty much "feature
complete".  One known brown-paper-bag breakage exists in t/perf/,
whose fix is still in 'next'.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the
'v2.9.0-rc1' tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.8.0 are as follows.
Welcome to the Git development community!

  Alexander Rinass, Armin Kunaschik, Ben Woosley, Gabriel Souza
  Franco, Jacob Nisnevich, Jan Durovec, Jean-No=C3=ABl Avila, Kazuki
  Yamaguchi, Keller Fuchs, Laurent Arnoud, Li Peng, Marios Titas,
  Mehul Jain, Michael Procter, Nikola Forr=C3=B3, Pranit Bauva, Ray
  Zhang, Ren=C3=A9 Nyffenegger, Santiago Torres, Saurav Sachidanand,
  Shin Kojima, Sidhant Sharma [:tk], Stanislav Kolotinskiy,
  and Xiaolong Ye.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Adam Dinwoodie, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason, Alexander Kul=
eshov,
  brian m. carlson, Brian Norris, Christian Couder, David Aguilar,
  David Turner, Dennis Kaarsemaker, Elia Pinto, Elijah Newren,
  Eric Sunshine, Eric Wong, Felipe Contreras, Jacob Keller,
  Jeff King, Jiang Xin, Johannes Schindelin, Johannes Sixt,
  John Keeping, Junio C Hamano, Karsten Blees, Lars Schneider,
  Linus Torvalds, Luke Diamand, Matthieu Moy, Michael Haggerty,
  Michael J Gruber, Michael Rappazzo, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy,
  Ori Avtalion, Ralf Thielow, Ramsay Jones, Stefan Beller, Stephen
  P. Smith, Sven Strickroth, SZEDER G=C3=A1bor, Torsten B=C3=B6gershaus=
en,
  and Vasco Almeida.

----------------------------------------------------------------

Git 2.9 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Backward compatibility notes
----------------------------

The end-user facing Porcelain level commands in the "git diff" and
"git log" family by default enable the rename detection; you can still
use "diff.renames" configuration variable to disable this.

Merging two branches that have no common ancestor with "git merge" is
by default forbidden now to prevent creating such an unusual merge by
mistake.

The output formats of "git log" that indents the commit log message by
4 spaces now expands HT in the log message by default.  You can use
the "--no-expand-tabs" option to disable this.

"git commit-tree" plumbing command required the user to always sign
its result when the user sets the commit.gpgsign configuration
variable, which was an ancient mistake, which this release corrects.
A script that drives commit-tree, if it relies on this mistake, now
needs to read commit.gpgsign and pass the -S option as necessary.


Updates since v2.8
------------------

UI, Workflows & Features

 * Comes with git-multimail 1.3.1 (in contrib/).

 * The end-user facing commands like "git diff" and "git log"
   now enable the rename detection by default.

 * The credential.helper configuration variable is cumulative and
   there is no good way to override it from the command line.  As
   a special case, giving an empty string as its value now serves
   as the signal to clear the values specified in various files.

 * A new "interactive.diffFilter" configuration can be used to
   customize the diff shown in "git add -i" sessions.

 * "git p4" now allows P4 author names to be mapped to Git author
   names.

 * "git rebase -x" can be used without passing "-i" option.

 * "git -c credential.<var>=3D<value> submodule" can now be used to
   propagate configuration variables related to credential helper
   down to the submodules.

 * "git tag" can create an annotated tag without explicitly given an
   "-a" (or "-s") option (i.e. when a tag message is given).  A new
   configuration variable, tag.forceSignAnnotated, can be used to tell
   the command to create signed tag in such a situation.

 * "git merge" used to allow merging two branches that have no common
   base by default, which led to a brand new history of an existing
   project created and then get pulled by an unsuspecting maintainer,
   which allowed an unnecessary parallel history merged into the
   existing project.  The command has been taught not to allow this by
   default, with an escape hatch "--allow-unrelated-histories" option
   to be used in a rare event that merges histories of two projects
   that started their lives independently.

 * "git pull" has been taught to pass the "--allow-unrelated-histories"
   option to underlying "git merge".

 * "git apply -v" learned to report paths in the patch that were
   skipped via --include/--exclude mechanism or being outside the
   current working directory.

 * Shell completion (in contrib/) updates.

 * The commit object name reported when "rebase -i" stops has been
   shortened.

 * "git worktree add" can be given "--no-checkout" option to only
   create an empty worktree without checking out the files.

 * "git mergetools" learned to drive ExamDiff.

 * "git pull --rebase" learned "--[no-]autostash" option, so that
   the rebase.autostash configuration variable set to true can be
   overridden from the command line.

 * When "git log" shows the log message indented by 4-spaces, the
   remainder of a line after a HT does not align in the way the author
   originally intended.  The command now expands tabs by default to hel=
p
   such a case, and allows the users to override it with a new option,
   "--no-expand-tabs".

 * "git send-email" now uses a more readable timestamps when
   formulating a message ID.

 * "git rerere" can encounter two or more files with the same conflict
   signature that have to be resolved in different ways, but there was
   no way to record these separate resolutions.

 * "git p4" learned to record P4 jobs in Git commit that imports from
   the history in Perforce.

 * "git describe --contains" often made a hard-to-justify choice of
   tag to name a given commit, because it tried to come up
   with a name with smallest number of hops from a tag, causing an old
   commit whose close descendant that is recently tagged were not
   described with respect to an old tag but with a newer tag.  It did
   not help that its computation of "hop" count was further tweaked to
   penalize being on a side branch of a merge.  The logic has been
   updated to favor using the tag with the oldest tagger date, which
   is a lot easier to explain to the end users: "We describe a commit
   in terms of the (chronologically) oldest tag that contains the
   commit."
   (merge 7550424 js/name-rev-use-oldest-ref later to maint).

 * "git clone" learned the "--shallow-submodules" option.

 * HTTP transport clients learned to throw extra HTTP headers at the
   server, specified via http.extraHeader configuration variable.

 * Patch output from "git diff" and friends has been tweaked to be
   more readable by using a blank line as a strong hint that the
   contents before and after it belong to logically separate units.

 * A new configuration variable core.hooksPath allows customizing
   where the hook directory is.

 * An earlier addition of "sanitize_submodule_env" with 14111fc4 (git:
   submodule honor -c credential.* from command line, 2016-02-29)
   turned out to be a convoluted no-op; implement what it wanted to do
   correctly, and stop filtering settings given via "git -c var=3Dval".

 * "git commit --dry-run" reported "No, no, you cannot commit." in one
   case where "git commit" would have allowed you to commit, and this
   improves it a little bit ("git commit --dry-run --short" still does
   not give you the correct answer, for example).  This is a stop-gap
   measure in that "commit --short --dry-run" still gives an incorrect
   result.

 * The experimental "multiple worktree" feature gains more safety to
   forbid operations on a branch that is checked out or being actively
   worked on elsewhere, by noticing that e.g. it is being rebased.

 * "git format-patch" learned a new "--base" option to record what
   (public, well-known) commit the original series was built on in
   its output.

 * "git commit" learned to pay attention to the "commit.verbose"
   configuration variable and act as if the "--verbose" option
   was given from the command line.

 * Updated documentation gives hints to GMail users with two-factor
   auth enabled that they need app-specific-password when using
   "git send-email".


Performance, Internal Implementation, Development Support etc.

 * The embedded args argv-array in the child process is used to build
   the command line to run pack-objects instead of using a separate
   array of strings.

 * A test for tags has been restructured so that more parts of it can
   easily be run on a platform without a working GnuPG.

 * The startup_info data, which records if we are working inside a
   repository (among other things), are now uniformly available to Git
   subcommand implementations, and Git avoids attempting to touch
   references when we are not in a repository.

 * The command line argument parser for "receive-pack" has been
   rewritten to use parse-options.

 * A major part of "git submodule update" has been ported to C to take
   advantage of the recently added framework to run download tasks in
   parallel.  Other updates to "git submodule" that move pieces of
   logic to C continues.

 * Rename bunch of tests on "git clone" for better organization.

 * The tests that involve running httpd leaked the system-wide
   configuration in /etc/gitconfig to the tested environment.

 * Build updates for MSVC.

 * The repository set-up sequence has been streamlined (the biggest
   change is that there is no longer git_config_early()), so that we
   do not attempt to look into refs/* when we know we do not have a
   Git repository.

 * Code restructuring around the "refs" API to prepare for pluggable
   refs backends.

 * Sources to many test helper binaries and the generated helpers
   have been moved to t/helper/ subdirectory to reduce clutter at the
   top level of the tree.

 * Unify internal logic between "git tag -v" and "git verify-tag"
   commands by making one directly call into the other.

 * "merge-recursive" strategy incorrectly checked if a path that is
   involved in its internal merge exists in the working tree.

 * The test scripts for "git p4" (but not "git p4" implementation
   itself) has been updated so that they would work even on a system
   where the installed version of Python is python 3.

 * As nobody maintains our in-tree git.spec.in and distros use their
   own spec file, we stopped pretending that we support "make rpm".

 * Move from "unsigned char[20]" to "struct object_id" continues.

 * The code for warning_errno/die_errno has been refactored and a new
   error_errno() reporting helper is introduced.
   (merge 1da045f nd/error-errno later to maint).

 * Running tests with '-x' option to trace the individual command
   executions is a useful way to debug test scripts, but some tests
   that capture the standard error stream and check what the command
   said can be broken with the trace output mixed in.  When running
   our tests under "bash", however, we can redirect the trace output
   to another file descriptor to keep the standard error of programs
   being tested intact.
   (merge d88785e jk/test-send-sh-x-trace-elsewhere later to maint).

 * t0040 had too many unnecessary repetitions in its test data.  Teach
   test-parse-options program so that a caller can tell what it
   expects in its output, so that these repetitions can be cleaned up.

 * Add perf test for "rebase -i".

 * Common mistakes when writing gitlink: in our documentation are
   found by "make check-docs".

 * t9xxx series has been updated primarily for readability, while
   fixing small bugs in it.  A few scripted Porcelain commands have
   also been updated to fix possible bugs around their use of
   "test -z" and "test -n".

 * CI test was taught to run git-svn tests.

 * "git cat-file --batch-all" has been sped up, by taking advantage
   of the fact that it does not have to read a list of objects, in two
   ways.

 * test updates to make it more readable and maintainable.
   (merge e6273f4 es/t1500-modernize later to maint).


Also contains various documentation updates and code clean-ups.


=46ixes since v2.8
----------------

Unless otherwise noted, all the fixes since v2.8 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * "git config --get-urlmatch", unlike other variants of the "git
   config --get" family, did not signal error with its exit status
   when there was no matching configuration.

 * The "--local-env-vars" and "--resolve-git-dir" options of "git
   rev-parse" failed to work outside a repository when the command's
   option parsing was rewritten in 1.8.5 era.

 * "git index-pack --keep[=3D<msg>] pack-$name.pack" simply did not wor=
k.

 * Fetching of history by naming a commit object name directly didn't
   work across remote-curl transport.

 * A small memory leak in an error codepath has been plugged in xdiff
   code.

 * strbuf_getwholeline() did not NUL-terminate the buffer on certain
   corner cases in its error codepath.

 * "git mergetool" did not work well with conflicts that both sides
   deleted.

 * "git send-email" had trouble parsing alias file in mailrc format
   when lines in it had trailing whitespaces on them.

 * When "git merge --squash" stopped due to conflict, the concluding
   "git commit" failed to read in the SQUASH_MSG that shows the log
   messages from all the squashed commits.

 * "git merge FETCH_HEAD" dereferenced NULL pointer when merging
   nothing into an unborn history (which is arguably unusual usage,
   which perhaps was the reason why nobody noticed it).

 * When "git worktree" feature is in use, "git branch -d" allowed
   deletion of a branch that is checked out in another worktree,
   which was wrong.

 * When "git worktree" feature is in use, "git branch -m" renamed a
   branch that is checked out in another worktree without adjusting
   the HEAD symbolic ref for the worktree.

 * "git diff -M" used to work better when two originally identical
   files A and B got renamed to X/A and X/B by pairing A to X/A and B
   to X/B, but this was broken in the 2.0 timeframe.

 * "git send-pack --all <there>" was broken when its command line
   option parsing was written in the 2.6 timeframe.

 * "git format-patch --help" showed `-s` and `--no-patch` as if these
   are valid options to the command.  We already hide `--patch` option
   from the documentation, because format-patch is about showing the
   diff, and the documentation now hides these options as well.

 * When running "git blame $path" with unnormalized data in the index
   for the path, the data in the working tree was blamed, even though
   "git add" would not have changed what is already in the index, due
   to "safe crlf" that disables the line-end conversion.  It has been
   corrected.

 * A change back in version 2.7 to "git branch" broke display of a
   symbolic ref in a non-standard place in the refs/ hierarchy (we
   expect symbolic refs to appear in refs/remotes/*/HEAD to point at
   the primary branch the remote has, and as .git/HEAD to point at the
   branch we locally checked out).

 * A partial rewrite of "git submodule" in the 2.7 timeframe changed
   the way the gitdir: pointer in the submodules point at the real
   repository location to use absolute paths by accident.  This has
   been corrected.

 * "git commit" misbehaved in a few minor ways when an empty message
   is given via -m '', all of which has been corrected.

 * Support for CRAM-MD5 authentication method in "git imap-send" did
   not work well.

 * Upcoming OpenSSL 1.1.0 will break compilation by updating a few API
   elements we use in imap-send, which has been adjusted for the change=
=2E

 * The socks5:// proxy support added back in 2.6.4 days was not aware
   that socks5h:// proxies behave differently from socks5:// proxies.

 * "git config" had a codepath that tried to pass a NULL to
   printf("%s"), which nobody seems to have noticed.

 * On Cygwin, object creation uses the "create a temporary and then
   rename it to the final name" pattern, not "create a temporary,
   hardlink it to the final name and then unlink the temporary"
   pattern.

   This is necessary to use Git on Windows shared directories, and is
   already enabled for the MinGW and plain Windows builds.  It also
   has been used in Cygwin packaged versions of Git for quite a while.
   See http://thread.gmane.org/gmane.comp.version-control.git/291853

 * "merge-octopus" strategy did not ensure that the index is clean
   when merge begins.

 * When "git merge" notices that the merge can be resolved purely at
   the tree level (without having to merge blobs) and the resulting
   tree happens to already exist in the object store, it forgot to
   update the index, which left an inconsistent state that would
   break later operations.

 * "git submodule" reports the paths of submodules the command
   recurses into, but these paths were incorrectly reported when
   the command was not run from the root level of the superproject.

 * The "user.useConfigOnly" configuration variable makes it an error
   if users do not explicitly set user.name and user.email.  However,
   its check was not done early enough and allowed another error to
   trigger, reporting that the default value we guessed from the
   system setting was unusable.  This was a suboptimal end-user
   experience as we want the users to set user.name/user.email without
   relying on the auto-detection at all.

 * "git mv old new" did not adjust the path for a submodule that lives
   as a subdirectory inside old/ directory correctly.

 * "git replace -e" did not honour "core.editor" configuration.

 * "git push" from a corrupt repository that attempts to push a large
   number of refs deadlocked; the thread to relay rejection notices
   for these ref updates blocked on writing them to the main thread,
   after the main thread at the receiving end notices that the push
   failed and decides not to read these notices and return a failure.

 * mmap emulation on Windows has been optimized and work better without
   consuming paging store when not needed.

 * A question by "git send-email" to ask the identity of the sender
   has been updated.

 * UI consistency improvements for "git mergetool".

 * "git rebase -m" could be asked to rebase an entire branch starting
   from the root, but failed by assuming that there always is a parent
   commit to the first commit on the branch.

 * Fix a broken "p4 lfs" test.

 * Recent update to Git LFS broke "git p4" by changing the output from
   its "lfs pointer" subcommand.

 * "git fetch" test t5510 was flaky while running a (forced) automagic
   garbage collection.

 * Documentation updates to help contributors setting up Travis CI
   test for their patches.

 * Some multi-byte encoding can have a backslash byte as a later part
   of one letter, which would confuse "highlight" filter used in
   gitweb.

 * "git commit-tree" plumbing command required the user to always sign
   its result when the user sets the commit.gpgsign configuration
   variable, which was an ancient mistake.  Rework "git rebase" that
   relied on this mistake so that it reads commit.gpgsign and pass (or
   not pass) the -S option to "git commit-tree" to keep the end-user
   expectation the same, while teaching "git commit-tree" to ignore
   the configuration variable.  This will stop requiring the users to
   sign commit objects used internally as an implementation detail of
   "git stash".

 * "http.cookieFile" configuration variable clearly wants a pathname,
   but we forgot to treat it as such by e.g. applying tilde expansion.
   (merge e5a39ad bn/http-cookiefile-config later to maint).

 * Consolidate description of tilde-expansion that is done to
   configuration variables that take pathname to a single place.
   (merge dca83ab jc/config-pathname-type later to maint).

 * Correct faulty recommendation to use "git submodule deinit ." when
   de-initialising all submodules, which would result in a strange
   error message in a pathological corner case.
   (merge f6a5279 sb/submodule-deinit-all later to maint).

 * Many 'linkgit:<git documentation page>' references were broken,
   which are all fixed with this.
   (merge 1cca17d jc/linkgit-fix later to maint).

 * "git rerere" can get confused by conflict markers deliberately left
   by the inner merge step, because they are indistinguishable from
   the real conflict markers left by the outermost merge which are
   what the end user and "rerere" need to look at.  This was fixed by
   making the conflict markers left by the inner merges a bit longer.
   (merge 0f9fd5c jc/ll-merge-internal later to maint).

 * CI test was taught to build documentation pages.
   (merge b98712b ls/travis-build-doc later to maint).

 * "git fsck" learned to catch NUL byte in a commit object as
   potential error and warn.
   (merge 6d2d780 jc/fsck-nul-in-commit later to maint).

 * Portability enhancement for "rebase -i" to help platforms whose
   shell does not like "for i in <empty>" (which is not POSIX-kosher).
   (merge 8e98b35 jk/rebase-interactive-eval-fix later to maint).

 * On Windows, .git and optionally any files whose name starts with a
   dot are now marked as hidden, with a core.hideDotFiles knob to
   customize this behaviour.
   (merge ebf31e7 js/windows-dotgit later to maint).

 * Documentation for "git merge --verify-signatures" has been updated
   to clarify that the signature of only the commit at the tip is
   verified.  Also the phrasing used for signature and key validity is
   adjusted to align with that used by OpenPGP.
   (merge 05a5869 kf/gpg-sig-verification-doc later to maint).

 * A couple of bugs around core.autocrlf have been fixed.
   (merge caa47ad tb/core-eol-fix later to maint).

 * Many commands normalize command line arguments from NFD to NFC
   variant of UTF-8 on OSX, but commands in the "diff" family did
   not, causing "git diff $path" to complain that no such path is
   known to Git.  They have been taught to do the normalization.
   (merge 90a78b8 ar/diff-args-osx-precompose later to maint).

 * "git difftool" learned to handle unmerged paths correctly in
   dir-diff mode.
   (merge 366f9ce da/difftool later to maint).

 * The "are we talking with TTY, doing an interactive session?"
   detection has been updated to work better for "Git for Windows".
   (merge f7f90e0 kb/msys2-tty later to maint).

 * We forgot to add "git log --decorate=3Dauto" to documentation when w=
e
   added the feature back in v2.1.0 timeframe.
   (merge 462cbb4 rj/log-decorate-auto later to maint).

 * "git fast-import --export-marks" would overwrite the existing marks
   file even when it makes a dump from its custom die routine.
   Prevent it from doing so when we have an import-marks file but
   haven't finished reading it.
   (merge f4beed6 fc/fast-import-broken-marks-file later to maint).

 * Other minor clean-ups and documentation updates
   (merge 832c0e5 lp/typofixes later to maint).
   (merge f5ee54a sb/z-is-gnutar-ism later to maint).
   (merge 2e3926b va/i18n-misc-updates later to maint).
   (merge f212dcc bn/config-doc-tt-varnames later to maint).
   (merge f54bea4 nd/remote-plural-ours-plus-theirs later to maint).
   (merge 2bb0518 ak/t4151-ls-files-could-be-empty later to maint).
   (merge 4df4313 jc/test-seq later to maint).
   (merge a75a308 tb/t5601-sed-fix later to maint).
   (merge 6c1fbe1 va/i18n-remote-comment-to-align later to maint).
   (merge dee2303 va/mailinfo-doc-typofix later to maint).

----------------------------------------------------------------

Changes since v2.8.0 are as follows:

Adam Dinwoodie (2):
      config.mak.uname: Cygwin needs OBJECT_CREATION_USES_RENAMES
      commit: --amend -m '' silently fails to wipe message

Alexander Kuleshov (1):
      submodule-config: use hashmap_iter_first()

Alexander Rinass (1):
      diff: run arguments through precompose_argv

Armin Kunaschik (2):
      t4151: make sure argument to 'test -z' is given
      t0008: 4 tests fail with ksh88

Ben Woosley (1):
      git-rebase--merge: don't include absent parent as a base

Brian Norris (3):
      Documentation: config: improve word ordering for http.cookieFile
      http: expand http.cookieFile as a path
      config: consistently format $variables in monospaced font

Christian Couder (5):
      Documentation: talk about pager in api-trace.txt
      builtin/apply: get rid of useless 'name' variable
      builtin/apply: handle parse_binary() failure
      builtin/apply: free patch when parse_chunk() fails
      Git/SVN: die when there is no commit metadata

David Aguilar (4):
      mergetool: support delete/delete conflicts
      mergetool: honor tempfile configuration when resolving delete con=
flicts
      difftool: initialize variables for readability
      difftool: handle unmerged files in dir-diff mode

David Turner (5):
      refs: move head_ref{,_submodule} to the common code
      refs: move for_each_*ref* functions into common code
      files-backend: break out ref reading
      refs: move resolve_ref_unsafe into common code
      refs: on symref reflog expire, lock symref not referrent

Dennis Kaarsemaker (1):
      Makefile: remove dependency on git.spec

Elia Pinto (1):
      api-trace.txt: fix typo

Elijah Newren (6):
      merge-recursive: remove duplicate code
      merge-recursive: do not check working copy when creating a virtua=
l merge base
      t7605: add a testcase demonstrating a bug with trivial merges
      builtin/merge.c: fix a bug with trivial merges
      merge-octopus: abort if index does not match HEAD
      t6044: new merge testcases for when index doesn't match HEAD

Eric Sunshine (10):
      lib-gpg: drop unnecessary "missing GPG" warning
      t6302: normalize names and descriptions of signed tags
      t6302: also test annotated in addition to signed tags
      t6302: skip only signed tags rather than all tests when GPG is mi=
ssing
      git-format-patch.txt: don't show -s as shorthand for multiple opt=
ions
      t1500: be considerate to future potential tests
      t1500: test_rev_parse: facilitate future test enhancements
      t1500: avoid changing working directory outside of tests
      t1500: avoid setting configuration options outside of tests
      t1500: avoid setting environment variables outside of tests

Eric Wong (4):
      send-email: more meaningful Message-ID
      send-email: do not load Data::Dumper
      pack-objects: warn on split packs disabling bitmaps
      .mailmap: update to my shorter email address

=46elipe Contreras (1):
      fast-import: do not truncate exported marks file

Gabriel Souza Franco (2):
      fetch-pack: fix object_id of exact sha1
      fetch-pack: update the documentation for "<refs>..." arguments

Jacob Keller (7):
      submodule: don't pass empty string arguments to submodule--helper=
 clone
      submodule: check argc count for git submodule--helper clone
      submodule: fix submodule--helper clone usage
      submodule: fix segmentation fault in submodule--helper clone
      quote: implement sq_quotef()
      git: submodule honor -c credential.* from command line
      xdiff: add recs_match helper function

Jacob Nisnevich (2):
      mergetools: create mergetool_find_win32_cmd() helper function for=
 winmerge
      mergetools: add support for ExamDiff

Jan Durovec (2):
      git-p4: clean-up code style in tests
      git-p4: add P4 jobs to git commit message

Jeff King (55):
      credential: let empty credential specs reset helper list
      t1515: add tests for rev-parse out-of-repo helpers
      add--interactive: allow custom diff highlighting programs
      rev-parse: let some options run outside repository
      strbuf_getwholeline: NUL-terminate getdelim buffer on error
      setup: make startup_info available everywhere
      setup: set startup_info->have_repository more reliably
      remote: don't resolve HEAD in non-repository
      mailmap: do not resolve blobs in a non-repository
      grep: turn off gitlink detection for --no-index
      use setup_git_directory() in test-* programs
      setup: document check_repository_format()
      wrap shared_repository global in get/set accessors
      lazily load core.sharedrepository
      check_repository_format_gently: stop using git_config_early
      config: drop git_config_early
      setup: refactor repo format reading and verification
      init: use setup.c's repo version verification
      setup: unify repository version callbacks
      setup: drop repository_format_version global
      verify_repository_format: mark messages for translation
      send-email: ignore trailing whitespace in mailrc alias file
      credential-cache--daemon: clarify "exit" action semantics
      t/lib-httpd: pass through GIT_CONFIG_NOSYSTEM env
      git_config_push_parameter: handle empty GIT_CONFIG_PARAMETERS
      branch: fix shortening of non-remote symrefs
      commit: do not ignore an empty message given by -m ''
      config: lower-case first word of error strings
      git_config_set_multivar_in_file: all non-zero returns are errors
      git_config_set_multivar_in_file: handle "unset" errors
      t5532: use write_script
      send-pack: close demux pipe before finishing async process
      run-command: teach async threads to ignore SIGPIPE
      send-pack: isolate sigpipe in demuxer thread
      fetch-pack: isolate sigpipe in demuxer thread
      t5504: drop sigpipe=3Dok from push tests
      remote.c: spell __attribute__ correctly
      t5550: fix typo in $HTTPD_URL
      t5550: break submodule config test into multiple sub-tests
      submodule: export sanitized GIT_CONFIG_PARAMETERS
      submodule--helper: move config-sanitizing to submodule.c
      submodule: use prepare_submodule_repo_env consistently
      submodule: stop sanitizing config options
      t6302: simplify non-gpg cases
      rebase--interactive: avoid empty list in shell for-loop
      test-lib: set BASH_XTRACEFD automatically
      t/lib-git-svn: drop $remote_git_svn and $git_svn_id
      t9100,t3419: enclose all test code in single-quotes
      t9107: use "return 1" instead of "exit 1"
      t9107: switch inverted single/double quotes in test
      t9103: modernize test style
      always quote shell arguments to test -z/-n
      cat-file: avoid noop calls to sha1_object_info_extended
      cat-file: default to --buffer when --batch-all-objects is used
      archive-tar: convert snprintf to xsnprintf

Johannes Schindelin (16):
      replace --edit: respect core.editor
      name-rev: include taggerdate in considering the best name
      win32mmap: set errno appropriately
      mmap(win32): avoid copy-on-write when it is unnecessary
      mmap(win32): avoid expensive fstat() call
      http: support sending custom HTTP headers
      tests: adjust the configuration for Apache 2.2
      t5551: make the test for extra HTTP headers more robust
      t3404: fix typo
      submodule: ensure that -c http.extraheader is heeded
      mingw: introduce the 'core.hideDotFiles' setting
      mingw: remove unnecessary definition
      Windows: only add a no-op pthread_sigmask() when needed
      perf: let's disable symlinks when they are not available
      perf: make the tests work in worktrees
      perf: run "rebase -i" under perf

Johannes Sixt (3):
      Windows: shorten code by re-using convert_slashes()
      Windows: add pthread_sigmask() that does nothing
      t6044: replace seq by test_seq

John Keeping (3):
      config: fail if --get-urlmatch finds no value
      Documentation/git-config: use bulleted list for exit codes
      Documentation/git-config: fix --get-all description

Junio C Hamano (74):
      rerere: split conflict ID further
      rerere: scan $GIT_DIR/rr-cache/$ID when instantiating a rerere_id
      index-pack: correct --keep[=3D<msg>]
      index-pack: add a helper function to derive .idx/.keep filename
      rerere: handle leftover rr-cache/$ID directory and postimage file=
s
      rerere: delay the recording of preimage
      rerere: allow multiple variants to exist
      t4200: rerere a merge with two identical conflicts
      rerere: do use multiple variants
      apply: remove unused call to free() in gitdiff_{old,new}name()
      merge: fix NULL pointer dereference when merging nothing into voi=
d
      merge: refuse to create too cool a merge by default
      pretty: enable --expand-tabs by default for selected pretty forma=
ts
      pretty: allow tweaking tabwidth in --expand-tabs
      submodule--helper: do not borrow absolute_path() result for too l=
ong
      Git 2.8.1
      First batch for post 2.8 cycle
      pretty: test --expand-tabs
      Makefile: fix misdirected redirections
      Second batch for post 2.8 cycle
      Makefile: stop pretending to support rpmbuild
      rerere: gc and clear
      rerere: move code related to "forget" together
      rerere: split code to call ll_merge() further
      rerere: adjust 'forget' to multi-variant world order
      setup.c: do not feed NULL to "%.*s" even with precision 0
      Third batch for post 2.8 cycle
      http: differentiate socks5:// and socks5h://
      t1020: do not overuse printf and use write_script
      t3404: use write_script
      Fourth batch for post 2.8 cycle
      Start preparing for 2.8.2
      fsck_commit_buffer(): do not special case the last validation
      ll-merge: fix typo in comment
      Prepare for 2.8.2
      Makefile: clean *.o files we create
      Fifth batch for post 2.8 cycle
      t3033: avoid 'ambiguous refs' warning
      pull: pass --allow-unrelated-histories to "git merge"
      Sixth batch for post 2.8 cycle
      send-email: fix grammo in the prompt that asks e-mail recipients
      Seventh batch for post 2.8 cycle
      Git 2.8.2
      Eighth batch for 2.9
      diff: undocument the compaction heuristic knobs for experimentati=
on
      Start preparing for 2.8.3
      commit-tree: do not pay attention to commit.gpgsign
      Ninth batch for 2.9
      config: describe 'pathname' value type
      Tenth batch for 2.9
      Almost ready for 2.8.3
      test-lib-functions.sh: remove misleading comment on test_seq
      test-lib-functions.sh: rewrite test_seq without Perl
      ll-merge: use a longer conflict marker for internal merge
      t6036: remove pointless test that expects failure
      Documentation: fix linkgit references
      fsck: detect and warn a commit with embedded NUL
      ci: validate "linkgit:" in documentation
      test-parse-options: fix output when callback option fails
      test-parse-options: --expect=3D<string> option to simplify tests
      t0040: remove unused test helpers
      t0040: convert a few tests to use test-parse-options --expect
      Eleventh batch for 2.9
      rerere: plug memory leaks upon "rerere forget" failure
      Twelfth batch for 2.9
      Thirteenth batch for 2.9
      Git 2.8.3
      rerere: remove an null statement
      Git 2.9-rc0
      t4204: do not let $name variable clobbered
      Start preparing for 2.8.4
      Final batch before 2.9-rc1
      More topics for 2.8.4
      Git 2.9-rc1

Karsten Blees (1):
      mingw: make isatty() recognize MSYS2's pseudo terminals (/dev/pty=
*)

Kazuki Yamaguchi (10):
      branch -d: refuse deleting a branch which is currently checked ou=
t
      refs: add a new function set_worktree_head_symref
      branch -m: update all per-worktree HEADs
      set_worktree_head_symref(): fix error message
      imap-send: use HMAC() function provided by OpenSSL
      imap-send: check NULL return of SSL_CTX_new()
      imap-send: avoid deprecated TLSv1_method()
      configure: remove checking for HMAC_CTX_cleanup
      imap-send: check for NOLOGIN capability only when using LOGIN com=
mand
      imap-send: fix CRAM-MD5 response calculation

Keller Fuchs (1):
      Documentation: clarify signature verification

Lars Schneider (8):
      git-p4: map a P4 user to Git author name and email address
      travis-ci: update Git-LFS and P4 to the latest version
      travis-ci: express Linux/OS X dependency versions more clearly
      git-p4: fix Git LFS pointer parsing
      t9824: fix wrong reference value
      Documentation: add setup instructions for Travis CI
      travis-ci: build documentation
      travis-ci: enable Git SVN tests t91xx on Linux

Laurent Arnoud (1):
      tag: add the option to force signing of annotated tags

Li Peng (1):
      typofix: assorted typofixes in comments, documentation and messag=
es

Linus Torvalds (1):
      pretty: expand tabs in indented logs to make things line up prope=
rly

Luke Diamand (3):
      git-p4 tests: cd to / before running python
      git-p4 tests: work with python3 as well as python2
      git-p4 tests: time_in_seconds should use $PYTHON_PATH

Marios Titas (2):
      ident: check for useConfigOnly before auto-detection of name/emai=
l
      ident: give "please tell me" message upon useConfigOnly error

Matthieu Moy (11):
      Documentation/diff-config: fix description of diff.renames
      t4001-diff-rename: wrap file creations in a test
      t: add tests for diff.renames (true/false/unset)
      log: introduce init_log_defaults()
      diff: activate diff.renames by default
      lockfile: mark strings for translation
      lockfile: improve error message when lockfile exists
      git.spec.in: use README.md, not README
      README.md: don't take 'commandname' literally
      git-multimail: update to release 1.3.0
      git-multimail: update to release 1.3.1

Mehul Jain (9):
      git-pull.c: introduce git_pull_config()
      pull --rebase: add --[no-]autostash flag
      t5520: use consistent capitalization in test titles
      t5520: ensure consistent test conditions
      t5520: use better test to check stderr output
      t5520: factor out common "successful autostash" code
      t5520: factor out common "failing autostash" code
      t5520: reduce commom lines of code
      t5520: test --[no-]autostash with pull.rebase=3Dtrue

Michael Haggerty (19):
      t1430: test the output and error of some commands more carefully
      t1430: clean up broken refs/tags/shadow
      t1430: don't rely on symbolic-ref for creating broken symrefs
      t1430: test for-each-ref in the presence of badly-named refs
      t1430: improve test coverage of deletion of badly-named refs
      resolve_missing_loose_ref(): simplify semantics
      resolve_ref_unsafe(): use for loop to count up to MAXDEPTH
      resolve_ref_unsafe(): ensure flags is always set
      resolve_ref_1(): eliminate local variable
      resolve_ref_1(): reorder code
      resolve_ref_1(): eliminate local variable "bad_name"
      read_raw_ref(): manage own scratch space
      files-backend: inline resolve_ref_1() into resolve_ref_unsafe()
      read_raw_ref(): change flags parameter to unsigned int
      fsck_head_link(): remove unneeded flag variable
      cmd_merge(): remove unneeded flag variable
      checkout_paths(): remove unneeded flag variable
      check_aliased_update(): check that dst_name is non-NULL
      show_head_ref(): check the result of resolve_ref_namespace()

Michael J Gruber (1):
      completion: complete --cherry-mark for git log

Michael Procter (1):
      upload-pack: use argv_array for pack_objects

Michael Rappazzo (1):
      Documentation: add instructions to help setup gmail 2FA

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (62):
      git-apply.txt: remove a space
      git-apply.txt: mention the behavior inside a subdir
      apply: report patch skipping in verbose mode
      test helpers: move test-* to t/helper/ subdirectory
      dir.c: remove dead function fnmatch_icase()
      wrapper.c: delete dead function git_mkstemps()
      dir.c: rename str(n)cmp_icase to fspath(n)cmp
      path.c: add git_common_path() and strbuf_git_common_path()
      worktree.c: store "id" instead of "git_dir"
      worktree.c: make find_shared_symref() return struct worktree *
      worktree.c: mark current worktree
      path.c: refactor and add worktree_git_path()
      wt-status.c: split rebase detection out of wt_status_get_state()
      wt-status.c: make wt_status_check_rebase() work on any worktree
      worktree.c: avoid referencing to worktrees[i] multiple times
      worktree.c: check whether branch is rebased in another worktree
      wt-status.c: split bisect detection out of wt_status_get_state()
      worktree.c: check whether branch is bisected in another worktree
      branch: do not rename a branch under bisect or rebase
      remote.c: specify correct plural form in "commit diverge" message
      usage.c: move format processing out of die_errno()
      usage.c: add warning_errno() and error_errno()
      bisect.c: use die_errno() and warning_errno()
      builtin/am.c: use error_errno()
      builtin/branch.c: use error_errno()
      builtin/fetch.c: use error_errno()
      builtin/help.c: use warning_errno()
      builtin/mailsplit.c: use error_errno()
      builtin/merge-file.c: use error_errno()
      builtin/pack-objects.c: use die_errno() and warning_errno()
      builtin/rm.c: use warning_errno()
      builtin/update-index.c: prefer "err" to "errno" in process_lstat_=
error
      builtin/upload-archive.c: use error_errno()
      builtin/worktree.c: use error_errno()
      check-racy.c: use error_errno()
      combine-diff.c: use error_errno()
      compat/win32/syslog.c: use warning_errno()
      config.c: use error_errno()
      connected.c: use error_errno()
      copy.c: use error_errno()
      credential-cache--daemon.c: use warning_errno()
      diff-no-index.c: use error_errno()
      editor.c: use error_errno()
      entry.c: use error_errno()
      fast-import.c: use error_errno()
      gpg-interface.c: use error_errno()
      grep.c: use error_errno()
      http.c: use error_errno() and warning_errno()
      ident.c: use warning_errno()
      mailmap.c: use error_errno()
      reachable.c: use error_errno()
      rerere.c: use error_errno() and warning_errno()
      run-command.c: use error_errno()
      sequencer.c: use error_errno()
      server-info.c: use error_errno()
      sha1_file.c: use {error,die,warning}_errno()
      transport-helper.c: use error_errno()
      unpack-trees.c: use error_errno()
      upload-pack.c: use error_errno()
      vcs-svn: use error_errno()
      wrapper.c: use warning_errno()
      wrap-for-bin.sh: regenerate bin-wrappers when switching branches

Nikola Forr=C3=B3 (1):
      difftool/mergetool: make the form of yes/no questions consistent

Ori Avtalion (1):
      Documentation: git diff --check detects conflict markers

Pranit Bauva (9):
      t/t7502 : drop duplicate test
      api-parse-options.txt: document OPT_CMDMODE()
      t0040-test-parse-options.sh: fix style issues
      test-parse-options: print quiet as integer
      t0040-parse-options: improve test coverage
      t/t7507: improve test coverage
      parse-options.c: make OPTION_COUNTUP respect "unspecified" values
      t7507-commit-verbose: improve test coverage by testing number of =
diffs
      commit: add a commit.verbose config variable

Ralf Thielow (4):
      completion: add option '--guides' to 'git help'
      completion: add 'revisions' and 'everyday' to 'git help'
      rebase-i: print an abbreviated hash when stop for editing
      string_list: use string-list API in unsorted_string_list_lookup()

Ramsay Jones (3):
      xdiff/xprepare: use the XDF_DIFF_ALG() macro to access flag bits
      xdiff/xprepare: fix a memory leak
      log: document the --decorate=3Dauto option

Ray Zhang (1):
      worktree: add: introduce --checkout option

Ren=C3=A9 Nyffenegger (1):
      Documentation: fix typo 'In such these cases'

SZEDER G=C3=A1bor (5):
      diffcore: fix iteration order of identical files during rename de=
tection
      for-each-ref: fix description of '--contains' in manpage
      test-lib: simplify '--option=3Dvalue' parsing
      t9824: fix broken &&-chain in a subshell
      t5510: run auto-gc in the foreground

Santiago Torres (6):
      builtin/verify-tag.c: ignore SIGPIPE in gpg-interface
      t7030: test verifying multiple tags
      verify-tag: update variable name and type
      verify-tag: prepare verify_tag for libification
      verify-tag: move tag verification code to tag.c
      tag -v: verify directly rather than exec-ing verify-tag

Saurav Sachidanand (1):
      dir: store EXC_FLAG_* values in unsigned integers

Shin Kojima (1):
      gitweb: apply fallback encoding before highlight

Sidhant Sharma [:tk] (1):
      builtin/receive-pack.c: use parse_options API

Stanislav Kolotinskiy (1):
      git-send-pack: fix --all option when used with directory

Stefan Beller (44):
      submodule-config: keep update strategy around
      submodule-config: drop check against NULL
      fetching submodules: respect `submodule.fetchJobs` config option
      submodule update: direct error message to stderr
      run_processes_parallel: treat output of children as byte array
      run_processes_parallel: rename parameters for the callbacks
      git submodule update: have a dedicated helper for cloning
      submodule helper: remove double 'fatal: ' prefix
      submodule update: expose parallelism to the user
      clone: allow an explicit argument for parallel submodule clones
      clone tests: rename t57* =3D> t56*
      rebase: decouple --exec from --interactive
      t3404: cleanup double empty lines between tests
      submodule foreach: correct path display in recursive submodules
      submodule update --init: correct path handling in recursive submo=
dules
      submodule status: correct path handling in recursive submodules
      submodule update: align reporting path for custom command executi=
on
      submodule update: test recursive path reporting from subdirectory
      t7407: make expectation as clear as possible
      recursive submodules: test for relative paths
      submodule--helper: fix potential NULL-dereference
      submodule--helper clone: create the submodule path just once
      notes: don't leak memory in git_config_get_notes_strategy
      abbrev_sha1_in_line: don't leak memory
      bundle: don't leak an fd in case of early return
      credential-cache, send_request: close fd when done
      submodule--helper, module_clone: always operate on absolute paths
      submodule--helper, module_clone: catch fprintf failure
      submodule: port resolve_relative_url from shell to C
      submodule: port init from shell to C
      xdiff: implement empty line chunk heuristic
      mv: allow moving nested submodules
      clone: add `--shallow-submodules` flag
      config doc: improve exit code listing
      config.c: drop local variable
      submodule-config: don't shadow `cache`
      submodule init: fail gracefully with a missing .gitmodules file
      submodule--helper update-clone: abort gracefully on missing .gitm=
odules
      submodule deinit test: fix broken && chain in subshell
      submodule init: redirect stdout to stderr
      t7300: mark test with SANITY
      submodule deinit: require '--all' instead of '.' for all submodul=
es
      t3513: do not compress backup tar file
      t6041: do not compress backup tar file

Stephen P. Smith (1):
      wt-status.c: set commitable bit if there is a meaningful merge.

Sven Strickroth (3):
      commit: do not lose SQUASH_MSG contents
      MSVC: vsnprintf in Visual Studio 2015 doesn't need SNPRINTF_SIZE_=
CORR any more
      MSVC: use shipped headers instead of fallback definitions

Torsten B=C3=B6gershausen (6):
      correct blame for files commited with CRLF
      t0027: make commit_chk_wrnNNO() reliable
      convert: allow core.autocrlf=3Dinput and core.eol=3Dcrlf
      t0027: test cases for combined attributes
      convert.c: ident + core.autocrlf didn't work
      t5601: Remove trailing space in sed expression

Vasco Almeida (16):
      l10n: fr: fix transcation of "dir"
      l10n: fr: fix wrongly translated option name
      l10n: fr: change "id de cl=C3=A9" to match "id-cl=C3=A9"
      l10n: fr: don't translate "merge" as a parameter
      i18n: index-pack: use plural string instead of normal one
      i18n: builtin/branch.c: mark option for translation
      i18n: unpack-trees: mark strings for translation
      i18n: builtin/rm.c: remove a comma ',' from string
      i18n: branch: unmark string for translation
      i18n: branch: move comment for translators
      i18n: git-parse-remote.sh: mark strings for translation
      i18n: builtin/pull.c: mark placeholders for translation
      i18n: builtin/pull.c: split strings marked for translation
      i18n: remote: add comment for translators
      Documentation/git-mailinfo: fix typo
      i18n: unpack-trees: avoid substituting only a verb in sentences

Xiaolong Ye (4):
      patch-ids: make commit_patch_id() a public helper function
      format-patch: add '--base' option to record base tree info
      format-patch: introduce --base=3Dauto option
      format-patch: introduce format.useAutoBase configuration

brian m. carlson (6):
      sha1-name: introduce a get_oid() function
      test-match-trees: convert to use struct object_id
      match-trees: convert shift_tree() and shift_tree_by() to use obje=
ct_id
      struct name_entry: use struct object_id instead of unsigned char =
sha1[20]
      tree-walk: convert tree_entry_extract() to use struct object_id
      match-trees: convert several leaf functions to use struct object_=
id

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
      githooks.txt: improve the intro section
      githooks.txt: amend dangerous advice about 'update' hook ACL
      githooks.txt: minor improvements to the grammar & phrasing
      hooks: allow customizing where the hook directory is

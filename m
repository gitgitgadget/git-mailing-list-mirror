From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.8.0
Date: Mon, 28 Mar 2016 15:42:03 -0700
Message-ID: <xmqqoa9y1ays.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Mar 29 00:42:37 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1akfro-0005Di-CR
	for glk-linux-kernel-3@plane.gmane.org; Tue, 29 Mar 2016 00:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbcC1WmN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 28 Mar 2016 18:42:13 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753317AbcC1WmH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2016 18:42:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5EED14FF8C;
	Mon, 28 Mar 2016 18:42:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=5I+vGwF7ZaC0UH7cEo/0XMKKr
	bM=; b=jRDwtgnmgNQmRuorTwn6j2L2HR0eLPfQqfl2qcxSph77MXQHcwXs6N1tN
	P/K6nhCGZ+GFSJ8dqwtBRLTRDLXp0WLwrSPo1vJr2c7zapy6KGVz71QRdrzb1WJM
	f7AdfxBr3o2jpONgefCAGeHtCP/70m9WqajeGwiqXTaE1xmPeY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Xs7sre0a7ZACYskY/Kd
	u+pcxYAhyYhF83+Zr9aq/3VZMvwK5cd3YF5u4vkuC6w6z+U+1FrtfGjDMsP9fo1B
	NdkQA2eBTwgHrWwOg3CmXh0IgPkIJ+K92qk/sjGWVr4FAF78VJ3p36j9DDCmzQNh
	r5yfcTaQfvw1enkfWc0f7H7o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 54ECC4FF8B;
	Mon, 28 Mar 2016 18:42:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 71D464FF8A;
	Mon, 28 Mar 2016 18:42:04 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4B48F3E2-F536-11E5-AB20-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290071>

The latest feature release Git v2.8.0 is now available at the
usual places.  It is comprised of 532 non-merge commits since
v2.7.0, contributed by 74 people, 22 of which are new faces.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.8.0'
tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

New contributors whose contributions weren't in v2.7.0 are as follows.
Welcome to the Git development community!

  =EB=A7=88=EB=88=84=EC=97=98, Adam Dinwoodie, Andrew Wheeler, Changwoo=
 Ryu,
  Christoph Egger, Christoph Hoopmann, Dan Aloni, Dave Ware, David
  A. Wheeler, Dickson Wong, Felipe Gon=C3=A7alves Assis, GyuYong Jung,
  Jon Griffiths, Kazutoshi Satoda, Lars Vogel, Martin Amdisen,
  Matthew Kraai, Paul Wagland, Rob Mayoff, Romain Picard, Vasco
  Almeida, and Victor Leschuk.

Returning contributors who helped this release are as follows.
Thanks for your continued support.

  Alexander Kuleshov, Alexander Shopov, Alex Henrie, Audric
  Schiltknecht, brian m. carlson, Carlos Mart=C3=ADn Nieto, Christian
  Couder, David A. Greene, David Turner, Dennis Kaarsemaker,
  Dimitriy Ryazantcev, Edmundo Carmona Antoranz, Elia Pinto,
  Eric Sunshine, Eric Wong, Guillermo S. Romero, Jacob Keller,
  Jean-Noel Avila, Jeff King, Jiang Xin, Johannes Schindelin,
  Johannes Sixt, John Keeping, Jonathan Nieder, Junio C Hamano,
  Karsten Blees, Karthik Nayak, Knut Franke, Lars Schneider,
  Matthieu Moy, Matt McCutchen, Michael J Gruber, Mike Hommey,
  Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy, =C3=98yvind A. Holm, Patri=
ck Steinhardt,
  Pat Thoyts, Peter Krefting, Ralf Thielow, Ray Chen, Sebastian
  Schuberth, Shawn O. Pearce, Stefan Beller, Stephen P. Smith,
  SZEDER G=C3=A1bor, Thomas Ackermann, Thomas Braun, Thomas Gummerer,
  Tobias Klauser, Torsten B=C3=B6gershausen, Tr=E1=BA=A7n Ng=E1=BB=8Dc =
Qu=C3=A2n,
  and Will Palmer.

----------------------------------------------------------------

Git 2.8 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Backward compatibility note
---------------------------

The rsync:// transport has been removed.


Updates since v2.7
------------------

UI, Workflows & Features

 * It turns out "git clone" over rsync transport has been broken when
   the source repository has packed references for a long time, and
   nobody noticed nor complained about it.

 * "push" learned that its "--delete" option can be shortened to
   "-d", just like "branch --delete" and "branch -d" are the same
   thing.

 * "git blame" learned to produce the progress eye-candy when it takes
   too much time before emitting the first line of the result.

 * "git grep" can now be configured (or told from the command line)
   how many threads to use when searching in the working tree files.

 * Some "git notes" operations, e.g. "git log --notes=3D<note>", should
   be able to read notes from any tree-ish that is shaped like a notes
   tree, but the notes infrastructure required that the argument must
   be a ref under refs/notes/.  Loosen it to require a valid ref only
   when the operation would update the notes (in which case we must
   have a place to store the updated notes tree, iow, a ref).

 * "git grep" by default does not fall back to its "--no-index"
   behavior outside a directory under Git's control (otherwise the
   user may by mistake end up running a huge recursive search); with a
   new configuration (set in $HOME/.gitconfig--by definition this
   cannot be set in the config file per project), this safety can be
   disabled.

 * "git pull --rebase" has been extended to allow invoking
   "rebase -i".

 * "git p4" learned to cope with the type of a file getting changed.

 * "git format-patch" learned to notice format.outputDirectory
   configuration variable.  This allows "-o <dir>" option to be
   omitted on the command line if you always use the same directory in
   your workflow.

 * "interpret-trailers" has been taught to optionally update a file in
   place, instead of always writing the result to the standard output.

 * Many commands that read files that are expected to contain text
   that is generated (or can be edited) by the end user to control
   their behavior (e.g. "git grep -f <filename>") have been updated
   to be more tolerant to lines that are terminated with CRLF (they
   used to treat such a line to contain payload that ends with CR,
   which is usually not what the users expect).

 * "git notes merge" used to limit the source of the merged notes tree
   to somewhere under refs/notes/ hierarchy, which was too limiting
   when inventing a workflow to exchange notes with remote
   repositories using remote-tracking notes trees (located in e.g.
   refs/remote-notes/ or somesuch).

 * "git ls-files" learned a new "--eol" option to help diagnose
   end-of-line problems.

 * "ls-remote" learned an option to show which branch the remote
   repository advertises as its primary by pointing its HEAD at.

 * New http.proxyAuthMethod configuration variable can be used to
   specify what authentication method to use, as a way to work around
   proxies that do not give error response expected by libcurl when
   CURLAUTH_ANY is used.  Also, the codepath for proxy authentication
   has been taught to use credential API to store the authentication
   material in user's keyrings.

 * Update the untracked cache subsystem and change its primary UI from
   "git update-index" to "git config".

 * There were a few "now I am doing this thing" progress messages in
   the TCP connection code that can be triggered by setting a verbose
   option internally in the code, but "git fetch -v" and friends never
   passed the verbose option down to that codepath.

 * Clean/smudge filters defined in a configuration file of lower
   precedence can now be overridden to be a pass-through no-op by
   setting the variable to an empty string.

 * A new "<branch>^{/!-<pattern>}" notation can be used to name a
   commit that is reachable from <branch> that does not match the
   given <pattern>.

 * The "user.useConfigOnly" configuration variable can be used to
   force the user to always set user.email & user.name configuration
   variables, serving as a reminder for those who work on multiple
   projects and do not want to put these in their $HOME/.gitconfig.

 * "git fetch" and friends that make network connections can now be
   told to only use ipv4 (or ipv6).

 * Some authentication methods do not need username or password, but
   libcurl needs some hint that it needs to perform authentication.
   Supplying an empty username and password string is a valid way to
   do so, but you can set the http.[<url>.]emptyAuth configuration
   variable to achieve the same, if you find it cleaner.

 * You can now set http.[<url>.]pinnedpubkey to specify the pinned
   public key when building with recent enough versions of libcURL.

 * The configuration system has been taught to phrase where it found a
   bad configuration variable in a better way in its error messages.
   "git config" learnt a new "--show-origin" option to indicate where
   the values come from.

 * The "credential-cache" daemon process used to run in whatever
   directory it happened to start in, but this made umount(2)ing the
   filesystem that houses the repository harder; now the process
   chdir()s to the directory that house its own socket on startup.

 * When "git submodule update" did not result in fetching the commit
   object in the submodule that is referenced by the superproject, the
   command learned to retry another fetch, specifically asking for
   that commit that may not be connected to the refs it usually
   fetches.

 * "git merge-recursive" learned "--no-renames" option to disable its
   rename detection logic.

 * Across the transition at around Git version 2.0, the user used to
   get a pretty loud warning when running "git push" without setting
   push.default configuration variable.  We no longer warn because the
   transition was completed a long time ago.

 * README has been renamed to README.md and its contents got tweaked
   slightly to make it easier on the eyes.


Performance, Internal Implementation, Development Support etc.

 * Add a framework to spawn a group of processes in parallel, and use
   it to run "git fetch --recurse-submodules" in parallel.

 * A slight update to the Makefile to mark ".PHONY" targets as such
   correctly.

 * In-core storage of the reverse index for .pack files (which lets
   you go from a pack offset to an object name) has been streamlined.

 * d95138e6 (setup: set env $GIT_WORK_TREE when work tree is set, like
   $GIT_DIR, 2015-06-26) attempted to work around a glitch in alias
   handling by overwriting GIT_WORK_TREE environment variable to
   affect subprocesses when set_git_work_tree() gets called, which
   resulted in a rather unpleasant regression to "clone" and "init".
   Try to address the same issue by always restoring the environment
   and respawning the real underlying command when handling alias.

 * The low-level code that is used to create symbolic references has
   been updated to share more code with the code that deals with
   normal references.

 * strbuf_getline() and friends have been redefined to make it easier
   to identify which callsite of (new) strbuf_getline_lf() should
   allow and silently ignore carriage-return at the end of the line to
   help users on DOSsy systems.

 * "git shortlog" used to accumulate various pieces of information
   regardless of what was asked to be shown in the final output.  It
   has been optimized by noticing what need not to be collected
   (e.g. there is no need to collect the log messages when showing
   only the number of changes).

 * "git checkout $branch" (and other operations that share the same
   underlying machinery) has been optimized.

 * Automated tests in Travis CI environment has been optimized by
   persisting runtime statistics of previous "prove" run, executing
   tests that take longer before other ones; this reduces the total
   wallclock time.

 * Test scripts have been updated to remove assumptions that are not
   portable between Git for POSIX and Git for Windows, or to skip ones
   with expectations that are not satisfiable on Git for Windows.

 * Some calls to strcpy(3) triggers a false warning from static
   analyzers that are less intelligent than humans, and reducing the
   number of these false hits helps us notice real issues.  A few
   calls to strcpy(3) in a couple of protrams that are already safe
   has been rewritten to avoid false warnings.

 * The "name_path" API was an attempt to reduce the need to construct
   the full path out of a series of path components while walking a
   tree hierarchy, but over time made less efficient because the path
   needs to be flattened, e.g. to be compared with another path that
   is already flat.  The API has been removed and its users have been
   rewritten to simplify the overall code complexity.

 * Help those who debug http(s) part of the system.
   (merge 0054045 sp/remote-curl-ssl-strerror later to maint).

 * The internal API to interact with "remote.*" configuration
   variables has been streamlined.

 * The ref-filter's format-parsing code has been refactored, in
   preparation for "branch --format" and friends.

 * Traditionally, the tests that try commands that work on the
   contents in the working tree were named with "worktree" in their
   filenames, but with the recent addition of "git worktree"
   subcommand, whose tests are also named similarly, it has become
   harder to tell them apart.  The traditional tests have been renamed
   to use "work-tree" instead in an attempt to differentiate them.
   (merge 5549029 mg/work-tree-tests later to maint).

 * Many codepaths forget to check return value from git_config_set();
   the function is made to die() to make sure we do not proceed when
   setting a configuration variable failed.
   (merge 3d18064 ps/config-error later to maint).

 * Handling of errors while writing into our internal asynchronous
   process has been made more robust, which reduces flakiness in our
   tests.
   (merge 43f3afc jk/epipe-in-async later to maint).

 * There is a new DEVELOPER knob that enables many compiler warning
   options in the Makefile.

 * The way the test scripts configure the Apache web server has been
   updated to work also for Apache 2.4 running on RedHat derived
   distros.

 * Out of maintenance gcc on OSX 10.6 fails to compile the code in
   'master'; work it around by using clang by default on the platform.

 * The "name_path" API was an attempt to reduce the need to construct
   the full path out of a series of path components while walking a
   tree hierarchy, but over time made less efficient because the path
   needs to be flattened, e.g. to be compared with another path that
   is already flat, in many cases.  The API has been removed and its
   users have been rewritten to simplify the overall code complexity.
   This incidentally also closes some heap-corruption holes.

 * Recent versions of GNU grep is pickier than before to decide if a
   file is "binary" and refuse to give line-oriented hits when we
   expect it to, unless explicitly told with "-a" option.  As our
   scripted Porcelains use sane_grep wrapper for line-oriented data,
   even when the line may contain non-ASCII payload we took from
   end-user data, use "grep -a" to implement sane_grep wrapper when
   using an implementation of "grep" that takes the "-a" option.



Also contains various documentation updates and code clean-ups.


=46ixes since v2.7
----------------

Unless otherwise noted, all the fixes since v2.7 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * An earlier change in 2.5.x-era broke users' hooks and aliases by
   exporting GIT_WORK_TREE to point at the root of the working tree,
   interfering when they tried to use a different working tree without
   setting GIT_WORK_TREE environment themselves.

 * The "exclude_list" structure has the usual "alloc, nr" pair of
   fields to be used by ALLOC_GROW(), but clear_exclude_list() forgot
   to reset 'alloc' to 0 when it cleared 'nr' to discard the managed
   array.

 * Paths that have been told the index about with "add -N" are not
   quite yet in the index, but a few commands behaved as if they
   already are in a harmful way.

 * "git send-email" was confused by escaped quotes stored in the alias
   files saved by "mutt", which has been corrected.

 * A few non-portable C construct have been spotted by clang compiler
   and have been fixed.

 * The documentation has been updated to hint the connection between
   the '--signoff' option and DCO.

 * "git reflog" incorrectly assumed that all objects that used to be
   at the tip of a ref must be commits, which caused it to segfault.

 * The ignore mechanism saw a few regressions around untracked file
   listing and sparse checkout selection areas in 2.7.0; the change
   that is responsible for the regression has been reverted.

 * Some codepaths used fopen(3) when opening a fixed path in $GIT_DIR
   (e.g. COMMIT_EDITMSG) that is meant to be left after the command is
   done.  This however did not work well if the repository is set to
   be shared with core.sharedRepository and the umask of the previous
   user is tighter.  They have been made to work better by calling
   unlink(2) and retrying after fopen(3) fails with EPERM.

 * Asking gitweb for a nonexistent commit left a warning in the server
   log.

   Somebody may want to follow this up with an additional test, perhaps=
?
   IIRC, we do test that no Perl warnings are given to the server log,
   so this should have been caught if our test coverage were good.

 * "git rebase", unlike all other callers of "gc --auto", did not
   ignore the exit code from "gc --auto".

 * Many codepaths that run "gc --auto" before exiting kept packfiles
   mapped and left the file descriptors to them open, which was not
   friendly to systems that cannot remove files that are open.  They
   now close the packs before doing so.

 * A recent optimization to filter-branch in v2.7.0 introduced a
   regression when --prune-empty filter is used, which has been
   corrected.

 * The description for SANITY prerequisite the test suite uses has
   been clarified both in the comment and in the implementation.

 * "git tag" started listing a tag "foo" as "tags/foo" when a branch
   named "foo" exists in the same repository; remove this unnecessary
   disambiguation, which is a regression introduced in v2.7.0.

 * The way "git svn" uses auth parameter was broken by Subversion
   1.9.0 and later.

 * The "split" subcommand of "git subtree" (in contrib/) incorrectly
   skipped merges when it shouldn't, which was corrected.

 * A few options of "git diff" did not work well when the command was
   run from a subdirectory.

 * The command line completion learned a handful of additional options
   and command specific syntax.

 * dirname() emulation has been added, as Msys2 lacks it.

 * The underlying machinery used by "ls-files -o" and other commands
   has been taught not to create empty submodule ref cache for a
   directory that is not a submodule.  This removes a ton of wasted
   CPU cycles.

 * "git worktree" had a broken code that attempted to auto-fix
   possible inconsistency that results from end-users moving a
   worktree to different places without telling Git (the original
   repository needs to maintain back-pointers to its worktrees,
   but "mv" run by end-users who are not familiar with that fact
   will obviously not adjust them), which actually made things
   worse when triggered.

 * The low-level merge machinery has been taught to use CRLF line
   termination when inserting conflict markers to merged contents that
   are themselves CRLF line-terminated.

 * "git push --force-with-lease" has been taught to report if the push
   needed to force (or fast-forwarded).

 * The emulated "yes" command used in our test scripts has been
   tweaked not to spend too much time generating unnecessary output
   that is not used, to help those who test on Windows where it would
   not stop until it fills the pipe buffer due to lack of SIGPIPE.

 * The documentation for "git clean" has been corrected; it mentioned
   that .git/modules/* are removed by giving two "-f", which has never
   been the case.

 * The vimdiff backend for "git mergetool" has been tweaked to arrange
   and number buffers in the order that would match the expectation of
   majority of people who read left to right, then top down and assign
   buffers 1 2 3 4 "mentally" to local base remote merge windows based
   on that order.

 * "git show 'HEAD:Foo[BAR]Baz'" did not interpret the argument as a
   rev, i.e. the object named by the the pathname with wildcard
   characters in a tree object.
   (merge aac4fac nd/dwim-wildcards-as-pathspecs later to maint).

 * "git rev-parse --git-common-dir" used in the worktree feature
   misbehaved when run from a subdirectory.
   (merge 17f1365 nd/git-common-dir-fix later to maint).

 * "git worktree add -B <branchname>" did not work.

 * The "v(iew)" subcommand of the interactive "git am -i" command was
   broken in 2.6.0 timeframe when the command was rewritten in C.
   (merge 708b8cc jc/am-i-v-fix later to maint).

 * "git merge-tree" used to mishandle "both sides added" conflict with
   its own "create a fake ancestor file that has the common parts of
   what both sides have added and do a 3-way merge" logic; this has
   been updated to use the usual "3-way merge with an empty blob as
   the fake common ancestor file" approach used in the rest of the
   system.
   (merge 907681e jk/no-diff-emit-common later to maint).

 * The memory ownership rule of fill_textconv() API, which was a bit
   tricky, has been documented a bit better.
   (merge a64e6a4 jk/more-comments-on-textconv later to maint).

 * Update various codepaths to avoid manually-counted malloc().
   (merge 08c95df jk/tighten-alloc later to maint).

 * The documentation did not clearly state that the 'simple' mode is
   now the default for "git push" when push.default configuration is
   not set.
   (merge f6b1fb3 mm/push-simple-doc later to maint).

 * Recent versions of GNU grep are pickier when their input contains
   arbitrary binary data, which some of our tests uses.  Rewrite the
   tests to sidestep the problem.
   (merge 3b1442d jk/grep-binary-workaround-in-test later to maint).

 * A helper function "git submodule" uses since v2.7.0 to list the
   modules that match the pathspec argument given to its subcommands
   (e.g. "submodule add <repo> <path>") has been fixed.
   (merge 2b56bb7 sb/submodule-module-list-fix later to maint).

 * "git config section.var value" to set a value in per-repository
   configuration file failed when it was run outside any repository,
   but didn't say the reason correctly.
   (merge 638fa62 js/config-set-in-non-repository later to maint).

 * The code to read the pack data using the offsets stored in the pack
   idx file has been made more carefully check the validity of the
   data in the idx.
   (merge 7465feb jk/pack-idx-corruption-safety later to maint).

 * Other minor clean-ups and documentation updates
   (merge f459823 ak/extract-argv0-last-dir-sep later to maint).
   (merge 63ca1c0 ak/git-strip-extension-from-dashed-command later to m=
aint).
   (merge 4867f11 ps/plug-xdl-merge-leak later to maint).
   (merge 4938686 dt/initial-ref-xn-commit-doc later to maint).
   (merge 9537f21 ma/update-hooks-sample-typofix later to maint).

----------------------------------------------------------------

Changes since v2.7.0 are as follows:

Adam Dinwoodie (1):
      t9117: test specifying full url to git svn init -T

Alex Henrie (2):
      stripspace: call U+0020 a "space" instead of a "blank"
      l10n: ca.po: update translation

Alexander Kuleshov (3):
      format-patch: introduce format.outputDirectory configuration
      exec_cmd.c: use find_last_dir_sep() for code simplification
      git.c: simplify stripping extension of a file in handle_builtin()

Alexander Shopov (1):
      gitk: Update Bulgarian translation (311t)

Andrew Wheeler (1):
      push: fix ref status reporting for --force-with-lease

Audric Schiltknecht (1):
      l10n: fr.po: Correct case in sentence

Carlos Mart=C3=ADn Nieto (1):
      Disown ssh+git and git+ssh

Changwoo Ryu (4):
      l10n: ko.po: Add Korean translation
      l10n: ko.po: Update Korean translation
      l10n: ko: Update Korean translation
      l10n: ko.po: Update Korean translation

Christian Couder (11):
      dir: free untracked cache when removing it
      update-index: use enum for untracked cache options
      update-index: add --test-untracked-cache
      update-index: add untracked cache notifications
      update-index: move 'uc' var declaration
      dir: add {new,add}_untracked_cache()
      dir: add remove_untracked_cache()
      dir: simplify untracked cache "ident" field
      config: add core.untrackedCache
      test-dump-untracked-cache: don't modify the untracked cache
      t7063: add tests for core.untrackedCache

Christoph Egger (1):
      http: implement public key pinning

Christoph Hoopmann (1):
      l10n: de.po: fix typo

Dan Aloni (1):
      ident: add user.useConfigOnly boolean for when ident shouldn't be=
 guessed

Dave Ware (1):
      contrib/subtree: fix "subtree split" skipped-merge bug

David A. Greene (1):
      contrib/subtree: Make testing easier

David A. Wheeler (1):
      Expand documentation describing --signoff

David Turner (3):
      do_compare_entry: use already-computed path
      unpack-trees: fix accidentally quadratic behavior
      refs: document transaction semantics

Dennis Kaarsemaker (1):
      reflog-walk: don't segfault on non-commit sha1's in the reflog

Dickson Wong (1):
      mergetool: reorder vim/gvim buffers in three-way diffs

Dimitriy Ryazantcev (3):
      l10n: ru.po: update Russian translation
      l10n: ru.po: update Russian translation
      l10n: ru.po: update Russian translation

Edmundo Carmona Antoranz (1):
      blame: add support for --[no-]progress option

Elia Pinto (92):
      Makefile: add missing phony target
      contrib/examples/git-commit.sh: use the $( ... ) construct for co=
mmand substitution
      contrib/examples/git-fetch.sh: use the $( ... ) construct for com=
mand substitution
      contrib/examples/git-merge.sh: use the $( ... ) construct for com=
mand substitution
      contrib/examples/git-repack.sh: use the $( ... ) construct for co=
mmand substitution
      contrib/examples/git-revert.sh: use the $( ... ) construct for co=
mmand substitution
      contrib/thunderbird-patch-inline/appp.sh: use the $( ... ) constr=
uct for command substitution
      git-gui/po/glossary/txt-to-pot.sh: use the $( ... ) construct for=
 command substitution
      t/lib-httpd.sh: use the $( ... ) construct for command substituti=
on
      test-sha1.sh: use the $( ... ) construct for command substitution
      unimplemented.sh: use the $( ... ) construct for command substitu=
tion
      t/t1100-commit-tree-options.sh: use the $( ... ) construct for co=
mmand substitution
      t/t1401-symbolic-ref.sh: use the $( ... ) construct for command s=
ubstitution
      t/t1410-reflog.sh: use the $( ... ) construct for command substit=
ution
      t/t1511-rev-parse-caret.sh: use the $( ... ) construct for comman=
d substitution
      t/t1512-rev-parse-disambiguation.sh: use the $( ... ) construct f=
or command substitution
      t/t1700-split-index.sh: use the $( ... ) construct for command su=
bstitution
      t/t2025-worktree-add.sh: use the $( ... ) construct for command s=
ubstitution
      t/t2102-update-index-symlinks.sh: use the $( ... ) construct for =
command substitution
      t/t3030-merge-recursive.sh: use the $( ... ) construct for comman=
d substitution
      t/t3100-ls-tree-restrict.sh: use the $( ... ) construct for comma=
nd substitution
      t/t3101-ls-tree-dirname.sh: use the $( ... ) construct for comman=
d substitution
      t/t3210-pack-refs.sh: use the $( ... ) construct for command subs=
titution
      t/t3403-rebase-skip.sh: use the $( ... ) construct for command su=
bstitution
      t/t3511-cherry-pick-x.sh: use the $( ... ) construct for command =
substitution
      t/t3600-rm.sh: use the $( ... ) construct for command substitutio=
n
      t/t3700-add.sh: use the $( ... ) construct for command substituti=
on
      t/t5100-mailinfo.sh: use the $( ... ) construct for command subst=
itution
      t/t5300-pack-object.sh: use the $( ... ) construct for command su=
bstitution
      t/t5301-sliding-window.sh: use the $( ... ) construct for command=
 substitution
      t/t5302-pack-index.sh: use the $( ... ) construct for command sub=
stitution
      t/t5303-pack-corruption-resilience.sh: use the $( ... ) construct=
 for command substitution
      t/t5304-prune.sh: use the $( ... ) construct for command substitu=
tion
      t/t5305-include-tag.sh: use the $( ... ) construct for command su=
bstitution
      t/t5500-fetch-pack.sh: use the $( ... ) construct for command sub=
stitution
      t/t5505-remote.sh: use the $( ... ) construct for command substit=
ution
      t/t5506-remote-groups.sh: use the $( ... ) construct for command =
substitution
      t/t5510-fetch.sh: use the $( ... ) construct for command substitu=
tion
      t/t5515-fetch-merge-logic.sh: use the $( ... ) construct for comm=
and substitution
      t/t5516-fetch-push.sh: use the $( ... ) construct for command sub=
stitution
      t/t5517-push-mirror.sh: use the $( ... ) construct for command su=
bstitution
      t/t5522-pull-symlink.sh: use the $( ... ) construct for command s=
ubstitution
      t/t5530-upload-pack-error.sh: use the $( ... ) construct for comm=
and substitution
      t/t5532-fetch-proxy.sh: use the $( ... ) construct for command su=
bstitution
      t/t5537-fetch-shallow.sh: use the $( ... ) construct for command =
substitution
      t/t5538-push-shallow.sh: use the $( ... ) construct for command s=
ubstitution
      t/t5550-http-fetch-dumb.sh: use the $( ... ) construct for comman=
d substitution
      t/t5570-git-daemon.sh: use the $( ... ) construct for command sub=
stitution
      t/t5601-clone.sh: use the $( ... ) construct for command substitu=
tion
      t/t5700-clone-reference.sh: use the $( ... ) construct for comman=
d substitution
      t/t5710-info-alternate.sh: use the $( ... ) construct for command=
 substitution
      t/t5900-repo-selection.sh: use the $( ... ) construct for command=
 substitution
      t/t6001-rev-list-graft.sh: use the $( ... ) construct for command=
 substitution
      t/t6002-rev-list-bisect.sh: use the $( ... ) construct for comman=
d substitution
      t/t6015-rev-list-show-all-parents.sh: use the $( ... ) construct =
for command substitution
      t/t6032-merge-large-rename.sh: use the $( ... ) construct for com=
mand substitution
      t/t6132-pathspec-exclude.sh: use the $( ... ) construct for comma=
nd substitution
      t/t7001-mv.sh: use the $( ... ) construct for command substitutio=
n
      t/t7003-filter-branch.sh: use the $( ... ) construct for command =
substitution
      t/t7004-tag.sh: use the $( ... ) construct for command substituti=
on
      t/t7006-pager.sh: use the $( ... ) construct for command substitu=
tion
      t/t7103-reset-bare.sh: use the $( ... ) construct for command sub=
stitution
      t/t7406-submodule-update.sh: use the $( ... ) construct for comma=
nd substitution
      t/t7408-submodule-reference.sh: use the $( ... ) construct for co=
mmand substitution
      t/t7504-commit-msg-hook.sh: use the $( ... ) construct for comman=
d substitution
      t/t7505-prepare-commit-msg-hook.sh: use the $( ... ) construct fo=
r command substitution
      t/t7602-merge-octopus-many.sh: use the $( ... ) construct for com=
mand substitution
      t/t7700-repack.sh: use the $( ... ) construct for command substit=
ution
      t/t8003-blame-corner-cases.sh: use the $( ... ) construct for com=
mand substitution
      t/t9001-send-email.sh: use the $( ... ) construct for command sub=
stitution
      t9100-git-svn-basic.sh: use the $( ... ) construct for command su=
bstitution
      t9101-git-svn-props.sh: use the $( ... ) construct for command su=
bstitution
      t9104-git-svn-follow-parent.sh: use the $( ... ) construct for co=
mmand substitution
      t9105-git-svn-commit-diff.sh: use the $( ... ) construct for comm=
and substitution
      t9107-git-svn-migrate.sh: use the $( ... ) construct for command =
substitution
      t9108-git-svn-glob.sh: use the $( ... ) construct for command sub=
stitution
      t9109-git-svn-multi-glob.sh: use the $( ... ) construct for comma=
nd substitution
      t9110-git-svn-use-svm-props.sh: use the $( ... ) construct for co=
mmand substitution
      t9114-git-svn-dcommit-merge.sh: use the $( ... ) construct for co=
mmand substitution
      t9118-git-svn-funky-branch-names.sh: use the $( ... ) construct f=
or command substitution
      t9119-git-svn-info.sh: use the $( ... ) construct for command sub=
stitution
      t9129-git-svn-i18n-commitencoding.sh: use the $( ... ) construct =
for command substitution
      t9130-git-svn-authors-file.sh: use the $( ... ) construct for com=
mand substitution
      t9132-git-svn-broken-symlink.sh: use the $( ... ) construct for c=
ommand substitution
      t9137-git-svn-dcommit-clobber-series.sh: use the $( ... ) constru=
ct for command substitution
      t9138-git-svn-authors-prog.sh: use the $( ... ) construct for com=
mand substitution
      t9145-git-svn-master-branch.sh: use the $( ... ) construct for co=
mmand substitution
      t9150-svk-mergetickets.sh: use the $( ... ) construct for command=
 substitution
      t9300-fast-import.sh: use the $( ... ) construct for command subs=
titution
      t9350-fast-export.sh: use the $( ... ) construct for command subs=
titution
      t9501-gitweb-standalone-http-status.sh: use the $( ... ) construc=
t for command substitution
      t9901-git-web--browse.sh: use the $( ... ) construct for command =
substitution

Eric Sunshine (2):
      git-compat-util: st_add4: work around gcc 4.2.x compiler crash
      Revert "config.mak.uname: use clang for Mac OS X 10.6"

Eric Wong (10):
      git-send-email: do not double-escape quotes from mutt
      for-each-ref: document `creatordate` and `creator` fields
      git-svn: fix auth parameter handling on SVN 1.9.0+
      pass transport verbosity down to git_connect
      connect & http: support -4 and -6 switches for remote operations
      t5570: add tests for "git {clone,fetch,pull} -v"
      git-svn: hoist out utf8 prep from t9129 to lib-git-svn
      tests: remove no-op full-svn-test target
      git-svn: shorten glob error message
      git-svn: fix URL canonicalization during init w/ SVN 1.7+

=46elipe Gon=C3=A7alves Assis (7):
      merge-recursive: option to disable renames
      merge-recursive: more consistent interface
      merge-strategies.txt: fix typo
      merge-recursive: find-renames resets threshold
      t3034: add rename threshold tests
      t3034: test option to disable renames
      t3034: test deprecated interface

Guillermo S. Romero (1):
      gitk: Follow themed bgcolor in help dialogs

GyuYong Jung (1):
      git-cvsserver.perl: fix typo

Jacob Keller (1):
      notes: allow merging from arbitrary references

Jean-Noel Avila (5):
      l10n: fr.po v2.8.0 round 1 2509t
      l10n: fr.po v2.8.0 round 2
      l10n: fr.po v2.8.0 round 3
      gitk: Update French translation (311t)
      gitk: fr.po: Sync translations with git

Jeff King (86):
      pack-revindex: drop hash table
      pack-revindex: store entries directly in packed_git
      create_symref: modernize variable names
      create_symref: use existing ref-lock code
      create_symref: write reflog while holding lock
      run-command: don't warn on SIGPIPE deaths
      avoid shifting signed integers 31 bits
      bswap: add NO_UNALIGNED_LOADS define
      checkout,clone: check return value of create_symref
      lock_ref_sha1_basic: always fill old_oid while holding lock
      lock_ref_sha1_basic: handle REF_NODEREF with invalid refs
      rebase: ignore failures from "gc --auto"
      shortlog: match both "Author:" and "author" on stdin
      shortlog: use strbufs to read from stdin
      shortlog: replace hand-parsing of author with pretty-printer
      shortlog: optimize "--summary" mode
      shortlog: optimize out useless "<none>" normalization
      shortlog: optimize out useless string list
      shortlog: don't warn on empty author
      filter-branch: resolve $commit^{tree} in no-index case
      clean: make is_git_repository a public function
      resolve_gitlink_ref: ignore non-repository paths
      t6300: use test_atom for some un-modern tests
      tag: do not show ambiguous tag names as "tags/foo"
      transport: drop support for git-over-rsync
      give "nbuf" strbuf a more meaningful name
      checkout-index: simplify "-z" option parsing
      checkout-index: handle "--no-prefix" option
      checkout-index: handle "--no-index" option
      checkout-index: disallow "--no-stage" option
      apply, ls-files: simplify "-z" parsing
      fmt_ident: refactor strictness checks
      test-path-utils: use xsnprintf in favor of strcpy
      rerere: replace strcpy with xsnprintf
      checkout: reorder check_filename conditional
      check_filename: tighten dwim-wildcard ambiguity
      get_sha1: don't die() on bogus search strings
      http-push: stop using name_path
      show_object_with_name: simplify by using path_name()
      list-objects: convert name_path to a strbuf
      list-objects: drop name_path entirely
      list-objects: pass full pathname to callbacks
      git-config: better document default behavior for `--include`
      ref-filter: use string_list_split over strbuf_split
      reflog_expire_cfg: NUL-terminate pattern field
      add helpers for detecting size_t overflow
      tree-diff: catch integer overflow in combine_diff_path allocation
      diff: clarify textconv interface
      harden REALLOC_ARRAY and xcalloc against size_t overflow
      add helpers for allocating flex-array structs
      argv-array: add detach function
      convert manual allocations to argv_array
      convert trivial cases to ALLOC_ARRAY
      use xmallocz to avoid size arithmetic
      convert trivial cases to FLEX_ARRAY macros
      use st_add and st_mult for allocation size computation
      prepare_{git,shell}_cmd: use argv_array
      write_untracked_extension: use FLEX_ALLOC helper
      fast-import: simplify allocation in start_packfile
      fetch-pack: simplify add_sought_entry
      test-path-utils: fix normalize_path_copy output buffer size
      sequencer: simplify memory allocation of get_message
      git-compat-util: drop mempcpy compat code
      transport_anonymize_url: use xstrfmt
      diff_populate_gitlink: use a strbuf
      convert ewah/bitmap code to use xmalloc
      ewah: convert to REALLOC_ARRAY, etc
      merge-one-file: use empty blob for add/add base
      merge-tree: drop generate_common strategy
      xdiff: drop XDL_EMIT_COMMON
      t5313: test bounds-checks of corrupted/malicious pack/idx files
      nth_packed_object_offset: bounds-check extended offset
      use_pack: handle signed off_t overflow
      write_or_die: handle EPIPE in async threads
      fetch-pack: ignore SIGPIPE in sideband demuxer
      test_must_fail: report number of unexpected signal
      t5504: handle expected output from SIGPIPE death
      compat/mingw: brown paper bag fix for 50a6c8e
      t9700: fix test for perl older than 5.14
      tree-diff: catch integer overflow in combine_diff_path allocation
      http-push: stop using name_path
      add helpers for detecting size_t overflow
      show_object_with_name: simplify by using path_name()
      list-objects: convert name_path to a strbuf
      list-objects: drop name_path entirely
      list-objects: pass full pathname to callbacks

Jiang Xin (7):
      l10n: git.pot: v2.8.0 round 1 (48 new, 16 removed)
      http: honor no_http env variable to bypass proxy
      l10n: zh_CN: for git v2.8.0 l10n round 1
      l10n: git.pot: v2.8.0 round 2 (21 new, 1 removed)
      l10n: zh_CN: for git v2.8.0 l10n round 2
      l10n: git.pot: Add one new message for Git 2.8.0
      l10n: zh_CN: for git v2.8.0 l10n round 3

Johannes Schindelin (51):
      commit: allow editing the commit message even in shared repos
      Handle more file writes correctly in shared repos
      Refactor skipping DOS drive prefixes
      compat/basename: make basename() conform to POSIX
      compat/basename.c: provide a dirname() compatibility function
      t0060: verify that basename() and dirname() work as expected
      config.mak.uname: support MSys2
      config.mak.uname: supporting 64-bit MSys2
      fetch: release pack files before garbage-collecting
      am: release pack files before garbage-collecting
      merge: release pack files before garbage-collecting
      receive-pack: release pack files before garbage-collecting
      pull: allow interactive rebase with --rebase=3Dinteractive
      remote: handle the config setting branch.*.rebase=3Dinteractive
      completion: add missing branch.*.rebase values
      nedmalloc: allow compiling with MSys2's compiler
      compat/mingw: support MSys2-based MinGW build
      compat/winansi: support compiling with MSys2
      t0060: loosen overly strict expectations
      mingw: avoid redefining S_* constants
      mingw: avoid warnings when casting HANDLEs to int
      mingw: squash another warning about a cast
      mingw: uglify (a, 0) definitions to shut up warnings
      mingw: let's use gettext with MSYS2
      mingw: do not trust MSYS2's MinGW gettext.sh
      Git.pm: stop assuming that absolute paths start with a slash
      mingw: prepare the TMPDIR environment variable for shell scripts
      mingw: let lstat() fail with errno =3D=3D ENOTDIR when appropriat=
e
      merge-file: let conflict markers match end-of-line style of the c=
ontext
      merge-file: ensure that conflict sections match eol style
      mingw: fix t5601-clone.sh
      mingw: accomodate t0060-path-utils for MSYS2
      mingw: disable mkfifo-based tests
      tests: turn off git-daemon tests if FIFOs are not available
      mingw: skip test in t1508 that fails due to path conversion
      mingw: fix t9700's assumption about directory separators
      mingw: work around pwd issues in the tests
      mingw: mark t9100's test cases with appropriate prereqs
      mingw: avoid illegal filename in t9118
      mingw: handle the missing POSIXPERM prereq in t9124
      mingw: skip a test in t9130 that cannot pass on Windows
      mingw: do not bother to test funny file names
      test-lib: limit the output of the yes utility
      gitignore: ignore generated test-fake-ssh executable
      t5505: 'remote add x y' should work when url.y.insteadOf =3D x
      git config: report when trying to modify a non-existing repo conf=
ig
      Mark win32's pthread_exit() as NORETURN
      config --show-origin: report paths with forward slashes
      t1300-repo-config: make it resilient to being run via 'sh -x'
      t1300: fix the new --show-origin tests on Windows
      mingw: skip some tests in t9115 due to file name issues

Johannes Sixt (3):
      t/t5100: no need to use 'echo' command substitutions for globbing
      mingw: avoid linking to the C library's isalpha()
      t0001: fix GIT_* environment variable check under --valgrind

John Keeping (3):
      completion: add missing git-rebase options
      t8005: avoid grep on non-ASCII data
      t9200: avoid grep on non-ASCII data

Jon Griffiths (3):
      credential-cache--daemon: refactor check_socket_directory
      credential-cache--daemon: disallow relative socket path
      credential-cache--daemon: change to the socket dir on startup

Jonathan Nieder (1):
      submodule.c: write "Fetching submodule <foo>" to stderr

Junio C Hamano (59):
      First batch for post 2.7 cycle
      strbuf: miniscule style fix
      strbuf: make strbuf_getline_crlf() global
      strbuf: introduce strbuf_getline_{lf,nul}()
      mktree: there are only two possible line terminations
      check-attr: there are only two possible line terminations
      check-ignore: there are only two possible line terminations
      update-index: there are only two possible line terminations
      checkout-index: there are only two possible line terminations
      strbuf: give strbuf_getline() to the "most text friendly" variant
      hash-object: read --stdin-paths with strbuf_getline()
      revision: read --stdin with strbuf_getline()
      rev-parse: read parseopt spec with strbuf_getline()
      ident.c: read /etc/mailname with strbuf_getline()
      remote.c: read $GIT_DIR/remotes/* with strbuf_getline()
      clone/sha1_file: read info/alternates with strbuf_getline()
      transport-helper: read helper response with strbuf_getline()
      cat-file: read batch stream with strbuf_getline()
      column: read lines with strbuf_getline()
      send-pack: read list of refs with strbuf_getline()
      grep: read -f file with strbuf_getline()
      test-sha1-array: read command stream with strbuf_getline()
      test-lib: clarify and tighten SANITY
      Second batch for 2.8 cycle
      Third batch for 2.8 cycle
      git: remove an early return from save_env_before_alias()
      git: protect against unbalanced calls to {save,restore}_env()
      git: simplify environment save/restore logic
      Fourth batch for 2.8.cycle
      Getting closer to 2.7.1
      restore_env(): free the saved environment variable once we are do=
ne
      Fifth batch for 2.8 cycle
      Git 2.7.1
      Sixth batch for the 2.8 cycle
      pager: lose a separate argv[]
      pager: factor out a helper to prepare a child process to run the =
pager
      am -i: fix "v"iew
      Start preparing for 2.7.2
      Seventh batch for the 2.8 cycle
      Git 2.7.2
      Eighth batch for 2.8
      Git 2.8-rc0
      Git 2.8-rc1
      gitignore: document that unignoring a directory unignores everyth=
ing in it
      Git 2.7.3
      Git 2.8-rc2
      sane_grep: pass "-a" if grep accepts it
      rebase-i: clarify "is this commit relevant?" test
      RelNotes for 2.8.0: typofix
      Git 2.8-rc3
      Git 2.4.11
      Git 2.5.5
      Git 2.6.6
      Git 2.7.4
      Revert "Merge branch 'jc/exclusion-doc'"
      Revert "Merge branch 'nd/exclusion-regression-fix'"
      RelNotes: remove the mention of !reinclusion
      Git 2.8-rc4
      Git 2.8

Karsten Blees (1):
      mingw: factor out Windows specific environment setup

Karthik Nayak (10):
      ref-filter: bump 'used_atom' and related code to the top
      ref-filter: introduce struct used_atom
      ref-filter: introduce parsing functions for each valid atom
      ref-filter: introduce color_atom_parser()
      ref-filter: introduce parse_align_position()
      ref-filter: introduce align_atom_parser()
      ref-filter: align: introduce long-form syntax
      ref-filter: introduce remote_ref_atom_parser()
      ref-filter: introduce contents_atom_parser()
      ref-filter: introduce objectname_atom_parser()

Kazutoshi Satoda (2):
      git-svn: enable "svn.pathnameencoding" on dcommit
      git-svn: apply "svn.pathnameencoding" before URL encoding

Knut Franke (2):
      http: allow selection of proxy authentication method
      http: use credential API to handle proxy authentication

Lars Schneider (10):
      travis-ci: run previously failed tests first, then slowest to fas=
test
      travis-ci: explicity use container-based infrastructure
      convert: treat an empty string for clean/smudge filters as "cat"
      t: do not hide Git's exit code in tests using 'nul_to_q'
      rename git_config_from_buf to git_config_from_mem
      config: add 'origin_type' to config_source struct
      config: add '--show-origin' option to print the origin of a confi=
g value
      add DEVELOPER makefile knob to check for acknowledged warnings
      Documentation: use ASCII quotation marks in git-p4
      Documentation: fix git-p4 AsciiDoc formatting

Lars Vogel (1):
      git-add doc: do not say working directory when you mean working t=
ree

Martin Amdisen (1):
      templates/hooks: fix minor typo in the sample update-hook

Matt McCutchen (1):
      Documentation/git-clean.txt: don't mention deletion of .git/modul=
es/*

Matthew Kraai (1):
      Documentation: remove unnecessary backslashes

Matthieu Moy (8):
      Documentation/git-push: document that 'simple' is the default
      README: use markdown syntax
      README.md: add hyperlinks on filenames
      README.md: move the link to git-scm.com up
      README.md: don't call git stupid in the title
      README.md: move down historical explanation about the name
      push: remove "push.default is unset" warning message
      Documentation: fix broken linkgit to git-config

Michael J Gruber (5):
      t9100: fix breakage when SHELL_PATH is not /bin/sh
      tests: rename work-tree tests to *work-tree*
      t/lib-httpd: load mod_unixd
      t5510: do not leave changed cwd
      wt-status: allow "ahead " to be picked up by l10n

Mike Hommey (1):
      notes: allow treeish expressions as notes ref

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (25):
      blame: remove obsolete comment
      add and use a convenience macro ce_intent_to_add()
      Revert "setup: set env $GIT_WORK_TREE when work tree is set, like=
 $GIT_DIR"
      git.c: make it clear save_env() is for alias handling only
      setup.c: re-fix d95138e (setup: set env $GIT_WORK_TREE when ..
      git.c: make sure we do not leak GIT_* to alias scripts
      grep: make it clear i-t-a entries are ignored
      dir.c: clean the entire struct in clear_exclude_list()
      Revert "dir.c: don't exclude whole dir prematurely if neg pattern=
 may match"
      worktree.c: fix indentation
      diff-no-index: do not take a redundant prefix argument
      diff: make -O and --output work in subdirectory
      worktree: stop supporting moving worktrees manually
      rev-parse: take prefix into account in --git-common-dir
      dir.c: fix match_pathname()
      dir.c: support tracing exclude
      dir.c: support marking some patterns already matched
      dir.c: don't exclude whole dir prematurely
      worktree: fix "add -B"
      worktree add -B: do the checkout test before update branch
      sha1_file.c: mark strings for translation
      builtin/checkout.c: mark strings for translation
      builtin/clone.c: mark strings for translation
      ref-filter.c: mark strings for translation
      trailer.c: mark strings for translation

Pat Thoyts (1):
      t0008: avoid absolute path

Patrick Steinhardt (18):
      push: add '--delete' flag to synopsis
      push: add '-d' as shorthand for '--delete'
      config: introduce set_or_die wrappers
      branch: report errors in tracking branch setup
      branch: die on config error when unsetting upstream
      branch: die on config error when editing branch description
      submodule: die on config error when linking modules
      submodule--helper: die on config error when cloning module
      remote: die on config error when setting URL
      remote: die on config error when setting/adding branches
      remote: die on config error when manipulating remotes
      clone: die on config error in cmd_clone
      init-db: die on config errors when initializing empty repo
      sequencer: die on config error when saving replay opts
      compat: die when unable to set core.precomposeunicode
      config: rename git_config_set to git_config_set_gently
      config: rename git_config_set_or_die to git_config_set
      xdiff/xmerge: fix memory leak in xdl_merge

Paul Wagland (2):
      completion: complete show-branch "--date-order"
      completion: update completion arguments for stash

Peter Krefting (3):
      l10n: sv.po: Fix inconsistent translation of "progress meter"
      l10n: sv.po: Update Swedish translation (2509t0f0u)
      l10n: sv.po: Update Swedish translation (2530t0f0u)

Ralf Thielow (8):
      l10n: TEAMS: update Ralf Thielow's email address
      l10n: de.po: add space to abbreviation "z. B."
      l10n: de.po: fix interactive rebase message
      l10n: de.po: translate "command" as "Befehl"
      l10n: de.po: translate 48 new messages
      l10n: de.po: translate 22 new messages
      l10n: de.po: add missing newlines
      gitk: Update German translation

Ray Chen (1):
      l10n: zh_CN: review for git v2.8.0 l10n round 2

Rob Mayoff (1):
      contrib/subtree: unwrap tag refs

Romain Picard (1):
      git-p4.py: add support for filetype change

SZEDER G=C3=A1bor (2):
      t6050-replace: make failing editor test more robust
      completion: fix mis-indentation in _git_stash()

Sebastian Schuberth (3):
      docs: clarify that passing --depth to git-clone implies --single-=
branch
      docs: say "commits" in the --depth option wording for git-clone
      docs: clarify that --depth for git-fetch works with newly initial=
ized repos

Shawn O. Pearce (1):
      remote-curl: include curl_errorstr on SSL setup failures

Stefan Beller (11):
      xread: poll on non blocking fds
      strbuf: add strbuf_read_once to read without blocking
      sigchain: add command to pop all common signals
      run-command: add an asynchronous parallel child processor
      fetch_populated_submodules: use new parallel job processing
      submodules: allow parallel fetching, add tests and documentation
      submodule helper list: respect correct path prefix
      submodule: try harder to fetch needed sha1 by direct fetching sha=
1
      run-command: do not pass child process data into callbacks
      Documentation: reword rebase summary
      submodule: fix regression for deinit without submodules

Stephen P. Smith (4):
      user-manual: remove temporary branch entry from todo list
      glossary: define the term shallow clone
      user-manual: add section documenting shallow clones
      user-manual: add addition gitweb information

Thomas Ackermann (1):
      documentation: fix some typos

Thomas Braun (1):
      completion: complete "diff --word-diff-regex=3D"

Thomas Gummerer (11):
      t7810: correct --no-index test
      builtin/grep: add grep.fallbackToNoIndex config
      ls-remote: document --quiet option
      ls-remote: document --refs option
      ls-remote: fix synopsis
      ls-remote: use parse-options api
      ls-remote: add support for showing symrefs
      remote: use parse_config_key
      remote: simplify remote_is_configured()
      remote: actually check if remote exits
      remote: use remote_is_configured() for add and rename

Tobias Klauser (2):
      trailer: allow to write to files other than stdout
      interpret-trailers: add option for in-place editing

Torsten B=C3=B6gershausen (9):
      ls-files: add eol diagnostics
      t0027: add tests for get_stream_filter()
      convert.c: remove unused parameter 'path'
      convert.c: remove input_crlf_action()
      convert.c: use text_eol_is_crlf()
      convert.c: refactor crlf_action
      convert.c: simplify text_stat
      convert.c: correct attr_action()
      config.mak.uname: use clang for Mac OS X 10.6

Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n (2):
      l10n: vi.po (2509t): Updated Vietnamese translation
      l10n: vi.po (2530t): Update translation

Vasco Almeida (1):
      l10n: pt_PT: Update and add new translations

Victor Leschuk (4):
      grep: allow threading even on a single-core machine
      grep: slight refactoring to the code that disables threading
      grep: add --threads=3D<num> option and grep.threads configuration
      git-svn: loosen config globs limitations

Will Palmer (2):
      test for '!' handling in rev-parse's named commits
      object name: introduce '^{/!-<negative pattern>}' notation

brian m. carlson (1):
      http: add option to try authentication without username

=C3=98yvind A. Holm (1):
      gitweb: squelch "uninitialized value" warning

=EB=A7=88=EB=88=84=EC=97=98 (1):
      mingw: try to delete target directory before renaming

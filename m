From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.0.0-rc0
Date: Fri, 18 Apr 2014 12:37:27 -0700
Message-ID: <xmqqk3ambf9k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Fri Apr 18 21:38:27 2014
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1WbEcE-0000ju-RN
	for glk-linux-kernel-3@plane.gmane.org; Fri, 18 Apr 2014 21:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753822AbaDRThh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 18 Apr 2014 15:37:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52682 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189AbaDRThc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2014 15:37:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBFDD7BF0B;
	Fri, 18 Apr 2014 15:37:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=7GPOpm56XNUWR8UsP9xn2/0oA
	Y4=; b=OynTWj6EKYf2c6kUo8G3CUnP3+LT96pHjzEeCSNNrr7Lk5EXtBLe+JN4F
	HjH1Dbt9gAVjUN1/q7gy+H9REbGvmbknKIIIJlNCiuywmA/+/RUGwFEu+FB4A3/d
	K79WBQME9nc3XX19ErM8g1K+MQIT8Bxev9YG8h81JI33rPOgpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=KsCDzffdAE9bIqqI5NK
	TDj3e1Rjb2e0pacOmfGRxLCtqbNXuWTyWZZxNTgrzfvZm5zfdQK0RIsKVJvOBHfg
	LPEu10LC19HCLj7Z7YRuFx8m2TrUWfbOPQAcyNGMQM1onKWvjq9KjKV2aO3vmKEC
	eua00SEG0EZcEWFgQOPd4e8w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4C2E7BF0A;
	Fri, 18 Apr 2014 15:37:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BDD57BF05;
	Fri, 18 Apr 2014 15:37:29 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E1262442-C730-11E3-8DCF-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246480>

An early preview release Git v2.0.0-rc0 is now available for
testing at the usual places.

A major version bump between v1.x.x series and the upcoming v2.0.0
means there are a handful of backward incompatible UI improvements,
but for most people, all the tricky preparation for the transition
would have been already done for you and the upcoming release just
flips the default.  Unless you were living in a cave and have stayed
with an ancient version of Git (e.g. one before 1.8.2 that was
released more than a year ago) for all these times, that is---those
of you may want to double check the backward compatibility notes
section at the beginning of the draft release notes.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/testing/

The following public repositories all have a copy of the 'v2.0.0-rc0'
tag and the 'master' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Git v2.0 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

Backward compatibility notes
----------------------------

When "git push [$there]" does not say what to push, we have used the
traditional "matching" semantics so far (all your branches were sent
to the remote as long as there already are branches of the same name
over there).  In Git 2.0, the default is now the "simple" semantics,
which pushes:

 - only the current branch to the branch with the same name, and only
   when the current branch is set to integrate with that remote
   branch, if you are pushing to the same remote as you fetch from; or

 - only the current branch to the branch with the same name, if you
   are pushing to a remote that is not where you usually fetch from.

You can use the configuration variable "push.default" to change
this.  If you are an old-timer who wants to keep using the
"matching" semantics, you can set the variable to "matching", for
example.  Read the documentation for other possibilities.

When "git add -u" and "git add -A" are run inside a subdirectory
without specifying which paths to add on the command line, they
operate on the entire tree for consistency with "git commit -a" and
other commands (these commands used to operate only on the current
subdirectory).  Say "git add -u ." or "git add -A ." if you want to
limit the operation to the current directory.

"git add <path>" is the same as "git add -A <path>" now, so that
"git add dir/" will notice paths you removed from the directory and
record the removal.  In older versions of Git, "git add <path>" used
to ignore removals.  You can say "git add --ignore-removal <path>" to
add only added or modified paths in <path>, if you really want to.

The "-q" option to "git diff-files", which does *NOT* mean "quiet",
has been removed (it told Git to ignore deletion, which you can do
with "git diff-files --diff-filter=3Dd").

"git request-pull" lost a few "heuristics" that often led to mistakes.


Updates since v1.9 series
-------------------------

UI, Workflows & Features

 * The "multi-mail" post-receive hook (in contrib/) has been updated
   to a more recent version from the upstream.

 * "git gc --aggressive" learned "--depth" option and
   "gc.aggressiveDepth" configuration variable to allow use of a less
   insane depth than the built-in default value of 250.

 * "git log" learned the "--show-linear-break" option to show where a
   single strand-of-pearls is broken in its output.

 * The "rev-parse --parseopt" mechanism used by scripted Porcelains to
   parse command line options and to give help text learned to take
   the argv-help (the placeholder string for an option parameter,
   e.g. "key-id" in "--gpg-sign=3D<key-id>").

 * The pattern to find where the function begins in C/C++ used in
   "diff" and "grep -p" have been updated to help C++ source better.

 * "git rebase" learned to interpret a lone "-" as "@{-1}", the
   branch that we were previously on.

 * "git commit --cleanup=3D<mode>" learned a new mode, scissors.

 * "git tag --list" output can be sorted using "version sort" with
   "--sort=3Dversion:refname".

 * Discard the accumulated "heuristics" to guess from which branch the
   result wants to be pulled from and make sure what the end user
   specified is not second-guessed by "git request-pull", to avoid
   mistakes.  When you pushed out your 'master' branch to your public
   repository as 'for-linus', use the new "master:for-linus" syntax to
   denote the branch to be pulled.

 * "git grep" learned to behave in a way similar to native grep when
   "-h" (no header) and "-c" (count) options are given.

 * transport-helper, fast-import and fast-export have been updated to
   allow the ref mapping and ref deletion in a way similar to the
   natively supported transports.

 * The "simple" mode is the default for "git push".

 * "git add -u" and "git add -A", when run without any pathspec, is a
   tree-wide operation even when run inside a subdirectory of a
   working tree.

 * "git add <path> is the same as "git add -A <path>" now.

 * "core.statinfo" configuration variable, which is a
   never-advertised synonym to "core.checkstat", has been removed.

 * The "-q" option to "git diff-files", which does *NOT* mean
   "quiet", has been removed (it told Git to ignore deletion, which
   you can do with "git diff-files --diff-filter=3Dd").

 * Server operators can loosen the "tips of refs only" restriction for
   the remote archive service with the uploadarchive.allowUnreachable
   configuration option.

 * The progress indicators from various time-consuming commands have
   been marked for i18n/l10n.

 * "git notes -C <blob>" diagnoses an attempt to use an object that
   is not a blob as an error.

 * "git config" learned to read from the standard input when "-" is
   given as the value to its "--file" parameter (attempting an
   operation to update the configuration in the standard input of
   course is rejected).

 * Trailing whitespaces in .gitignore files, unless they are quoted
   for fnmatch(3), e.g. "path\ ", are warned and ignored.  Strictly
   speaking, this is a backward incompatible change, but very unlikely
   to bite any sane user and adjusting should be obvious and easy.

 * Many commands that create commits, e.g. "pull", "rebase",
   learned to take the --gpg-sign option on the command line.

 * "git commit" can be told to always GPG sign the resulting commit
   by setting "commit.gpgsign" configuration variable to true (the
   command line option --no-gpg-sign should override it).

 * "git pull" can be told to only accept fast-forward by setting the
   new "pull.ff" configuration.

 * "git reset" learned "-N" option, which does not reset the index
   fully for paths the index knows about but the tree-ish the command
   resets to does not (these paths are kept as intend-to-add entries).


Performance, Internal Implementation, etc.

 * The compilation options to port to AIX and to MSVC have been
   updated.

 * We started using wildmatch() in place of fnmatch(3) a few releases
   ago; complete the process and stop using fnmatch(3).

 * Uses of curl's "multi" interface and "easy" interface do not mix
   well when we attempt to reuse outgoing connections.  Teach the RPC
   over http code, used in the smart HTTP transport, not to use the
   "easy" interface.

 * The bitmap-index feature from JGit has been ported, which should
   significantly improve performance when serving objects form a
   repository that uses it.

 * The way "git log --cc" shows a combined diff against multiple
   parents have been optimized.

 * The prefixcmp() and suffixcmp() functions are gone.  Use
   starts_with() and ends_with(), and also consider if skip_prefix()
   suits your needs better when using the former.


Also contains various documentation updates and code clean-ups.  Many
of them came from flurry of activities as GSoC candidate microproject
exercises.


=46ixes since v1.9 series
-----------------------

Unless otherwise noted, all the fixes since v1.9 in the maintenance
track are contained in this release (see the maintenance releases'
notes for details).

 * zsh prompt (in contrib/) leaked unnecessary error messages.

 * bash completion (in contrib/) did not complete the refs and remotes
   correctly given "git pu<TAB>" when "pu" is aliased to "push".

 * Some more Unicode codepoints defined in Unicode 6.3 as having zero
   width have been taught to our display column counting logic.
   (merge d813ab9 tb/unicode-6.3-zero-width later to maint).

 * Some tests used shell constructs that did not work well on FreeBSD
   (merge ff7a1c6 km/avoid-bs-in-shell-glob later to maint).
   (merge 00764ca km/avoid-cp-a later to maint).

 * "git update-ref --stdin" did not fail a request to create a ref
   when the ref already existed.
   (merge b9d56b5 mh/update-ref-batch-create-fix later to maint).

 * "git diff --no-index -Mq a b" fell into an infinite loop.
   (merge ad1c3fb jc/fix-diff-no-index-diff-opt-parse later to maint).

 * "git fetch --prune", when the right-hand-side of multiple fetch
   refspecs overlap (e.g. storing "refs/heads/*" to
   "refs/remotes/origin/*", while storing "refs/frotz/*" to
   "refs/remotes/origin/fr/*"), aggressively thought that lack of
   "refs/heads/fr/otz" on the origin site meant we should remove
   "refs/remotes/origin/fr/otz" from us, without checking their
   "refs/frotz/otz" first.

   Note that such a configuration is inherently unsafe (think what
   should happen when "refs/heads/fr/otz" does appear on the origin
   site), but that is not a reason not to be extra careful.
   (merge e6f6371 cn/fetch-prune-overlapping-destination later to maint=
).

 * "git status --porcelain --branch" showed its output with labels
   "ahead/behind/gone" translated to the user's locale.
   (merge 7a76c28 mm/status-porcelain-format-i18n-fix later to maint).

 * A stray environment variable $prefix could have leaked into and
   affected the behaviour of the "subtree" script (in contrib/).

 * When it is not necessary to edit a commit log message (e.g. "git
   commit -m" is given a message without specifying "-e"), we used to
   disable the spawning of the editor by overriding GIT_EDITOR, but
   this means all the uses of the editor, other than to edit the
   commit log message, are also affected.
   (merge b549be0 bp/commit-p-editor later to maint).

 * "git mv" that moves a submodule forgot to adjust the array that
   uses to keep track of which submodules were to be moved to update
   its configuration.
   (merge fb8a4e8 jk/mv-submodules-fix later to maint).

 * Length limit for the pathname used when removing a path in a deep
   subdirectory has been removed to avoid buffer overflows.
   (merge 2f29e0c mh/remove-subtree-long-pathname-fix later to maint).

 * The test helper lib-terminal always run an actual test_expect_*
   when included, which screwed up with the use of skil-all that may
   have to be done later.
   (merge 7e27173 jk/lib-terminal-lazy later to maint).

 * "git index-pack" used a wrong variable to name the keep-file in an
   error message when the file cannot be written or closed.
   (merge de983a0 nd/index-pack-error-message later to maint).

 * "rebase -i" produced a broken insn sheet when the title of a commit
   happened to contain '\n' (or ended with '\c') due to a careless use
   of 'echo'.
   (merge cb1aefd us/printf-not-echo later to maint).

 * There were a few instances of 'git-foo' remaining in the
   documentation that should have been spelled 'git foo'.
   (merge 3c3e6f5 rr/doc-merge-strategies later to maint).

 * Serving objects from a shallow repository needs to write a
   new file to hold the temporary shallow boundaries but it was not
   cleaned when we exit due to die() or a signal.
   (merge 7839632 jk/shallow-update-fix later to maint).

 * When "git stash pop" stops after failing to apply the stash
   (e.g. due to conflicting changes), the stash is not dropped. State
   that explicitly in the output to let the users know.
   (merge 2d4c993 jc/stash-pop-not-popped later to maint).

 * The labels in "git status" output that describe the nature of
   conflicts (e.g. "both deleted") were limited to 20 bytes, which was
   too short for some l10n (e.g. fr).
   (merge c7cb333 jn/wt-status later to maint).

 * "git clean -d pathspec" did not use the given pathspec correctly
   and ended up cleaning too much.
   (merge 1f2e108 jk/clean-d-pathspec later to maint).

 * "git difftool" misbehaved when the repository is bound to the
   working tree with the ".git file" mechanism, where a textual file
   ".git" tells us where it is.
   (merge fcfec8b da/difftool-git-files later to maint).

 * "git push" did not pay attention to branch.*.pushremote if it is
   defined earlier than remote.pushdefault; the order of these two
   variables in the configuration file should not matter, but it did
   by mistake.
   (merge 98b406f jk/remote-pushremote-config-reading later to maint).

 * Codepaths that parse timestamps in commit objects have been
   tightened.
   (merge f80d1f9 jk/commit-dates-parsing-fix later to maint).

 * "git diff --external-diff" incorrectly fed the submodule directory
   in the working tree to the external diff driver when it knew it is
   the same as one of the versions being compared.
   (merge aba4727 tr/diff-submodule-no-reuse-worktree later to maint).

 * "git reset" needs to refresh the index when working in a working
   tree (it can also be used to match the index to the HEAD in an
   otherwise bare repository), but it failed to set up the working
   tree properly, causing GIT_WORK_TREE to be ignored.
   (merge b7756d4 nd/reset-setup-worktree later to maint).

 * "git check-attr" when working on a repository with a working tree
   did not work well when the working tree was specified via the
   --work-tree (and obviously with --git-dir) option.
   (merge cdbf623 jc/check-attr-honor-working-tree later to maint).

 * "merge-recursive" was broken in 1.7.7 era and stopped working in
   an empty (temporary) working tree, when there are renames
   involved.  This has been corrected.
   (merge 6e2068a bk/refresh-missing-ok-in-merge-recursive later to mai=
nt.)

 * "git rev-parse" was loose in rejecting command line arguments
   that do not make sense, e.g. "--default" without the required
   value for that option.
   (merge a43219f ds/rev-parse-required-args later to maint.)

 * include.path variable (or any variable that expects a path that
   can use ~username expansion) in the configuration file is not a
   boolean, but the code failed to check it.
   (merge 67beb60 jk/config-path-include-fix later to maint.)

 * Commands that take pathspecs on the command line misbehaved when
   the pathspec is given as an absolute pathname (which is a
   practice not particularly encouraged) that points at a symbolic
   link in the working tree.
   (merge later 655ee9e mw/symlinks to maint.)

 * "git diff --quiet -- pathspec1 pathspec2" sometimes did not return
   correct status value.
   (merge f34b205 nd/diff-quiet-stat-dirty later to maint.)

 * Attempting to deepen a shallow repository by fetching over smart
   HTTP transport failed in the protocol exchange, when no-done
   extension was used.  The fetching side waited for the list of
   shallow boundary commits after the sending end stopped talking to
   it.
   (merge 0232852 nd/http-fetch-shallow-fix later to maint.)

 * Allow "git cmd path/", when the 'path' is where a submodule is
   bound to the top-level working tree, to match 'path', despite the
   extra and unnecessary trailing slash (such a slash is often
   given by command line completion).
   (merge 2e70c01 nd/submodule-pathspec-ending-with-slash later to main=
t.)

 * Documentation and in-code comments had many instances of mistaken
   use of "nor", which have been corrected.
   (merge 235e8d5 jl/nor-or-nand-and later to maint).

----------------------------------------------------------------

Changes since v1.9.2 are as follows:

Adam (1):
      branch.c: install_branch_config: simplify if chain

Albert L. Lash, IV (4):
      docs/merge-strategies: remove hyphen from mis-merges
      docs/git-remote: capitalize first word of initial blurb
      docs/git-clone: clarify use of --no-hardlinks option
      docs/git-blame: explain more clearly the example pickaxe use

Andrew Keller (1):
      gitweb: Avoid overflowing page body frame with large images

Astril Hayato (1):
      Documentation/gitk: document the location of the configulation fi=
le

Benoit Sigoure (1):
      git-compat-util.h: #undef (v)snprintf before #define them

Brian Bourn (2):
      diff-no-index: rename read_directory()
      diff-no-index: replace manual "."/".." check with is_dot_or_dotdo=
t()

Brian Gesiak (3):
      t3200-branch: test setting branch as own upstream
      branch: use skip_prefix() in install_branch_config()
      rebase: allow "-" short-hand for the previous branch

Charles Bailey (2):
      dir.c: make git_fnmatch() not inline
      tests: don't rely on strerror text when testing rmdir failure

Chris Angelico (1):
      config.txt: third-party tools may and do use their own variables

Chris Packham (2):
      Documentation/git-am: Document supported --patch-format options
      Documentation/git-am: typofix

Christian Couder (1):
      strbuf: remove prefixcmp() and suffixcmp()

David Aguilar (2):
      pull: add pull.ff configuration
      pull: add --ff-only to the help text

David Kastrup (6):
      builtin/blame.c: struct blame_entry does not need a prev link
      builtin/blame.c: eliminate same_suspect()
      builtin/blame.c::prepare_lines: fix allocation size of sb->lineno
      blame.c: prepare_lines should not call xrealloc for every line
      builtin/blame.c::find_copy_in_blob: no need to scan for region en=
d
      skip_prefix(): scan prefix only once

David Tran (1):
      tests: use "env" to run commands with temporary env-var settings

Dirk Wallenstein (1):
      doc: status, remove leftover statement about '#' prefix

Dmitry Marakasov (1):
      configure.ac: link with -liconv for locale_charset()

Dmitry S. Dolzhenko (15):
      commit.c: use the generic "sha1_pos" function for lookup
      builtin/pack-objects.c: use ALLOC_GROW() in check_pbase_path()
      bundle.c: use ALLOC_GROW() in add_to_ref_list()
      cache-tree.c: use ALLOC_GROW() in find_subtree()
      commit.c: use ALLOC_GROW() in register_commit_graft()
      diff.c: use ALLOC_GROW()
      diffcore-rename.c: use ALLOC_GROW()
      patch-ids.c: use ALLOC_GROW() in add_commit()
      replace_object.c: use ALLOC_GROW() in register_replace_object()
      reflog-walk.c: use ALLOC_GROW()
      dir.c: use ALLOC_GROW() in create_simplify()
      attr.c: use ALLOC_GROW() in handle_attr_line()
      builtin/mktree.c: use ALLOC_GROW() in append_to_tree()
      read-cache.c: use ALLOC_GROW() in add_index_entry()
      sha1_file.c: use ALLOC_GROW() in pretend_sha1_file()

Elia Pinto (9):
      bisect.c: reduce scope of variable
      builtin/apply.c: reduce scope of variables
      builtin/blame.c: reduce scope of variables
      builtin/clean.c: reduce scope of variable
      builtin/commit.c: reduce scope of variables
      builtin/fetch.c: reduce scope of variable
      builtin/gc.c: reduce scope of variables
      check-builtins.sh: use the $(...) construct for command substitut=
ion
      git-am.sh: use the $(...) construct for command substitution

Eric Sunshine (2):
      name-hash: retire unused index_name_exists()
      sh-i18n--envsubst: retire unused string_list_member()

=46abian Ruch (1):
      add: use struct argv_array in run_add_interactive()

=46elipe Contreras (10):
      transport-helper: mismerge fix
      transport-helper: don't update refs in dry-run
      transport-helper: add 'force' to 'export' helpers
      transport-helper: check for 'forced update' message
      remote-helpers: allow all tests running from any dir
      remote-hg: always normalize paths
      remote-bzr: add support for older versions
      completion: fix completing args of aliased "push", "fetch", etc.
      remote-bzr: trivial test fix
      prompt: fix missing file errors in zsh

Hiroyuki Sano (1):
      fsck: use bitwise-or assignment operator to set flag

Ilya Bobyr (1):
      rev-parse --parseopt: option argument name hints

Jacopo Notarstefano (2):
      git-bisect.sh: fix a few style issues
      branch.c: delete size check of newly tracked branch names

Jeff King (43):
      pack-objects: split add_object_entry
      repack: stop using magic number for ARRAY_SIZE(exts)
      repack: turn exts array into array-of-struct
      repack: handle optional files created by pack-objects
      t: add basic bitmap functionality tests
      t/perf: add tests for pack bitmaps
      cat-file: refactor error handling of batch_objects
      cat-file: fix a minor memory leak in batch_objects
      do not discard revindex when re-preparing packfiles
      block-sha1: factor out get_be and put_be wrappers
      read-cache: use get_be32 instead of hand-rolled ntoh_l
      tests: auto-set git-daemon port
      ewah: unconditionally ntohll ewah data
      tests: turn on network daemon tests by default
      http: never use curl_easy_perform
      config: disallow relative include paths from blobs
      docs: clarify remote restrictions for git-upload-archive
      CodingGuidelines: mention C whitespace rules
      repack: add `repack.packKeptObjects` config var
      docs: mark info/grafts as outdated
      match_explicit: hoist refspec lhs checks into their own function
      match_explicit_lhs: allow a "verify only" mode
      push: detect local refspec errors early
      cat-file: restore warn_on_object_refname_ambiguity flag
      rev-list: disable object/refname ambiguity check with --stdin
      pack-objects: show progress for reused packfiles
      pack-objects: show reused packfile objects in "Counting objects"
      pack-objects: turn off bitmaps when skipping objects
      subtree: initialize "prefix" variable
      t/Makefile: stop setting GIT_CONFIG
      t/test-lib: drop redundant unset of GIT_CONFIG
      t: drop useless sane_unset GIT_* calls
      t: stop using GIT_CONFIG to cross repo boundaries
      t: prefer "git config --file" to GIT_CONFIG with test_must_fail
      t: prefer "git config --file" to GIT_CONFIG
      t0001: make symlink reinit test more careful
      t0001: use test_path_is_*
      t0001: use test_config_global
      t0001: use test_must_fail
      t0001: drop useless subshells
      t0001: drop subshells just for "cd"
      pack-objects: do not reuse packfiles without --delta-base-offset
      config.c: mark die_bad_number as NORETURN

Jens Lehmann (2):
      submodule: don't access the .gitmodules cache entry after removin=
g it
      submodule update: consistently document the '--checkout' option

Johan Herland (1):
      notes: disallow reusing non-blob as a note object

Johannes Sixt (11):
      t0008: skip trailing space test on Windows
      userdiff: support C++ ->* and .* operators in the word regexp
      userdiff: support unsigned and long long suffixes of integer cons=
tants
      t4018: an infrastructure to test hunk headers
      t4018: convert perl pattern tests to the new infrastructure
      t4018: convert java pattern test to the new infrastructure
      t4018: convert custom pattern test to the new infrastructure
      t4018: reduce test files for pattern compilation tests
      t4018: test cases for the built-in cpp pattern
      t4018: test cases showing that the cpp pattern misses many anchor=
 points
      userdiff: have 'cpp' hunk header pattern catch more C++ anchor po=
ints

John Keeping (4):
      notes-utils: handle boolean notes.rewritemode correctly
      utf8: fix iconv error detection
      utf8: use correct type for values in interval table
      builtin/mv: don't use memory after free

John Marshall (1):
      stash doc: mention short form -k in save description

Jonathan Nieder (3):
      am doc: add a pointer to relevant hooks
      .gitignore: test-hashmap is a generated file
      test-hashmap.c: drop unnecessary #includes

Junio C Hamano (35):
      git add <pathspec>... defaults to "-A"
      git add: -u/-A now affects the entire working tree
      core.statinfo: remove as promised in Git 2.0
      push: switch default from "matching" to "simple"
      diff: remove "diff-files -q" in a version of Git in a distant fut=
ure
      push: switch default from "matching" to "simple"
      t3004: add test for ls-files on symlinks via absolute paths
      open_istream(): do not dereference NULL in the error case
      combine-diff: simplify intersect_paths() further
      commit-tree: add and document --no-gpg-sign
      request-pull: pick up tag message as before
      request-pull: test updates
      request-pull: resurrect "pretty refname" feature
      *.sh: drop useless use of "env"
      tag: grok "--with" as synonym to "--contains"
      Start preparing for Git 2.0
      request-pull: documentation updates
      Update draft release notes to Git 2.0
      Update draft release notes to Git 2.0
      Update draft release notes to 2.0
      t1502: protect runs of SPs used in the indentation
      parse-options: multi-word argh should use dash to separate words
      update-index: teach --cacheinfo a new syntax "mode,sha1,path"
      parse-options: make sure argh string does not have SP or _
      Update draft release notes to 2.0
      Update draft release notes to 2.0
      parse-options: add cast to correct pointer type to OPT_SET_PTR
      Update draft release notes to 2.0
      Revert "Merge branch 'wt/doc-submodule-name-path-confusion-2'"
      Revert "submodule: explicit local branch creation in module_clone=
"
      Revert part of 384364b (Start preparing for Git 2.0, 2014-03-07)
      Update draft release notes to 2.0
      Update draft release notes to 2.0
      Update draft release notes for 2.0
      Git 2.0-rc0

Karsten Blees (14):
      add a hashtable implementation that supports O(1) removal
      buitin/describe.c: use new hash map implementation
      diffcore-rename.c: move code around to prepare for the next patch
      diffcore-rename.c: simplify finding exact renames
      diffcore-rename.c: use new hash map implementation
      name-hash.c: use new hash map implementation for directories
      name-hash.c: remove unreferenced directory entries
      name-hash.c: use new hash map implementation for cache entries
      name-hash.c: remove cache entries instead of marking them CE_UNHA=
SHED
      remove old hash.[ch] implementation
      fix 'git update-index --verbose --again' output
      builtin/update-index.c: cleanup update_one
      read-cache.c: fix memory leaks caused by removed cache entries
      hashmap.h: use 'unsigned int' for hash-codes everywhere

Kirill A. Shutemov (3):
      builtin/config.c: rename check_blob_write() -> check_write()
      config: change git_config_with_options() interface
      config: teach "git config --file -" to read from the standard inp=
ut

Kirill Smelkov (10):
      tree-diff: allow diff_tree_sha1 to accept NULL sha1
      tree-diff: convert diff_root_tree_sha1() to just call diff_tree_s=
ha1 with old=3DNULL
      line-log: convert to using diff_tree_sha1()
      revision: convert to using diff_tree_sha1()
      tree-walk: finally switch over tree descriptors to contain a pre-=
parsed entry
      diffcore-order: export generic ordering interface
      diff test: add tests for combine-diff with orderfile
      combine-diff: optimize combine_diff_path sets intersection
      combine-diff: combine_diff_path.len is not needed anymore
      tests: add checking that combine-diff emits only correct paths

Kyle J. McKay (2):
      test: fix t7001 cp to use POSIX options
      test: fix t5560 on FreeBSD

Lars Gullik Bj=C3=B8nnes (1):
      git-contacts: do not fail parsing of good diffs

Linus Torvalds (2):
      request-pull: more strictly match local/remote branches
      request-pull: allow "local:remote" to specify names on both ends

Marat Radchenko (5):
      MSVC: allow linking with the cURL library
      MSVC: link in invalidcontinue.obj for better POSIX compatibility
      MSVC: fix t0040-parse-options crash
      parse-options: remove unused OPT_SET_PTR
      MSVC: allow using ExtUtils::MakeMaker

Martin Erik Werner (5):
      t0060: add test for prefix_path on symlinks via absolute paths
      t0060: add test for prefix_path when path =3D=3D work tree
      t0060: add tests for prefix_path when path begins with work tree
      setup: add abspath_part_inside_repo() function
      setup: don't dereference in-tree symlinks for absolute paths

Max Horn (2):
      transport-helper.c: do not overwrite forced bit
      remote-hg: do not fail on invalid bookmarks

Michael Haggerty (14):
      rename read_replace_refs to check_replace_refs
      replace_object: use struct members instead of an array
      find_pack_entry(): document last_found_pack
      sha1_file_name(): declare to return a const string
      sha1_file.c: document a bunch of functions defined in the file
      Add docstrings for lookup_replace_object() and do_lookup_replace_=
object()
      Document some functions defined in object.c
      cache_tree_find(): remove redundant checks
      cache_tree_find(): find the end of path component using strchrnul=
()
      cache_tree_find(): fix comment formatting
      cache_tree_find(): remove redundant check
      cache_tree_find(): remove early return
      cache_tree_find(): use path variable when passing over slashes
      git-multimail: update to version 1.0.0

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (24):
      count-objects: recognize .bitmap in garbage-checking
      t7101, t7014: rename test files to indicate what that file is for
      reset: support "--mixed --intent-to-add" mode
      daemon: move daemonize() to libgit.a
      gc: config option for running --auto in background
      dir: warn about trailing spaces in exclude patterns
      dir: ignore trailing spaces in exclude patterns
      wt-status.c: make cut_line[] const to shrink .data section a bit
      wt-status.c: move cut-line print code out to wt_status_add_cut_li=
ne
      use wildmatch() directly without fnmatch() wrapper
      Revert "test-wildmatch: add "perf" command to compare wildmatch a=
nd fnmatch"
      stop using fnmatch (either native or compat)
      actually remove compat fnmatch source code
      sha1_file: fix delta_stack memory leak in unpack_entry
      i18n: mark all progress lines for translation
      commit: add --cleanup=3Dscissors
      tag: support --sort=3D<spec>
      strbuf: style fix -- top opening bracket on a separate line
      upload-pack: send shallow info over stdin to pack-objects
      connect.c: SP after "}", not TAB
      object.h: centralize object flag allocation
      log: add --show-linear-break to help see non-linear history
      gc --aggressive: make --depth configurable
      environment.c: fix constness for odb_pack_keep()

Nicolas Vigier (10):
      cherry-pick, revert: add the --gpg-sign option
      git-sh-setup.sh: add variable to use the stuck-long mode
      am: parse options in stuck-long mode
      am: add the --gpg-sign option
      rebase: remove useless arguments check
      rebase: don't try to match -M option
      rebase: parse options in stuck-long mode
      rebase: add the --gpg-sign option
      commit-tree: add the commit.gpgsign option to sign all commits
      test the commit.gpgsign config option

Ralf Thielow (1):
      help.c: rename function "pretty_print_string_list"

Ren=C3=A9 Scharfe (13):
      t7810: add missing variables to tests in loop
      grep: support -h (no header) with --count
      t4209: set up expectations up front
      t4209: factor out helper function test_log()
      t4209: factor out helper function test_log_icase()
      t4209: use helper functions to test --grep
      t4209: use helper functions to test --author
      pickaxe: honor -i when used with -S and --pickaxe-regex
      pickaxe: merge diffcore_pickaxe_grep() and diffcore_pickaxe_count=
() into diffcore_pickaxe()
      pickaxe: move pickaxe() after pickaxe_match()
      pickaxe: call strlen only when necessary in diffcore_pickaxe_coun=
t()
      pickaxe: simplify kwset loop in contains()
      rev-parse: fix typo in example on manpage

Richard Hansen (2):
      test-hg.sh: tests are now expected to pass
      remote-bzr: support the new 'force' option

Richard Lowe (1):
      diffcore.h: be explicit about the signedness of is_binary

Roberto Tyley (1):
      Documentation: fix documentation AsciiDoc links for external urls

Rohit Mani (1):
      use strchrnul() in place of strchr() and strlen()

Scott J. Goldman (1):
      add uploadarchive.allowUnreachable option

Sebastian Schuberth (1):
      t5510: Do not use $(pwd) when fetching / pushing / pulling via rs=
ync

Simon Ruderich (2):
      git-config: document interactive.singlekey requires Term::ReadKey
      git-add--interactive: warn if module for interactive.singlekey is=
 missing

Sun He (3):
      write_pack_file: use correct variable in diagnostic
      finish_tmp_packfile():use strbuf for pathname construction
      Use hashcpy() when copying object names

Sup Yut Sum (1):
      completion: teach --recurse-submodules to fetch, pull and push

Tanay Abhra (1):
      commit.c: use skip_prefix() instead of starts_with()

Tay Ray Chuan (1):
      demonstrate git-commit --dry-run exit code behaviour

Thomas Gummerer (3):
      introduce GIT_INDEX_VERSION environment variable
      test-lib: allow setting the index format version
      read-cache: add index.version config variable

Torsten B=C3=B6gershausen (1):
      utf8.c: partially update to version 6.3

Vicent Marti (16):
      revindex: export new APIs
      pack-objects: refactor the packing list
      pack-objects: factor out name_hash
      revision: allow setting custom limiter function
      sha1_file: export `git_open_noatime`
      compat: add endianness helpers
      ewah: compressed bitmap implementation
      documentation: add documentation for the bitmap format
      pack-bitmap: add support for bitmap indexes
      pack-objects: use bitmaps when packing objects
      rev-list: add bitmap mode to speed up object lists
      pack-objects: implement bitmap writing
      repack: consider bitmaps when performing repacks
      pack-bitmap: implement optional name_hash cache
      ewah: support platforms that require aligned reads
      add `ignore_missing_links` mode to revwalk

Vlad Dogaru (1):
      git-p4: explicitly specify that HEAD is a revision

W. Trevor King (6):
      submodule: make 'checkout' update_module mode more explicit
      submodule: document module_clone arguments in comments
      submodule: explicit local branch creation in module_clone
      Documentation: describe 'submodule update --remote' use case
      doc: submodule.* config are keyed by submodule names
      doc: submodule.*.branch config is keyed by name

Yuxuan Shui (2):
      fsck.c:fsck_ident(): ident points at a const string
      fsck.c:fsck_commit(): use skip_prefix() to verify and skip consta=
nt

brian m. carlson (1):
      pull: add the --gpg-sign option.

dequis (1):
      remote-bzr: include authors field in pushed commits

=D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=BE=
=D0=B2 (1):
      Makefile: describe CHARSET_LIB better

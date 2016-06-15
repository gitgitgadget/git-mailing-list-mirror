From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2010, #02; Sun, 07)
Date: Sun, 07 Mar 2010 14:49:53 -0800
Message-ID: <7vk4tnd9wu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 07 23:50:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoPIW-0007oX-Lg
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 23:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821Ab0CGWuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 17:50:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702Ab0CGWuA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 17:50:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AF1CA0361;
	Sun,  7 Mar 2010 17:49:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=x+6W
	Xn0yD4JmhZ3ztcgZuXTOoSo=; b=vM+lxoJgC8NCcUlunasICRNE3OiwsSJFJOPE
	egi1Uzg0iobUx+/AaIxnyqmFv+bS2iamzlbJFQnAVNViefslYiED9ZPCVeOwb4+y
	hDFscIsU2N8OlR8f5ceOCiD5A1oyUx0inPP6zSuUCeMaTafXag5Pi8pTiyCPOWdT
	nRnva8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=les
	FqffjVen1FTvokIHutn2/0GdE6pZyKa9/qt/l6PibvEuq707AGKk4A8Vcd4KtyWb
	+9uPxtTD4zhSwoT/f0oJQ4gTf3P4kE/8smK1H6KnE8DMfSDycEgzDCIq8Ka3D7Aw
	dwIE+gt7vKztfACZ9myqnQTSwg7tZ+aTY1zOYYZg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB689A035D;
	Sun,  7 Mar 2010 17:49:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EABADA035C; Sun,  7 Mar
 2010 17:49:54 -0500 (EST)
X-master-at: b7e7f6fb0005f861ca8aed80473a9809d646c403
X-next-at: daec67978caa3f4d202ebee1e75c4bbb27fdc4ee
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C0BA4EE0-2A3B-11DF-98B5-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141745>

What's cooking in git.git (Mar 2010, #02; Sun, 07)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

Let's start quieting things down on 'next' front.

--------------------------------------------------
[Graduated to "master"]

* mw/maint-gcc-warns-unused-write (2010-01-30) 1 commit
  (merged to 'next' on 2010-03-04 at 17716c0)
 + run-command.c: fix build warnings on Ubuntu

* gb/maint-submodule-env (2010-02-25) 5 commits
  (merged to 'next' on 2010-02-25 at 8c22d03)
 + is_submodule_modified(): clear environment properly
 + submodules: ensure clean environment when operating in a submodule
 + shell setup: clear_local_git_env() function
 + rev-parse: --local-env-vars option
 + Refactor list of of repo-local env vars
 (this branch is used by jl/submodule-diff-dirtiness.)

* jc/fetch-param (2010-02-24) 3 commits
  (merged to 'next' on 2010-02-25 at e95e252)
 + fetch --all/--multiple: keep all the fetched branch information
 + builtin-fetch --all/--multi: propagate options correctly
 + t5521: fix and modernize

* jk/maint-push-tracking-wo-remote (2010-02-24) 1 commit
  (merged to 'next' on 2010-02-25 at da946ba)
 + push: fix segfault for odd config

* mb/shortlog-nongit-stdin (2010-02-24) 1 commit
  (merged to 'next' on 2010-02-25 at d17bb74)
 + shortlog: warn the user when there is no input

* fn/maint-mkdtemp-compat (2010-02-25) 1 commit
  (merged to 'next' on 2010-02-25 at 2899a47)
 + Fix gitmkdtemp: correct test for mktemp() return value

* ml/maint-grep-doc (2010-02-25) 4 commits
  (merged to 'next' on 2010-03-02 at a75dfe0)
 + grep docs: document --no-index option
  (merged to 'next' on 2010-02-25 at ec1faf8)
 + grep docs: --cached and <tree>... are incompatible
 + grep docs: use AsciiDoc literals consistently
 + grep docs: pluralize "Example" section

* as/maint-expire (2010-02-26) 2 commits
  (merged to 'next' on 2010-03-02 at 4015ae4)
 + reflog: honor gc.reflogexpire=never
 + prune: honor --expire=never

* il/loosen-remote-helper-names (2010-02-23) 1 commit
  (merged to 'next' on 2010-02-25 at 5c22a39)
 + Allow '+', '-' and '.' in remote helper names

* jk/maint-add--interactive-delete (2010-02-22) 1 commit
  (merged to 'next' on 2010-02-24 at 908cef8)
 + add-interactive: fix bogus diff header line ordering

* js/runtime-prefix-trace-not-warn (2010-02-23) 1 commit
  (merged to 'next' on 2010-02-24 at 8d9d305)
 + Print RUNTIME_PREFIX warning only when GIT_TRACE is set

* jc/maint-fix-mailinfo-strip (2010-02-19) 1 commit
  (merged to 'next' on 2010-02-24 at 621fa3d)
 + mailinfo: do not strip leading spaces even for a header line

* ne/pack-local-doc (2010-02-24) 3 commits
  (merged to 'next' on 2010-02-25 at 75cfba5)
 + pack-objects documentation: Fix --honor-pack-keep as well.
 + pack-objects documentation: reword "objects that appear in the standard input"
 + Documentation: pack-objects: Clarify --local's semantics.

* mm/mkstemps-mode-for-packfiles (2010-02-22) 6 commits
  (merged to 'next' on 2010-02-24 at 31b5903)
 + Use git_mkstemp_mode instead of plain mkstemp to create object files
 + git_mkstemps_mode: don't set errno to EINVAL on exit.
 + Use git_mkstemp_mode and xmkstemp_mode in odb_mkstemp, not chmod later.
 + git_mkstemp_mode, xmkstemp_mode: variants of gitmkstemps with mode argument.
 + Move gitmkstemps to path.c
 + Add a testcase for ACL with restrictive umask.

* nd/root-git (2010-02-14) 5 commits
  (merged to 'next' on 2010-02-25 at bff4955)
 + Add test for using Git at root of file system
 + Support working directory located at root
 + Move offset_1st_component() to path.c
 + init-db, rev-parse --git-dir: do not append redundant slash
 + make_absolute_path(): Do not append redundant slash

--------------------------------------------------
[New Topics]

* jl/submodule-diff-dirtiness (2010-03-05) 2 commits
 - git status: Show detailed dirty status of submodules in long format
  (merged to 'next' on 2010-03-04 at 58b2645)
 + git diff --submodule: Show detailed dirty status of submodules

The tip one may want to use flag bits from places different from "format",
but otherwise I found the basic idea reasonably sound.

* cc/cherry-pick-ff (2010-03-06) 7 commits
  (merged to 'next' on 2010-03-07 at 5589b26)
 + rebase -i: use new --ff cherry-pick option
 + cherry-pick: add a no-op --no-ff option to future proof scripts
 + Documentation: describe new cherry-pick --ff option
 + cherry-pick: add tests for new --ff option
 + revert: add --ff option to allow fast forward when cherry-picking
 + builtin/merge: make checkout_fast_forward() non static
 + parse-options: add parse_options_concat() to concat options

* js/async-thread (2010-03-06) 6 commits
 - Dying in an async procedure should only exit the thread, not the process.
 - Reimplement async procedures using pthreads
 - Windows: more pthreads functions
 - Fix signature of fcntl() compatibility dummy
 - Make report() from usage.c public as vreportf() and use it.
 - Modernize t5530-upload-pack-error.

Perhaps later we would want to enable async-by-thread on all threading
capable platforms, if only to make sure we use the same code on major
platforms to reduce chances of platform specific bugs.

* nd/setup (2010-03-07) 18 commits
 - merge-file: use RUN_SETUP_GENTLY
 - var: use RUN_SETUP_GENTLY
 - ls-remote: use RUN_SETUP_GENTLY
 - help: use RUN_SETUP_GENTLY
 - diff: use RUN_SETUP_GENTLY
 - bundle: use RUN_SETUP_GENTLY
 - apply: use RUN_SETUP_GENTLY
 - verify-pack: use RUN_SETUP_GENTLY
 - check-ref-format: use RUN_SETUP_GENTLY
 - mailinfo: use RUN_SETUP_GENTLY
 - archive: use RUN_SETUP_GENTLY
 - builtin: USE_PAGER should not be used without RUN_SETUP*
 - grep: use RUN_SETUP_GENTLY
 - shortlog: use RUN_SETUP_GENTLY
 - hash-object: use RUN_SETUP_GENTLY
 - config: use RUN_SETUP_GENTLY
 - builtin: Support RUN_SETUP_GENTLY to set up repository early if found
 - builtin: introduce startup_info struct
 (this branch uses lt/deepen-builtin-source.)

--------------------------------------------------
[Stalled]

* sd/log-decorate (2010-02-17) 3 commits
 - log.decorate: usability fixes
 - Add `log.decorate' configuration variable.
 - git_config_maybe_bool()

Probably ready for 'next', except that people need to be warned about
having to update their scripts to explicitly pass --no-decorate to keep
them working.  A good idea to disable this when --pretty was given, just
like notes are disabled by default, was floated.

* pb/log-first-parent-p-m (2010-02-10) 1 commit
  (merged to 'next' on 2010-02-17 at 2f8e5ae)
 + git log -p -m: document -m and honor --first-parent

Needs tests but otherwise looked fine.  We might want to teach "-m trumps
implicit --cc" to "git show", but that is a totally separate topic.

I actually care about this "log -p --first-parent" very much, but if Pasky
is counting on that and procrastinating until I write the tests myself, he
is in for a disappointment.  I don't have that much free time these days.
Help is appreciated.

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

--------------------------------------------------
[Cooking]

* sd/format-patch-to (2010-02-17) 1 commit
  (merged to 'next' on 2010-03-07 at ef7a18d)
 + Add 'git format-patch --to=' option and 'format.to' configuration variable.

Squashed tests by Stephen in; it seems we will have updates to add --no-{cc,to,...}
to both format-patch and send-email but that is more or less independent clean-up.

* bg/apply-fix-blank-at-eof (2010-03-06) 5 commits
  (merged to 'next' on 2010-03-07 at daec679)
 + t3417: Add test cases for "rebase --whitespace=fix"
 + t4124: Add additional tests of --whitespace=fix
 + apply: Allow blank context lines to match beyond EOF
 + apply: Remove the quick rejection test
 + apply: Don't unnecessarily update line lengths in the preimage

* sg/bash-completion (2010-02-23) 4 commits
 - bash: completion for gitk aliases
 - bash: support user-supplied completion scripts for aliases
 - bash: support user-supplied completion scripts for user's git commands
 - bash: improve aliased command recognition

Perhaps rename _git_frotz -> _git_complete_frotz?  I dunno.

* fl/askpass (2010-03-04) 2 commits
  (merged to 'next' on 2010-03-07 at 5ab370a)
 + git-core: Support retrieving passwords with GIT_ASKPASS
 + git-svn: Support retrieving passwords with GIT_ASKPASS

* jc/color-attrs (2010-02-27) 1 commit
 - color: allow multiple attributes

As the output we generate is bounded, there is no need for checking
overflows as long as we count the maximum correctly.

* jc/maint-add-ignored-dir (2010-02-28) 3 commits
 - builtin-add: fix exclude handling
 - tests for "git add ignored-dir/file" without -f
 - t0050: mark non-working test as such

Not quite happy, but will merge to 'next' anyway.

* ml/color-grep (2010-03-07) 3 commits
 - grep: Colorize selected, context, and function lines
 - grep: Colorize filename, line number, and separator
 - Add GIT_COLOR_BOLD_* and GIT_COLOR_BG_*

Perhaps unoptimize the "reset" bit?  Other than that looked Ok.

* sb/notes-parse-opt (2010-02-27) 1 commit
 - notes: rework subcommands and parse options
 (this branch uses early parts of jh/notes and tr/notes-display.)

* sh/am-keep-cr (2010-02-27) 4 commits
  (merged to 'next' on 2010-03-02 at ffe3c5e)
 + git-am: Add tests for `--keep-cr`, `--no-keep-cr` and `am.keepcr`
 + git-am: Add am.keepcr and --no-keep-cr to override it
 + git-am: Add command line parameter `--keep-cr` passing it to git-mailsplit
 + documentation: 'git-mailsplit --keep-cr' is not hidden anymore

* bw/union-merge-refactor (2010-03-01) 4 commits
 - merge-file: add option to select union merge favor
 - merge-file: add option to specify the marker size
  (merged to 'next' on 2010-03-07 at 9d1eff6)
 + refactor merge flags into xmparam_t
 + make union merge an xdl merge favor

* mg/test-svn-info (2010-03-03) 2 commits
 - t9119-git-svn-info.sh: test with svn 1.6.* as well
 - git-svn: req_svn when needed

* jh/maint-submodule-status-in-void (2010-03-03) 1 commit
 - submodule summary: do not fail before the first commit

* ld/push-porcelain (2010-02-26) 4 commits
  (merged to 'next' on 2010-03-02 at d15bb1e)
 + git-push: add tests for git push --porcelain
 + git-push: make git push --porcelain print "Done"
 + git-push: send "To <remoteurl>" messages to the standard output in --porcelain mode
 + git-push: fix an advice message so it goes to stderr

* sd/init-template (2010-03-02) 5 commits
  (merged to 'next' on 2010-03-02 at 2d87e3f)
 + wrap-for-bin: do not export an empty GIT_TEMPLATE_DIR
 + t/t0001-init.sh: add test for 'init with init.templatedir set'
 + init: having keywords without value is not a global error.
 + Add a "TEMPLATE DIRECTORY" section to git-init[1].
 + Add `init.templatedir` configuration variable.

* lt/deepen-builtin-source (2010-02-22) 1 commit
  (merged to 'next' on 2010-02-25 at 320aa74)
 + Move 'builtin-*' into a 'builtin/' subdirectory
 (this branch is used by nd/setup.)

This is a painful one to keep out of 'master' for a long time, as any
topic with new builtin commands will need evil merges to adjust to it.

* tc/http-cleanup (2010-03-02) 7 commits
  (merged to 'next' on 2010-03-07 at e92db25)
 + remote-curl: init walker only when needed
 + remote-curl: use http_fetch_ref() instead of walker wrapper
 + http: init and cleanup separately from http-walker
 + http-walker: cleanup more thoroughly
 + http-push: remove "|| 1" to enable verbose check
 + t554[01]-http-push: refactor, add non-ff tests
 + t5541-http-push: check that ref is unchanged for non-ff test

* tr/notes-display (2010-02-23) 11 commits
 - notes: add shorthand --ref to override GIT_NOTES_REF
 - commit --amend: copy notes to the new commit
 - rebase: support automatic notes copying
 - notes: implement helpers needed for note copying during rewrite
 - notes: implement 'git notes copy --stdin'
 - rebase -i: invoke post-rewrite hook
 - rebase: invoke post-rewrite hook
 - commit --amend: invoke post-rewrite hook
 - Documentation: document post-rewrite hook
 - Support showing notes from more than one notes tree
 - test-lib: unset GIT_NOTES_REF to stop it from influencing tests
 (this branch uses early parts of jh/notes; is used by sb/notes-parse-opt.)

Re-roll planned.

* cw/test-lib-relicense (2010-02-22) 1 commit
 . test-lib.sh: Add explicit license detail, with change from GPLv2 to GPLv2+.

Ack-collection stopped at the last three names.  I am hoping Carl can take
it from there without my keeping an eye on it?

* tc/transport-verbosity (2010-02-24) 10 commits
  (merged to 'next' on 2010-03-07 at 898d6dd)
 + transport: update flags to be in running order
 + fetch and pull: learn --progress
 + push: learn --progress
 + transport->progress: use flag authoritatively
 + clone: support multiple levels of verbosity
 + push: support multiple levels of verbosity
 + fetch: refactor verbosity option handling into transport.[ch]
 + Documentation/git-push: put --quiet before --verbose
 + Documentation/git-pull: put verbosity options before merge/fetch ones
 + Documentation/git-clone: mention progress in -v

* cp/add-u-pathspec (2010-02-09) 2 commits
  (merged to 'next' on 2010-02-24 at 2f3f2bc)
 + test for add with non-existent pathspec
 + git add -u: die on unmatched pathspec

Not quite happy, but will merge to 'master' shortly anyway.

* jh/notes (2010-03-04) 33 commits
  (merged to 'next' on 2010-03-04 at 3bb921f)
 + Documentation: fix a few typos in git-notes.txt
  (merged to 'next' on 2010-02-24 at c88263d)
 + notes: fix malformed tree entry
 + builtin-notes: Minor (mostly parse_options-related) fixes
  (merged to 'next' on 2010-02-21 at 75fc451)
 + builtin-notes: Add "copy" subcommand for copying notes between objects
 + builtin-notes: Misc. refactoring of argc and exit value handling
 + builtin-notes: Add -c/-C options for reusing notes
 + builtin-notes: Refactor handling of -F option to allow combining -m and -F
 + builtin-notes: Deprecate the -m/-F options for "git notes edit"
 + builtin-notes: Add "append" subcommand for appending to note objects
 + builtin-notes: Add "add" subcommand for adding notes to objects
 + builtin-notes: Add --message/--file aliases for -m/-F options
 + builtin-notes: Add "list" subcommand for listing note objects
 + Documentation: Generalize git-notes docs to 'objects' instead of 'commits'
 + builtin-notes: Add "prune" subcommand for removing notes for missing objects
 + Notes API: prune_notes(): Prune notes that belong to non-existing objects
 + t3305: Verify that removing notes triggers automatic fanout consolidation
 + builtin-notes: Add "remove" subcommand for removing existing notes
 + Teach builtin-notes to remove empty notes
 + Teach notes code to properly preserve non-notes in the notes tree
 + t3305: Verify that adding many notes with git-notes triggers increased fanout
 + t3301: Verify successful annotation of non-commits
 + Builtin-ify git-notes
 + Refactor notes concatenation into a flexible interface for combining notes
 + Notes API: Allow multiple concurrent notes trees with new struct notes_tree
 + Notes API: write_notes_tree(): Store the notes tree in the database
 + Notes API: for_each_note(): Traverse the entire notes tree with a callback
 + Notes API: get_note(): Return the note annotating the given object
 + Notes API: remove_note(): Remove note objects from the notes tree structure
 + Notes API: add_note(): Add note objects to the internal notes tree structure
 + Notes API: init_notes(): Initialize the notes tree from the given notes ref
 + Add tests for checking correct handling of $GIT_NOTES_REF and core.notesRef
 + Notes API: get_commit_notes() -> format_note() + remove the commit restriction
 + Minor cosmetic fixes to notes.c
 (this branch shares commits with sb/notes-parse-opt and tr/notes-display.)

Ready for 'master'.

* cc/reset-keep (2010-01-19) 5 commits
  (merged to 'next' on 2010-03-07 at 5237d8e)
 + reset: disallow using --keep when there are unmerged entries
 + reset: disallow "reset --keep" outside a work tree
 + Documentation: reset: describe new "--keep" option
 + reset: add test cases for "--keep" option
 + reset: add option "--keep" to "git reset"

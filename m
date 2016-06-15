From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2010, #03; Wed, 10)
Date: Wed, 10 Mar 2010 19:21:07 -0800
Message-ID: <7v7hpj4k7w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 04:21:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpYxl-0006xs-BR
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 04:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284Ab0CKDVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 22:21:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46629 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861Ab0CKDVO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 22:21:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0414CA0A82;
	Wed, 10 Mar 2010 22:21:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=8WFd
	GVtg9CtOhTg1t0o5xtk/jBc=; b=uURJvh26Fp8vLb8+T7k1AAk/aCuMnUw3jfOp
	yj/Ms8VPl1oMaVVJlumeVsJX/jkfOXabdQYQgrlRugnUOiziSSDE8amrzkuC3ESj
	4IPdfW4E2S0RFes65jQ1m8NJa30xhZL06uHMDS2IJOxM1DRtXXOwcvwmaihPhKw5
	whCWpr8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=fqz
	SMhtsA6+QEFf2TG9fDKHKHtC413ecNBz8qcCoTQK4/PLtO0fB7bvNyfgqgZZ6T3A
	m+Z7fdhoQ8GuLwXAUivdKP5nqFffW8ZcKFlusrK9l/DvhvESSxMCVjP9qsQI06Lz
	qcdP0wsq2CpQ8HOdlZO4rrsn3iTOBj9h7UzAXylM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4ED6A0A81;
	Wed, 10 Mar 2010 22:21:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAC8FA0A80; Wed, 10 Mar
 2010 22:21:08 -0500 (EST)
X-master-at: 90a2bf9ca155c8e0e43d9e30197d9562dd02ea96
X-next-at: fb6b9c061dfbae34a3ab97d98b4150d138dd15ef
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 24040076-2CBD-11DF-AC2A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141931>

What's cooking in git.git (Mar 2010, #03; Wed, 10)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[Graduated to "master"]

* sh/am-keep-cr (2010-02-27) 4 commits
  (merged to 'next' on 2010-03-02 at ffe3c5e)
 + git-am: Add tests for `--keep-cr`, `--no-keep-cr` and `am.keepcr`
 + git-am: Add am.keepcr and --no-keep-cr to override it
 + git-am: Add command line parameter `--keep-cr` passing it to git-mailsplit
 + documentation: 'git-mailsplit --keep-cr' is not hidden anymore

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

* cp/add-u-pathspec (2010-02-09) 2 commits
  (merged to 'next' on 2010-02-24 at 2f3f2bc)
 + test for add with non-existent pathspec
 + git add -u: die on unmatched pathspec

--------------------------------------------------
[Stalled]

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

* sd/log-decorate (2010-02-17) 3 commits
  (merged to 'next' on 2010-03-08 at 58a6fba)
 + log.decorate: usability fixes
 + Add `log.decorate' configuration variable.
 + git_config_maybe_bool()

Needs squelching the configuration setting when "--pretty=raw" is given,
at least, or possibly when any "--pretty" is explicitly given.

--------------------------------------------------
[Cooking]

* pb/log-first-parent-p-m (2010-03-09) 5 commits
 - show --first-parent/-m: do not default to --cc
 - show -c: show patch text
 - revision: introduce setup_revision_opt
 - t4013: add tests for log -p -m --first-parent
  (merged to 'next' on 2010-02-17 at 2f8e5ae)
 + git log -p -m: document -m and honor --first-parent

I said 'We might want to teach "-m trumps implicit --cc" to "git show"',
and that is what I did near the tip.  Comments?

* jl/submodule-diff-dirtiness (2010-03-08) 2 commits
  (merged to 'next' on 2010-03-08 at 33f7a57)
 + git status: Show detailed dirty status of submodules in long format
  (merged to 'next' on 2010-03-04 at 58b2645)
 + git diff --submodule: Show detailed dirty status of submodules

* cc/cherry-pick-ff (2010-03-06) 7 commits
  (merged to 'next' on 2010-03-07 at 5589b26)
 + rebase -i: use new --ff cherry-pick option
 + cherry-pick: add a no-op --no-ff option to future proof scripts
 + Documentation: describe new cherry-pick --ff option
 + cherry-pick: add tests for new --ff option
 + revert: add --ff option to allow fast forward when cherry-picking
 + builtin/merge: make checkout_fast_forward() non static
 + parse-options: add parse_options_concat() to concat options

* js/async-thread (2010-03-09) 7 commits
 - Enable threaded async procedures whenever pthreads is available
 - Dying in an async procedure should only exit the thread, not the process.
 - Reimplement async procedures using pthreads
 - Windows: more pthreads functions
 - Fix signature of fcntl() compatibility dummy
 - Make report() from usage.c public as vreportf() and use it.
 - Modernize t5530-upload-pack-error.

The last one is probably unsafe for 'next' until somebody goes and vets
the callees that are invoked via this interface (any possible breakages
are already inflicted on Windows people, though).

* nd/setup (2010-03-08) 21 commits
 - index-pack: use RUN_SETUP_GENTLY
 - index-pack: trust the prefix returned by setup_git_directory_gently()
 - worktree setup: calculate prefix even if no worktree is found
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

* sd/format-patch-to (2010-03-07) 4 commits
  (merged to 'next' on 2010-03-08 at 739b8cd)
 + send-email: add --no-cc, --no-to, and --no-bcc
 + format-patch: add --no-cc, --no-to, and --no-add-headers
 + format-patch: use a string_list for headers
  (merged to 'next' on 2010-03-07 at ef7a18d)
 + Add 'git format-patch --to=' option and 'format.to' configuration variable.

Squashed tests by Stephen in.
I think this is ready for 'master'.  Comments?

* bg/apply-fix-blank-at-eof (2010-03-06) 5 commits
  (merged to 'next' on 2010-03-07 at daec679)
 + t3417: Add test cases for "rebase --whitespace=fix"
 + t4124: Add additional tests of --whitespace=fix
 + apply: Allow blank context lines to match beyond EOF
 + apply: Remove the quick rejection test
 + apply: Don't unnecessarily update line lengths in the preimage

* sg/bash-completion (2010-02-23) 4 commits
  (merged to 'next' on 2010-03-08 at bc59860)
 + bash: completion for gitk aliases
 + bash: support user-supplied completion scripts for aliases
 + bash: support user-supplied completion scripts for user's git commands
 + bash: improve aliased command recognition

Perhaps rename _git_frotz -> _git_complete_frotz?  I dunno.

* fl/askpass (2010-03-04) 2 commits
  (merged to 'next' on 2010-03-07 at 5ab370a)
 + git-core: Support retrieving passwords with GIT_ASKPASS
 + git-svn: Support retrieving passwords with GIT_ASKPASS

* jc/color-attrs (2010-02-27) 1 commit
  (merged to 'next' on 2010-03-08 at ba02883)
 + color: allow multiple attributes

* jc/maint-add-ignored-dir (2010-02-28) 3 commits
  (merged to 'next' on 2010-03-08 at a51762e)
 + builtin-add: fix exclude handling
 + tests for "git add ignored-dir/file" without -f
 + t0050: mark non-working test as such

Jeff came up with a simpler fix than the one at the tip, and we may want
to replace it with his, and possibly teach globbing to the logic later.

* ml/color-grep (2010-03-07) 3 commits
  (merged to 'next' on 2010-03-08 at 24d1eb4)
 + grep: Colorize selected, context, and function lines
 + grep: Colorize filename, line number, and separator
 + Add GIT_COLOR_BOLD_* and GIT_COLOR_BG_*

* sb/notes-parse-opt (2010-02-27) 1 commit
 - notes: rework subcommands and parse options
 (this branch uses early parts of jh/notes and tr/notes-display.)

* bw/union-merge-refactor (2010-03-01) 4 commits
  (merged to 'next' on 2010-03-10 at b917078)
 + merge-file: add option to select union merge favor
 + merge-file: add option to specify the marker size
  (merged to 'next' on 2010-03-07 at 9d1eff6)
 + refactor merge flags into xmparam_t
 + make union merge an xdl merge favor

* jh/maint-submodule-status-in-void (2010-03-09) 2 commits
 - git submodule summary: Handle HEAD as argument when on an unborn branch
  (merged to 'next' on 2010-03-08 at 0697bf4)
 + submodule summary: do not fail before the first commit

There are still more fix-ups comming?

* ld/push-porcelain (2010-02-26) 4 commits
  (merged to 'next' on 2010-03-02 at d15bb1e)
 + git-push: add tests for git push --porcelain
 + git-push: make git push --porcelain print "Done"
 + git-push: send "To <remoteurl>" messages to the standard output in --porcelain mode
 + git-push: fix an advice message so it goes to stderr

I think this is ready for 'master'.  Comments?

* tc/http-cleanup (2010-03-02) 7 commits
  (merged to 'next' on 2010-03-07 at e92db25)
 + remote-curl: init walker only when needed
 + remote-curl: use http_fetch_ref() instead of walker wrapper
 + http: init and cleanup separately from http-walker
 + http-walker: cleanup more thoroughly
 + http-push: remove "|| 1" to enable verbose check
 + t554[01]-http-push: refactor, add non-ff tests
 + t5541-http-push: check that ref is unchanged for non-ff test

I think this is ready for 'master'.  Comments?

* tr/notes-display (2010-03-10) 13 commits
 - git-notes(1): add a section about the meaning of history
 - notes: track whether notes_trees were changed at all
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

Re-rolled.  I think this is ready for 'next'.  Comments?

* cw/test-lib-relicense (2010-02-22) 1 commit
 . test-lib.sh: Add explicit license detail, with change from GPLv2 to GPLv2+.

Ack-collection stopped at the last three names.  I am hoping Carl can take
it from there without my keeping an eye on it.

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

I think this is ready for 'master'.  Comments?

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

* cc/reset-keep (2010-03-09) 6 commits
  (merged to 'next' on 2010-03-08 at 015ef4b)
 + Documentation: improve description of "git reset --keep"
  (merged to 'next' on 2010-03-07 at 5237d8e)
 + reset: disallow using --keep when there are unmerged entries
 + reset: disallow "reset --keep" outside a work tree
 + Documentation: reset: describe new "--keep" option
 + reset: add test cases for "--keep" option
 + reset: add option "--keep" to "git reset"

I think this is ready for 'master'.  Comments?

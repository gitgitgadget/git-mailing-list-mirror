From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Mar 2010, #05; Sat, 20)
Date: Sat, 20 Mar 2010 14:00:45 -0700
Message-ID: <7vr5ne908y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 22:00:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt5my-0003I5-5u
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 22:00:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597Ab0CTVAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 17:00:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0CTVAu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 17:00:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E4052A3507;
	Sat, 20 Mar 2010 17:00:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=Fiv+
	73DIoiVveYKY7kZi1yYNdt0=; b=Rn9H+2g6oh+OuzdWVczQWhs2woKXK0STvPpS
	wrTNyjSp694RpTSmIVv37NN768EXaisffAK6W6+TPbNXvGe4QaQpI0TiMvNwbmP/
	5pmtHtHAMV12leShqZjlu0DhxX7FJIJ4Jbb5gSpWPGKRd3tBwIAwWjRrnlk6Apk9
	BI9rTWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=jEy
	pMVhfF80D9LyiPkavlEzGq4kweLtRGYKSHw6gk+6nytnpTHBuCthW1mfjf2IGQKe
	R70ten2MNWjMmGQ2iB+CgfQwP+zqgXbOkdWc0s7+W/7qtdQueS7K0YA+wAc3YuSc
	F+Y7xir+ST4upLNKLvp67YoZu+ZL2irKTk4th1VM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D09CDA3506;
	Sat, 20 Mar 2010 17:00:48 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1F8DA3503; Sat, 20 Mar
 2010 17:00:46 -0400 (EDT)
X-master-at: 0d0925c5e25fad8079739be36d88faa21fc1f588
X-next-at: fdfcd14527c8a7f606aebfcd9dcd99e6cbf7cea5
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A91FF028-3463-11DF-933B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142752>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[Graduated to "master"]

* jk/maint-add-ignored-dir (2010-02-28) 3 commits
  (merged to 'next' on 2010-03-13 at df91e32)
 + tests for "git add ignored-dir/file" without -f
 + dir: fix COLLECT_IGNORED on excluded prefixes
 + t0050: mark non-working test as such

This replaced jc/maint-add-ignored-dir.  Will need to merge to maint
later.

* bg/apply-fix-blank-at-eof (2010-03-06) 5 commits
  (merged to 'next' on 2010-03-07 at daec679)
 + t3417: Add test cases for "rebase --whitespace=fix"
 + t4124: Add additional tests of --whitespace=fix
 + apply: Allow blank context lines to match beyond EOF
 + apply: Remove the quick rejection test
 + apply: Don't unnecessarily update line lengths in the preimage

* fl/askpass (2010-03-04) 2 commits
  (merged to 'next' on 2010-03-07 at 5ab370a)
 + git-core: Support retrieving passwords with GIT_ASKPASS
 + git-svn: Support retrieving passwords with GIT_ASKPASS

* jc/color-attrs (2010-02-27) 1 commit
  (merged to 'next' on 2010-03-08 at ba02883)
 + color: allow multiple attributes

* ml/color-grep (2010-03-07) 3 commits
  (merged to 'next' on 2010-03-08 at 24d1eb4)
 + grep: Colorize selected, context, and function lines
 + grep: Colorize filename, line number, and separator
 + Add GIT_COLOR_BOLD_* and GIT_COLOR_BG_*

* bw/union-merge-refactor (2010-03-01) 4 commits
  (merged to 'next' on 2010-03-10 at b917078)
 + merge-file: add option to select union merge favor
 + merge-file: add option to specify the marker size
  (merged to 'next' on 2010-03-07 at 9d1eff6)
 + refactor merge flags into xmparam_t
 + make union merge an xdl merge favor

* cc/reset-keep (2010-03-09) 6 commits
  (merged to 'next' on 2010-03-08 at 015ef4b)
 + Documentation: improve description of "git reset --keep"
  (merged to 'next' on 2010-03-07 at 5237d8e)
 + reset: disallow using --keep when there are unmerged entries
 + reset: disallow "reset --keep" outside a work tree
 + Documentation: reset: describe new "--keep" option
 + reset: add test cases for "--keep" option
 + reset: add option "--keep" to "git reset"

--------------------------------------------------
[New Topics]

* ar/config-from-command-line (2010-03-19) 1 commit
 - Allow passing of configuration parameters in the command line

* bc/t5505-fix (2010-03-19) 3 commits
 - t/t5505-remote.sh: escape * to prevent interpretation by shell as glob
 - t5505: add missing &&
 - t5505: remove unnecessary subshell invocations

Looked reasonable.  Soon in 'next'.

* bw/template-tool-buildconfig (2010-03-20) 2 commits
 - Modernize git calling conventions in hook templates
 - Make templates honour SHELL_PATH and PERL_PATH

Looked reasonable.  Soon in 'next'.

* mb/rebase-i-no-ff (2010-03-16) 1 commit
 - Teach --no-ff option to 'rebase -i'.

Looked reasonable.  Soon in 'next'.

* jn/merge-diff3-label (2010-03-17) 13 commits
 . cherry-pick, revert: add a label for ancestor
 . revert: clarify label on conflict hunks
 . compat: add mempcpy()
 . tests: document cherry-pick behavior in face of conflicts
 . checkout -m --conflict=diff3: add a label for ancestor
 . tests: document format of conflicts from checkout -m
 . merge_trees(): add ancestor label parameter for diff3-style output
 . merge_file(): add comment explaining behavior wrt conflict style
 . checkout --conflict=diff3: add a label for ancestor
 . ll_merge(): add ancestor label parameter for diff3-style output
 . merge-file --diff3: add a label for ancestor
 . xdl_merge(): move file1 and file2 labels to xmparam structure
 . xdl_merge(): add optional ancestor label to diff3-style output

This somewhat conflicts with bw/union-merge-refactor that in 'master'; I
could resolve the conflicts myself, but I'd rather not.  Jonathan, could
you rebase the series?

--------------------------------------------------
[Stalled]

* cw/test-lib-relicense (2010-02-22) 1 commit
 . test-lib.sh: Add explicit license detail, with change from GPLv2 to GPLv2+.

Ack-collection stopped at the last three names.  I am hoping Carl can take
it from there without my keeping an eye on it.

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

* sg/bash-completion (2010-02-23) 4 commits
  (merged to 'next' on 2010-03-08 at bc59860)
 + bash: completion for gitk aliases
 + bash: support user-supplied completion scripts for aliases
 + bash: support user-supplied completion scripts for user's git commands
 + bash: improve aliased command recognition

Perhaps rename _git_frotz -> _git_complete_frotz?  I dunno.

* sd/log-decorate (2010-02-17) 3 commits
  (merged to 'next' on 2010-03-08 at 58a6fba)
 + log.decorate: usability fixes
 + Add `log.decorate' configuration variable.
 + git_config_maybe_bool()

Needs squelching the configuration setting when "--pretty=raw" is given,
at least, or possibly when any "--pretty" is explicitly given.

--------------------------------------------------
[Cooking]

* do/rebase-i-arbitrary (2010-03-14) 1 commit
 - rebase--interactive: don't require what's rebased to be a branch

Looked reasonable.  Soon in 'next'.

* ja/send-email-ehlo (2010-03-14) 3 commits
 - git-send-email.perl - try to give real name of the calling host to HELO/EHLO
 - git-send-email.perl: add option --smtp-debug
 - git-send-email.perl: improve error message in send_message()

Looked reasonable.  Soon in 'next'.

* ak/everyday-git (2009-10-21) 1 commit
 - everyday: fsck and gc are not everyday operations

Looked reasonable.  Soon in 'next'.

* bc/acl-test (2010-03-15) 5 commits
 - t/t1304: make a second colon optional in the mask ACL check
 - t/t1304: set the ACL effective rights mask
 - t/t1304: use 'test -r' to test readability rather than looking at mode bits
 - t/t1304: set the Default ACL base entries
 - t/t1304: avoid -d option to setfacl

Looked reasonable.  Soon in 'next'.

* bc/maint-daemon-sans-ss-family (2010-03-15) 1 commit
 - daemon.c: avoid accessing ss_family member of struct sockaddr_storage

Looked reasonable.  Soon in 'next'.

* ef/cherry-abbrev (2010-03-15) 1 commit
 - cherry: support --abbrev option

Looked reasonable.  Soon in 'next'.

* gh/maint-stash-show-error-message (2010-03-16) 1 commit
 - Improve error messages from 'git stash show'

Looked reasonable.  Soon in 'next'.

* jc/maint-refs-dangling (2010-03-15) 1 commit
  (merged to 'next' on 2010-03-16 at 376027b)
 + refs: ref entry with NULL sha1 is can be a dangling symref

Looked reasonable.  Soon in 'next'.

* rs/threaded-grep-context (2010-03-15) 1 commit
 - grep: enable threading for context line printing

Looked reasonable.  Soon in 'next'.

* pb/log-first-parent-p-m (2010-03-09) 5 commits
  (merged to 'next' on 2010-03-15 at 0ae494e)
 + show --first-parent/-m: do not default to --cc
 + show -c: show patch text
 + revision: introduce setup_revision_opt
 + t4013: add tests for log -p -m --first-parent
  (merged to 'next' on 2010-02-17 at 2f8e5ae)
 + git log -p -m: document -m and honor --first-parent

Ready for 'master'.

* jl/submodule-diff-dirtiness (2010-03-13) 5 commits
  (merged to 'next' on 2010-03-15 at 9601fd9)
 + git status: ignoring untracked files must apply to submodules too
  (merged to 'next' on 2010-03-13 at f9bfd8a)
 + git status: Fix false positive "new commits" output for dirty submodules
 + Refactor dirty submodule detection in diff-lib.c
  (merged to 'next' on 2010-03-08 at 33f7a57)
 + git status: Show detailed dirty status of submodules in long format
  (merged to 'next' on 2010-03-04 at 58b2645)
 + git diff --submodule: Show detailed dirty status of submodules

Ready for 'master'.

* cc/cherry-pick-ff (2010-03-06) 6 commits
  (merged to 'next' on 2010-03-20 at fdfcd14)
 + rebase -i: use new --ff cherry-pick option
  (merged to 'next' on 2010-03-07 at 5589b26)
 + Documentation: describe new cherry-pick --ff option
 + cherry-pick: add tests for new --ff option
 + revert: add --ff option to allow fast forward when cherry-picking
 + builtin/merge: make checkout_fast_forward() non static
 + parse-options: add parse_options_concat() to concat options

Ready for 'master'.

* js/async-thread (2010-03-09) 7 commits
 - Enable threaded async procedures whenever pthreads is available
  (merged to 'next' on 2010-03-20 at 9939243)
 + Dying in an async procedure should only exit the thread, not the process.
 + Reimplement async procedures using pthreads
 + Windows: more pthreads functions
 + Fix signature of fcntl() compatibility dummy
 + Make report() from usage.c public as vreportf() and use it.
 + Modernize t5530-upload-pack-error.

The tip one will be soon in 'next', but one step at a time.

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

* sb/notes-parse-opt (2010-02-27) 1 commit
 - notes: rework subcommands and parse options
 (this branch uses tr/notes-display.)

* jh/maint-submodule-status-in-void (2010-03-09) 2 commits
  (merged to 'next' on 2010-03-15 at 49af9de)
 + git submodule summary: Handle HEAD as argument when on an unborn branch
  (merged to 'next' on 2010-03-08 at 0697bf4)
 + submodule summary: do not fail before the first commit

* tr/notes-display (2010-03-12) 13 commits
  (merged to 'next' on 2010-03-15 at 3329361)
 + git-notes(1): add a section about the meaning of history
 + notes: track whether notes_trees were changed at all
 + notes: add shorthand --ref to override GIT_NOTES_REF
 + commit --amend: copy notes to the new commit
 + rebase: support automatic notes copying
 + notes: implement helpers needed for note copying during rewrite
 + notes: implement 'git notes copy --stdin'
 + rebase -i: invoke post-rewrite hook
 + rebase: invoke post-rewrite hook
 + commit --amend: invoke post-rewrite hook
 + Documentation: document post-rewrite hook
 + Support showing notes from more than one notes tree
 + test-lib: unset GIT_NOTES_REF to stop it from influencing tests
 (this branch is used by sb/notes-parse-opt.)

From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2009, #05; Mon, 28)
Date: Mon, 28 Dec 2009 01:57:59 -0800
Message-ID: <7v8wcnto7s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 28 10:58:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPCMm-0007cT-27
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 10:58:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072AbZL1J6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 04:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751959AbZL1J6K
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 04:58:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639AbZL1J6F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 04:58:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E96CAA0D3;
	Mon, 28 Dec 2009 04:58:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=aD0W
	x1xkEjuJ8qjlOU/YptyqhGQ=; b=ktyY7vpVyqCXq9A7w6C/gUQOTkoDIwFv6GAd
	dVxQWQ+YY+rGTZRlbhky1OF8MnoC9RSOnlMHTKnJUL4WJ4UHp+CXtHNR4NREk1y7
	SjRgk5zCOnHAwmYiqL4BjPm8rcfnpYxLD6N36DB4kkS6LbGybK6UTyq4RF81Hi51
	Z/dhc2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=aZz
	LpXJnZW8B+Q6doB5uFc5sftmkUmU3rmQFG6hCY3jBEFQR9Ew9oNO25UeXKgJYV9t
	af9MdNk7Hgc2dr+XF6GY+mpDPUsFf12JHjoT3V2bsxzgzR0r/VUKzd1UD+sCU61l
	StG9twZvesji+auAf5E/QCwI9VFOPTECPej9YFoY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0B4F0AA0D0;
	Mon, 28 Dec 2009 04:58:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C9DB2AA0CE; Mon, 28 Dec 2009
 04:58:00 -0500 (EST)
X-master-at: c2ff10c98e22ae64d553273e6d67bb123a1c916f
X-next-at: ba67783643e94c85cfa57edf932dea2abdf68711
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7CF9C3DC-F397-11DE-86FE-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135733>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

--------------------------------------------------
[Graduated to "master"]

* sr/vcs-helper (2009-12-07) 14 commits
  (merged to 'next' on 2009-12-07 at 8f041bc)
 + tests: handle NO_PYTHON setting
  (merged to 'next' on 2009-12-03 at e45b562)
 + builtin-push: don't access freed transport->url
  (merged to 'next' on 2009-11-27 at 83268ab)
 + Add Python support library for remote helpers
 + Basic build infrastructure for Python scripts
 + Allow helpers to report in "list" command that the ref is unchanged
 + Fix various memory leaks in transport-helper.c
 + Allow helper to map private ref names into normal names
 + Add support for "import" helper command
 + Allow specifying the remote helper in the url
 + Add a config option for remotes to specify a foreign vcs
 + Allow fetch to modify refs
 + Use a function to determine whether a remote is valid
 + Allow programs to not depend on remotes having urls
 + Fix memory leak in helper method for disconnect

* jc/1.7.0-send-email-no-thread-default (2009-08-22) 1 commit
  (merged to 'next' on 2009-10-11 at 043acdf)
 + send-email: make --no-chain-reply-to the default

* jc/1.7.0-push-safety (2009-02-09) 2 commits
  (merged to 'next' on 2009-10-11 at 81b8128)
 + Refuse deleting the current branch via push
 + Refuse updating the current branch in a non-bare repository via push

* jc/1.7.0-diff-whitespace-only-status (2009-08-30) 4 commits
  (merged to 'next' on 2009-10-11 at 546c74d)
 + diff.c: fix typoes in comments
 + Make test case number unique
 + diff: Rename QUIET internal option to QUICK
 + diff: change semantics of "ignore whitespace" options
 (this branch is used by jc/1.7.0-diff-whitespace-prepare and jc/diff-whitespace-prepare.)

This changes exit code from "git diff --ignore-whitespace" and friends
when there is no actual output.

* gb/1.7.0-diff-whitespace-only-output (2009-11-19) 1 commit
  (merged to 'next' on 2009-11-21 at 3375bf4)
 + No diff -b/-w output for all-whitespace changes
 (this branch is used by jc/1.7.0-diff-whitespace-prepare and jc/diff-whitespace-prepare.)

Likewise but for the output of "diff --git" headers.

* jk/1.7.0-status (2009-12-11) 16 commits
  (merged to 'next' on 2009-12-24 at e9929b3)
 + status/commit: do not suggest "reset HEAD <path>" while merging
 + commit/status: "git add <path>" is not necessarily how to resolve
 + commit/status: check $GIT_DIR/MERGE_HEAD only once
  (merged to 'next' on 2009-12-08 at 9b57d84)
 + t7508-status: test all modes with color
 + t7508-status: status --porcelain ignores relative paths setting
  (merged to 'next' on 2009-12-07 at 7723acf)
 + status: reduce duplicated setup code
 + status: disable color for porcelain format
  (merged to 'next' on 2009-12-05 at 44dcefd)
 + status -s: obey color.status
 + builtin-commit: refactor short-status code into wt-status.c
  (merged to 'next' on 2009-11-27 at 91691ec)
 + t7508-status.sh: Add tests for status -s
 + status -s: respect the status.relativePaths option
  (merged to 'next' on 2009-11-21 at 884bb56)
 + docs: note that status configuration affects only long format
  (merged to 'next' on 2009-10-11 at 65c8513)
 + commit: support alternate status formats
 + status: add --porcelain output format
 + status: refactor format option parsing
 + status: refactor short-mode printing to its own function
 (this branch uses jc/1.7.0-status.)

Gives the --short output format to post 1.7.0 "git commit --dry-run" that
is similar to that of post 1.7.0 "git status".

* jc/1.7.0-status (2009-09-05) 4 commits
  (merged to 'next' on 2009-10-11 at 9558627)
 + status: typo fix in usage
 + git status: not "commit --dry-run" anymore
 + git stat -s: short status output
 + git stat: the beginning of "status that is not a dry-run of commit"
 (this branch is used by jk/1.7.0-status.)

With this, "git status" is no longer "git commit --dry-run".

--------------------------------------------------
[New Topics]

* jc/cache-unmerge (2009-12-25) 9 commits
 - rerere forget path: forget recorded resolution
 - rerere: refactor rerere logic to make it independent from I/O
 - rerere: remove silly 1024-byte line limit
 - resolve-undo: teach "update-index --unresolve" to use resolve-undo info
 - resolve-undo: "checkout -m path" uses resolve-undo information
 - resolve-undo: allow plumbing to clear the information
 - resolve-undo: basic tests
 - resolve-undo: record resolved conflicts in a new index extension section
 - builtin-merge.c: use standard active_cache macros

* js/filter-branch-prime (2009-12-15) 1 commit
 - filter-branch: remove an unnecessary use of 'git read-tree'

* mg/tag-d-show (2009-12-10) 1 commit
 - tag -d: print sha1 of deleted tag

* sb/maint-octopus (2009-12-11) 3 commits
 - octopus: remove dead code
 - octopus: reenable fast-forward merges
 - octopus: make merge process simpler to follow

* il/exec-error-report (2009-12-24) 2 commits
 - Improve transport helper exec failure reporting
 - Report exec errors from run-command

--------------------------------------------------
[Cooking]

* jh/commit-status (2009-12-07) 1 commit
 - [test?] Add commit.status, --status, and --no-status

* jc/checkout-merge-base (2009-11-20) 2 commits
  (merged to 'next' on 2009-12-24 at ff4d1d4)
 + "rebase --onto A...B" replays history on the merge base between A and B
 + "checkout A...B" switches to the merge base between A and B

* tr/http-push-ref-status (2009-12-24) 6 commits
 - transport-helper.c::push_refs(): emit "no refs" error message
 - transport-helper.c::push_refs(): ignore helper-reported status if ref is not to be pushed
 - transport.c::transport_push(): make ref status affect return value
 - refactor ref status logic for pushing
 - t5541-http-push.sh: add test for unmatched, non-fast-forwarded refs
 - t5541-http-push.sh: add tests for non-fast-forward pushes

* bg/maint-add-all-doc (2009-12-07) 4 commits
 - squash! rm documentation--also mention add-u where we mention commit-a
 - git-rm doc: Describe how to sync index & work tree
 - git-add/rm doc: Consistently back-quote
 - Documentation: 'git add -A' can remove files

I didn't like the existing documentation for "add -u" myself (especially
because I wrote the initial version) and this neatly fix it as well.

* il/vcs-helper (2009-12-09) 8 commits
 - Remove special casing of http, https and ftp
 - Support remote archive from all smart transports
 - Support remote helpers implementing smart transports
 - Support taking over transports
 - Refactor git transport options parsing
 - Pass unknown protocols to external protocol handlers
 - Support mandatory capabilities
 - Add remote helper debug mode

* mm/diag-path-in-treeish (2009-12-07) 1 commit
 - Detailed diagnosis when parsing an object name fails.

* mh/rebase-fixup (2009-12-07) 2 commits
 - Add a command "fixup" to rebase --interactive
 - t3404: Use test_commit to set up test repository
 (this branch is used by ns/rebase-auto-squash.)

Initial round of "fixup" action that is similar to "squash" action in
"rebase -i" that excludes the commit log message from follow-up commits
when composing the log message for the updated one.  Expected is a further
improvement to skip opening the editor if a pick is followed only by
"fixup" and no "squash".

* ns/rebase-auto-squash (2009-12-08) 2 commits
 - fixup! rebase -i --autosquash
 - rebase -i --autosquash: auto-squash commits
 (this branch uses mh/rebase-fixup.)

* jh/notes (2009-12-07) 11 commits
 - Refactor notes concatenation into a flexible interface for combining notes
 - Notes API: Allow multiple concurrent notes trees with new struct notes_tree
 - Notes API: for_each_note(): Traverse the entire notes tree with a callback
 - Notes API: get_note(): Return the note annotating the given object
 - Notes API: add_note(): Add note objects to the internal notes tree structure
 - Notes API: init_notes(): Initialize the notes tree from the given notes ref
 - Notes API: get_commit_notes() -> format_note() + remove the commit restriction
 - Minor style fixes to notes.c
 - Add more testcases to test fast-import of notes
 - Rename t9301 to t9350, to make room for more fast-import tests
 - fast-import: Proper notes tree manipulation

* fc/opt-quiet-gc-reset (2009-12-02) 1 commit
 - General --quiet improvements

* mv/commit-date (2009-12-03) 2 commits
 - Document date formats accepted by parse_date()
 - builtin-commit: add --date option

* sr/gfi-options (2009-12-04) 7 commits
 - fast-import: add (non-)relative-marks feature
 - fast-import: allow for multiple --import-marks= arguments
 - fast-import: test the new option command
 - fast-import: add option command
 - fast-import: add feature command
 - fast-import: put marks reading in its own function
 - fast-import: put option parsing code in separate functions

* ap/merge-backend-opts (2008-07-18) 6 commits
 - Document that merge strategies can now take their own options
 - Extend merge-subtree tests to test -Xsubtree=dir.
 - Make "subtree" part more orthogonal to the rest of merge-recursive.
 - Teach git-pull to pass -X<option> to git-merge
 - git merge -X<option>
 - git-merge-file --ours, --theirs

"git pull" patch needs sq-then-eval fix to protect it from $IFS
but otherwise seemed good.

* mo/bin-wrappers (2009-12-02) 3 commits
 - INSTALL: document a simpler way to run uninstalled builds
 - run test suite without dashed git-commands in PATH
 - build dashless "bin-wrappers" directory similar to installed bindir

* tr/http-updates (2009-12-01) 3 commits
  (merged to 'next' on 2009-12-07 at f08d447)
 + Allow curl to rewind the RPC read buffer
 + Add an option for using any HTTP authentication scheme, not only basic
 + http: maintain curl sessions

* nd/sparse (2009-12-14) 22 commits
  (merged to 'next' on 2009-12-24 at 1fa9ff3)
 + commit: correctly respect skip-worktree bit
 + ie_match_stat(): do not ignore skip-worktree bit with CE_MATCH_IGNORE_VALID
  (merged to 'next' on 2009-11-25 at 71380f5)
 + tests: rename duplicate t1009
  (merged to 'next' on 2009-11-23 at f712a41)
 + sparse checkout: inhibit empty worktree
 + Add tests for sparse checkout
 + read-tree: add --no-sparse-checkout to disable sparse checkout support
 + unpack-trees(): ignore worktree check outside checkout area
 + unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final index
 + unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/sparse-checkout
 + unpack-trees.c: generalize verify_* functions
 + unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
 + Introduce "sparse checkout"
 + dir.c: export excluded_1() and add_excludes_from_file_1()
 + excluded_1(): support exclude files in index
 + unpack-trees(): carry skip-worktree bit over in merged_entry()
 + Read .gitignore from index if it is skip-worktree
 + Avoid writing to buffer in add_excludes_from_file_1()
 + Teach Git to respect skip-worktree bit (writing part)
 + Teach Git to respect skip-worktree bit (reading part)
 + Introduce "skip-worktree" bit in index, teach Git to get/set this bit
 + Add test-index-version
 + update-index: refactor mark_valid() in preparation for new options

--------------------------------------------------
[Ejected]

* je/send-email-no-subject (2009-08-05) 1 commit
  (merged to 'next' on 2009-10-11 at 1b99c56)
 + send-email: confirm on empty mail subjects

* jc/fix-tree-walk (2009-10-22) 8 commits
  (merged to 'next' on 2009-10-22 at 10c0c8f)
 + Revert failed attempt since 353c5ee
 + read-tree --debug-unpack
  (merged to 'next' on 2009-10-11 at 0b058e2)
 + unpack-trees.c: look ahead in the index
 + unpack-trees.c: prepare for looking ahead in the index
 + Aggressive three-way merge: fix D/F case
 + traverse_trees(): handle D/F conflict case sanely
 + more D/F conflict tests
 + tests: move convenience regexp to match object names to test-lib.sh

This has some stupid bugs and reverted from 'next' until I can fix it, but
the "temporarily" turned out to be very loooong.

* jc/grep-full-tree (2009-11-24) 1 commit
 . grep: --full-tree

The interaction with this option and pathspecs need to be worked out
better.  I _think_ "grep --full-tree -e pattern -- '*.h'" should find from
all the header files in the tree, for example.

* cc/reset-more (2009-12-08) 6 commits
 . Documentation: reset: add some tables to describe the different options
 . Documentation: reset: describe new "--keep-local-changes" option
 . reset: add test cases for "--keep-local-changes" option
 . reset: add option "--keep-local-changes" to "git reset"
 . reset: use "unpack_trees()" directly instead of "git read-tree"
 . reset: add a few tests for "git reset --merge"

The documentation is much clearer than the previous round in describing
what it does, but I find it a bit unclear in describing what it is _good_
for (iow, scenarios and use cases).

Breaks 'pu' and does not pass test on its own yet.

From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Dec 2009, #06; Thu, 31)
Date: Thu, 31 Dec 2009 16:10:40 -0800
Message-ID: <7vskaqptvj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 01 01:10:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQV6Q-000793-FJ
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jan 2010 01:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab0AAAKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 19:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702Ab0AAAKq
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 19:10:46 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284Ab0AAAKp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 19:10:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9379F8C9E8;
	Thu, 31 Dec 2009 19:10:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=rmsy
	/hQN37rb74SMESBH1Hs3aN0=; b=k3vyoygHAuZ2VGPz6y+l1hRidVadlctZZMV2
	E/WN58ZWQj0BvYeO3rzFsa+KmxmjDNLp4fhZGX5921FM0i6zCVqXG76ahgCNieJm
	A8VsnORZU+X57ekALgObNBAcleb7lHNBoCXyS5ZHxprGv3OMlG7Muo8sN9JMCyvs
	tKd5avk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=bCZ
	G4YnVhFu/GqaDjAbFCC3NGEDHmotpNSHkusBtejcGDTzv8ZwtWQ+Y5tXUbKE06Va
	H8YH4KbwOcSA4moh0n1/WY0qUDR/eMZKokj+Kk91JWXSF4/wTJvqh6J1uA1RZz7s
	TYkobT8CPZb+8dEwOE2Xd0CeVz9lxmbraHhNYiUo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 80EC38C9E7;
	Thu, 31 Dec 2009 19:10:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93B498C9E5; Thu, 31 Dec
 2009 19:10:41 -0500 (EST)
X-master-at: 37bae10e38a66e4f1ddd5350daded00b21735126
X-next-at: 442ff22addab31be84a7a93a389d265fc8a49f93
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1A3EEB84-F66A-11DE-AF1E-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135991>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

The tip of 'next' will soon be rebuilt on top of the current 'master'.

This will be the last "What's cooking" message in year 2009 ;-)

--------------------------------------------------
[New Topics]

* cc/reset-more (2009-12-30) 4 commits
 - reset: use "unpack_trees()" directly instead of "git read-tree"
 - reset: add a few tests for "git reset --merge"
 - Documentation: reset: add some tables to describe the different options
 - reset: improve mixed reset error message when in a bare repo

Resurrected from "Ejected" category.  Haven't looked at it yet myself,
though...

* bg/maint-remote-update-default (2009-12-31) 1 commit
 - Fix "git remote update" with remotes.defalt set

* jc/branch-d (2009-12-29) 1 commit
 - branch -d: base the "already-merged" safety on the branch it merges with

* jc/rerere (2009-12-04) 1 commit
 - Teach --[no-]rerere-autoupdate option to merge, revert and friends

* jk/maint-1.6.5-reset-hard (2009-12-30) 1 commit
  (merged to 'next' on 2009-12-30 at de97679)
 + reset: unbreak hard resets with GIT_WORK_TREE

* jk/push-to-delete (2009-12-30) 1 commit
 - builtin-push: add --delete as syntactic sugar for :foo

* jk/run-command-use-shell (2009-12-30) 6 commits
 - diff: run external diff helper with shell
 - textconv: use shell to run helper
 - editor: use run_command's shell feature
 - run-command: optimize out useless shell calls
 - run-command: convert simple callsites to use_shell
 - run-command: add "use shell" option

* mm/config-path (2009-12-30) 1 commit
 - builtin-config: add --path option doing ~ and ~user expansion.

* pm/cvs-environ (2009-12-30) 1 commit
 - CVS Server: Support reading base and roots from environment

* rs/maint-archive-match-pathspec (2009-12-12) 1 commit
 - archive: complain about path specs that don't match anything

* so/cvsserver-update (2009-12-07) 1 commit
 - cvsserver: make the output of 'update' more compatible with cvs.

* tc/clone-v-progress (2009-12-26) 4 commits
 - clone: use --progress to force progress reporting
 - clone: set transport->verbose when -v/--verbose is used
 - git-clone.txt: reword description of progress behaviour
 - check stderr with isatty() instead of stdout when deciding to show progress

* tc/smart-http-restrict (2009-12-30) 3 commits
 - Smart-http tests: Test http-backend without curl or a webserver
 - Smart-http tests: Break test t5560-http-backend into pieces
 - Smart-http: check if repository is OK to export before serving it

* tr/maint-1.6.5-bash-prompt-show-submodule-changes (2009-12-31) 1 commit
 - bash completion: factor submodules into dirty state

--------------------------------------------------
[Cooking]

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
  (merged to 'next' on 2009-12-29 at c89a730)
 + Add more testcases to test fast-import of notes
 + Rename t9301 to t9350, to make room for more fast-import tests
 + fast-import: Proper notes tree manipulation

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

* tr/http-updates (2009-12-28) 4 commits
  (merged to 'next' on 2009-12-30 at e143bc9)
 + Remove http.authAny
  (merged to 'next' on 2009-12-07 at f08d447)
 + Allow curl to rewind the RPC read buffer
 + Add an option for using any HTTP authentication scheme, not only basic
 + http: maintain curl sessions

* nd/sparse (2009-12-30) 23 commits
  (merged to 'next' on 2009-12-31 at 442ff22)
 + grep: do not do external grep on skip-worktree entries
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

* il/exec-error-report (2009-12-30) 2 commits
 . Improve transport helper exec failure reporting
 . Report exec errors from run-command

Freezes "git log" or anything that uses pager; J6t made quite a many good
suggestions.  Expecting more rounds of reroll.

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

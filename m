From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Sep 2009, #01; Sat, 05)
Date: Sat, 05 Sep 2009 01:35:14 -0700
Message-ID: <7vocpp3i2l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 10:35:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjqkF-00074G-FI
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757199AbZIEIfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754398AbZIEIfY
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:35:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55572 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbZIEIfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:35:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DFFD84418C;
	Sat,  5 Sep 2009 04:35:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=Ah9Y
	5qI63oO3u6s0J3ZKZhnzrjU=; b=v/XxueuSLU8JDTsyfgaLrP1K31SlCuA8UVtl
	qxrZwnEiwFQBMk6/zkG9lTONiHPm2SUsgfsxi23js3VUKpvk4cUWwxlDJ9n4aYpn
	V+yITlY9iJ0cYRt2EF7a4MgEo1HGASsKMzHLzitU8XC99/5hzs2rVkW3HgPrbrix
	PQSdDzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=k+7
	NimJ53bHEwJ6LN3J2g28eWD4uEC8Q52ZahiQTO85j8yF2Sm2MSok120CChVUqreS
	okhwQTah/rIzfI6Keo8DOd0yo/RWB/CMnagshLj22zvFBmVJ6Qo8pHLiiTVQnQIP
	7B9Lx+2HhsCeUCj47uhxtKHINoCFUuZ98hW8TGHw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CAB8C4418B;
	Sat,  5 Sep 2009 04:35:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 59FDC44189; Sat,  5 Sep 2009
 04:35:17 -0400 (EDT)
X-master-at: 79b4fde573eb5e86a8109d100ad182be1eb5fc54
X-next-at: 85dc3ec32928a03c0f4996b00d7a74f5a8f9045e
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D58A8BC-99F7-11DE-AC9F-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127796>

What's cooking in git.git (Sep 2009, #01; Sat, 05)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

After the 1.6.5 cycle, the next release will be 1.7.0, and we will push
out the planned "push safety" change.  1.7.0 would be a good time to
introduce "justifiable" changes that are not strictly backward compatible.

During 1.6.5 cycle, 'next' will hold topics meant for 1.6.5 and 1.7.0.

I will probably do 1.6.5-rc0 this weekend, leaving some topics still
cooking in 'next'.

--------------------------------------------------
[Graduated to "master"]

* lt/approxidate (2009-08-30) 6 commits
  (merged to 'next' on 2009-08-30 at e016e3d)
 + fix approxidate parsing of relative months and years
 + tests: add date printing and parsing tests
 + refactor test-date interface
 + Add date formatting and parsing functions relative to a given time
  (merged to 'next' on 2009-08-26 at 62853f9)
 + Further 'approxidate' improvements
 + Improve on 'approxidate'

* mr/gitweb-snapshot (2009-08-25) 3 commits
  (merged to 'next' on 2009-08-30 at e4edd0b)
 + gitweb: add t9501 tests for checking HTTP status codes
 + gitweb: split test suite into library and tests
 + gitweb: improve snapshot error handling

* tf/diff-whitespace-incomplete-line (2009-08-23) 2 commits.
  (merged to 'next' on 2009-08-26 at 4fc7784)
 + xutils: Fix xdl_recmatch() on incomplete lines
 + xutils: Fix hashing an incomplete line with whitespaces at the end

--------------------------------------------------
[New Topics]

* pk/fast-import-tars (2009-09-03) 1 commit
 - import-tars: Allow per-tar author and commit message.

* jc/maint-1.6.0-blank-at-eof (2009-09-04) 9 commits.
 - diff --color: color blank-at-eof
 - diff --whitespace=warn/error: fix blank-at-eof check
 - diff --whitespace=warn/error: obey blank-at-eof
 - diff.c: the builtin_diff() deals with only two-file comparison
 - apply --whitespace: warn blank but not necessarily empty lines at EOF
 - apply --whitespace=warn/error: diagnose blank at EOF
 - apply.c: split check_whitespace() into two
 - apply --whitespace=fix: detect new blank lines at eof correctly
 - apply --whitespace=fix: fix handling of blank lines at the eof

--------------------------------------------------
[Stalled]

* jh/notes (2009-08-27) 12 commits.
 - Add '%N'-format for pretty-printing commit notes
 - Add flags to get_commit_notes() to control the format of the note string
 - notes.c: Implement simple memory pooling of leaf nodes
 - Selftests verifying semantics when loading notes trees with various fanouts
 - Teach the notes lookup code to parse notes trees with various fanout schemes
 - t3302-notes-index-expensive: Speed up create_repo()
 - fast-import: Add support for importing commit notes
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

I heard the cvs-helper series depends on this one.  It seems that the
fan-out strategy is being rethought?

--------------------------------------------------
[Cooking]

* db/vcs-helper (2009-09-03) 16 commits
 - Allow helpers to report in "list" command that the ref is unchanged
 - Add support for "import" helper command
 - Add a config option for remotes to specify a foreign vcs
 - Allow programs to not depend on remotes having urls
 - Allow fetch to modify refs
 - Use a function to determine whether a remote is valid
 - Use a clearer style to issue commands to remote helpers
 - Make the "traditionally-supported" URLs a special case
  (merged to 'next' on 2009-08-07 at f3533ba)
 + Makefile: install hardlinks for git-remote-<scheme> supported by libcurl if possible
 + Makefile: do not link three copies of git-remote-* programs
 + Makefile: git-http-fetch does not need expat
  (merged to 'next' on 2009-08-06 at 15da79d)
 + http-fetch: Fix Makefile dependancies
 + Add transport native helper executables to .gitignore
  (merged to 'next' on 2009-08-05 at 33d491e)
 + git-http-fetch: not a builtin
 + Use an external program to implement fetching with curl
 + Add support for external programs for handling native fetches
 (this branch is used by jh/cvs-helper)

* jh/cvs-helper (2009-08-18) 8 commits
 - More fixes to the git-remote-cvs installation procedure
 - Fix the Makefile-generated path to the git_remote_cvs package in git-remote-cvs
 - Add simple selftests of git-remote-cvs functionality
 - git-remote-cvs: Remote helper program for CVS repositories
 - 2/2: Add Python support library for CVS remote helper
 - 1/2: Add Python support library for CVS remote helper
 - Basic build infrastructure for Python scripts
 - Allow helpers to request marks for fast-import
 (this branch uses db/vcs-helper)

Builds on db/vcs-helper.  There is a re-roll planned.

* pk/fast-import-dirs (2009-09-03) 1 commit
 - Add script for importing bits-and-pieces to Git.

With an updated key-value quoting rules, which I haven't carefully looked
at.  Aren't there standard libraries to do this sort of thing without us
having to hand-roll these logic every time, I have to wonder...

* jn/gitweb-blame (2009-09-01) 5 commits
 - gitweb: Minify gitweb.js if JSMIN is defined
 - gitweb: Create links leading to 'blame_incremental' using JavaScript
 - gitweb: Colorize 'blame_incremental' view during processing
 - gitweb: Incremental blame (using JavaScript)
 - gitweb: Add optional "time to generate page" info in footer

Ajax-y blame.  The first part should be in 'next' shortly.

* js/stash-dwim (2009-07-27) 1 commit.
  (merged to 'next' on 2009-08-16 at 67896c4)
 + Make 'git stash -k' a short form for 'git stash save --keep-index'
 (this branch is used by tr/reset-checkout-patch.)

* tr/reset-checkout-patch (2009-08-18) 10 commits.
  (merged to 'next' on 2009-09-03 at d4f2ed7)
 + stash: simplify defaulting to "save" and reject unknown options
  (merged to 'next' on 2009-08-27 at d314281)
 + Make test case number unique
  (merged to 'next' on 2009-08-18 at e465bb3)
 + tests: disable interactive hunk selection tests if perl is not available
  (merged to 'next' on 2009-08-16 at 67896c4)
 + DWIM 'git stash save -p' for 'git stash -p'
 + Implement 'git stash save --patch'
 + Implement 'git checkout --patch'
 + Implement 'git reset --patch'
 + builtin-add: refactor the meat of interactive_add()
 + Add a small patch-mode testing library
 + git-apply--interactive: Refactor patch mode code
 (this branch uses js/stash-dwim.)

DWIMmery of the two series tightened for safety.  This should be ready for
1.6.5.

* jc/upload-pack-hook (2009-08-28) 2 commits
  (merged to 'next' on 2009-08-31 at f9933a5)
 + upload-pack: feed "kind [clone|fetch]" to post-upload-pack hook
 + upload-pack: add a trigger for post-upload-pack hook

* jk/clone-b (2009-08-26) 1 commit
  (merged to 'next' on 2009-08-30 at 10a68d1)
 + clone: add --branch option to select a different HEAD

* je/send-email-no-subject (2009-08-05) 1 commit
  (merged to 'next' on 2009-08-30 at b6455c2)
 + send-email: confirm on empty mail subjects

The existing tests to covers the positive case (i.e. as long as the user
says "yes" to the "do you really want to send this message that lacks
subject", the message is sent) of this feature, but the feature itself
needs its own test to verify the negative case (i.e. does it correctly
stop if the user says "no"?)

* jc/mailinfo-scissors (2009-08-26) 5 commits
  (merged to 'next' on 2009-08-30 at 5fc6248)
 + mailinfo.scissors: new configuration
 + am/mailinfo: Disable scissors processing by default
 + Documentation: describe the scissors mark support of "git am"
 + Teach mailinfo to ignore everything before -- >8 -- mark
 + builtin-mailinfo.c: fix confusing internal API to mailinfo()

I didn't pick up the patch to simplify the definition of scissors. I do
not have strong opinion on it either way, but the list would hopefully
decide it before too long.

* cc/sequencer-rebase-i (2009-08-28) 15 commits
 - rebase -i: use "git sequencer--helper --cherry-pick"
 - sequencer: add "--cherry-pick" option to "git sequencer--helper"
 - sequencer: add "do_commit()" and related functions working on "next_commit"
 - pick: libify "pick_help_msg()"
 - revert: libify cherry-pick and revert functionnality
 - rebase -i: use "git sequencer--helper --fast-forward"
 - sequencer: let "git sequencer--helper" callers set "allow_dirty"
 - sequencer: add "--fast-forward" option to "git sequencer--helper"
 - sequencer: add "do_fast_forward()" to perform a fast forward
 - rebase -i: use "git sequencer--helper --reset-hard"
 - sequencer: add "--reset-hard" option to "git sequencer--helper"
 - sequencer: add "reset_almost_hard()" and related functions
 - rebase -i: use "git sequencer--helper --make-patch"
 - sequencer: add "make_patch" function to save a patch
 - sequencer: add "builtin-sequencer--helper.c"

Migrating "rebase -i" bit by bit to C.

* sr/gfi-options (2009-09-02) 6 commits
 - fast-import: test the new option command
 - fast-import: add option command
 - fast-import: test the new feature command
 - fast-import: add feature command
 - fast-import: put marks reading in it's own function
 - fast-import: put option parsing code in separate functions

Re-rolled again.

* nd/sparse (2009-08-20) 19 commits
 - sparse checkout: inhibit empty worktree
 - Add tests for sparse checkout
 - read-tree: add --no-sparse-checkout to disable sparse checkout support
 - unpack-trees(): ignore worktree check outside checkout area
 - unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final index
 - unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/sparse-checkout
 - unpack-trees.c: generalize verify_* functions
 - unpack-trees(): add CE_WT_REMOVE to remove on worktree alone
 - Introduce "sparse checkout"
 - dir.c: export excluded_1() and add_excludes_from_file_1()
 - excluded_1(): support exclude files in index
 - unpack-trees(): carry skip-worktree bit over in merged_entry()
 - Read .gitignore from index if it is skip-worktree
 - Avoid writing to buffer in add_excludes_from_file_1()
 - Teach Git to respect skip-worktree bit (writing part)
 - Teach Git to respect skip-worktree bit (reading part)
 - Introduce "skip-worktree" bit in index, teach Git to get/set this bit
 - Add test-index-version
 - update-index: refactor mark_valid() in preparation for new options

--------------------------------------------------
[For 1.7.0]

* jc/1.7.0-status (2009-08-15) 3 commits
  (merged to 'next' on 2009-08-22 at b3507bb)
 + git status: not "commit --dry-run" anymore
 + git stat -s: short status output
 + git stat: the beginning of "status that is not a dry-run of commit"

With this, "git status" is no longer "git commit --preview".

* jc/1.7.0-send-email-no-thread-default (2009-08-22) 1 commit
  (merged to 'next' on 2009-08-22 at 5106de8)
 + send-email: make --no-chain-reply-to the default

* jc/1.7.0-diff-whitespace-only-status (2009-08-30) 4 commits.
  (merged to 'next' on 2009-08-30 at 0623572)
 + diff.c: fix typoes in comments
  (merged to 'next' on 2009-08-27 at 81fb2bd)
 + Make test case number unique
  (merged to 'next' on 2009-08-02 at 9c08420)
 + diff: Rename QUIET internal option to QUICK
 + diff: change semantics of "ignore whitespace" options

This changes exit code from "git diff --ignore-whitespace" and friends
when there is no actual output.  It is a backward incompatible change, but
we could argue that it is a bugfix.

* jc/1.7.0-push-safety (2009-02-09) 2 commits
  (merged to 'next' on 2009-08-02 at 38b82fe)
 + Refuse deleting the current branch via push
 + Refuse updating the current branch in a non-bare repository via push

--------------------------------------------------
[I have been too busy to purge these]

* jc/log-tz (2009-03-03) 1 commit.
 - Allow --date=local --date=other-format to work as expected

Maybe some people care about this.  I dunno.

* jc/mailinfo-remove-brackets (2009-07-15) 1 commit.
 - mailinfo: -b option keeps [bracketed] strings that is not a [PATCH] marker

Maybe some people care about this.  I dunno.

* ar/maint-1.6.2-merge-recursive-d-f (2009-05-11) 2 commits.
 . Fix for a merge where a branch has an F->D transition
 . Add a reminder test case for a merge with F/D transition

* jc/merge-convert (2009-01-26) 1 commit.
 . git-merge-file: allow converting the results for the work tree

* lt/read-directory (2009-05-15) 3 commits.
 . Add initial support for pathname conversion to UTF-8
 . read_directory(): infrastructure for pathname character set conversion
 . Add 'fill_directory()' helper function for directory traversal

* ps/blame (2009-03-12) 1 commit.
 . blame.c: start libifying the blame infrastructure

* pb/tracking (2009-07-16) 7 commits.
 . branch.c: if remote is not config'd for branch, don't try delete push config
 . branch, checkout: introduce autosetuppush
 . move deletion of merge configuration to branch.c
 . remote: add per-remote autosetupmerge and autosetuprebase configuration
 . introduce a struct tracking_config
 . branch: install_branch_config and struct tracking refactoring
 . config: allow false and true values for branch.autosetuprebase

Has been ejected from 'pu' for some time, expecting a reroll.

* ne/rev-cache (2009-08-21) 6 commits
 . support for path name caching in rev-cache
 . full integration of rev-cache into git, completed test suite
 . administrative functions for rev-cache, start of integration into git
 . support for non-commit object caching in rev-cache
 . basic revision cache system, no integration or features
 . man page and technical discussion for rev-cache

Updated but seems to break upload-pack tests when merged to 'pu'; given
what this series touches, breakages in that area are expected.
May discard if a working reroll comes, to give it a fresh start.

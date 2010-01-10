From: Junio C Hamano <gitster@pobox.com>
Subject: "What's cooking" incremental edition
Date: Sun, 10 Jan 2010 11:55:23 -0800
Message-ID: <7vmy0lpwes.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 10 20:55:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NU3ss-0001Wj-A6
	for gcvg-git-2@lo.gmane.org; Sun, 10 Jan 2010 20:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511Ab0AJTz3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jan 2010 14:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348Ab0AJTz2
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jan 2010 14:55:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296Ab0AJTz2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jan 2010 14:55:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E8E68F7A8;
	Sun, 10 Jan 2010 14:55:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=wm7reWQxXL5TR5PKM8y3L4Wx5
	DA=; b=D8IWttuvioO13uSisyeT22IchPk83TwN7oinO0obQCyZUZdalIil9k+wU
	6wplK02RTXpJsKqQA+NJmYTTgxSiW/Erwg6Y3r3wZjZQJxh4oa9p1P/CnuElo7gB
	C0Bu8uV9IO7yAIJb5q0BHCXZi2nzKpnjS/YM/k6FvQDeOOXLOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=i2kObno4Pb08i8Pttny
	4t4Y76lfLaFtXPzaCk1bN+2EjvHsWu3HaJvw4/DH8+t6GaNXGEt+n0VEKz4U5njl
	wd77WsZLVs7ER0hLbLQkCY2gsoI03DPFKE1h76KjxLUBNx74v2pVWPy4Yr6R49Nn
	asy6W6bLILK1PFXUK+bfDSs4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 784618F7A7;
	Sun, 10 Jan 2010 14:55:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 865648F7A6; Sun, 10 Jan
 2010 14:55:24 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 18B5FDC4-FE22-11DE-B046-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136585>

This is "git show --ext-diff" output in 'todo' branch (see README.cooki=
ng
in the same branch) for today's updates to highlight the updated parts.

-- >8 --

-What's cooking in git.git (Jan 2010, #02; Thu, 07)
+What's cooking in git.git (Jan 2010, #03; Sun, 10)
=20
 Here are the topics that have been cooking.  Commits prefixed with '-'=
 are
 only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
 marked with '.' do not appear in any of the integration branches, but =
I am
 still holding onto them.
-
-The tip of 'next' has been rebuilt on top of the current 'master'.

--------------------------------------------------
Born topics

[New Topics]

 * bk/fix-relative-gitdir-file (2010-01-08) 2 commits
  - Handle relative paths in submodule .git files
  - Test update-index for a gitlink to a .git file

 * jc/ident (2010-01-08) 3 commits
  - ident.c: treat $EMAIL as giving user.email identity explicitly
   (merged to 'next' on 2010-01-10 at f1f9ded)
  + ident.c: check explicit identity for name and email separately
  + ident.c: remove unused variables

 * jc/ls-files-ignored-pathspec (2010-01-08) 4 commits
  - ls-files: fix overeager pathspec optimization
  - read_directory(): further split treat_path()
  - read_directory_recursive(): refactor handling of a single path into=
 a separate function
  - t3001: test ls-files -o ignored/dir

 * js/exec-error-report (2010-01-10) 4 commits
  - Improve error message when a transport helper was not found
  - start_command: detect execvp failures early
  - run-command: move wait_or_whine earlier
  - start_command: report child process setup errors to the parent's st=
derr
  (this branch uses il/vcs-helper.)

--------------------------------------------------
Moved from [New Topics] to [Cooking]

 * jc/maint-1.6.1-checkout-m-custom-merge (2010-01-06) 1 commit
- - checkout -m path: fix recreating conflicts
+  (merged to 'next' on 2010-01-10 at df14116)
+ + checkout -m path: fix recreating conflicts

 * jn/makefile (2010-01-06) 4 commits
- - Makefile: consolidate .FORCE-* targets
- - Makefile: learn to generate listings for targets requiring special =
flags
- - Makefile: use target-specific variable to pass flags to cc
- - Makefile: regenerate assembler listings when asked
+  (merged to 'next' on 2010-01-10 at f5a5d42)
+ + Makefile: consolidate .FORCE-* targets
+ + Makefile: learn to generate listings for targets requiring special =
flags
+ + Makefile: use target-specific variable to pass flags to cc
+ + Makefile: regenerate assembler listings when asked

--------------------------------------------------
Moved from [Will graduate after a bit more cooking] to [Graduated to "m=
aster"]

 * tr/http-updates (2009-12-28) 4 commits

 * jk/maint-1.6.5-reset-hard (2009-12-30) 1 commit

 * jk/push-to-delete (2009-12-30) 1 commit

 * mm/config-path (2009-12-30) 1 commit

 * pm/cvs-environ (2009-12-30) 1 commit

 * tr/maint-1.6.5-bash-prompt-show-submodule-changes (2009-12-31) 1 com=
mit

 * bg/maint-remote-update-default (2009-12-31) 1 commit

--------------------------------------------------
Moved from [Cooking] to [Will graduate after a bit more cooking]

 * cc/reset-more (2010-01-08) 8 commits
- - t7111: check that reset options work as described in the tables
+  (merged to 'next' on 2010-01-10 at 84730de)
+ + t7111: check that reset options work as described in the tables
   (merged to 'next' on 2010-01-06 at 96639cb)
  + Documentation: reset: add some missing tables
   (merged to 'next' on 2010-01-04 at 8802c2c)
  + Fix bit assignment for CE_CONFLICTED
   (merged to 'next' on 2010-01-03 at f83d4c6)
  + "reset --merge": fix unmerged case
  + reset: use "unpack_trees()" directly instead of "git read-tree"
  + reset: add a few tests for "git reset --merge"
  + Documentation: reset: add some tables to describe the different opt=
ions
  + reset: improve mixed reset error message when in a bare repo

 * rs/maint-archive-match-pathspec (2009-12-12) 1 commit

-* il/vcs-helper (2009-12-09) 8 commits
+* il/vcs-helper (2010-01-09) 9 commits
+  (merged to 'next' on 2010-01-10 at 11e448e)
+ + Reset possible helper before reusing remote structure
   (merged to 'next' on 2010-01-06 at 7c79f42)
  + Remove special casing of http, https and ftp
  + Support remote archive from all smart transports
  + Support remote helpers implementing smart transports
  + Support taking over transports
  + Refactor git transport options parsing
  + Pass unknown protocols to external protocol handlers
  + Support mandatory capabilities
  + Add remote helper debug mode
+ (this branch is used by js/exec-error-report.)

--------------------------------------------------
Moved from [Cooking] to [Stalled]

 * jh/commit-status (2009-12-07) 1 commit

 * mh/rebase-fixup (2009-12-07) 2 commits
-Initial round of "fixup" action that is similar to "squash" action in
-"rebase -i" that excludes the commit log message from follow-up commit=
s
-when composing the log message for the updated one.  Expected is a fur=
ther
-improvement to skip opening the editor if a pick is followed only by
-"fixup" and no "squash".
+Expecting further improvements to skip opening the editor if a pick is
+followed only by "fixup" and no "squash".

 * ns/rebase-auto-squash (2009-12-08) 1 commit
   (merged to 'next' on 2010-01-06 at da4e2f5)
  + rebase -i --autosquash: auto-squash commits
  (this branch uses mh/rebase-fixup.)
+
+Blocked by the above.

 * jh/notes (2009-12-07) 11 commits
-http://mid.gmane.org/201001051231.43048.johan@herland.net Hold!
+Hold: JH on 2010-01-05, http://article.gmane.org/gmane.comp.version-co=
ntrol.git/136183

 * ap/merge-backend-opts (2008-07-18) 6 commits

--------------------------------------------------
Moved from [Cooking] to [Graduated to "master"]

 * mm/diag-path-in-treeish (2009-12-07) 1 commit

 * fc/opt-quiet-gc-reset (2009-12-02) 1 commit

--------------------------------------------------
Other topics

[Will graduate after a bit more cooking]

 * nd/sparse (2010-01-04) 25 commits
- - t7002: test for not using external grep on skip-worktree paths
- - t7002: set test prerequisite "external-grep" if supported
+  (merged to 'next' on 2010-01-10 at fa73d6e)
+ + t7002: test for not using external grep on skip-worktree paths
+ + t7002: set test prerequisite "external-grep" if supported
   (merged to 'next' on 2010-01-02 at 5499bbe)
  + grep: do not do external grep on skip-worktree entries
  + commit: correctly respect skip-worktree bit
  + ie_match_stat(): do not ignore skip-worktree bit with CE_MATCH_IGNO=
RE_VALID
  + tests: rename duplicate t1009
  + sparse checkout: inhibit empty worktree
  + Add tests for sparse checkout
  + read-tree: add --no-sparse-checkout to disable sparse checkout supp=
ort
  + unpack-trees(): ignore worktree check outside checkout area
  + unpack_trees(): apply $GIT_DIR/info/sparse-checkout to the final in=
dex
  + unpack-trees(): "enable" sparse checkout and load $GIT_DIR/info/spa=
rse-checkout
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
  + Introduce "skip-worktree" bit in index, teach Git to get/set this b=
it
  + Add test-index-version
  + update-index: refactor mark_valid() in preparation for new options
+
+I've queued the (close to) original tests for external grep, but as a =
belt
+and suspender measure Nguy=E1=BB=85n may also want to add the whitebox=
 test
+in the review thread.

[Cooking]

-* da/difftool (2009-12-22) 2 commits
+* da/difftool (2010-01-09) 6 commits
+  (merged to 'next' on 2010-01-10 at 749c870)
+ + git-diff.txt: Link to git-difftool
+ + difftool: Allow specifying unconfigured commands with --extcmd
+ + difftool--helper: Remove use of the GIT_MERGE_TOOL variable
+ + difftool--helper: Update copyright and remove distracting comments
   (merged to 'next' on 2010-01-06 at e957395)
  + git-difftool: Add '--gui' for selecting a GUI tool
  + t7800-difftool: Set a bogus tool for use by tests

 * jh/gitweb-cached (2010-01-03) 4 commits
-Will merge to 'next', unless I hear objections within a few days.
+Hold: Warthog on 2010-01-06, http://article.gmane.org/gmane.comp.versi=
on-control.git/136306

 * jc/fix-tree-walk (2009-09-14) 7 commits
 Resurrected from "Ejected" category.  This is fix for a tricky codepat=
h
 and testing and improving before it hits 'next' by brave souls is grea=
tly
-appreciated.  I am not very happy about the solution myself.
+appreciated (I am using this in my private build).

 * jc/branch-d (2009-12-29) 1 commit
- - branch -d: base the "already-merged" safety on the branch it merges=
 with
-
+  (merged to 'next' on 2010-01-10 at 61a14b7)
+ + branch -d: base the "already-merged" safety on the branch it merges=
 with
-http://thread.gmane.org/gmane.comp.version-control.git/135837/focus=3D=
135863
-I am tempted to merge this to 'next', but please stop me if people see=
 issues
-in it.

 * jc/rerere (2009-12-04) 1 commit
- - Teach --[no-]rerere-autoupdate option to merge, revert and friends
+  (merged to 'next' on 2010-01-10 at e295b7f)
+ + Teach --[no-]rerere-autoupdate option to merge, revert and friends

 * jk/run-command-use-shell (2010-01-01) 8 commits
- - t4030, t4031: work around bogus MSYS bash path conversion
- - diff: run external diff helper with shell
- - textconv: use shell to run helper
- - editor: use run_command's shell feature
- - run-command: optimize out useless shell calls
- - run-command: convert simple callsites to use_shell
- - t0021: use $SHELL_PATH for the filter script
- - run-command: add "use shell" option
+  (merged to 'next' on 2010-01-10 at 7479e2a)
+ + t4030, t4031: work around bogus MSYS bash path conversion
+ + diff: run external diff helper with shell
+ + textconv: use shell to run helper
+ + editor: use run_command's shell feature
+ + run-command: optimize out useless shell calls
+ + run-command: convert simple callsites to use_shell
+ + t0021: use $SHELL_PATH for the filter script
+ + run-command: add "use shell" option
=20

 * tc/clone-v-progress (2009-12-26) 4 commits
- - clone: use --progress to force progress reporting
- - clone: set transport->verbose when -v/--verbose is used
- - git-clone.txt: reword description of progress behaviour
- - check stderr with isatty() instead of stdout when deciding to show =
progress
+  (merged to 'next' on 2010-01-10 at ec2bfd7)
+ + clone: use --progress to force progress reporting
+ + clone: set transport->verbose when -v/--verbose is used
+ + git-clone.txt: reword description of progress behaviour
+ + check stderr with isatty() instead of stdout when deciding to show =
progress
=20

 * jc/cache-unmerge (2009-12-25) 9 commits
-Will wait a bit more before moving it to 'next'.
+Will wait a bit more before moving it to 'next'.  J6t spotted an issue
+with "rerere forget" and has a test script.

-* tr/http-push-ref-status (2009-12-24) 6 commits
+* tr/http-push-ref-status (2010-01-08) 6 commits
-Peff: $gmane/136169, 136167, 136168
-RC: $gmane/136172
+Rerolled.

 * sr/gfi-options (2009-12-04) 7 commits
- - fast-import: add (non-)relative-marks feature
- - fast-import: allow for multiple --import-marks=3D arguments
- - fast-import: test the new option command
- - fast-import: add option command
- - fast-import: add feature command
- - fast-import: put marks reading in its own function
- - fast-import: put option parsing code in separate functions
-
-http://thread.gmane.org/gmane.comp.version-control.git/134540
-
+  (merged to 'next' on 2010-01-10 at 8b305fb)
+ + fast-import: add (non-)relative-marks feature
+ + fast-import: allow for multiple --import-marks=3D arguments
+ + fast-import: test the new option command
+ + fast-import: add option command
+ + fast-import: add feature command
+ + fast-import: put marks reading in its own function
+ + fast-import: put option parsing code in separate functions
-I haven't seen comments on this round, and I am tempted to merge it to
-'next' soonish.  Please file complaints before I do so if people have
-objections.

--------------------------------------------------
Gone topics

Was in [Graduated to "master"]

 * mo/bin-wrappers (2009-12-02) 3 commits
   (merged to 'next' on 2010-01-03 at 8c5fa27)
  + INSTALL: document a simpler way to run uninstalled builds
  + run test suite without dashed git-commands in PATH
  + build dashless "bin-wrappers" directory similar to installed bindir

 * mv/commit-date (2009-12-03) 2 commits
   (merged to 'next' on 2010-01-03 at 1c45fdf)
  + Document date formats accepted by parse_date()
  + builtin-commit: add --date option

 * bg/maint-add-all-doc (2009-12-07) 4 commits
   (merged to 'next' on 2010-01-03 at b19a323)
  + squash! rm documentation--also mention add-u where we mention commi=
t-a
  + git-rm doc: Describe how to sync index & work tree
  + git-add/rm doc: Consistently back-quote
  + Documentation: 'git add -A' can remove files

 * so/cvsserver-update (2009-12-07) 1 commit
   (merged to 'next' on 2010-01-03 at 99959b6)
  + cvsserver: make the output of 'update' more compatible with cvs.

 * mg/tag-d-show (2009-12-10) 1 commit
   (merged to 'next' on 2010-01-03 at 87657d2)
  + tag -d: print sha1 of deleted tag

 * sb/maint-octopus (2009-12-11) 3 commits
   (merged to 'next' on 2010-01-03 at ffe77d6)
  + octopus: remove dead code
  + octopus: reenable fast-forward merges
  + octopus: make merge process simpler to follow

 * js/filter-branch-prime (2009-12-15) 1 commit
   (merged to 'next' on 2010-01-03 at 7c90319)
  + filter-branch: remove an unnecessary use of 'git read-tree'

From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Wed, 23 Feb 2011 15:26:50 -0800
Message-ID: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 24 00:27:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsO6q-00059h-CV
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619Ab1BWX07 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 18:26:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53300 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab1BWX05 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 18:26:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DA4E344AC;
	Wed, 23 Feb 2011 18:28:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=4WSf6mPuPCXnVrbSVFD+q9kBz
	sQ=; b=oONfcJKlPW01kPKgqFFF8SUrRffFzaPwgab4yEmPiZgMG+tNPeMbm+cnZ
	yTXX9RcvnXmOApyeaZU+6xSEbnF9zMt1V9P7H9lGqgJqfbnwVQVXuhnsYuyEgm01
	jL/pXcjJ+KOC1MM649drdacRvoBxp8dwrTz+65N446UhYDlvgI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=N9xfy0R3kEbA7yd5q5V
	NzenMVGRJd74cjiprZbgW0U1TPT2jhksMnLRbsi7YMAO5uJXu1fDlgcc+A4MSJpa
	NJGfUANbqNpH+nG+I1zFOHrbTmfLgTQ1BmgXZvuid8ONlPzjLz8hGfGcMeRJqdir
	9IBpDZvDjEu/x4Y7ioaipd98=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C707444AB;
	Wed, 23 Feb 2011 18:28:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4764844A7; Wed, 23 Feb 2011
 18:28:05 -0500 (EST)
X-master-at: 046613c5465e4fc0611f93a5ef31d3815fb50c22
X-next-at: 426d48db1a78ffd5f2b882725c32f266e617529e
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 91F14FF8-3FA4-11E0-B70B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167742>

Here are the topics that have been cooking.  Commits prefixed with '-' =
are
only in 'pu' while commits prefixed with '+' are in 'next'.

--------------------------------------------------
[New Topics]

* ab/i18n (2011-02-22) 73 commits
 - i18n: git-shortlog basic messages
 - i18n: git-revert split up "could not revert/apply" message
 - i18n: git-revert literal "me" messages
 - i18n: git-revert "Your local changes" message
 - i18n: git-revert basic messages
 - i18n: git-notes GIT_NOTES_REWRITE_MODE error message
 - i18n: git-notes basic commands
 - i18n: git-gc "Auto packing the repository" message
 - i18n: git-gc basic messages
 - i18n: git-describe basic messages
 - i18n: git-clean clean.requireForce messages
 - i18n: git-clean basic messages
 - i18n: git-bundle basic messages
 - i18n: git-archive basic messages
 - i18n: git-status "renamed: " message
 - i18n: git-status "Initial commit" message
 - i18n: git-status "Changes to be committed" message
 - i18n: git-status shortstatus messages
 - i18n: git-status "nothing to commit" messages
 - i18n: git-status basic messages
 - i18n: git-push "prevent you from losing" message
 - i18n: git-push basic messages
 - i18n: git-tag tag_template message
 - i18n: git-tag basic messages
 - i18n: git-reset "Unstaged changes after reset" message
 - i18n: git-reset reset_type_names messages
 - i18n: git-reset basic messages
 - i18n: git-rm basic messages
 - i18n: git-mv "bad" messages
 - i18n: git-mv basic messages
 - i18n: git-merge "Wonderful" message
 - i18n: git-merge "You have not concluded your merge" messages
 - i18n: git-merge "Updating %s..%s" message
 - i18n: git-merge basic messages
 - i18n: git-log "--OPT does not make sense" messages
 - i18n: git-log basic messages
 - i18n: git-grep "--open-files-in-pager" message
 - i18n: git-grep basic messages
 - i18n: git-fetch split up "(non-fast-forward)" message
 - i18n: git-fetch update_local_ref messages
 - i18n: git-fetch formatting messages
 - i18n: git-fetch basic messages
 - i18n: git-diff basic messages
 - i18n: git-commit advice messages
 - i18n: git-commit "enter the commit message" message
 - i18n: git-commit print_summary messages
 - i18n: git-commit formatting messages
 - i18n: git-commit "middle of a merge" message
 - i18n: git-commit basic messages
 - i18n: git-checkout "Switched to a .. branch" message
 - i18n: git-checkout "HEAD is now at" message
 - i18n: git-checkout describe_detached_head messages
 - i18n: git-checkout: our/their version message
 - i18n: git-checkout basic messages
 - i18n: git-branch "(no branch)" message
 - i18n: git-branch "git branch -v" messages
 - i18n: git-branch "Deleted branch [...]" message
 - i18n: git-branch "remote branch '%s' not found" message
 - i18n: git-branch basic messages
 - i18n: git-add "Unstaged changes" message
 - i18n: git-add "remove '%s'" message
 - i18n: git-add "did not match any files" message
 - i18n: git-add "The following paths are ignored" message
 - i18n: git-add basic messages
 - i18n: git-clone "Cloning into" message
 - i18n: git-clone "Cloning into" message
 - i18n: git-clone basic messages
 - i18n: git-init "Initialized [...] repository" message
 - i18n: git-init basic messages
 - i18n: Makefile: "pot" target to extract messages marked for translat=
ion
 - i18n: do not poison translations unless GIT_GETTEXT_POISON envvar is=
 set
 - i18n: add GETTEXT_POISON to simulate translated messages unfriendly =
translator
 - i18n: add no-op _() and N_() wrappers

Re^4-roll, coordinated between =C3=86var and Jonathan.

I'd like to fast-track the basics (especially the bottom 3 patches), an=
d
am even tempted to rebase other patches on 'pu' that are not yet in 'ne=
xt'
on top of them, to make the transition easier, so please lend extra set=
s
of eyeballs on an earlier ones to make sure they are sane (I thought th=
ey
were, but I am far from perfect).

* gr/cvsimport-alternative-cvspass-location (2011-02-18) 1 commit
 - Look for password in both CVS and CVSNT password files.

* jc/checkout-orphan-warning (2011-02-18) 1 commit
 - commit: give final warning when reattaching HEAD to leave commits be=
hind

Likes, dislikes?

* jh/maint-do-not-track-non-branches (2011-02-17) 1 commit
 - branch/checkout --track: Ensure that upstream branch is indeed a bra=
nch

This supersedes "do not track HEAD" from Thomas.

* jk/diffstat-binary (2011-02-19) 2 commits
  (merged to 'next' on 2011-02-23 at 49da967)
 + diff: don't retrieve binary blobs for diffstat
 + diff: handle diffstat of rewritten binary files

* jk/fail-null-clone (2011-02-17) 1 commit
  (merged to 'next' on 2011-02-23 at a4217f5)
 + clone: die when trying to clone missing local path

* jk/merge-rename-ux (2011-02-20) 6 commits
 - pull: propagate --progress to merge
 - merge: enable progress reporting for rename detection
 - add inexact rename detection progress infrastructure
 - commit: stop setting rename limit
 - bump rename limit defaults (again)
 - merge: improve inexact rename limit warning

The above three all seemed sensible improvements.

* jn/test-terminal-punt-on-osx-breakage (2011-02-17) 1 commit
  (merged to 'next' on 2011-02-23 at d754139)
 + tests: skip terminal output tests on OS X

* js/cherry-pick-usability (2011-02-19) 4 commits
  (merged to 'next' on 2011-02-23 at 95db30e)
 + Teach commit about CHERRY_PICK_HEAD
 + bash: teach __git_ps1 about CHERRY_PICK_HEAD
 + Introduce CHERRY_PICK_HEAD
 + t3507: introduce pristine-detach helper

* js/detach-doc (2011-02-20) 1 commit
  (merged to 'next' on 2011-02-21 at c384c3c)
 + git-checkout.txt: improve detached HEAD documentation

* lt/rename-no-extra-copy-detection (2011-02-18) 3 commits
  (merged to 'next' on 2011-02-23 at 2c1f271)
 + diffcore-rename: improve estimate_similarity() heuristics
 + diffcore-rename: properly honor the difference between -M and -C
 + for_each_hash: allow passing a 'void *data' pointer to callback

* mg/rev-list-one-side-only (2011-02-22) 6 commits
 - t6007: test rev-list --cherry
 - log --cherry: a synonym
 - rev-list: --left/right-only are mutually exclusive
 - rev-list: documentation and test for --left/right-only
 - t6007: Make sure we test --cherry-pick
 - revlist.c: introduce --left/right-only for unsymmetric picking

* so/submodule-no-update-first-time (2011-02-17) 2 commits
  (merged to 'next' on 2011-02-23 at 2c6e8c9)
 + t7406: "git submodule update {--merge|--rebase]" with new submodules
 + submodule: no [--merge|--rebase] when newly cloned

* va/p4 (2011-02-20) 2 commits
  (merged to 'next' on 2011-02-21 at d981b23)
 + git-p4: Add copy detection support
 + git-p4: Improve rename detection support

* jc/complete-symmetric-diff (2011-02-23) 1 commit
 - completion: complete "git diff ...branc<TAB>"

* jh/submodule-fetch-on-demand (2011-02-23) 6 commits
 - submodule update: Don't fetch when the submodule commit is already p=
resent
 - fetch/pull: Don't recurse into a submodule when commits are already =
present
 - Submodules: Add 'on-demand' value for the 'fetchRecurseSubmodule' op=
tion
 - config: teach the fetch.recurseSubmodules option the 'on-demand' val=
ue
 - fetch/pull: Add the 'on-demand' value to the --recurse-submodules op=
tion
 - fetch/pull: recurse into submodules when necessary

* jk/format-patch-multiline-header (2011-02-23) 2 commits
 - format-patch: wrap long header lines
 - strbuf: add fixed-length version of add_wrapped_text

* cp/mergetool-beyondcompare (2011-02-18) 1 commit
 - mergetool--lib: add support for beyond compare

May want to have an independent success report on Windows.

--------------------------------------------------
[Stalled]

* jh/merge-sans-branch (2011-02-10) 4 commits
 . merge: add support for merging from upstream by default
 - merge: introduce per-branch-configuration helper function
 - merge: introduce setup_merge_commit helper function
 - merge: update the usage information to be more modern

There was an objection to the tip one that determines the upstream in a
wrong way?

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of objec=
t
flags needs to be rethought, or at least the helper needs to be moved t=
o
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

* jc/rename-degrade-cc-to-c (2011-01-06) 3 commits
 . diffcore-rename: fall back to -C when -C -C busts the rename limit
 . diffcore-rename: record filepair for rename src
 . diffcore-rename: refactor "too many candidates" logic

* nd/index-doc (2010-09-06) 1 commit
 . doc: technical details about the index file format

--------------------------------------------------
[Cooking]

* js/checkout-untracked-symlink (2011-02-20) 2 commits
  (merged to 'next' on 2011-02-23 at 52a35ce)
 + do not overwrite untracked symlinks
 + Demonstrate breakage: checkout overwrites untracked symlink with dir=
ectory

* pw/p4 (2011-02-19) 8 commits
  (merged to 'next' on 2011-02-21 at 1a7b7d2)
 + git-p4: support clone --bare
 + git-p4: decode p4 wildcard characters
 + git-p4: better message for "git-p4 sync" when not cloned
 + git-p4: reinterpret confusing p4 message
 + git-p4: accommodate new move/delete type in p4
 + git-p4: add missing newline in initial import message
 + git-p4: fix key error for p4 problem
 + git-p4: test script

* jh/push-default-upstream-configname (2011-02-16) 1 commit
  (merged to 'next' on 2011-02-23 at b5c25fa)
 + push.default: Rename 'tracking' to 'upstream'

This is not "renaming" in the sense that breaks existing practice, but
giving a new official name and deprecating the existing one.

* js/maint-merge-use-prepare-commit-msg-hook (2011-02-14) 1 commit
  (merged to 'next' on 2011-02-22 at 6458c4b)
 + merge: honor prepare-commit-msg hook

* mg/patch-id (2011-02-17) 2 commits
  (merged to 'next' on 2011-02-22 at 6f4acd8)
 + git-patch-id: do not trip over "no newline" markers
 + git-patch-id: test for "no newline" markers

* mg/placeholders-are-lowercase (2011-02-17) 5 commits
  (merged to 'next' on 2011-02-22 at 2754e21)
 + Make <identifier> lowercase in Documentation
 + Make <identifier> lowercase as per CodingGuidelines
 + Make <identifier> lowercase as per CodingGuidelines
 + Make <identifier> lowercase as per CodingGuidelines
 + CodingGuidelines: downcase placeholders in usage messages

* mo/perl-bidi-pipe-envfix (2011-02-15) 1 commit
  (merged to 'next' on 2011-02-15 at c36e816)
 + perl: command_bidi_pipe() method should set-up git environmens

Looked reasonable.

* nd/sorted-builtin-command-list (2011-02-15) 1 commit
  (merged to 'next' on 2011-02-22 at 91fccd1)
 + git.c: reorder builtin command list

* sp/maint-smart-http-sans-100-continue (2011-02-15) 1 commit
  (merged to 'next' on 2011-02-15 at 553e3e5)
 + smart-http: Don't use Expect: 100-Continue

* jc/grep--no-index-pathspec-fix (2011-02-16) 1 commit
  (merged to 'next' on 2011-02-23 at 58b03b1)
 + grep --no-index: honor pathspecs correctly
 (this branch uses nd/struct-pathspec; is tangled with en/object-list-w=
ith-pathspec.)

* mz/rebase (2011-02-09) 32 commits
  (merged to 'next' on 2011-02-22 at 3219155)
 + rebase: use @{upstream} if no upstream specified
 + rebase -i: remove unnecessary state rebase-root
 + rebase -i: don't read unused variable preserve_merges
 + git-rebase--am: remove unnecessary --3way option
 + rebase -m: don't print exit code 2 when merge fails
 + rebase -m: remember allow_rerere_autoupdate option
 + rebase: remember strategy and strategy options
 + rebase: remember verbose option
 + rebase: extract code for writing basic state
 + rebase: factor out sub command handling
 + rebase: make -v a tiny bit more verbose
 + rebase -i: align variable names
 + rebase: show consistent conflict resolution hint
 + rebase: extract am code to new source file
 + rebase: extract merge code to new source file
 + rebase: remove $branch as synonym for $orig_head
 + rebase -i: support --stat
 + rebase: factor out call to pre-rebase hook
 + rebase: factor out clean work tree check
 + rebase: factor out reference parsing
 + rebase: reorder validation steps
 + rebase -i: remove now unnecessary directory checks
 + rebase: factor out command line option processing
 + rebase: align variable content
 + rebase: align variable names
 + rebase: stricter check of standalone sub command
 + rebase: act on command line outside parsing loop
 + rebase: improve detection of rebase in progress
 + rebase: remove unused rebase state 'prev_head'
 + rebase: read state outside loop
 + rebase: refactor reading of state
 + rebase: clearer names for directory variables

Minor UI regression was reported but otherwise it looked like that the
topic is in a good shape.

* lp/config-vername-check (2011-02-01) 2 commits
  (merged to 'next' on 2011-02-23 at 426d48d)
 + Disallow empty section and variable names
 + Sanity-check config variable names

* mz/rerere-remaining (2011-02-16) 2 commits
  (merged to 'next' on 2011-02-22 at fa2d5ab)
 + mergetool: don't skip modify/remove conflicts
 + rerere "remaining"

Looked much better than my weatherbaloon patch.

* nd/hash-object-sanity (2011-02-05) 1 commit
  (merged to 'next' on 2011-02-22 at 09acf6f)
 + Make hash-object more robust against malformed objects

* hv/mingw-fs-funnies (2011-02-07) 5 commits
  (merged to 'next' on 2011-02-09 at 3d0bb1a)
 + mingw_rmdir: set errno=3DENOTEMPTY when appropriate
 + mingw: add fallback for rmdir in case directory is in use
 + mingw: make failures to unlink or move raise a question
 + mingw: work around irregular failures of unlink on windows
 + mingw: move unlink wrapper to mingw.c

Rerolled and seems ready to move forward.

* nd/struct-pathspec (2011-01-31) 22 commits
  (merged to 'next' on 2011-02-09 at b1e64ee)
 + t6004: add pathspec globbing test for log family
 + t7810: overlapping pathspecs and depth limit
 + grep: drop pathspec_matches() in favor of tree_entry_interesting()
 + grep: use writable strbuf from caller for grep_tree()
 + grep: use match_pathspec_depth() for cache/worktree grepping
 + grep: convert to use struct pathspec
 + Convert ce_path_match() to use match_pathspec_depth()
 + Convert ce_path_match() to use struct pathspec
 + struct rev_info: convert prune_data to struct pathspec
 + pathspec: add match_pathspec_depth()
 + tree_entry_interesting(): optimize wildcard matching when base is ma=
tched
 + tree_entry_interesting(): support wildcard matching
 + tree_entry_interesting(): fix depth limit with overlapping pathspecs
 + tree_entry_interesting(): support depth limit
 + tree_entry_interesting(): refactor into separate smaller functions
 + diff-tree: convert base+baselen to writable strbuf
 + glossary: define pathspec
 + Move tree_entry_interesting() to tree-walk.c and export it
 + tree_entry_interesting(): remove dependency on struct diff_options
 + Convert struct diff_options to use struct pathspec
 + diff-no-index: use diff_tree_setup_paths()
 + Add struct pathspec
 (this branch is used by en/object-list-with-pathspec and jc/grep--no-i=
ndex-pathspec-fix.)

* en/object-list-with-pathspec (2010-09-20) 2 commits
  (merged to 'next' on 2011-02-09 at ccf6c6a)
 + Add testcases showing how pathspecs are handled with rev-list --obje=
cts
 + Make rev-list --objects work together with pathspecs
 (this branch uses nd/struct-pathspec; is tangled with jc/grep--no-inde=
x-pathspec-fix.)

* uk/checkout-ambiguous-ref (2011-02-15) 5 commits
  (merged to 'next' on 2011-02-15 at 645dad6)
 + Rename t2019 with typo "amiguous" that meant "ambiguous"
 + checkout: rearrange update_refs_for_switch for clarity
 + checkout: introduce --detach synonym for "git checkout foo^{commit}"
 + checkout: split off a function to peel away branchname arg
  (merged to 'next' on 2011-02-03 at 9044724)
 + checkout: fix bug with ambiguous refs

The topic has become about "checkout --detach" ;-).

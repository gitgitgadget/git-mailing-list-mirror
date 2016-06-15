From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2011, #07; Wed, 27)
Date: Wed, 27 Apr 2011 14:18:08 -0700
Message-ID: <7v1v0n75rj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 23:18:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFC7s-0008Id-FF
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 23:18:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab1D0VSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 17:18:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39945 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab1D0VSR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 17:18:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3B0EF481E;
	Wed, 27 Apr 2011 17:20:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Q
	PHzWq9KWa4unlAme5ijohuIaKw=; b=vt3a4958CT3Qcb89gFCq1vrctRdfSk8to
	uagwGPrZny41Px/KlnQ9Da3ws7+2Ns2z9bot6gTbaHiTnPrltUi+oOQDyVsfuWXB
	MorBwRmPgUyePj6RggJrGuIliq22fplXjas7b8Oba4zoDIpNPnSZbQtN9RqRbGOA
	i0gtxwGTzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=VcN
	L+8S68Hh6QL3d3XiciZ1jIBksMIAjLb4IHxarf2AXakog3YdWHvE4GyS60lM3443
	M03Z+Q9rm7o50LvzssQ5za0aULqCoEE/Oy7HuqitAv8o/PN2BULv7hFdxBfelhea
	EdRjxeQIBi/Ji1BjbKFC9acxkyUPtD6dVzSLX/3c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2647C481D;
	Wed, 27 Apr 2011 17:20:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A2FE04817; Wed, 27 Apr 2011
 17:20:13 -0400 (EDT)
X-master-at: e839fe6c1206292aeb4518939b8f124ae5068619
X-next-at: f5ef3c22908b68d63e56ce32f4234438cd775f22
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2550BA04-7114-11E0-A989-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172274>

What's cooking in git.git (Apr 2011, #07; Wed, 27)
--------------------------------------------------

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.

The main part of this cycle is expected to run thru May, aiming for a
feature freeze in early June.  We are in the middle of week #1 of this
cycle and week #2 starts on May 2nd.

--------------------------------------------------
[Graduated to "master"]

* ar/clean-rmdir-empty (2011-04-01) 1 commit
  (merged to 'next' on 2011-04-25 at 5a71fdb)
 + clean: unreadable directory may still be rmdir-able if it is empty

* cn/format-patch-quiet (2011-04-12) 2 commits
  (merged to 'next' on 2011-04-25 at 40e2d1c)
 + format-patch: document --quiet option
 + format-patch: don't pass on the --quiet flag

* dm/color-palette (2011-04-05) 1 commit
  (merged to 'next' on 2011-04-25 at 839b17b)
 + Share color list between graph and show-branch

* dm/stash-k-i-p (2011-04-07) 2 commits
  (merged to 'next' on 2011-04-25 at 01a207c)
 + stash: ensure --no-keep-index and --patch can be used in any order
 + stash: add two more tests for --no-keep-index

* ef/maint-strbuf-init (2011-04-10) 2 commits
  (merged to 'next' on 2011-04-25 at 6a45422)
 + config: support values longer than 1023 bytes
 + strbuf: make sure buffer is zero-terminated

* jc/merge-dash-previous (2011-04-07) 1 commit
  (merged to 'next' on 2011-04-25 at 512faf4)
 + merge: allow "-" as a short-hand for "previous branch"

* jc/pack-objects-bigfile (2011-04-05) 1 commit
  (merged to 'next' on 2011-04-25 at 621035c)
 + Teach core.bigfilethreashold to pack-objects

* jk/maint-stash-oob (2011-04-06) 2 commits
  (merged to 'next' on 2011-04-25 at 8478a92)
 + stash: fix false positive in the invalid ref test.
 + stash: fix accidental apply of non-existent stashes

* jk/maint-upload-pack-shallow (2011-04-06) 1 commit
  (merged to 'next' on 2011-04-25 at 073dac4)
 + upload-pack: start pack-objects before async rev-list

* jk/stash-loosen-safety (2011-04-05) 1 commit
  (merged to 'next' on 2011-04-25 at cdc549f)
 + stash: drop dirty worktree check on apply

* mg/reflog-with-options (2011-04-01) 3 commits
  (merged to 'next' on 2011-04-25 at 1ab8b78)
 + reflog: fix overriding of command line options
 + t/t1411: test reflog with formats
 + builtin/log.c: separate default and setup of cmd_log_init()
 (this branch is used by mg/show-without-prune.)

* mg/sha1-path-advise (2011-03-31) 2 commits
  (merged to 'next' on 2011-04-25 at 8b094f5)
 + sha1_name: Suggest commit:./file for path in subdir
 + t1506: factor out test for "Did you mean..."

* mg/x-years-12-months (2011-04-20) 1 commit
  (merged to 'next' on 2011-04-25 at 74ba83b)
 + date: avoid "X years, 12 months" in relative dates

* mh/git-svn-automkdirs (2011-04-01) 1 commit
  (merged to 'next' on 2011-04-25 at 2e95357)
 + git-svn: add an option to skip the creation of empty directories

* nk/blame-abbrev (2011-04-06) 1 commit
  (merged to 'next' on 2011-04-25 at 59a4281)
 + blame: add --abbrev command line option and make it honor core.abbrev

* rj/sparse (2011-04-07) 7 commits
  (merged to 'next' on 2011-04-25 at e1af2af)
 + sparse: Fix some "symbol not declared" warnings
 + sparse: Fix errors due to missing target-specific variables
 + sparse: Fix an "symbol 'merge_file' not decared" warning
 + sparse: Fix an "symbol 'format_subject' not declared" warning
 + sparse: Fix some "Using plain integer as NULL pointer" warnings
 + sparse: Fix an "symbol 'cmd_index_pack' not declared" warning
 + Makefile: Use cgcc rather than sparse in the check target

* rr/doc-content-type (2011-04-07) 4 commits
  (merged to 'next' on 2011-04-25 at 83c41e4)
 + Documentation: Allow custom diff tools to be specified in 'diff.tool'
 + Documentation: Add diff.<driver>.* to config
 + Documentation: Move diff.<driver>.* from config.txt to diff-config.txt
 + Documentation: Add filter.<driver>.* to config

--------------------------------------------------
[New Topics]

* aw/maint-rebase-i-p-no-ff (2011-04-20) 1 commit
 - git-rebase--interactive.sh: preserve-merges fails on merges created with no-ff

* mg/alias-expose-prefix (2011-04-27) 2 commits
 - handle_alias: provide GIT_PREFIX to !alias
 - t1020: test !alias in subdirectory

* mg/diff-uiconfig-doc (2011-04-27) 1 commit
 - config.txt,diff-options.txt: porcelain vs. plumbing for color.diff

With tentative rewording.

* ld/p4-preserve-user-names (2011-04-21) 1 commit
 - git-p4: add option to preserve user names

Pete acked and told Luke to wait and then resend; I just picked it up so
that the patch is not lost.

* mg/rev-list-count-cherry (2011-04-26) 1 commit
  (merged to 'next' on 2011-04-26 at dc3e80a)
 + rev-list --count: separate count for --cherry-mark

Will merge to "master" by the end of week #2.

* ft/gitweb-tar-with-gzip-n (2011-04-26) 1 commit
  (merged to 'next' on 2011-04-26 at 8e59a0e)
 + gitweb: supply '-n' to gzip for identical output

Will merge to "master" by the end of week #2.

* ml/test-readme (2011-04-26) 1 commit
  (merged to 'next' on 2011-04-26 at d1efe84)
 + t/README: unify documentation of test function args

Will merge to "master" by the end of week #2.

* sp/maint-clear-postfields (2011-04-26) 1 commit
  (merged to 'next' on 2011-04-26 at 0082503)
 + http: clear POSTFIELDS when initializing a slot

Fixes a rather nasty bug we had since the beginning of smart-HTTP
but has become a lot easier to trigger since 1.7.5, introducing a
regression.

Will merge to "master" by the end of week #1.

* jk/format-patch-quote-special-in-from (2011-04-08) 1 commit
 - pretty: quote rfc822 specials in email addresses

Will merge to "next".

* rs/strbuf-setlen-assert (2011-04-27) 1 commit
 - strbuf: clarify assertion in strbuf_setlen()

Will merge to "next".

* jh/dirstat-lines (2011-04-27) 7 commits
 - diff --dirstat: tighten and clean-up parsing.
 - New --dirstat=lines mode, doing dirstat analysis based on diffstat
 - Allow specifying --dirstat cut-off percentage as a floating point number
 - Add config variable for specifying default --dirstat behavior
 - Refactor --dirstat parsing; deprecate --cumulative and --dirstat-by-file
 - Make --dirstat=0 output directories that contribute < 0.1% of changes
 - Add several testcases for --dirstat and friends
 (this branch uses jh/dirstat.)

This is v3/v4 that is still being discussed.

--------------------------------------------------
[Stalled]

* jn/gitweb-js (2011-04-15) 13 commits
 - gitweb: Make JavaScript ability to adjust timezones configurable
 - gitweb.js: Add UI for selecting common timezone to display dates
 - gitweb: JavaScript ability to adjust time based on timezone
 - gitweb: Unify the way long timestamp is displayed
 - gitweb: Refactor generating of long dates into format_timestamp_html
 - gitweb.js: Provide getElementsByClassName method (if it not exists)
 - gitweb.js: Introduce gitweb/static/js/lib/cookies.js
 - gitweb.js: Extract and improve datetime handling
 - gitweb.js: Provide default values for padding in padLeftStr and padLeft
 - gitweb.js: Update and improve comments in JavaScript files
 - gitweb: Split JavaScript for maintability, combining on build
 - Remove gitweb/gitweb.cgi and other legacy targets from main Makefile
 - git-instaweb: Simplify build dependency on gitweb

I do not recall seeing this series much reviewed. Is everybody happy with
this series?

* jk/maint-merge-rename-create (2011-03-25) 3 commits
 - merge: turn on rewrite detection
 - merge: handle renames with replacement content
 - t3030: fix accidental success in symlink rename

Peff wanted to reroll this, so this is taken out of "next".

* dm/http-cleanup (2011-03-30) 2 commits
 - http-push: refactor curl_easy_setup madness
 - http: make curl callbacks match contracts from curl header

The second one will probably need re-rolling after
sp/maint-clear-postfields settles.

* rr/rerere-clear-libify (2011-04-13) 1 commit
 - rerere: Expose an API corresponding to 'clear' functionality

Jonathan had good comments on moving the garbage collection interface as
well. Perhaps needs a re-roll.

* jc/maint-add-p-overlapping-hunks (2011-04-06) 2 commits
 - "add -p": work-around an old laziness that does not coalesce hunks
 - add--interactive.perl: factor out repeated --recount option

This came from http://thread.gmane.org/gmane.comp.version-control.git/170685/focus=171000;
we may want to add tests before moving it forward.

* mg/show-without-prune (2011-04-01) 1 commit
 - builtin/show: do not prune by pathspec

I wanted to like this, but it still feels like too much magic.  Will drop
and wait for the topic to resurface.

* gr/cvsimport-alternative-cvspass-location (2011-02-18) 1 commit
 - Look for password in both CVS and CVSNT password files.

It seems that we need separate parsers for these two formats in order not
to regress the users of the original cvs.

* jc/index-pack (2011-02-25) 5 commits
 - index-pack --verify: read anomalous offsets from v2 idx file
 - write_idx_file: need_large_offset() helper function
 - index-pack: --verify
 - write_idx_file: introduce a struct to hold idx customization options
 - index-pack: group the delta-base array entries also by type

Still a WIP. Need to put histogram output into index-pack --verify to
really kill verify-pack.

* jk/tag-contains (2010-07-05) 4 commits
 - Why is "git tag --contains" so slow?
 - default core.clockskew variable to one day
 - limit "contains" traversals based on commit timestamp
 - tag: speed up --contains calculation

The idea of the bottom one is probably Ok, except that the use of object
flags needs to be rethought, or at least the helper needs to be moved to
builtin/tag.c to make it clear that it should not be used outside the
current usage context.

--------------------------------------------------
[Cooking]

* jn/setup-revisions-glob-and-friends-passthru (2011-04-21) 2 commits
 - revisions: allow --glob and friends in parse_options-enabled commands
 - revisions: split out handle_revision_pseudo_opt function

Will merge to "next".

* cn/log-parse-opt (2011-04-14) 1 commit
 - log: convert to parse-options

Will merge to "next".

* jc/fix-add-u-unmerged (2011-04-20) 1 commit
 - Fix "add -u" that sometimes fails to resolve unmerged paths
 (this branch uses jc/fix-diff-files-unmerged.)

Will merge to "next".

* jc/fix-diff-files-unmerged (2011-04-22) 4 commits
 - diff-files: show unmerged entries correctly
 - diff: remove often unused parameters from diff_unmerge()
 - diff.c: return filepair from diff_unmerge()
 - test: use $_z40 from test-lib
 (this branch is used by jc/fix-add-u-unmerged.)

Will merge to "next".

* js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix (2011-04-25) 1 commit
 - send-pack: avoid deadlock when pack-object dies early
 (this branch is used by js/maint-send-pack-stateless-rpc-deadlock-fix.)

* js/maint-send-pack-stateless-rpc-deadlock-fix (2011-04-25) 1 commit
 - Merge branch 'js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix' into js/maint-send-pack-stateless-rpc-deadlock-fix
 (this branch uses js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix.)

Will merge to "next".

* vh/git-svn-doc (2011-04-26) 3 commits
 - git-svn.txt: small typeface improvements
 - git-svn.txt: move option descriptions
 - git-svn.txt: fix usage of --add-author-from

Will merge to "next".

* jk/format-patch-multiline-header (2011-04-14) 1 commit
  (merged to 'next' on 2011-04-26 at 3d5eda3)
 + format-patch: wrap email addresses after long names

Will merge to "master" by the end of week #2.

* jn/maint-format-patch-doc (2011-04-14) 1 commit
  (merged to 'next' on 2011-04-26 at 400cf42)
 + Documentation: describe the format of messages with inline patches
 (this branch is used by jn/format-patch-doc.)

Will merge to "master" by the end of week #2.

* jn/format-patch-doc (2011-04-18) 6 commits
  (merged to 'next' on 2011-04-26 at 3f64325)
 + Documentation/format-patch: suggest Toggle Word Wrap add-on for Thunderbird
 + Documentation: publicize hints for sending patches with GMail
 + Documentation: publicize KMail hints for sending patches inline
 + Documentation: hints for sending patches inline with Thunderbird
 + Documentation: explain how to check for patch corruption
 + Merge v1.7.5-rc2 into jn/format-patch-doc
 (this branch uses jn/maint-format-patch-doc.)

Will merge to "master" by the end of week #2.

* jn/run-command-error-failure (2011-04-20) 2 commits
  (merged to 'next' on 2011-04-26 at a1f171e)
 + run-command: handle short writes and EINTR in die_child
 + tests: check error message from run_command

Will merge to "master" by the end of week #2.

* ss/cherry-pick-x-doc (2011-04-15) 1 commit
  (merged to 'next' on 2011-04-26 at c9a6f83)
 + doc: Clarify that "cherry-pick -x" does not use "git notes"

Will merge to "master" by the end of week #2.

* ss/doc-svn (2011-04-19) 1 commit
  (merged to 'next' on 2011-04-26 at a723b91)
 + remove noise and inaccuracies from git-svn docs

Will merge to "master" by the end of week #2.

* vr/merge-base-doc (2011-04-15) 2 commits
  (merged to 'next' on 2011-04-26 at e906ba3)
 + Restructure documentation for git-merge-base.
 + Documentation: update to git-merge-base --octopus

Will merge to "master" by the end of week #2.

* jh/dirstat (2011-04-12) 4 commits
  (merged to 'next' on 2011-04-25 at cb277e6)
 + --dirstat: In case of renames, use target filename instead of source filename
 + Teach --dirstat not to completely ignore rearranged lines within a file
 + --dirstat-by-file: Make it faster and more correct
 + --dirstat: Describe non-obvious differences relative to --stat or regular diff
 (this branch is used by jh/dirstat-lines.)

Will merge to "master" by the end of week #1.

* jm/mergetool-submodules (2011-04-13) 1 commit
  (merged to 'next' on 2011-04-26 at 40892cf)
 + mergetool: Teach about submodules

Will merge to "master" by the end of week #2.

* ab/i18n-fixup (2011-04-14) 24 commits
  (merged to 'next' on 2011-04-25 at 32fef07)
 + i18n: use test_i18n{cmp,grep} in t7600, t7607, t7611 and t7811
 + i18n: use test_i18n{grep,cmp} in t7508
 + i18n: use test_i18ngrep in t7506
 + i18n: use test_i18ngrep and test_i18ncmp in t7502
 + i18n: use test_i18ngrep in t7501
 + i18n: use test_i18ncmp in t7500
 + i18n: use test_i18ngrep in t7201
 + i18n: use test_i18ncmp and test_i18ngrep in t7102 and t7110
 + i18n: use test_i18ncmp and test_i18ngrep in t5541, t6040, t6120, t7004, t7012 and t7060
 + i18n: use test_i18ncmp and test_i18ngrep in t3700, t4001 and t4014
 + i18n: use test_i18ncmp and test_i18ngrep in t3203, t3501 and t3507
 + i18n: use test_i18ngrep in t2020, t2204, t3030, and t3200
 + i18n: use test_i18ngrep in lib-httpd and t2019
 + i18n: do not overuse C_LOCALE_OUTPUT (grep)
 + i18n: use test_i18ncmp in t1200 and t2200
 + i18n: .git file is not a human readable message (t5601)
 + i18n: do not overuse C_LOCALE_OUTPUT
 + i18n: mark init-db messages for translation
 + i18n: mark checkout plural warning for translation
 + i18n: mark checkout --detach messages for translation
 + i18n: mark clone nonexistent repository message for translation
 + i18n: mark merge CHERRY_PICK_HEAD messages for translation
 + i18n: mark merge "upstream" messages for translation
 + i18n: mark merge "Could not read from" message for translation

Will merge to "master" by the end of week #2.

* nm/submodule-update-force (2011-04-01) 1 commit
  (merged to 'next' on 2011-04-25 at 270fffc)
 + submodule: Add --force option for git submodule update

Will merge to "master" by the end of week #2.

* jc/diff-irreversible-delete (2011-02-28) 1 commit
  (merged to 'next' on 2011-04-25 at c37610d)
 + git diff -D: omit the preimage of deletes

Will merge to "master" by the end of week #2.

* jh/notes-add-ui (2011-03-30) 1 commit
  (merged to 'next' on 2011-04-25 at 4fb1ac2)
 + Make "git notes add" more user-friendly when there are existing notes

Will merge to "master" by the end of week #2.

* jk/notes-ui-updates (2011-04-14) 8 commits
  (merged to 'next' on 2011-04-25 at 4216d33)
 + contrib/completion: --notes, --no-notes
 + log/pretty-options: Document --[no-]notes and deprecate old notes options
 + revision.c: make --no-notes reset --notes list
 + revision.c: support --notes command-line option
 + notes: refactor display notes default handling
 + notes: refactor display notes extra refs field
 + revision.c: refactor notes ref expansion
 + notes: make expand_notes_ref globally accessible

Will merge to "master" by the end of week #2.

* nd/maint-setup (2011-03-26) 2 commits
  (merged to 'next' on 2011-04-25 at fd45c63)
 + Kill off get_relative_cwd()
 + setup: return correct prefix if worktree is '/'

Will merge to "master" by the end of week #2.

* mz/rebase (2011-02-28) 34 commits
  (merged to 'next' on 2011-04-25 at 4bbed46)
 + rebase: define options in OPTIONS_SPEC
 + Makefile: do not install sourced rebase scripts
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

Will merge to "master" by the end of week #2.

* mz/maint-rename-unmerged (2011-03-23) 1 commit
  (merged to 'next' on 2011-04-25 at 038a8c3)
 + diffcore-rename: don't consider unmerged path as source

Will merge to "master" by the end of week #2.

* nd/struct-pathspec (2011-04-05) 5 commits
  (merged to 'next' on 2011-04-25 at 65dbe80)
 + pathspec: rename per-item field has_wildcard to use_wildcard
 + Improve tree_entry_interesting() handling code
 + Convert read_tree{,_recursive} to support struct pathspec
 + Reimplement read_tree_recursive() using tree_entry_interesting()
 + Merge branch 'en/object-list-with-pathspec' into 'nd/struct-pathspec'

Will merge to "master" by the end of week #2.

* jc/magic-pathspec (2011-04-06) 3 commits
  (merged to 'next' on 2011-04-25 at 788cd46)
 + magic pathspec: add ":(icase)path" to match case insensitively
 + magic pathspec: futureproof shorthand form
 + magic pathspec: add tentative ":/path/from/top/level" pathspec support

Thanks to Peff, Duy, and Michael for helping to whip the syntax and the
basic semantics into a not-so-horrible shape.

Will merge to "master" by the end of week #2.

* jc/rename-degrade-cc-to-c (2011-01-06) 4 commits
  (merged to 'next' on 2011-04-25 at 25c195e)
 + diffcore-rename: fall back to -C when -C -C busts the rename limit
 + diffcore-rename: record filepair for rename src
 + diffcore-rename: refactor "too many candidates" logic
 + builtin/diff.c: remove duplicated call to diff_result_code()

Will merge to "master" by the end of week #2.

* en/merge-recursive (2011-03-17) 4 commits
  (merged to 'next' on 2011-04-25 at 8027acd)
 + merge-recursive: tweak magic band-aid
 + merge-recursive: When we detect we can skip an update, actually skip it
 + t6022: New test checking for unnecessary updates of files in D/F conflicts
 + t6022: New test checking for unnecessary updates of renamed+modified files

Will merge to "master" by the end of week #2.

--------------------------------------------------
[Discarded]

* jk/maint-push-async-hang (2011-03-31) 4 commits
 . send-pack: abort sideband demuxer on pack-objects error
 . run-command: allow aborting async code prematurely
 . finish_async: be quiet when waiting for async process
 . teach wait_or_whine a "quiet" mode
 (this branch is used by jk/maint-push-async-hang-threads.)

* jk/maint-push-async-hang-threads (2011-03-31) 2 commits
 . run-command: implement abort_async for pthreads
 . Merge branch 'jk/maint-push-async-hang' into jk/maint-push-async-hang-threads
 (this branch uses jk/maint-push-async-hang.)

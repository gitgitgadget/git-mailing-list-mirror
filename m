From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2010, #02; Fri, 7)
Date: Fri, 07 May 2010 22:45:35 -0700
Message-ID: <7vy6fvaqv4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 07:45:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAcrE-0002FR-Kt
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 07:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367Ab0EHFpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 01:45:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab0EHFpk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 01:45:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 324EBB1E9B;
	Sat,  8 May 2010 01:45:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=yszM
	6facBhh9RXyy9hj5KAxlkME=; b=t3fV0JcVSObNv3zRB28j+vtlNSK3xeGmjSTp
	+C9kNJDg5Y/m31cYGOI4kJ7dQmOJZdhugoPYffGzcMwWPCT14vtXIwRAq1Dzn787
	Jh/usaaoXzSvpi27Hu4vsSwHU6dIcpoz+GVVfrxzSwSSKkBECLYGY9yGwHBcjftb
	VDhMmEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=MGE
	ufKsEpqRHgdDoNlaSbldWo8McwUJ/tXYQbe67lW3s0zpy/pn7NswG7BQ+YVzysv5
	dKv4dg99ItYA4Tk4vQq0s6l//rZeKiHewQYw4FHoppfZltI4ISp9FEAnGGSYQftD
	pmz1gGGchTXzWU/yk7QML6jHgumsqbf5q1lR8KVo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1903EB1E9A;
	Sat,  8 May 2010 01:45:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0ADCDB1E99; Sat,  8 May
 2010 01:45:36 -0400 (EDT)
X-master-at: cfb88e9a8d4926b0011ae2dd67e1f57a98f4b768
X-next-at: 703bdcf9e5ad91e669ce4c834d8d17a47c9e720e
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EE9A74DA-5A64-11DF-B182-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146644>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

I'm in the middle of physically moving and haven't started graduating the
topics that have been cooking in 'next'.  Perhaps I can find time to do so
for some of them over the weekend.  I expect that I won't be back up to
speed until later this month.

--------------------------------------------------
[New Topics]

* jn/gitweb-syntax-highlight (2010-04-27) 2 commits
 - gitweb: Refactor syntax highlighting support
 - gitweb: Syntax highlighting support

* jn/maint-amend-missing-name (2010-05-02) 1 commit
 - commit --amend: cope with missing display name

* rs/diff-no-minimal (2010-05-02) 1 commit
 - git diff too slow for a file

* ab/test-cleanup (2010-05-07) 2 commits
 - Turn setup code in t2007-checkout-symlink.sh into a test
 - Move t6000lib.sh to lib-*

* by/blame-doc-m-c (2010-05-06) 1 commit
 - blame-options.txt: Add default value for `-M/-C` options.

* by/log-follow (2010-05-06) 3 commits
 - Make git log --follow find copies among unmodified files.
 - Make diffcore_std only can run once before a diff_flush
 - Add a macro DIFF_QUEUE_CLEAR.

* eb/crlf (2010-05-07) 3 commits
 - Add per-repository eol normalization
 - Add tests for per-repository eol normalization
 - Add "auto-eol" attribute and "core.eolStyle" config variable

* jn/notes-doc (2010-05-03) 4 commits
 - Documentation/notes: nitpicks
 - Documentation/notes: describe content of notes
 - Documentation/notes: adjust description to use configuration section
 - Documentation/notes: describe effect of environment and configuration

* mg/advice-statushints (2010-04-22) 2 commits
 - wt-status: take advice.statusHints seriously
 - t7508: test advice.statusHints

--------------------------------------------------
[Graduated to "master"]

* jc/doc-submit-gmail (2010-04-07) 1 commit
  (merged to 'next' on 2010-04-10 at cd4e8cf)
 + SubmittingPatches: update GMail section

* jg/auto-initialize-notes-with-percent-n-in-format (2010-04-13) 1 commit
 + pretty: Initialize notes if %N is used

* jk/maint-diffstat-overflow (2010-04-17) 1 commit
 + diff: use large integers for diffstat calculations

* rr/remote-helper-doc (2010-04-07) 3 commits
 + Documentation/remote-helpers: Add invocation section
 + Documentation/urls: Rewrite to accomodate <transport>::<address>
 + Documentation/remote-helpers: Rewrite description

* wp/doc-filter-direction (2010-04-17) 1 commit
 + documentation: clarify direction of core.autocrlf

These were pushed out as part of 1.7.1

--------------------------------------------------
[Stalled]

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

* js/grep-open (2010-05-01) 3 commits
 - grep: do not ignore return value from chdir()
 - grep -O: allow optional argument specifying the pager (or editor)
 - grep: Add the option '--open-files-in-pager'
 (this branch is used by jp/hold-string-list-sanity.)

Probably needs to support --no-index mode as well.

* jp/hold-string-list-sanity (2010-04-06) 9 commits
 . string_list: Fix argument order for string_list_append
 . Merge branch 'sr/remote-helper-export' into HEAD
 . Merge branch 'js/grep-open' into HEAD
 . Merge branch 'sb/fmt-merge-msg' into HEAD
 . string_list: Fix argument order for string_list_lookup
 . string_list: Fix argument order for string_list_insert_at_index
 . string_list: Fix argument order for string_list_insert
 . string_list: Fix argument order for for_each_string_list
 . string_list: Fix argument order for print_string_list
 (this branch uses js/grep-open and sr/remote-helper-export.)

Building this on top of slushy codebase is not a very promising endeavor.
Good thing to do, but it came at a bad time.

--------------------------------------------------
[Cooking]

* cb/maint-stash-orphaned-file (2010-04-18) 2 commits
  (merged to 'next' on 2010-05-04 at 38488ba)
 + stash tests: stash can lose data in a file removed from the index
 + stash: Don't overwrite files that have gone from the index

(was in 'next' on 2010-04-22)

* jn/maint-bundle (2010-04-19) 2 commits
  (merged to 'next' on 2010-05-04 at f2086f5)
 + fix "bundle --stdin" segfault
 + t5704 (bundle): add tests for bundle --stdin

(was in 'next' on 2010-04-22)

* pb/patch-id-plus (2010-04-19) 2 commits
  (merged to 'next' on 2010-05-04 at 59881b8)
 + patch-id: Add support for mbox format
 + patch-id: extract parsing one diff out of generate_id_list

(was in 'next' on 2010-04-22)

* rr/doc-submitting (2010-04-19) 1 commit
  (merged to 'next' on 2010-05-04 at 5f040bd)
 + SubmittingPatches: Add new section about what to base work on

(was in 'next' on 2010-04-22)

* st/remote-tags-no-tags (2010-04-20) 2 commits
 - remote add: add a --[no-]tags option
 - Honor "tagopt = --tags" configuration option

* jc/rev-list-ancestry-path (2010-04-20) 1 commit
 - revision: --ancestry-path

Just an illustration patch.  merge simplification logic used when
pathspecs are in effect interacts with this rather badly.

* cb/assume-unchanged-fix (2010-05-01) 2 commits
 - Documentation: git-add does not update files marked "assume unchanged"
 - do not overwrite files marked "assume unchanged"

* jn/fsck-ident (2010-04-24) 1 commit
 - fsck: check ident lines in commit objects

There also was a companion patch to fast-import to deal with foreign SCM
interface that may not have human-readable author identifier.

* jn/gitweb-caching-prep (2010-04-24) 5 commits
 - gitweb: Move generating page title to separate subroutine
 - gitweb: Add custom error handler using die_error
 - gitweb: Use nonlocal jump instead of 'exit' in die_error
 - gitweb: href(..., -path_info => 0|1)
 - Export more test-related variables when running external tests

* jn/gitweb-install (2010-05-01) 2 commits
 - gitweb: Create install target for gitweb in Makefile
 - gitweb: Improve installation instructions in gitweb/INSTALL

* jn/gitweb-our-squelch (2010-04-30) 1 commit
 - gitweb: Silence 'Variable VAR may be unavailable' warnings

* jn/maint-request-pull (2010-05-07) 3 commits
 - t5150: protect backslash with backslash in shell
 - request-pull: protect against OPTIONS_KEEPDASHDASH from environment
 - tests for request-pull
 (this branch is used by jn/request-pull.)

* jn/request-pull (2010-04-24) 2 commits
 - adapt request-pull tests for new pull request format
 - Merge branch 'jn/maint-request-pull' into jn/request-pull
 (this branch uses jn/maint-request-pull.)

* jn/shortlog (2010-05-03) 5 commits
 - pretty: Respect --abbrev option
 - shortlog: Document and test --format option
 - t4201 (shortlog): Test output format with multiple authors
 - t4201 (shortlog): guard setup with test_expect_success
 - Documentation/shortlog: scripted users should not rely on implicit HEAD

* wp/pretty-enhancement (2010-05-02) 3 commits
 - pretty: add aliases for pretty formats
 - pretty: add infrastructure for commit format aliases
 - pretty: make it easier to add new formats

* jn/t7006-fixup (2010-04-14) 1 commit
  (merged to 'next' on 2010-05-04 at 490ab5d)
 + t7006: guard cleanup with test_expect_success

(was in 'next' on 2010-04-22)

* js/maint-receive-pack-symref-alias (2010-04-19) 3 commits
  (merged to 'next' on 2010-05-04 at 259f4f1)
 + t5516-fetch-push.sh: style cleanup
 + receive-pack: detect aliased updates which can occur with symrefs
 + receive-pack: switch global variable 'commands' to a parameter

(was in 'next' on 2010-04-22)

* sp/maint-dumb-http-pack-reidx (2010-04-19) 12 commits
  (merged to 'next' on 2010-05-04 at 166443a)
 + http.c::new_http_pack_request: do away with the temp variable filename
 + http-fetch: Use temporary files for pack-*.idx until verified
 + http-fetch: Use index-pack rather than verify-pack to check packs
 + Allow parse_pack_index on temporary files
 + Extract verify_pack_index for reuse from verify_pack
 + Introduce close_pack_index to permit replacement
 + http.c: Remove unnecessary strdup of sha1_to_hex result
 + http.c: Don't store destination name in request structures
 + http.c: Drop useless != NULL test in finish_http_pack_request
 + http.c: Tiny refactoring of finish_http_pack_request
 + t5550-http-fetch: Use subshell for repository operations
 + http.c: Remove bad free of static block

(was in 'next' on 2010-04-22)

* hg/id-munging (2010-04-06) 2 commits
 - convert: Keep foreign $Id$ on checkout.
 - convert: Safer handling of $Id$ contraction.

* jn/submodule-basic-test (2010-04-10) 3 commits
  (merged to 'next' on 2010-05-04 at 0bec27a)
 + t7400: clarify submodule update tests
 + t7400: clarify 'submodule add' tests
 + t7400: split setup into multiple tests

(was in 'next' on 2010-04-22)

* np/index-pack-memsave (2010-04-12) 3 commits
  (merged to 'next' on 2010-05-04 at 366b014)
 + index-pack: smarter memory usage when appending objects
 + index-pack: rationalize unpack_entry_data()
 + index-pack: smarter memory usage when resolving deltas

(was in 'next' on 2010-04-22)

* jc/am-3-show-corrupted-patch (2010-04-09) 1 commit
  (merged to 'next' on 2010-05-04 at 951f0e6)
 + am -3: recover the diagnostic messages for corrupt patches

(was in 'next' on 2010-04-22)

* jc/maint-no-reflog-expire-unreach-for-head (2010-04-09) 3 commits
  (merged to 'next' on 2010-05-04 at d23a180)
 + reflog --expire-unreachable: special case entries in "HEAD" reflog
 + more war on "sleep" in tests
 + Document gc.<pattern>.reflogexpire variables
 (this branch uses jc/maint-reflog-expire-unreachable.)

(was in 'next' on 2010-04-22)

* cw/maint-exec-defpath (2010-04-15) 2 commits
  (merged to 'next' on 2010-05-04 at 8d1591f)
 + autoconf: Check if <paths.h> exists and set HAVE_PATHS_H
 + exec_cmd.c: replace hard-coded path list with one from <paths.h>

(was in 'next' on 2010-04-22)

* tr/word-diff (2010-04-14) 1 commit
  (merged to 'next' on 2010-05-04 at d191b25)
 + diff: add --word-diff option that generalizes --color-words

(was in 'next' on 2010-04-22)
There are gitk patches that go with this series.

* sp/maint-describe-tiebreak-with-tagger-date (2010-04-12) 5 commits
  (merged to 'next' on 2010-05-04 at af2d605)
 + describe: Break annotated tag ties by tagger date
 + tag.c: Parse tagger date (if present)
 + tag.c: Refactor parse_tag_buffer to be saner to program
 + tag.h: Remove unused signature field
 + tag.c: Correct indentation

(was in 'next' on 2010-04-22)

* bg/apply-blank-trailing-context (2010-04-08) 1 commit
  (merged to 'next' on 2010-05-04 at 31f3482)
 + apply: Allow blank *trailing* context lines to match beyond EOF

(was in 'next' on 2010-04-14)

* bg/send-email-smtpdomain (2010-04-10) 4 commits
  (merged to 'next' on 2010-05-04 at 2afbe2c)
 + send-email: Cleanup smtp-domain and add config
 + Document send-email --smtp-domain
 + send-email: Don't use FQDNs without a '.'
 + send-email: Cleanup { style

(was in 'next' on 2010-04-14)

* rc/ls-remote-default (2010-04-09) 1 commit
  (merged to 'next' on 2010-05-04 at 2af33e1)
 + ls-remote: fall-back to default remotes when no remote specified

(was in 'next' on 2010-04-14)

* rc/maint-curl-helper (2010-04-08) 3 commits
  (merged to 'next' on 2010-05-04 at c32988d)
 + remote-curl: ensure that URLs have a trailing slash
 + http: make end_url_with_slash() public
 + t5541-http-push: add test for URLs with trailing slash

(was in 'next' on 2010-04-14)

* hg/maint-attr-fix (2010-04-06) 3 commits
  (merged to 'next' on 2010-05-04 at 8b98845)
 + attr: Expand macros immediately when encountered.
 + attr: Allow multiple changes to an attribute on the same line.
 + attr: Fixed debug output for macro expansion.

(was in 'next' on 2010-04-14)

* jc/status-show-ignored (2010-05-01) 6 commits
  (merged to 'next' on 2010-05-04 at 8b32120)
 + wt-status: fix 'fprintf' compilation warning
 + status: --ignored option shows ignored files
 + wt-status: rename and restructure status-print-untracked
 + wt-status: collect ignored files
 + wt-status: plug memory leak while collecting untracked files
 + wt-status: remove unused workdir_untracked member

(was in 'next' on 2010-05-01)

I am negative about conflating the JSON output to the mix at this point.
Let's stabilize "status" with the existing --porcelain/-z option first.

* eb/unpretty-b-format (2010-03-24) 1 commit
  (merged to 'next' on 2010-05-04 at a466ed8)
 + Add `%B' in format strings for raw commit body in `git log' and friends

(was in 'next' on 2010-04-07)

* ab/commit-empty-message (2010-04-06) 1 commit
  (merged to 'next' on 2010-05-04 at 54c2e47)
 + Add option to git-commit to allow empty log messages

(was in 'next' on 2010-04-07)

* jc/test-sleepless (2010-04-06) 1 commit
  (merged to 'next' on 2010-05-04 at 9ff84b0)
 + war on "sleep" in tests

(was in 'next' on 2010-04-07)

* jc/maint-reflog-expire-unreachable (2010-04-07) 1 commit
  (merged to 'next' on 2010-05-04 at 4efe837)
 + reflog --expire-unreachable: avoid merge-base computation
 (this branch is used by jc/maint-no-reflog-expire-unreach-for-head.)

(was in 'next' on 2010-04-22)

* np/malloc-threading (2010-04-08) 2 commits
  (merged to 'next' on 2010-05-04 at 1b0567f)
 + Thread-safe xmalloc and xrealloc needs a recursive mutex
 + Make xmalloc and xrealloc thread-safe

(was in 'next' on 2010-04-10)

The fix should eventually go to 'maint' and 'master'.

* js/async-thread (2010-03-09) 7 commits
 - Enable threaded async procedures whenever pthreads is available
  (merged to 'next' on 2010-05-04 at 2644e74)
 + Dying in an async procedure should only exit the thread, not the process.
 + Reimplement async procedures using pthreads
 + Windows: more pthreads functions
 + Fix signature of fcntl() compatibility dummy
 + Make report() from usage.c public as vreportf() and use it.
 + Modernize t5530-upload-pack-error.

(all except for the tip was in 'next' on 2010-03-20).

* sd/log-decorate (2010-04-08) 6 commits
  (merged to 'next' on 2010-05-04 at 6e54ae9)
 + log.decorate: only ignore it under "log --pretty=raw"
 + script with rev-list instead of log
 + log --pretty/--oneline: ignore log.decorate
 + log.decorate: usability fixes
 + Add `log.decorate' configuration variable.
 + git_config_maybe_bool()

(was in 'next' on 2010-04-08)

* mh/status-optionally-refresh (2010-04-03) 3 commits
  (merged to 'next' on 2010-05-04 at be164f0)
 + t7508: add a test for "git status" in a read-only repository
 + git status: refresh the index if possible
 + t7508: add test for "git status" refreshing the index

(was in 'next' on 2010-04-05)

* cw/ws-indent-with-tab (2010-04-03) 6 commits
  (merged to 'next' on 2010-05-04 at 1d7aca4)
 + whitespace: tests for git-apply --whitespace=fix with tab-in-indent
 + whitespace: add tab-in-indent support for --whitespace=fix
 + whitespace: replumb ws_fix_copy to take a strbuf *dst instead of char *dst
 + whitespace: tests for git-diff --check with tab-in-indent error class
 + whitespace: add tab-in-indent error class
 + whitespace: we cannot "catch all errors known to git" anymore

(was in 'next' on 2010-04-05)

* sr/remote-helper-export (2010-04-12) 9 commits
  (merged to 'next' on 2010-05-04 at 519ab16)
 + t5800: testgit helper requires Python support
 + Makefile: Simplify handling of python scripts
 + remote-helpers: add tests for testgit helper
 + remote-helpers: add testgit helper
 + remote-helpers: add support for an export command
 + remote-helpers: allow requesing the path to the .git directory
 + fast-import: always create marks_file directories
 + clone: also configure url for bare clones
 + clone: pass the remote name to remote_get
 (this branch is used by jp/hold-string-list-sanity.)

(was in 'next' on 2010-04-12)

* cc/revert-strategy (2010-03-31) 5 commits
  (merged to 'next' on 2010-05-04 at 6d44a83)
 + revert: add "--strategy" option to choose merge strategy
 + merge: make function try_merge_command non static
 + merge: refactor code that calls "git merge-STRATEGY"
 + revert: refactor merge recursive code into its own function
 + revert: use strbuf to refactor the code that writes the merge message

(was in 'next' on 2010-04-05)

* sc/http-late-auth (2010-04-01) 1 commit
  (merged to 'next' on 2010-05-04 at 23ae2e8)
 + Prompt for a username when an HTTP request 401s

(was in 'next' on 2010-04-02)

* jk/cached-textconv (2010-04-01) 5 commits
  (merged to 'next' on 2010-05-04 at e4b72a0)
 + diff: avoid useless filespec population
 + diff: cache textconv output
 + textconv: refactor calls to run_textconv
 + introduce notes-cache interface
 + make commit_tree a library function

(was in 'next' on 2010-04-02)

* ld/discovery-limit-to-fs (2010-04-04) 6 commits
 - write-index: check and warn when worktree crosses a filesystem boundary
  (merged to 'next' on 2010-05-04 at b7118ad)
 + Rename ONE_FILESYSTEM to DISCOVERY_ACROSS_FILESYSTEM
 + GIT_ONE_FILESYSTEM: flip the default to stop at filesystem boundaries
 + Add support for GIT_ONE_FILESYSTEM
 + truncate cwd string before printing error message
 + config.c: remove static keyword from git_env_bool()

(all except for the tip was in 'next' on 2010-04-07)

The tip one is a bit iffy.

* pc/remove-warn (2010-03-26) 4 commits
  (merged to 'next' on 2010-05-04 at c79c1e6)
 + Remove a redundant errno test in a usage of remove_path
 + Introduce remove_or_warn function
 + Implement the rmdir_or_warn function
 + Generalise the unlink_or_warn function

(was in 'next' on 2010-04-02)

* em/checkout-orphan (2010-03-21) 1 commit
  (merged to 'next' on 2010-05-04 at ddb45fc)
 + git checkout: create unparented branch by --orphan

(was in 'next' on 2010-03-28)

Perhaps needs a bit of documentation updates, describing the "going open
source" scenario.

* ar/config-from-command-line (2010-03-26) 2 commits
  (merged to 'next' on 2010-05-04 at 2962717)
 + Use strbufs instead of open-coded string manipulation
 + Allow passing of configuration parameters in the command line

(was in 'next' on 2010-04-07)

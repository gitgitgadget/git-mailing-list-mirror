From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Apr 2010, #04; Sat, 10)
Date: Sat, 10 Apr 2010 20:55:13 -0700
Message-ID: <7vr5mmr6ce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 11 05:55:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0oGp-0006da-Ex
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 05:55:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130Ab0DKDzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 23:55:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56197 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab0DKDzU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 23:55:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 644AAA9119;
	Sat, 10 Apr 2010 23:55:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=1CEZ
	007EI5TjM0VZPHrhW7y1SQ0=; b=WMewnbwLl6PoWFCMIHwB8RkzFLYaoJJbsEW5
	9Y7AtqcBwYgCt8lruarRQY4eEB2XJO7ZGbGuWM/1Hti4LKt9PXiXcn4hzRExSf/7
	jJr7jMPmZerlHrpnhTDEd4dAbWJ9jMWi2mJRFCsRrXgRcD1qULOI5+ld49/lkiWC
	VSUrJPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=yKn
	/SjcQKF4dDDZSkb3tDg73/RaGDK3Edugf/vJv/OKV1bTWWAz4kgO4QjFpVJCryN8
	m/O02yVcn1cJIM3oG6txaF0NwaDO47vOc946kO+U/7/DTl13N/u4N9FZAh6qggAK
	74+95Ic/UqB2hbGttC3oRwkm5LJ9dqPDyWitvmu8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F705A9117;
	Sat, 10 Apr 2010 23:55:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2E7DDA9115; Sat, 10 Apr
 2010 23:55:15 -0400 (EDT)
X-master-at: b9aa901856cee7ad16737343f6a372bb37871258
X-next-at: e1730fbcd4659526c1ef8e8c851b5d6cab4a82c1
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0A8FCC3C-451E-11DF-AAE9-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144628>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the integration branches, but I am
still holding onto them.

We are at 1.7.1-rc1; please test 'master', report & fix regressions.
Hopefully we can do another rc during the next week and release the final
one next weekend.

--------------------------------------------------
[Graduated to "master"]

* mr/gitweb-jsmin (2010-04-02) 6 commits
  (merged to 'next' on 2010-04-05 at 5ad036c)
 + gitweb: update INSTALL to use shorter make target
 + gitweb: add documentation to INSTALL regarding gitweb.js
 + instaweb: add minification awareness
 + Gitweb: add autoconfigure support for minifiers
 + Gitweb: add support for minifying gitweb.css
 + Gitweb: add ignore and clean rules for minified files

--------------------------------------------------
[New Topics]

* bg/apply-blank-trailing-context (2010-04-08) 1 commit
 - apply: Allow blank *trailing* context lines to match beyond EOF

Looked Ok; soon in 'next'

* bg/send-email-smtpdomain (2010-04-10) 4 commits
 - send-email: Cleanup smtp-domain and add config
 - Document send-email --smtp-domain
 - send-email: Don't use FQDNs without a '.'
 - send-email: Cleanup { style

Looked Ok; soon in 'next'

* rc/ls-remote-default (2010-04-09) 1 commit
 - ls-remote: fall-back to default remotes when no remote specified

Looked Ok; soon in 'next'

* rc/maint-curl-helper (2010-04-08) 3 commits
 - remote-curl: ensure that URLs have a trailing slash
 - http: make end_url_with_slash() public
 - t5541-http-push: add test for URLs with trailing slash

Looked Ok; soon in 'next'

* jc/status-show-ignored (2010-04-10) 5 commits
 - status: --ignored option shows ignored files
 - wt-status: rename and restructure status-print-untracked
 - wt-status: collect ignored files
 - wt-status: plug memory leak while collecting untracked files
 - wt-status: remove unused workdir_untracked member

This is merely an illustration patch.  I am negative about conflating the
JSON output to the mix at this point.  If we are going to add JSON option
to everywhere we would generate "machine readable" output with the -z
and/or --porcelain options, that is fine, but let's stabilize "status"
with the existing --porcelain/-z option first.

* hg/maint-attr-fix (2010-04-06) 3 commits
 - attr: Expand macros immediately when encountered.
 - attr: Allow multiple changes to an attribute on the same line.
 - attr: Fixed debug output for macro expansion.

* jc/am-3-show-corrupted-patch (2010-04-09) 1 commit
 . wip

* jc/maint-no-reflog-expire-unreach-for-head (2010-04-09) 1 commit
 . WIP: no reflog expireunreachable for HEAD
 (this branch uses jc/maint-reflog-expire-unreachable.)

* sp/maint-describe-tiebreak-with-tagger-date (2010-04-10) 1 commit
 - describe: Break annotated tag ties by tagger date

--------------------------------------------------
[Stalled]

* js/rebase-origin-x (2010-02-05) 1 commit
 - [RFC w/o test and incomplete] rebase: add -x option to record original commit name

I retract my objection against the idea of -x; needs polishing before
moving forward.

* js/grep-open (2010-03-26) 2 commits
 - grep -O: allow optional argument specifying the pager (or editor)
 - grep: Add the option '--open-files-in-pager'
 (this branch is used by jp/hold-sring-list-sanity.)

Probably needs to support --no-index mode as well.

* tr/word-diff (2010-04-04) 2 commits
 - gitk: add the equivalent of diff --color-words
 - diff: add --word-diff option that generalizes --color-words

* jp/hold-sring-list-sanity (2010-04-06) 6 commits
 . string_list: Fix argument order for string_list_append
 . string_list: Fix argument order for string_list_lookup
 . string_list: Fix argument order for string_list_insert_at_index
 . string_list: Fix argument order for string_list_insert
 . string_list: Fix argument order for for_each_string_list
 . string_list: Fix argument order for print_string_list
 (this branch uses js/grep-open and early parts of sr/remote-helper-export.)

Building this on top of slushy codebase is not a very promising endeavor.
Good thing to do, but bad timing.

--------------------------------------------------
[Cooking]

* ne/rev-cache (2010-04-05) 7 commits
 - graft awareness
 - object name support
 - integration into revision walker
 - administrative api and tools
 - support for non-commit objects
 - basic api and porcelain
 - man page and technical docs

For some reason this was extremely hard to read, partly because it had too
many distracting style violations and too many long lines.

* eb/unpretty-b-format (2010-03-24) 1 commit
  (merged to 'next' on 2010-04-07 at 7f5c112)
 + Add `%B' in format strings for raw commit body in `git log' and friends

* ab/commit-empty-message (2010-04-06) 1 commit
  (merged to 'next' on 2010-04-07 at 701e863)
 + Add option to git-commit to allow empty log messages

* jc/test-sleepless (2010-04-06) 1 commit
  (merged to 'next' on 2010-04-07 at 8ccf40a)
 + war on "sleep" in tests

* jc/maint-reflog-expire-unreachable (2010-04-07) 1 commit
 - reflog --expire-unreachable: avoid merge-base computation
 (this branch is used by jc/maint-no-reflog-expire-unreach-for-head.)

* jc/doc-submit-gmail (2010-04-07) 1 commit
  (merged to 'next' on 2010-04-10 at cd4e8cf)
 + SubmittingPatches: update GMail section

* np/malloc-threading (2010-04-08) 2 commits
  (merged to 'next' on 2010-04-10 at e1730fb)
 + Thread-safe xmalloc and xrealloc needs a recursive mutex
 + Make xmalloc and xrealloc thread-safe

The fix should eventually go to 'maint' and 'master'.  This queues the one
from J6t for Windows compatibility.

* js/async-thread (2010-03-09) 7 commits
 - Enable threaded async procedures whenever pthreads is available
  (merged to 'next' on 2010-03-20 at 9939243)
 + Dying in an async procedure should only exit the thread, not the process.
 + Reimplement async procedures using pthreads
 + Windows: more pthreads functions
 + Fix signature of fcntl() compatibility dummy
 + Make report() from usage.c public as vreportf() and use it.
 + Modernize t5530-upload-pack-error.

Been waiting for resolution of locking issues in malloc-threading.

* sd/log-decorate (2010-04-08) 6 commits
  (merged to 'next' on 2010-04-08 at 68fee56)
 + log.decorate: only ignore it under "log --pretty=raw"
 + script with rev-list instead of log
  (merged to 'next' on 2010-04-06 at 992c9ad)
 + log --pretty/--oneline: ignore log.decorate
  (merged to 'next' on 2010-03-08 at 58a6fba)
 + log.decorate: usability fixes
 + Add `log.decorate' configuration variable.
 + git_config_maybe_bool()

* mh/status-optionally-refresh (2010-04-03) 3 commits
  (merged to 'next' on 2010-04-05 at 0e64aac)
 + t7508: add a test for "git status" in a read-only repository
 + git status: refresh the index if possible
 + t7508: add test for "git status" refreshing the index

* cw/ws-indent-with-tab (2010-04-03) 6 commits
  (merged to 'next' on 2010-04-05 at 5b5e579)
 + whitespace: tests for git-apply --whitespace=fix with tab-in-indent
 + whitespace: add tab-in-indent support for --whitespace=fix
 + whitespace: replumb ws_fix_copy to take a strbuf *dst instead of char *dst
 + whitespace: tests for git-diff --check with tab-in-indent error class
 + whitespace: add tab-in-indent error class
 + whitespace: we cannot "catch all errors known to git" anymore

* rr/remote-helper-doc (2010-04-07) 3 commits
 - Documentation/remote-helpers: Add invocation section
 - Documentation/urls: Rewrite to accomodate <transport>::<address>
 - Documentation/remote-helpers: Rewrite description

I'd like acks or rewrites from transport people on this topic.

* sr/remote-helper-export (2010-04-09) 8 commits
  (merged to 'next' on 2010-04-09 at 94f6e3d)
 + Makefile: Simplify handling of python scripts
  (merged to 'next' on 2010-04-07 at 5651307)
 + remote-helpers: add tests for testgit helper
 + remote-helpers: add testgit helper
 + remote-helpers: add support for an export command
 + remote-helpers: allow requesing the path to the .git directory
 + fast-import: always create marks_file directories
 + clone: also configure url for bare clones
 + clone: pass the remote name to remote_get
 (this branch shares commits with jp/hold-sring-list-sanity.)

* cc/revert-strategy (2010-03-31) 5 commits
  (merged to 'next' on 2010-04-05 at 50909c1)
 + revert: add "--strategy" option to choose merge strategy
 + merge: make function try_merge_command non static
 + merge: refactor code that calls "git merge-STRATEGY"
 + revert: refactor merge recursive code into its own function
 + revert: use strbuf to refactor the code that writes the merge message

This is more about debugging and we are not in a great hurry.

* sc/http-late-auth (2010-04-01) 1 commit
  (merged to 'next' on 2010-04-02 at c991acf)
 + Prompt for a username when an HTTP request 401s

* jk/cached-textconv (2010-04-01) 5 commits
  (merged to 'next' on 2010-04-02 at a023e3c)
 + diff: avoid useless filespec population
 + diff: cache textconv output
 + textconv: refactor calls to run_textconv
 + introduce notes-cache interface
 + make commit_tree a library function

The small leak fixes in the beginning of the series has been merged to
'master' after a minor fixup.

* ld/discovery-limit-to-fs (2010-04-04) 6 commits
 - write-index: check and warn when worktree crosses a filesystem boundary
  (merged to 'next' on 2010-04-07 at 11ea09a)
 + Rename ONE_FILESYSTEM to DISCOVERY_ACROSS_FILESYSTEM
 + GIT_ONE_FILESYSTEM: flip the default to stop at filesystem boundaries
 + Add support for GIT_ONE_FILESYSTEM
 + truncate cwd string before printing error message
 + config.c: remove static keyword from git_env_bool()

The tip one is a bit iffy; the whole series changes behaviour in a corner
case, and is not a 1.7.1 material.

* pc/remove-warn (2010-03-26) 4 commits
  (merged to 'next' on 2010-04-02 at 52fc00d)
 + Remove a redundant errno test in a usage of remove_path
 + Introduce remove_or_warn function
 + Implement the rmdir_or_warn function
 + Generalise the unlink_or_warn function

I cherry-picked only obviously sensible bits.

* em/checkout-orphan (2010-03-21) 1 commit
  (merged to 'next' on 2010-03-28 at 86b6a4f)
 + git checkout: create unparented branch by --orphan

Perhaps needs a bit of documentation updates, describing the "going open
source" scenario.

* ar/config-from-command-line (2010-03-26) 2 commits
  (merged to 'next' on 2010-04-07 at e50fd3a)
 + Use strbufs instead of open-coded string manipulation
 + Allow passing of configuration parameters in the command line

* nd/setup (2010-04-05) 43 commits
 - builtins: do not commit pager choice early
 - builtins: setup repository before print unknown command error
 - t0001: Add test cases for "git init" with aliases
 - Guard unallowed access to repository when it's not set up
 - alias: keep repository found while collecting aliases as long as possible
 - Allow to undo setup_git_directory_gently() gracefully (and fix alias code)
 - builtins: check for startup_info->help, print and exit early
 - builtins: utilize startup_info->help where possible
 - run_builtin(): save "-h" detection result for later use
 - config: do not read .git/config if there is no repository
 - apply: do not check sha1 if there is no repository
 - Do not read .git/info/attributes if there is no repository
 - Do not read .git/info/exclude if there is no repository
 - git_config(): do not read .git/config if there is no repository
 - init/clone: turn on startup->have_repository properly
 - worktree setup: restore original state when things go wrong
 - Use git_config_early() instead of git_config() during repo setup
 - Add git_config_early()
 - worktree setup: call set_git_dir explicitly
 - rev-parse --git-dir: print relative gitdir correctly
 - enter_repo(): initialize other variables as setup_git_directory_gently() does
 - Move enter_repo() to setup.c
 - index-pack: use RUN_SETUP_GENTLY
 - index-pack: trust the prefix returned by setup_git_directory_gently()
 - worktree setup: calculate prefix even if no worktree is found
 - merge-file: use RUN_SETUP_GENTLY
 - var: use RUN_SETUP_GENTLY
 - ls-remote: use RUN_SETUP_GENTLY
 - help: take note why this command is not applicable for RUN_SETUP_GENTLY
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

Rerolled.  I need to look at this series during the feature freeze so that
we can decide to (or not to) include it in 'next' early in post 1.7.1 cycle.

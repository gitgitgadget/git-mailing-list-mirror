From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (May 2009, #04; Sun, 31)
Date: Sun, 31 May 2009 18:24:58 -0700
Message-ID: <7v63fgpwyd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 03:28:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAwKL-0005Ca-Ud
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 03:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbZFABY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 21:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbZFABY6
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 21:24:58 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:55051 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZFABY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 21:24:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090601012500.CNHX20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 31 May 2009 21:25:00 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id yRQy1b00H4aMwMQ03RQzMq; Sun, 31 May 2009 21:24:59 -0400
X-Authority-Analysis: v=1.0 c=1 a=n9hohcYa0b8A:10 a=9ttGZAtH5zYA:10
 a=DVJC8n9COtcj36KGD9wA:9 a=NGzsMjlTPGLQB9LHO3YA:7
 a=h2GyG4GrRINDa5fvI-mJsttAjWcA:4
X-CM-Score: 0.00
X-master-at: f9275c68af58e0f65e1557b5109ccbfdbbbc384a
X-next-at: 426b5a935392df623347be0aea16bca045d44b52
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120438>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

All of these are soon to be in 'next'.

* bc/solaris (Wed May 27 21:17:08 2009 -0500) 4 commits
 - Makefile: introduce SANE_TOOL_PATH for prepending required
   elements to PATH
 - Makefile: add section for SunOS 5.7
 - Makefile: add NEEDS_RESOLV to optionally add -lresolv to compile
   arguments
 - Makefile: use /usr/ucb/install on SunOS platforms rather than
   ginstall

* nw/maint-cvsexportcommit (Fri May 29 00:23:33 2009 +0100) 1 commit
 - git-cvsexportcommit can't commit files which have been removed
   from CVS

* tr/maint-doc-stash-pop (Thu May 28 11:40:15 2009 +0200) 1 commit
 - Documentation: teach stash/pop workflow instead of stash/apply

* da/pretty-tempname (Sun May 31 01:35:52 2009 -0700) 3 commits
 - diff: generate pretty filenames in prep_temp_blob()
 - compat: add a basename() compatibility function
 - compat: add a mkstemps() compatibility function

* ak/maint-for-each-ref-no-lookup (Wed May 27 15:23:12 2009 -0400) 1 commit
 - for-each-ref: Do not lookup objects when they will not be used

* cb/match_refs_internal_tail (Wed May 27 22:13:44 2009 +0200) 1 commit
 - match_refs: search ref list tail internally

I need to replace this with the new iteration...

* gb/am-foreign (Wed May 27 11:25:19 2009 +0200) 4 commits
 - git-am: refactor 'cleaning up and aborting'
 - git-am foreign patch support: StGIT support
 - git-am foreign patch support: autodetect some patch formats
 - git-am foreign patch support: introduce patch_format

----------------------------------------------------------------
[Graduated to "master"]

* sb/opt-filename (Sat May 23 11:53:13 2009 -0700) 2 commits
 + parse-opts: add OPT_FILENAME and transition builtins
 + parse-opts: prepare for OPT_FILENAME

* rs/maint-grep-word-regexp-fix (Sat May 23 13:45:26 2009 +0200) 1 commit
 + grep: fix word-regexp at the beginning of lines

* mm/apply-double-slash (Thu May 21 14:25:11 2009 +0200) 1 commit
 + apply: handle filenames with double slashes better

* bc/old-iconv (Fri May 22 18:47:06 2009 -0500) 10 commits
 + t8005: convert CP1251 character set to ISO8859-5
 + t8005: use more portable character encoding names
 + t5100: use ancient encoding syntax for backwards compatibility
 + t9301: use ISO8859-1 rather than ISO-8859-1
 + t3901: Use ISO8859-1 instead of ISO-8859-1 for backward
   compatibility
 + t3901: avoid negation on right hand side of '|'
 + builtin-mailinfo.c: use "ISO8859-1" instead of "latin1" as
   fallback encoding
 + builtin-mailinfo.c: compare character encodings case insensitively
 + Use 'UTF-8' rather than 'utf-8' everywhere for backward
   compatibility
 + t3900: use ancient iconv names for backward compatibility

* sb/show-branch-parse-options (Thu May 21 00:33:18 2009 -0700) 3 commits
 + show-branch: migrate to parse-options API
 + Merge branch 'mh/show-branch-color' into sb/show-branch-parse-
   options
 + parse-options: add PARSE_OPT_LITERAL_ARGHELP for complicated
   argh's

* sb/maint-1.6.2-opt-filename-fix (Sat May 23 11:53:11 2009 -0700) 2 commits
 + apply, fmt-merge-msg: use relative filenames
 + commit: -F overrides -t

* jc/solaris-0811 (Fri May 22 22:55:31 2009 -0700) 2 commits
 - OpenSolaris 200811 (SunOS 5.11) does not want OLD_ICONV
 - Teach Solaris that _XOPEN_SOURCE=600 really menas XPG6

* mw/send-email (Mon Apr 13 13:23:52 2009 -0500) 6 commits
 + send-email: Remove superfluous `my $editor = ...'
 + send-email: 'References:' should only reference what is sent
 + send-email: Handle "GIT:" rather than "GIT: " during --compose
 + Docs: send-email: --smtp-server-port can take symbolic ports
 + Docs: send-email: Refer to CONFIGURATION section for
   sendemail.multiedit
 + Docs: send-email: Put options back into alphabetical order

* jc/mktree (Thu May 14 15:49:10 2009 -0700) 9 commits
 + mktree: validate entry type in input
 + mktree --batch: build more than one tree object
 + mktree --missing: updated usage message and man page
 + mktree --missing: allow missing objects
 + t1010: add mktree test
 + mktree: do not barf on a submodule commit
 + builtin-mktree.c: use a helper function to handle one line of
   input
 + mktree: use parse-options
 + build-in git-mktree

* jc/maint-add-p-coalesce-fix (Sat May 16 10:48:23 2009 -0700) 2 commits
 + Revert "git-add--interactive: remove hunk coalescing"
 + Splitting a hunk that adds a line at the top fails in "add -p"

* sb/format-patch-parseopt (Sat May 16 02:24:46 2009 -0700) 1 commit
 + format-patch: migrate to parse-options API

* cc/bisect (Sun May 17 17:36:46 2009 +0200) 3 commits (early part)
 + bisect: check ancestors without forking a "git rev-list" process
 + commit: add function to unparse a commit and its parents
 + bisect: rework some rev related functions to make them more
   reusable

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* jh/notes (Sat May 16 13:44:17 2009 +0200) 5 commits
 - Teach "-m <msg>" and "-F <file>" to "git notes edit"
 - Add an expensive test for git-notes
 - Speed up git notes lookup
 - Add a script to edit/inspect notes
 - Introduce commit notes

Dscho asked about the performance implications of this; I do not think I
saw any progress on that yet...

* ph/submodule-rebase (Fri Apr 24 09:06:38 2009 +1000) 1 commit
 + git-submodule: add support for --rebase.

There was a discussion on --rebase vs --merge and needs for unified
configuration variable handling for this patch...

* lt/read-directory (Fri May 15 12:01:29 2009 -0700) 3 commits
 - Add initial support for pathname conversion to UTF-8
 - read_directory(): infrastructure for pathname character set
   conversion
 - Add 'fill_directory()' helper function for directory traversal

Before adding the real "conversion", this needs a few real fixups, I
think.  For example there is one hardcoded array that is used without
bounds check.

* ar/maint-1.6.2-merge-recursive-d-f (Mon May 11 21:25:36 2009 +0200) 2 commits
 - Fix for a merge where a branch has an F->D transition
 - Add a reminder test case for a merge with F/D transition

Although the reported breakage is covered with the patch, Alex feels the
solution unsatisfactory. Cleaning up D/F conflict handling in merge-recursive
may be long overdue but seems to be a hard problem.

* ps/blame (Thu Mar 12 21:30:03 2009 +1100) 1 commit
 - blame.c: start libifying the blame infrastructure

A few minor point remains in this initial one.  I hate to do these minor
fix-ups myself, but I may end up doing so...

* jc/log-tz (Tue Mar 3 00:45:37 2009 -0800) 1 commit
 - Allow --date=local --date=other-format to work as expected

The one I posted had a few corner-case bugs that was caught with the test
suite; this one has them fixed.  People did not like the UI so it is kept
out of 'next'

* jc/merge-convert (Mon Jan 26 16:45:01 2009 -0800) 1 commit
 - git-merge-file: allow converting the results for the work tree

This is a feature waiting for a user.

We did not give scripted Porcelains a way to say "this temporary file I am
using for merging is for this path, so use the core.autocrlf and attributes
rules for that final path".  Instead, merge-file simply wrote out the
data in the canonical repository representation.

rerere has the same issue, but it is a lot worse.  It reads the three
files (preimage, postimage and thisimage) from the work tree in the work
tree representation, merges them without converting them to the canonical
representation first but inserts the conflict markers with the canonical
representation and writes the resulting mess out.  It needs to be fixed to
read with convert_to_git(), merge them while they are still in the
canonical representation and possibly add conflict markers, and then write
the results out after convert_to_working_tree().  It also needs to write
in binary mode as well.

* db/foreign-scm (Tue Mar 24 23:04:12 2009 -0400) 3 commits
 - Add option for using a foreign VCS
 - Document details of transport function APIs
 - Allow late reporting of fetched hashes

* hv/cvsps-tests (Sun Apr 5 01:40:50 2009 -0700) 8 commits
 - t/t9600: remove exit after test_done
 - cvsimport: extend testcase about patchset order to contain
   branches
 - cvsimport: add test illustrating a bug in cvsps
 - Add a test of "git cvsimport"'s handling of tags and branches
 - Add some tests of git-cvsimport's handling of vendor branches
 - Test contents of entire cvsimported "master" tree contents
 - Use CVS's -f option if available (ignore user's ~/.cvsrc file)
 - Start a library for cvsimport-related tests

----------------------------------------------------------------
[Actively cooking]

* da/araxis-mergetool (Sun May 24 00:24:41 2009 +0000) 1 commit
 + mergetool--lib: add support for araxis merge

* jc/cache-tree (Fri May 22 23:14:25 2009 -0700) 5 commits
 + Avoid "diff-index --cached" optimization under --find-copies-
   harder
 + Optimize "diff-index --cached" using cache-tree
 + t4007: modernize the style
 + cache-tree.c::cache_tree_find(): simplify internal API
 + write-tree --ignore-cache-tree

* cb/maint-1.6.0-xdl-merge-fix (Mon May 25 01:21:14 2009 +0100) 2 commits
 - Change xdl_merge to generate output even for null merges
 - t6023: merge-file fails to output anything for a degenerate merge

Soon in 'next';

* jc/diff-whitespace-only-status (Sat May 23 01:15:35 2009 -0700) 2 commits
 - diff: Rename QUIET internal option to QUICK
 - diff: change semantics of "ignore whitespace" options

* cc/bisect (Thu May 28 23:21:16 2009 +0200) 2 commits
 - bisect: display first bad commit without forking a new process
 - bisect: drop unparse_commit() and use clear_commit_marks()

Soon in 'next';

* rc/http-push (Sat May 30 01:59:50 2009 +0800) 21 commits
 - http*: add helper methods for fetching objects (loose)
 - http*: add helper methods for fetching packs
 - http: use new http API in fetch_index()
 - http*: add http_get_info_packs
 - Use the new http API in fetch_symref()
 - Use the new http API in update_remote_info_refs()
 - Use the new http API in http_fetch_ref()
 - Use the new http API in get_refs_via_curl()
 - Two new functions for the http API
 - http: create function end_url_with_slash
 - http*: move common variables and macros to http.[ch]
 - Some cleanup in get_refs_via_curl()
 - Don't expect verify_pack() callers to set pack_size
 - http-push: do not SEGV after fetching a bad pack idx file
 - http*: copy string returned by sha1_to_hex
 - http-walker: verify remote packs
 - http-push, http-walker: style fixes
 - http-push: fix missing "#ifdef USE_CURL_MULTI" around
   "is_running_queue"
 - http-push: send out fetch requests on queue
 - t5540-http-push: test fetching of packed objects
 - t5540-http-push: test fetching of loose objects

Updated (but not yet with the "slot->local = NULL" patch)

* cc/replace (Wed May 27 07:14:09 2009 +0200) 14 commits
 - t6050: check pushing something based on a replaced commit
 - Documentation: add documentation for "git replace"
 - Add git-replace to .gitignore
 - builtin-replace: use "usage_msg_opt" to give better error messages
 - parse-options: add new function "usage_msg_opt"
 - builtin-replace: teach "git replace" to actually replace
 - Add new "git replace" command
 - environment: add global variable to disable replacement
 - mktag: call "check_sha1_signature" with the replacement sha1
 - replace_object: add a test case
 - object: call "check_sha1_signature" with the replacement sha1
 - sha1_file: add a "read_sha1_file_repl" function
 - replace_object: add mechanism to replace objects found in
   "refs/replace/"
 - refs: add a "for_each_replace_ref" function

Rebased to master.

----------------------------------------------------------------
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

These are for 1.7.0, but the messages when they trigger together may need
to be rethought.

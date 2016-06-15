From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2009, #02; Thu, 18)
Date: Thu, 18 Jun 2009 14:08:54 -0700
Message-ID: <7vy6rpmeqh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 23:09:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHOr3-0002im-0s
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 23:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbZFRVIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 17:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752801AbZFRVIx
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 17:08:53 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34294 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbZFRVIw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 17:08:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090618210855.HSUD17670.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 18 Jun 2009 17:08:55 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 5Z8u1c0054aMwMQ04Z8ueb; Thu, 18 Jun 2009 17:08:54 -0400
X-VR-Score: -30.00
X-Authority-Analysis: v=1.0 c=1 a=m-dMHsg7A5sA:10 a=b3uDMlK8r82H5qxy8HYA:9
 a=bLBlF5bVWP72pEHgQwgA:7 a=js4WAqsHkmIg8rBR1O_9oKWK_3IA:4
X-CM-Score: 0.00
X-master-at: da4e4a65a27ca912c3f48289acf9ff7a67476c3f
X-next-at: 04d09b6708a8fa33788706f00bbf43c80ea6af0e
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121870>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

Unfortunately I am unusually short of time these days, and some of the
topics unfortunately got less "final review before deciding to merge up"
than I would have liked to give them.  This message itself has more
"please comment/review" requests than usual.

----------------------------------------------------------------
[New Topics]

* ne/maint-1.6.0-diff-tree-t-r-show-directory (Sat Jun 13 17:06:09 2009 -0700) 1 commit
 - diff-tree -r -t: include added/removed directories in the output

* sb/maint-1.6.0-add-config-fix (Thu Jun 18 02:17:54 2009 -0700) 2 commits
 - add: allow configurations to be overriden by command line
 - use xstrdup, not strdup in ll-merge.c

* pb/maint-1.6.2-userdiff-fix (Wed Jun 17 12:11:10 2009 +0200) 2 commits
 - upload-archive: fix infinite loop on Cygwin
 - avoid exponential regex match for java and objc function names

* fc/user-manual (Fri May 1 11:44:20 2009 +0300) 2 commits
 . user-manual: use 'fast-forward' instead of 'fast forward'
 . user-manual: general quoting improvements

* uk/rev-parse-parse-opt (Sun Jun 14 01:58:43 2009 +0200) 2 commits
 - parse-opt: make PARSE_OPT_STOP_AT_NON_OPTION available to git rev-
   parse
 - more tests for git rev-parse --parse-opt

* js/daemon-log (Tue Jun 16 20:41:16 2009 +0200) 2 commits
 - upload-pack: squelch progress indicator if client cannot see it
 - daemon: send stderr of service programs to the syslog

* sb/quiet-porcelains (Wed Jun 17 18:07:37 2009 -0700) 6 commits
 - stash: teach quiet option
 - am, rebase: teach quiet option
 - submodule, repack: migrate to git-sh-setup's say()
 - git-sh-setup: introduce say() for quiet options
 - am: suppress apply errors when using 3-way
 - t4150: test applying with a newline in subject

* lt/maint-unsigned-left-shift (Wed Jun 17 17:22:27 2009 -0700) 1 commit
 - Fix big left-shifts of unsigned char

* jk/use-our-regexp (Tue Jun 16 15:08:21 2009 -0400) 2 commits
 - Makefile: use compat regex on Solaris
 - Makefile: refactor regex compat support

* cb/maint-fetch-refspec-wo-dst (Wed Jun 17 15:38:36 2009 +0200) 1 commit
 - fetch: do not create ref from empty name

* pb/send-email-cccmd-fix (Thu Jun 18 14:31:32 2009 +0200) 1 commit
 - Test cccmd in t9001-send-email.sh and fix some bugs

----------------------------------------------------------------
[Graduated to "master"]

* cb/maint-no-double-merge (Mon Jun 1 11:20:56 2009 +0200) 1 commit
 + refuse to merge during a merge

* sp/msysgit (Thu Jun 11 22:56:12 2009 +0200) 13 commits
 + compat/ has subdirectories: do not omit them in 'make clean'
 + Fix typo in nedmalloc warning fix
 + MinGW: Teach Makefile to detect msysgit and apply specific
   settings
 + Fix warnings in nedmalloc when compiling with GCC 4.4.0
 + Add custom memory allocator to MinGW and MacOS builds
 + MinGW readdir reimplementation to support d_type
 + connect.c: Support PuTTY plink and TortoisePlink as SSH on Windows
 + git: browsing paths with spaces when using the start command
 + MinGW: fix warning about implicit declaration of _getch()
 + test-chmtime: work around Windows limitation
 + Work around a regression in Windows 7, causing erase_in_line() to
   crash sometimes
 + Quiet make: do not leave Windows behind
 + MinGW: GCC >= 4 does not need SNPRINTF_SIZE_CORR anymore

* mh/fix-send-email-threaded (Fri Jun 12 09:23:43 2009 -0700) 7 commits
 + Merge branch 'mh/maint-fix-send-email-threaded' into
   mh/fix-send-email-threaded
 + send-email: fix a typo in a comment
 + send-email: fix threaded mails without chain-reply-to
 + add a test for git-send-email for threaded mails without chain-reply-to
 + doc/send-email: clarify the behavior of --in-reply-to with
   --no-thread
 + send-email: fix non-threaded mails
 + add a test for git-send-email for non-threaded mails

* rc/maint-http-local-slot-fix (Sat Jun 6 16:43:26 2009 +0800) 1 commit
 + http*: cleanup slot->local after fclose

* sb/parse-options-integer (Thu Jun 4 16:43:57 2009 -0700) 2 commits
 + parse-options: simplify usage argh handling
 + parse-options: make OPT_INTEGER's argh explicit

* bc/solaris (Sun Jun 7 07:40:29 2009 +0200) 10 commits
 + configure: test whether -lresolv is needed
 + Makefile: insert SANE_TOOL_PATH to PATH before /bin or /usr/bin
 + git-compat-util.h: avoid using c99 flex array feature with Sun
   compiler 5.8
 + Makefile: add section for SunOS 5.7
 + Makefile: introduce SANE_TOOL_PATH for prepending required
   elements to PATH
 + Makefile: define __sun__ on SunOS
 + git-compat-util.h: tweak the way _XOPEN_SOURCE is set on Solaris
 + On Solaris choose the OLD_ICONV iconv() declaration based on the
   UNIX spec
 + Makefile: add NEEDS_RESOLV to optionally add -lresolv to compile
   arguments
 + Makefile: use /usr/ucb/install on SunOS platforms rather than
   ginstall

* cb/match_refs_internal_tail (Sun May 31 16:26:48 2009 +0200) 1 commit
 + match_refs: search ref list tail internally

* nw/maint-cvsexportcommit (Fri May 29 00:23:33 2009 +0100) 1 commit
 + git-cvsexportcommit can't commit files which have been removed
   from CVS

* ak/maint-for-each-ref-no-lookup (Wed May 27 15:23:12 2009 -0400) 1 commit
 + for-each-ref: Do not lookup objects when they will not be used

I think this makes sense, except that I have this nagging feeling that its
use of for_each_rawref() where the original used for_each_ref() may have
some unintended side effects in corner cases.

* da/araxis-mergetool (Sun May 24 00:24:41 2009 +0000) 1 commit
 + mergetool--lib: add support for araxis merge

* rc/http-push (Sat Jun 6 16:44:02 2009 +0800) 24 commits
 + http*: add helper methods for fetching objects (loose)
 + http*: add helper methods for fetching packs
 + http: use new http API in fetch_index()
 + http*: add http_get_info_packs
 + http-push.c::fetch_symref(): use the new http API
 + http-push.c::remote_exists(): use the new http API
 + http.c::http_fetch_ref(): use the new http API
 + transport.c::get_refs_via_curl(): use the new http API
 + http.c: new functions for the http API
 + http: create function end_url_with_slash
 + http*: move common variables and macros to http.[ch]
 + transport.c::get_refs_via_curl(): do not leak refs_url
 + Don't expect verify_pack() callers to set pack_size
 + http-push: do not SEGV after fetching a bad pack idx file
 + http*: copy string returned by sha1_to_hex
 + http-walker: verify remote packs
 + http-push, http-walker: style fixes
 + t5550-http-fetch: test fetching of packed objects
 + http-push: fix missing "#ifdef USE_CURL_MULTI" around
   "is_running_queue"
 + http-push: send out fetch requests on queue
 + t5540-http-push: test fetching of packed objects
 + t5540-http-push: test fetching of loose objects
 + Merge branch 'rc/maint-http-local-slot-fix' into rc/http-push
 + http*: cleanup slot->local after fclose

* cc/bisect (Sat Jun 6 06:41:35 2009 +0200) 5 commits
 + t6030: test skipping away from an already skipped commit
 + bisect: when skipping, choose a commit away from a skipped commit
 + bisect: add parameters to "filter_skipped"
 + bisect: display first bad commit without forking a new process
 + bisect: drop unparse_commit() and use clear_commit_marks()

Regardless of metrics, this is an improvement from the current one.  Will
merge to 'master', and let the finer details taken care of later, which
is already happening.

----------------------------------------------------------------
[Will merge to "master" soon]

* ph/submodule-rebase (Wed Jun 3 00:59:12 2009 +0200) 1 commit
 + git-submodule: add support for --merge.

Even though some might still argue that "update --merge" is not a good
mode of operation.

* jc/cache-tree (Fri May 22 23:14:25 2009 -0700) 5 commits
 + Avoid "diff-index --cached" optimization under --find-copies-
   harder
 + Optimize "diff-index --cached" using cache-tree
 + t4007: modernize the style
 + cache-tree.c::cache_tree_find(): simplify internal API
 + write-tree --ignore-cache-tree

* mn/maint-iconv-autoconf (Mon Jun 8 20:46:38 2009 -0700) 1 commit
 + fix handling of iconv configuration options

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

A few minor point remains in this initial one.

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

* tr/die_errno (Fri Jun 12 09:00:59 2009 -0700) 5 commits
 - DONTMERGE fix double per-cent
 - Use die_errno() instead of die() when checking syscalls
 - Convert existing die(..., strerror(errno)) to die_errno()
 - die_errno(): double % in strerror() output just in case
 - Introduce die_errno() that appends strerror(errno) to die()

I didn't check the individual conversion from die() to die_errno()
in this latest round; comments?

Thomas found issues in my "double per-cent hack", so this cannot be merged
to yet until either it is fixed up, or drop the "double per-cent" attempt
altogether.

* sb/pull-rebase (Fri Jun 12 00:39:21 2009 +0200) 3 commits
 + parse-remote: remove unused functions
 + parse-remote: support default reflist in get_remote_merge_branch
 + parse-remote: function to get the tracking branch to be merge

It would be nice if we can fix the "currently works only for the default
mapping" before it goes to 'master'.  I looked at, but haven't queued any
of the recent RFC updates here.

* ne/futz-upload-pack (Wed Jun 10 01:50:18 2009 +0200) 1 commit
 - Shift object enumeration out of upload-pack

* ml/http (Wed May 27 23:16:03 2009 -0400) 2 commits
 - http.c: add http.sslCertPasswordProtected option
 - http.c: prompt for SSL client certificate password

I've rewritten these two to (1) move the #ifdef out of the main codepath,
and (2) use configuration/environment to make the misfeature of always
asking for a passphrase even a key/cert is unencrypted optional.  I tried
to be careful but extra sets of eyeballs would be nice to check the result.

* mg/pushurl (Sun Jun 14 21:46:10 2009 +0200) 6 commits
 + avoid NULL dereference on failed malloc
 + builtin-remote: Make "remote -v" display push urls
 + builtin-remote: Show push urls as well
 + technical/api-remote: Describe new struct remote member pushurl
 + t5516: Check pushurl config setting
 + Allow push and fetch urls to be different

* cc/bisect (Sat Jun 13 13:11:02 2009 +0200) 2 commits
 - Documentation: remove warning saying that "git bisect skip" may
   slow bisection
 - bisect: use a PRNG with a bias when skipping away from untestable
   commits

Will be in 'next' shortly.

* gb/am-foreign (Wed May 27 11:25:19 2009 +0200) 4 commits
 - git-am: refactor 'cleaning up and aborting'
 - git-am foreign patch support: StGIT support
 - git-am foreign patch support: autodetect some patch formats
 - git-am foreign patch support: introduce patch_format

Will be in 'next' shortly.

* jc/diff-whitespace-only-status (Sat May 23 01:15:35 2009 -0700) 2 commits
 - diff: Rename QUIET internal option to QUICK
 - diff: change semantics of "ignore whitespace" options

I am not sure if it should wait for a major version bump but this is a
good semantics change.  Perhaps merge to 'next' soonish, but I am
undecided.  Comments?

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

----------------------------------------------------------------
[On Hold]

* jc/deny-delete-current-1.7.0 (Mon Feb 9 00:19:46 2009 -0800) 1 commit
 - receive-pack: default receive.denyDeleteCurrent to refuse

* jc/refuse-push-to-current-1.7.0 (Wed Feb 11 02:28:03 2009 -0800) 1 commit
 - Refuse updating the current branch in a non-bare repository via
   push

These are for 1.7.0, but the messages when they trigger together may need
to be rethought.

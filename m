From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Jun 2009, #03; Sat, 27)
Date: Sun, 28 Jun 2009 00:09:19 -0700
Message-ID: <7vy6rcg7hc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 28 09:15:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKobw-0005kV-Bk
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 09:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbZF1HJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 03:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbZF1HJS
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 03:09:18 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:50607 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524AbZF1HJR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 03:09:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090628070920.FLGP20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 28 Jun 2009 03:09:20 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9K9K1c0054aMwMQ04K9KFt; Sun, 28 Jun 2009 03:09:19 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=W5zBQ-uuCvsA:10 a=C4XrVbuxarDMnbnB8NsA:9
 a=jaH_NsXsyabLD0RXU2kA:7 a=GRbe8mDQJxsY_hB-CbzsEZ0jlZkA:4
X-CM-Score: 0.00
X-master-at: 4f2b15ce88b70dd9e269517a9903864393ca873b
X-next-at: 98a794b5be3b0696055098d997dc22a127e8cd3d
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122394>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* gb/gitweb-avatar (Tue Jun 23 00:49:59 2009 +0200) 2 commits
 - gitweb: gravatar support
 - gitweb: refactor author name insertion

This was from way earlier round and will be replaced.

* ld/push-porcelain-out (Mon Jun 22 21:10:01 2009 -0400) 1 commit
 - add --porcelain option to git-push

* cf/maint-remote-uploadpack-useconfig-fix (Thu Jun 25 17:21:35 2009 -0400) 1 commit
 + git-remote: fix missing .uploadpack usage for show command

* en/fast-export (Thu Jun 25 22:48:33 2009 -0600) 7 commits
 - fast-export: Document the fact that git-rev-list arguments are
   accepted
 - Add new fast-export testcases
 - fast-export: Add a --tag-of-filtered-object option for newly
   dangling tags
 - fast-export: Do parent rewriting to avoid dropping relevant
   commits
 - fast-export: Make sure we show actual ref names instead of
   "(null)"
 - fast-export: Omit tags that tag trees
 - fast-export: Set revs.topo_order before calling setup_revisions

* sb/read-tree (Thu Jun 25 22:14:10 2009 -0700) 2 commits
 - read-tree: migrate to parse-options
 - read-tree: convert unhelpful usage()'s to helpful die()'s

* sb/show-ref-parse-options (Sat Jun 20 21:40:46 2009 -0700) 1 commit
 + show-ref: migrate to parse-options

----------------------------------------------------------------
[Graduated to "master"]

* sb/maint-1.6.0-add-config-fix (Thu Jun 18 02:17:54 2009 -0700) 2 commits
 + add: allow configurations to be overriden by command line
 + use xstrdup, not strdup in ll-merge.c

* pb/maint-1.6.2-userdiff-fix (Wed Jun 17 12:11:10 2009 +0200) 2 commits
 + upload-archive: fix infinite loop on Cygwin
 + avoid exponential regex match for java and objc function names

* lt/maint-unsigned-left-shift (Wed Jun 17 17:22:27 2009 -0700) 1 commit
 + Fix big left-shifts of unsigned char

* pb/send-email-cccmd-fix (Thu Jun 18 14:31:32 2009 +0200) 1 commit
 + Test cccmd in t9001-send-email.sh and fix some bugs

* ph/submodule-rebase (Wed Jun 3 00:59:12 2009 +0200) 1 commit
 + git-submodule: add support for --merge.

* jc/cache-tree (Fri May 22 23:14:25 2009 -0700) 5 commits
 + Avoid "diff-index --cached" optimization under --find-copies-
   harder
 + Optimize "diff-index --cached" using cache-tree
 + t4007: modernize the style
 + cache-tree.c::cache_tree_find(): simplify internal API
 + write-tree --ignore-cache-tree

* mn/maint-iconv-autoconf (Mon Jun 8 20:46:38 2009 -0700) 1 commit
 + fix handling of iconv configuration options

* sb/pull-rebase (Fri Jun 12 00:39:21 2009 +0200) 3 commits
 + parse-remote: remove unused functions
 + parse-remote: support default reflist in get_remote_merge_branch
 + parse-remote: function to get the tracking branch to be merge

* mg/pushurl (Sun Jun 14 21:46:10 2009 +0200) 6 commits
 + avoid NULL dereference on failed malloc
 + builtin-remote: Make "remote -v" display push urls
 + builtin-remote: Show push urls as well
 + technical/api-remote: Describe new struct remote member pushurl
 + t5516: Check pushurl config setting
 + Allow push and fetch urls to be different

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

* ne/maint-1.6.0-diff-tree-t-r-show-directory (Sat Jun 13 17:06:09 2009 -0700) 1 commit
 + diff-tree -r -t: include added/removed directories in the output

This changes the output from "diff-tree -r -t"; it brings more consistency
to it, but it is a change and could break scripts.

* uk/rev-parse-parse-opt (Sun Jun 14 01:58:43 2009 +0200) 2 commits
 + parse-opt: make PARSE_OPT_STOP_AT_NON_OPTION available to git rev-
   parse
 + more tests for git rev-parse --parse-opt

* js/daemon-log (Sun Jun 21 23:16:09 2009 +0200) 3 commits
 + receive-pack: do not send error details to the client
 + upload-pack: squelch progress indicator if client cannot see it
 + daemon: send stderr of service programs to the syslog

* sb/quiet-porcelains (Wed Jun 17 18:07:37 2009 -0700) 6 commits
 + stash: teach quiet option
 + am, rebase: teach quiet option
 + submodule, repack: migrate to git-sh-setup's say()
 + git-sh-setup: introduce say() for quiet options
 + am: suppress apply errors when using 3-way
 + t4150: test applying with a newline in subject

* jk/use-our-regexp (Fri Jun 19 10:10:39 2009 -0500) 3 commits
 + Makefile: Solaris needs HAVE_ALLOCA_H for alloca()
 + Makefile: use compat regex on Solaris
 + Makefile: refactor regex compat support

* cb/maint-fetch-refspec-wo-dst (Wed Jun 17 15:38:36 2009 +0200) 1 commit
 - fetch: do not create ref from empty name

* cc/bisect (Sat Jun 13 13:11:02 2009 +0200) 2 commits
 + Documentation: remove warning saying that "git bisect skip" may
   slow bisection
 + bisect: use a PRNG with a bias when skipping away from untestable
   commits

* tr/die_errno (Sat Jun 27 17:58:47 2009 +0200) 4 commits
 - Use die_errno() instead of die() when checking syscalls
 - Convert existing die(..., strerror(errno)) to die_errno()
 - die_errno(): double % in strerror() output just in case
 - Introduce die_errno() that appends strerror(errno) to die()

I didn't check the individual conversion from die() to die_errno()
in this latest round; comments?

* ne/futz-upload-pack (Wed Jun 10 01:50:18 2009 +0200) 1 commit
 - Shift object enumeration out of upload-pack

* ml/http (Wed May 27 23:16:03 2009 -0400) 2 commits
 - http.c: add http.sslCertPasswordProtected option
 - http.c: prompt for SSL client certificate password

I've rewritten these two to (1) move the #ifdef out of the main codepath,
and (2) use configuration/environment to make the misfeature of always
asking for a passphrase even a key/cert is unencrypted optional.  I tried
to be careful but extra sets of eyeballs would be nice to check the result.

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

From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Mon, 19 Feb 2007 23:42:57 -0800
Message-ID: <7v7iudz33y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 08:43:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJPeV-0000QH-4K
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 08:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbXBTHm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 02:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbXBTHm7
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 02:42:59 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:59718 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932599AbXBTHm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 02:42:58 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220074258.KXJJ1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 02:42:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rjix1W0011kojtg0000000; Tue, 20 Feb 2007 02:42:57 -0500
X-master-at: 1e592d65b50dbec87fde9f4ef1b7fd8d90bf7b8c
X-next-at: e5a1adc4486fabd0d06dd77b9e5e16649ee846a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40207>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* jc/apply-config (Tue Feb 20 03:45:49 2007 +0100) 5 commits
 - apply: fix memory leak in prefix_one()
 + git-apply: require -p<n> when working in a subdirectory.
 + git-apply: do not lose cwd when run from a subdirectory.
 + Teach 'git apply' to look at $HOME/.gitconfig even outside of a
   repository
 + Teach 'git apply' to look at $GIT_DIR/config

* lt/crlf (Sat Feb 17 12:37:25 2007 -0800) 4 commits
 + Teach core.autocrlf to 'git apply'
 + t0020: add test for auto-crlf
 + Make AutoCRLF ternary variable.
 + Lazy man's auto-CRLF

The above two series are to help MinGW and people who suffer
from CRLF in general.  I think they are good enough for general
consumption now.  Will perhaps push them out sometime this week.

* js/fetch-progress (Tue Feb 20 03:01:44 2007 +0100) 1 commit
 - fetch & clone: do not output progress when not on a tty
* js/name-rev-fix (Tue Feb 20 01:08:48 2007 +0100) 1 commit
 + name-rev: avoid "^0" when unneeded
* js/grep-pager (Mon Feb 19 15:56:04 2007 +0100) 1 commit
 - git grep: use pager
* js/no-limit-boundary (Mon Feb 19 03:14:59 2007 +0100) 1 commit
 + rev-list --max-age, --max-count: support --boundary
* fk/autoconf (Sun Feb 18 09:44:42 2007 +0100) 1 commit
 + New autoconf test for iconv
* js/etc-config (Wed Feb 14 12:48:14 2007 +0100) 1 commit
 - config: read system-wide defaults from /etc/gitconfig
* mw/64bit (Sat Feb 17 10:13:10 2007 +0100) 1 commit
 - Support for large files on 32bit systems.
* sb/merge (Thu Feb 15 16:39:53 2007 +0100) 1 commit
 - t/t5515-fetch-merge-logic.sh: Added tests for the merge logic in
   git-fetch

These should be Ok.  All should cook in 'next' and graduate to
'master' by end of next week at the latest.

* jc/fetch (Tue Feb 13 01:21:41 2007 +0000) 8 commits
 - Use stdin reflist passing in git-fetch.sh
 - Use stdin reflist passing in parse-remote
 - Allow fetch--tool to read from stdin
 - git-fetch: rewrite expand_ref_wildcard in C
 - git-fetch: rewrite another shell loop in C
 - git-fetch: move more code into C.
 - git-fetch--tool: start rewriting parts of git-fetch in C.
 - git-fetch: split fetch_main into fetch_dumb and fetch_native

Stalled.  If somebody wants to take this over I'll push this out
to 'next'.

* js/diff-2 (Sun Feb 18 12:44:43 2007 +0100) 1 commit
 - Add `git diff2`, a GNU diff workalike

Undecided.  Perhaps will merge to 'next' to see if somebody else
comes up with a better naming idea.

* jc/merge-subtree (Thu Feb 15 16:32:45 2007 -0800) 1 commit
 - A new merge stragety 'subtree'.

Seems to work very well, but I do not see great urgency to merge
this to 'next' yet.

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

Stalled.

* js/objhash (Sat Feb 17 18:38:50 2007 +0100) 2 commits
 . Add `struct object_hash` (fixup)
 . Add `struct object_hash`

Stalled.

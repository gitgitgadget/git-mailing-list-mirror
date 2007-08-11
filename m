From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (topics)
Date: Sat, 11 Aug 2007 02:43:38 -0700
Message-ID: <7vodhemmnp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 11:43:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJnVa-0001oz-7a
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 11:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbXHKJnm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 05:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755849AbXHKJnm
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 05:43:42 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:47428 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624AbXHKJnl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 05:43:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070811094341.ZTXV7193.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sat, 11 Aug 2007 05:43:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aZjg1X00D1kojtg0000000; Sat, 11 Aug 2007 05:43:40 -0400
X-master-at: f9286765b2c409e5b88efe8c20a2634d6842bc5f
X-next-at: a046fe0cb8697bc97993b2e609688ff5e89e3e90
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55598>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* jc/diff-files (Fri Aug 3 13:33:31 2007 -0700) 1 commit
 - git-diff: squelch "empty" diffs

It appears that people like the idea; I re-did the patch and
removed the option like Steve did.  I'll look at it again and
probably merge it to 'master' over the weekend.

* mc/logsize (Fri Jul 20 20:15:13 2007 +0200) 1 commit
 - Add --log-size to git log to print message size
* js/recursive-fix (Tue Jul 17 18:14:48 2007 +0100) 2 commits
 . Add tests for cherry-pick d/f conflict which should be none
 . merge-recursive: sometimes, d/f conflict is not an issue
* jc/blame (Thu Jul 12 10:49:08 2007 -0700) 4 commits
 - git-log --follow?
 - git-blame: optimize get_origin() from linear search to hash-
   lookup.
 - git-blame: pass "struct scoreboard *" pointers around.
 - blame: lift structure definitions up
* db/fetch-pack (Tue Jul 10 00:38:42 2007 -0400) 1 commit
 . Make fetch-pack a builtin with an internal API
* jc/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
 - rebase: allow starting from a dirty tree.
 - stash: implement "stash create"
* dh/repack (Fri May 25 14:40:24 2007 -0700) 1 commit
 - Enhance unpack-objects for live repo and large objects
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

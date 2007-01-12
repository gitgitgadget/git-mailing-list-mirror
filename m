From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Thu, 11 Jan 2007 18:43:48 -0800
Message-ID: <7vac0px8uz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 12 03:44:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5COi-0002H7-KG
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 03:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbXALCnu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 21:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbXALCnu
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 21:43:50 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:63721 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbXALCnt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 21:43:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070112024348.TNBR20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 21:43:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id A2ix1W00T1kojtg0000000; Thu, 11 Jan 2007 21:42:57 -0500
To: git@vger.kernel.org
X-master-at: ba70de01bb0c8a08135b63ace183bd3f4b149d9e
X-next-at: 8e6eb0c7820fd1607b551ff1a2138c056de5a6fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36653>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* js/reflog (Thu Jan 11 11:47:48 2007 +0100) 1 commit
 - Teach the revision walker to walk by reflogs with --walk-reflogs

It appears to show list of commits with reflog messages, but I
am not sure how useful it is until I get used to its output.

One question I keep asking reflog has been:

	When was commit X pushed out as part of 'master'?

I have reflog on a tracking branch that I fetch from the public
git.git repository immediately after I push into it, so it is a
matter of walking the reflog for that branch and see which one
is the earliest one that is a descendant of the commit in
question.  It does not tell me about the mirroring lags, but at
least let me keep track of when I pushed something out.


* jc/merge-base (Tue Jan 9 02:23:42 2007 -0800) 6 commits
 - Teach "git-merge-base --check-ancestry" about refs.
 - git-merge-base: --check-ancestry option
 + in_merge_bases(): optimization
 + merge_base(): move traversal into a separate function.
 + Allow in_merge_bases() to take more than one reference commits.
 + Make merge-base a built-in.
* sp/merge (Thu Dec 28 02:35:17 2006 -0500) 2 commits
 - Avoid git-fetch in `git-pull .` when possible.
 + Improve merge performance by avoiding in-index merges.
* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel
* jc/explain (Mon Dec 4 19:35:04 2006 -0800) 1 commit
 - git-explain
* jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
 + git-merge: preserve and merge local changes when doing fast
   forward
* jc/web (Wed Nov 8 14:54:09 2006 -0800) 1 commit
 - gitweb: steal loadavg throttle from kernel.org
* jc/pickaxe (Sun Nov 5 11:52:43 2006 -0800) 1 commit
 - blame: --show-stats for easier optimization work.
* jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700) 1 commit
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch
   (part 2)

These are on hold.

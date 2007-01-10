From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Wed, 10 Jan 2007 00:23:57 -0800
Message-ID: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-From: git-owner@vger.kernel.org Wed Jan 10 09:25:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Ylo-0002Mo-CK
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 09:25:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbXAJIYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 03:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932738AbXAJIX7
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 03:23:59 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:63242 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932737AbXAJIX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 03:23:58 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110082357.GTOM9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 03:23:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9LP71W0041kojtg0000000; Wed, 10 Jan 2007 03:23:07 -0500
To: git@vger.kernel.org
X-master-at: e05db0fd4f31dde7005f075a84f96b360d05984b
X-next-at: c3d62e5a6298ab611bfb1f6070309911171796b2
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36487>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* jc/detached-head (Tue Jan 9 20:39:09 2007 -0800) 9 commits
 + git-checkout: handle local changes sanely when detaching HEAD
 + git-checkout: safety check for detached HEAD checks existing refs
 + git-checkout: fix branch name output from the command
 + git-checkout: safety when coming back from the detached HEAD
   state.
 + git-checkout: rewording comments regarding detached HEAD.
 + git-checkout: do not warn detaching HEAD when it is already
   detached.
 + Detached HEAD (experimental)
 + git-branch: show detached HEAD
 + git-status: show detached HEAD

This is intended for v1.5.0; will merge to "master" by the weekend.

* jc/merge-base (Tue Jan 9 02:23:42 2007 -0800) 6 commits
 - Teach "git-merge-base --check-ancestry" about refs.
 - git-merge-base: --check-ancestry option
 + in_merge_bases(): optimization
 + merge_base(): move traversal into a separate function.
 + Allow in_merge_bases() to take more than one reference commits.
 + Make merge-base a built-in.

The early parts are just clean-up and optimization.  It's not
worth disrupt v1.5.0 process with potential bugs, so I would say
this is on-hold. 

* js/reflog (Mon Jan 8 01:59:54 2007 +0100) 1 commit
 + Sanitize for_each_reflog_ent()

I think this makes sense and is a good clean-up.

* jc/bare (Sun Jan 7 02:17:52 2007 -0800) 3 commits
 + git-fetch: allow updating the current branch in a bare repository.
 + Introduce is_bare_repository() and core.bare configuration
   variable
 + Move initialization of log_all_ref_updates

I'd like to take a serious look at Shawn's RFC patch to make
Porcelain-ish commands that require working tree refuse to
operate in a bare repository and rebuild it on top of these;
intended for v1.5.0.

* sp/merge (Sun Dec 31 00:02:13 2006 -0500) 3 commits
 - Refresh the index before starting merge-recursive.
 - Improve merge performance by avoiding in-index merges.
 - Avoid git-fetch in `git-pull .` when possible.
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

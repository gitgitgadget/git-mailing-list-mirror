X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Sun, 17 Dec 2006 23:28:39 -0800
Message-ID: <7vwt4p1x3s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 07:28:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34720>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwCvT-00069L-Fv for gcvg-git@gmane.org; Mon, 18 Dec
 2006 08:28:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753444AbWLRH2l (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 02:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753446AbWLRH2k
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 02:28:40 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:62259 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753444AbWLRH2k (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 02:28:40 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061218072839.CUEX18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Mon, 18
 Dec 2006 02:28:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 07Ur1W00W1kojtg0000000; Mon, 18 Dec 2006
 02:28:52 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Here are the topics cooking in git.git and their status.

*  jc/leftright (Sat Dec 16 16:07:20 2006 -0800) 3 commits
 + Make left-right automatic.
 + Teach all of log family --left-right output.
 + rev-list --left-right
*  jc/clone (Sat Dec 16 01:53:10 2006 -0800) 4 commits
 + git-clone: lose the traditional 'no-separate-remote' layout
 + git-clone: lose the artificial "first" fetch refspec
 + git-pull: refuse default merge without branch.*.merge
 + git-clone: use wildcard specification for tracking branches

Will likely to be in 'master' soonish.

*  ew/svn-pm (Fri Dec 15 23:58:08 2006 -0800) 3 commits
 + git-svn: rename 'commit' command to 'set-tree'
 + git-svn: remove support for the svn command-line client
 + git-svn: convert to using Git.pm

On hold -- the users will decide.

*^ jc/git-add--interactive (Mon Dec 11 17:09:26 2006 -0800) 2 commits
 - git-add --interactive: hunk splitting
 - git-add --interactive
*^ jc/explain (Mon Dec 4 19:35:04 2006 -0800) 1 commit
 - git-explain
*  jc/3way (Wed Nov 29 18:53:13 2006 -0800) 1 commit
 + git-merge: preserve and merge local changes when doing fast
   forward
*^ jc/web (Wed Nov 8 14:54:09 2006 -0800) 1 commit
 - gitweb: steal loadavg throttle from kernel.org

Undecided.

*^ jc/reflog (Sat Dec 16 18:35:00 2006 -0800) 1 commit
 - revision: introduce ref@{N..M} syntax.

I do not think this is of general use enough, so I'd shelve this
for now.

*^ jn/web (Sat Dec 16 17:12:55 2006 +0100) 1 commit
 - gitweb: Add some mod_perl specific support

Jakub says this needs review, so it is on hold for now.

*  js/shallow (Fri Nov 24 16:00:13 2006 +0100) 15 commits
 + fetch-pack: Do not fetch tags for shallow clones.
 + get_shallow_commits: Avoid memory leak if a commit has been
   reached already.
 + git-fetch: Reset shallow_depth before auto-following tags.
 + upload-pack: Check for NOT_SHALLOW flag before sending a shallow
   to the client.
 + fetch-pack: Properly remove the shallow file when it becomes
   empty.
 + shallow clone: unparse and reparse an unshallowed commit
 + Why didn't we mark want_obj as ~UNINTERESTING in the old code?
 + Why does it mean we do not have to register shallow if we have
   one?
 + We should make sure that the protocol is still extensible.
 + add tests for shallow stuff
 + Shallow clone: do not ignore shallowness when following tags
 + allow deepening of a shallow repository
 + allow cloning a repository "shallowly"
 + support fetching into a shallow repository
 + upload-pack: no longer call rev-list

Post v1.5.0

*  jc/diff-apply-patch (Fri Sep 22 16:17:58 2006 -0700) 1 commit
 + git-diff/git-apply: make diff output a bit friendlier to GNU patch
   (part 2)
*^ jc/pickaxe (Sun Nov 5 11:52:43 2006 -0800) 1 commit
 - blame: --show-stats for easier optimization work.
*^ jc/diff (Mon Sep 25 23:03:34 2006 -0700) 1 commit
 - para-walk: walk n trees, index and working tree in parallel

On hold.

*^ sv/git-svn (Tue Dec 5 16:17:38 2006 +1100) 5 commits
 . git-svn: re-map repository URLs and UUIDs on SVK mirror paths
 . git-svn: collect revision properties when fetching
 . git-svn: collect SVK source URL on mirror paths
 . git-svn: let libsvn_ls_fullurl return properties too
 . git-svn: make test for SVK mirror path import

On hold -- waiting for updates or responses to Eric's comment; I
am holding onto this series but it is temporarily dropped from
'pu'.

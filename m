From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: What's cooking in git/spearce.git (topics)
Date: Tue, 16 Oct 2007 02:04:56 -0400
Message-ID: <20071016060456.GC13801@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 08:05:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhfYI-0000YK-PH
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 08:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758779AbXJPGFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 02:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755255AbXJPGFB
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 02:05:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59393 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753952AbXJPGFA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 02:05:00 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IhfY1-00011T-JC
	for git@vger.kernel.org; Tue, 16 Oct 2007 02:04:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E4A7920FBAE; Tue, 16 Oct 2007 02:04:56 -0400 (EDT)
Content-Disposition: inline
X-master-at: 9de6d079200a50c0a61a5489e74419cb73993184
X-next-at: 5f967a43962a9a44b0d8ca3c7ca54affe35332e1
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61083>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

I know there are a number of other topics that I don't have in my
tree yet (bisect improvements, push refspec matching improvements,
option parser).  I plan on loading those into 'pu' tomorrow.
In the meantime we have this in next.


* db/fetch-pack (Thu Oct 11 01:47:55 2007 +0100) 58 commits
 + fetch: if not fetching from default remote, ignore default merge
 + Support 'push --dry-run' for http transport
 + Support 'push --dry-run' for rsync transport
 + Fix 'push --all branch...' error handling
 + Fix compilation when NO_CURL is defined
 + Added a test for fetching remote tags when there is not tags.
 + Fix a crash in ls-remote when refspec expands into nothing
 + Remove duplicate ref matches in fetch
 ... and many more ...

 The above commits are all new since Junio's last published next.
 About half of them fix known bugs in the builtin-fetch series.
 If you are running next, you want these fixes.

 I'm actually really happy with this series, but given the set of
 bugs that the above commits had to fix I think it needs to cook
 more in next before the topic can safely can graduate into master.

* jc/am-quiet (Mon Oct 1 00:27:51 2007 -0700) 2 commits
 + git-am: fix typo in the previous one.
 + git-am: make the output quieter.

 I'm also really happy with this change.  If nobody objects I may
 move it over to master later this week.


* lt/diff-rename (Tue Oct 2 19:28:19 2007 -0700) 1 commit
 + optimize diffcore-delta by sorting hash entries.

* kh/commit (Mon Sep 17 20:06:47 2007 -0400) 4 commits
 + Export rerere() and launch_editor().
 + Introduce entry point add_interactive and add_files_to_cache
 + Enable wt-status to run against non-standard index file.
 + Enable wt-status output to a given FILE pointer.

* js/stash-create (Mon Jul 9 00:51:23 2007 -0700) 2 commits
 + rebase: allow starting from a dirty tree.
 + stash: implement "stash create"

I inherited the above three topics from Junio.  I haven't had a
chance to really look at these yet myself to understand what their
status is and how ready they are for master (or not ready as the
case may be).

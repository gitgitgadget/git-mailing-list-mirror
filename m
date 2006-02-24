From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Add missing programs to ignore list
Date: Fri, 24 Feb 2006 17:51:15 -0500
Message-ID: <20060224225115.GA30609@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Feb 24 23:51:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FClmT-0005Gc-RV
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 23:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbWBXWvT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 17:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbWBXWvT
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 17:51:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:63645 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932627AbWBXWvS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 17:51:18 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FClmH-0006D9-0H
	for git@vger.kernel.org; Fri, 24 Feb 2006 17:51:09 -0500
Received: by asimov.spearce.org (Postfix, from userid 1000)
	id 8673E20FBA0; Fri, 24 Feb 2006 17:51:15 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16747>

Added recently added programs to the default exclude list.

---
 I found these were missing in master.  pg won't let me work in a
 directory if there are untracked files laying around which aren't
 excluded by an ignore pattern.

 .gitignore |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

base 809da5f8a21a10112eece4ee9be55fe64371ce68
last 9752e066a00144fc1b7657e6d54569e9d9764092
diff --git a/.gitignore b/.gitignore
index 94f66d5a1ef9d1e2bec2c14b392565ee5bf98dd6..5be239a4aa95f78cb09e4921459e1678b9f3c36e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -2,6 +2,7 @@ GIT-VERSION-FILE
 git
 git-add
 git-am
+git-annotate
 git-apply
 git-applymbox
 git-applypatch
@@ -22,6 +23,7 @@ git-convert-objects
 git-count-objects
 git-cvsexportcommit
 git-cvsimport
+git-cvsserver
 git-daemon
 git-diff
 git-diff-files
@@ -53,6 +55,7 @@ git-mailsplit
 git-merge
 git-merge-base
 git-merge-index
+git-merge-tree
 git-merge-octopus
 git-merge-one-file
 git-merge-ours
@@ -60,6 +63,7 @@ git-merge-recursive
 git-merge-resolve
 git-merge-stupid
 git-mktag
+git-mktree
 git-name-rev
 git-mv
 git-pack-redundant
-- 
1.2.3.g809d

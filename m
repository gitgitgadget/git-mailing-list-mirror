X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/2] Added completion support for git-branch.exe.
Date: Sat, 4 Nov 2006 13:57:18 -0500
Message-ID: <20061104185718.GA2500@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 18:57:46 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
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
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30934>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgQi5-0007eW-UD for gcvg-git@gmane.org; Sat, 04 Nov
 2006 19:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965606AbWKDS5Z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 13:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965607AbWKDS5Z
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 13:57:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56546 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S965606AbWKDS5Y
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 13:57:24 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgQhg-0007Bn-1S; Sat, 04 Nov 2006 13:57:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 973D120E491; Sat,  4 Nov 2006 13:57:18 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Cygwin a user might complete the new git-branch builtin as
git-branch.exe, at which point bash requires a new completion
registration for the command.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b074f4f..b7b8a43 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -339,6 +339,7 @@ complete -o default -o nospace -F _git_l
 # when the user has tab-completed the executable name and consequently
 # included the '.exe' suffix.
 #
+complete -o default            -F _git_branch git-branch.exe
 complete -o default -o nospace -F _git_cat_file git-cat-file.exe
 complete -o default -o nospace -F _git_diff git-diff.exe
 complete -o default -o nospace -F _git_diff_tree git-diff-tree.exe
-- 
1.4.3.3.g1a30

From: Willy Tarreau <w@1wt.eu>
Subject: [PATCH] minor typo fix for git-rebase
Date: Sun, 8 Aug 2010 07:30:01 +0200
Message-ID: <20100808053001.GD8115@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 07:30:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhySm-00073J-8Z
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 07:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab0HHFaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 01:30:04 -0400
Received: from 1wt.eu ([62.212.114.60]:40210 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751732Ab0HHFaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 01:30:03 -0400
Received: (from willy@localhost)
	by mail.home.local (8.14.4/8.14.4/Submit) id o785U1wM011840
	for git@vger.kernel.org; Sun, 8 Aug 2010 07:30:01 +0200
Content-Disposition: inline
User-Agent: Mutt/1.4.2.3i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152894>

Hi !

I found the minor typo below while reading the script.

Cheers,
Willy

--------
From 54fbcaabbd2c9d6da1b51a35114838797585cb06 Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sun, 8 Aug 2010 07:13:32 +0200
Subject: git-rebase: fix typo when parsing --force-rebase

Due to two missing hyphens, The "force" keyword on the command line
would be taken as an alias for the --force-rebase option.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 git-rebase.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 2d88742..1d38afd 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -346,7 +346,7 @@ do
 	--root)
 		rebase_root=t
 		;;
-	-f|--f|--fo|--for|--forc|force|--force-r|--force-re|--force-reb|--force-reba|--force-rebas|--force-rebase|--no-ff)
+	-f|--f|--fo|--for|--forc|--force|--force-r|--force-re|--force-reb|--force-reba|--force-rebas|--force-rebase|--no-ff)
 		force_rebase=t
 		;;
 	--rerere-autoupdate|--no-rerere-autoupdate)
-- 
1.6.4.4

From: Kevin Geiss <kevin@desertsol.com>
Subject: [PATCH 3/4] git-cvsexportcommit.perl: exit with non-0 status if patch fails.
Date: Mon, 14 Nov 2005 09:42:36 -0700
Message-ID: <20051114164236.GD9131@raven.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 17:43:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbhPk-0006vI-4S
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 17:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbVKNQmh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 11:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVKNQmh
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 11:42:37 -0500
Received: from 12-219-167-192.client.mchsi.com ([12.219.167.192]:54913 "EHLO
	desertsol.com") by vger.kernel.org with ESMTP id S1751182AbVKNQmh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 11:42:37 -0500
Received: from kevin by desertsol.com with local (Exim 4.50)
	id 1EbhPg-00084q-Si; Mon, 14 Nov 2005 09:42:36 -0700
To: martin.langhoff@gmail.com
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11813>

---

 git-cvsexportcommit.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 7e45b599120811e135c41136fae7570af7f5437b
f615833f7dad1372b93c90814674e13800e4bd63
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index da7dcda..d49494a 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -190,7 +190,7 @@ if ($dirtypatch) {
     print "NOTE: One or more hunks failed to apply cleanly.\n";
     print "Resolve the conflicts and then commit using:n";
     print "\n    $cmd\n\n";
-    exit;
+    exit(1);
 }
 
 
---
0.99.9.GIT

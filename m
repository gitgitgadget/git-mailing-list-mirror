From: Abhijit Menon-Sen <ams@toroid.org>
Subject: [PATCH] `git submodule add` now requires a <path>
Date: Wed, 30 Jul 2008 01:23:16 +0530
Message-ID: <1217361196-25143-1-git-send-email-ams@toroid.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 21:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNvH1-0007oD-Me
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 21:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbYG2TxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 15:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbYG2TxT
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 15:53:19 -0400
Received: from fugue.toroid.org ([85.10.196.113]:49467 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750897AbYG2TxS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 15:53:18 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 787255583D8;
	Tue, 29 Jul 2008 21:53:17 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id 7D931ADC369; Wed, 30 Jul 2008 01:23:16 +0530 (IST)
X-Mailer: git-send-email 1.6.0.rc0.43.g2aa74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90677>


Signed-off-by: Abhijit Menon-Sen <ams@toroid.org>
---
 Documentation/user-manual.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index c5641af..00256ca 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3458,7 +3458,7 @@ $ cd super
 $ git init
 $ for i in a b c d
 do
-	git submodule add ~/git/$i
+	git submodule add ~/git/$i $i
 done
 -------------------------------------------------
 
@@ -3471,10 +3471,10 @@ $ ls -a
 .  ..  .git  .gitmodules  a  b  c  d
 -------------------------------------------------
 
-The `git-submodule add` command does a couple of things:
+The `git-submodule add <repo> <path>` command does a couple of things:
 
-- It clones the submodule under the current directory and by default checks out
-  the master branch.
+- It clones the submodule from <repo> to the given <path> under the
+  current directory and by default checks out the master branch.
 - It adds the submodule's clone path to the linkgit:gitmodules[5] file and
   adds this file to the index, ready to be committed.
 - It adds the submodule's current commit ID to the index, ready to be
-- 
1.6.0.rc0.43.g2aa74

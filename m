From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 4/6] user-manual: use pithier example commit
Date: Sun, 26 Aug 2007 12:17:00 -0400
Message-ID: <1960.26424314386$1188145075@news.gmane.org>
References: <11881450221019-git-send-email->
 <11881450231606-git-send-email->
 <11881450231010-git-send-email->
 <11881450233251-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 26 18:17:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPKo8-0003GX-Dz
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 18:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbXHZQRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 12:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753237AbXHZQRV
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 12:17:21 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57986 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753167AbXHZQRF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 12:17:05 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IPKnP-0007U0-8p; Sun, 26 Aug 2007 12:17:03 -0400
X-Mailer: git-send-email 1.5.2.2.238.g7cbf2f2
In-Reply-To: <11881450233251-git-send-email->
Message-Id: <e2618ff42716dd7cbc7a353670f46f357c5fb4c5.1188139206.git.bfields@citi.umich.edu>
In-Reply-To: <464a8a7a15fc70efbcf56c4569f0f7275a9c76fe.1188139206.git.bfields@citi.umich.edu>
References: <464a8a7a15fc70efbcf56c4569f0f7275a9c76fe.1188139206.git.bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56699>

From: J. Bruce Fields <bfields@citi.umich.edu>

Actually, we should have a competition for the favorite example commit.
Criteria:

	- length: one-line changes with one-line comments preferred,
	  and no long lines
	- significance/memorability
	- comic value

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   45 ++++++++++++++++++----------------------
 1 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 6d35a1f..77e73bf 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -145,32 +145,27 @@ current branch:
 
 ------------------------------------------------
 $ git show
-commit 2b5f6dcce5bf94b9b119e9ed8d537098ec61c3d2
-Author: Jamal Hadi Salim <hadi@cyberus.ca>
-Date:   Sat Dec 2 22:22:25 2006 -0800
-
-    [XFRM]: Fix aevent structuring to be more complete.
-    
-    aevents can not uniquely identify an SA. We break the ABI with this
-    patch, but consensus is that since it is not yet utilized by any
-    (known) application then it is fine (better do it now than later).
-    
-    Signed-off-by: Jamal Hadi Salim <hadi@cyberus.ca>
-    Signed-off-by: David S. Miller <davem@davemloft.net>
-
-diff --git a/Documentation/networking/xfrm_sync.txt b/Documentation/networking/xfrm_sync.txt
-index 8be626f..d7aac9d 100644
---- a/Documentation/networking/xfrm_sync.txt
-+++ b/Documentation/networking/xfrm_sync.txt
-@@ -47,10 +47,13 @@ aevent_id structure looks like:
+commit 17cf781661e6d38f737f15f53ab552f1e95960d7
+Author: Linus Torvalds <torvalds@ppc970.osdl.org.(none)>
+Date:   Tue Apr 19 14:11:06 2005 -0700
+
+    Remove duplicate getenv(DB_ENVIRONMENT) call
+
+    Noted by Tony Luck.
+
+diff --git a/init-db.c b/init-db.c
+index 65898fa..b002dc6 100644
+--- a/init-db.c
++++ b/init-db.c
+@@ -7,7 +7,7 @@
  
-    struct xfrm_aevent_id {
-              struct xfrm_usersa_id           sa_id;
-+             xfrm_address_t                  saddr;
-              __u32                           flags;
-+             __u32                           reqid;
-    };
-...
+ int main(int argc, char **argv)
+ {
+-	char *sha1_dir = getenv(DB_ENVIRONMENT), *path;
++	char *sha1_dir, *path;
+ 	int len, i;
+ 
+ 	if (mkdir(".git", 0755) < 0) {
 ------------------------------------------------
 
 As you can see, a commit shows who made the latest change, what they
-- 
1.5.3.rc5.19.g0734d

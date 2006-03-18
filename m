From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Clarify git-rebase example commands.
Date: Fri, 17 Mar 2006 18:25:30 -0600
Message-ID: <E1FKPG6-00062H-Ds@jdl.com>
X-From: git-owner@vger.kernel.org Sat Mar 18 01:25:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKPGT-0006lL-SQ
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 01:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbWCRAZt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 19:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932786AbWCRAZt
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 19:25:49 -0500
Received: from colo.jdl.com ([66.118.10.122]:16269 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932781AbWCRAZs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Mar 2006 19:25:48 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FKPG6-00062H-Ds
	for git@vger.kernel.org; Fri, 17 Mar 2006 18:25:31 -0600
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17677>


Signed-off-by: Jon Loeliger <jdl@jdl.com>


---

 Documentation/git-rebase.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

f59f6f2e8da2e6260ad9585734010b5ea1cd7c2a
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 4d5b546..b36276c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -25,7 +25,7 @@ Assume the following history exists and 
          /
     D---E---F---G master
 
-From this point, the result of the following commands:
+From this point, the result of either of the following commands:
 
     git-rebase master
     git-rebase master topic
@@ -36,7 +36,7 @@ would be:
                  /
     D---E---F---G master
 
-While, starting from the same point, the result of the following
+While, starting from the same point, the result of either of the following
 commands:
 
     git-rebase --onto master~1 master
@@ -58,7 +58,7 @@ OPTIONS
 <upstream>::
 	Upstream branch to compare against.
 
-<head>::
+<branch>::
 	Working branch; defaults to HEAD.
 
 Author
-- 
1.2.4.gdd7be

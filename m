From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/3] git p4: update name in script
Date: Sun,  8 Apr 2012 20:18:01 -0400
Message-ID: <1333930682-31670-3-git-send-email-pw@padd.com>
References: <1333930682-31670-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 02:18:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SH2Jm-0004kO-2q
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 02:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756233Ab2DIASp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 20:18:45 -0400
Received: from honk.padd.com ([74.3.171.149]:45573 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755942Ab2DIASp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 20:18:45 -0400
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id A6DD73122;
	Sun,  8 Apr 2012 17:18:44 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 5CB00313D3; Sun,  8 Apr 2012 20:18:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.56.gfc226
In-Reply-To: <1333930682-31670-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195008>

In messages to the user and comments, change "git-p4" to "git p4".

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c5362c4..f910d5a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1129,12 +1129,12 @@ class P4Submit(Command, P4UserMap):
                     print "The following files should be scheduled for deletion with p4 delete:"
                     print " ".join(filesToDelete)
                 die("Please resolve and submit the conflict manually and "
-                    + "continue afterwards with git-p4 submit --continue")
+                    + "continue afterwards with git p4 submit --continue")
             elif response == "w":
                 system(diffcmd + " > patch.txt")
                 print "Patch saved to patch.txt in %s !" % self.clientPath
                 die("Please resolve and submit the conflict manually and "
-                    "continue afterwards with git-p4 submit --continue")
+                    "continue afterwards with git p4 submit --continue")
 
         system(applyPatchCmd)
 
@@ -1178,8 +1178,8 @@ class P4Submit(Command, P4UserMap):
 
             if self.checkAuthorship and not self.p4UserIsMe(p4User):
                 submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
-                submitTemplate += "######## Use git-p4 option --preserve-user to modify authorship\n"
-                submitTemplate += "######## Use git-p4 config git-p4.skipUserNameCheck hides this message.\n"
+                submitTemplate += "######## Use option --preserve-user to modify authorship.\n"
+                submitTemplate += "######## Variable git-p4.skipUserNameCheck hides this message.\n"
 
             separatorLine = "######## everything below this line is just the diff #######\n"
 
@@ -2254,7 +2254,7 @@ class P4Sync(Command, P4UserMap):
 
         details["change"] = newestRevision
 
-        # Use time from top-most change so that all git-p4 clones of
+        # Use time from top-most change so that all git p4 clones of
         # the same p4 repo have the same commit SHA1s.
         res = p4CmdList("describe -s %d" % newestRevision)
         newestTime = None
@@ -2474,8 +2474,8 @@ class P4Sync(Command, P4UserMap):
 
                 changes.sort()
             else:
-                # catch "git-p4 sync" with no new branches, in a repo that
-                # does not have any existing git-p4 branches
+                # catch "git p4 sync" with no new branches, in a repo that
+                # does not have any existing p4 branches
                 if len(args) == 0 and not self.p4BranchesInGit:
                     die("No remote p4 branches.  Perhaps you never did \"git p4 clone\" in here.");
                 if self.verbose:
-- 
1.7.10.4.gb369

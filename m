From: Pete Wyckoff <pw@padd.com>
Subject: [RFC PATCH 2/3] git p4: update name in script
Date: Sun, 12 Feb 2012 13:13:42 -0500
Message-ID: <1329070423-23761-3-git-send-email-pw@padd.com>
References: <1329070423-23761-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>,
	Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 19:14:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwdwV-0004ec-Mx
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 19:14:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701Ab2BLSO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 13:14:27 -0500
Received: from honk.padd.com ([74.3.171.149]:39187 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755680Ab2BLSO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 13:14:26 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 4F6C6E8B;
	Sun, 12 Feb 2012 10:14:26 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 27570313C6; Sun, 12 Feb 2012 13:14:24 -0500 (EST)
X-Mailer: git-send-email 1.7.9.193.g1d4a5
In-Reply-To: <1329070423-23761-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190586>

In messages to the user and comments, change "git-p4" to "git p4".

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index a78d9c5..1e27d70 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -988,12 +988,12 @@ class P4Submit(Command, P4UserMap):
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
 
@@ -1037,8 +1037,8 @@ class P4Submit(Command, P4UserMap):
 
             if self.checkAuthorship and not self.p4UserIsMe(p4User):
                 submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
-                submitTemplate += "######## Use git-p4 option --preserve-user to modify authorship\n"
-                submitTemplate += "######## Use git-p4 config git-p4.skipUserNameCheck hides this message.\n"
+                submitTemplate += "######## Use option --preserve-user to modify authorship.\n"
+                submitTemplate += "######## Variable git-p4.skipUserNameCheck hides this message.\n"
 
             separatorLine = "######## everything below this line is just the diff #######\n"
 
@@ -2106,7 +2106,7 @@ class P4Sync(Command, P4UserMap):
 
         details["change"] = newestRevision
 
-        # Use time from top-most change so that all git-p4 clones of
+        # Use time from top-most change so that all git p4 clones of
         # the same p4 repo have the same commit SHA1s.
         res = p4CmdList("describe -s %d" % newestRevision)
         newestTime = None
@@ -2349,8 +2349,8 @@ class P4Sync(Command, P4UserMap):
 
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
1.7.9.192.ga1d4b

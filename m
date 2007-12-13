From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH resending] Fix spelling mistakes in user manual
Date: Wed, 12 Dec 2007 22:36:21 -0600
Message-ID: <1197520581-23376-1-git-send-email-shawn.bohrer@gmail.com>
Cc: git@vger.kernel.org, Shawn Bohrer <shawn.bohrer@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Dec 13 05:36:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2fnv-0000lC-Ah
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 05:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbXLMEft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 23:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbXLMEfs
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 23:35:48 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:19440 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbXLMEfs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 23:35:48 -0500
Received: by an-out-0708.google.com with SMTP id d31so145289and.103
        for <git@vger.kernel.org>; Wed, 12 Dec 2007 20:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=/gajs1wAoPTiJ5LfuQ273prDbasJVq8rt6lvA1mDBJM=;
        b=RAX1W7xuPMPTF/5IU4FoXqD5FGb8mKdYybFPUe7G2viQEPSiPGNzkeYqdnustBDkS5tOGWZCReWDf9A/3rmPdsk1n6yebX/pU6lPpTTlDp3g2d8H3OxskCumc95AiQfE64SRVNr6q5FE8PucQ/sN11IBk9tuAQ6nJoAYfBNIsbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DHT064y+yaGPOXzpXRTh8XcojoIpNHI68IIa+QGaS7C4sWDSuU47ABLke/hRhC99TYy4oMQt5kmf3ctO9fbr/QYe2dD9MP1SKwSHQYL1CV37MUl62oeQ6Lxu5r9OOZyIgo1DsilnrHAQOD9kMx6T7/Lg4aHpde1WSwkpDHSSp8g=
Received: by 10.101.68.19 with SMTP id v19mr3119011ank.104.1197520547059;
        Wed, 12 Dec 2007 20:35:47 -0800 (PST)
Received: from mediacenter ( [70.112.149.232])
        by mx.google.com with ESMTPS id s36sm8958948rnf.2007.12.12.20.35.42
        (version=SSLv3 cipher=OTHER);
        Wed, 12 Dec 2007 20:35:43 -0800 (PST)
Received: by mediacenter (sSMTP sendmail emulation); Wed, 12 Dec 2007 22:36:21 -0600
X-Mailer: git-send-email 1.5.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68119>

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---

Not sure if this got lost, but I haven't see it applied and figured I
should resend.

 Documentation/user-manual.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 93a47b4..f2b4206 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1994,7 +1994,7 @@ $ git push ssh://yourserver.com/~you/proj.git +master
 -------------------------------------------------
 
 Normally whenever a branch head in a public repository is modified, it
-is modified to point to a descendent of the commit that it pointed to
+is modified to point to a descendant of the commit that it pointed to
 before.  By forcing a push in this situation, you break that convention.
 (See <<problems-with-rewriting-history>>.)
 
@@ -2921,7 +2921,7 @@ As you can see, a commit is defined by:
 - a tree: The SHA1 name of a tree object (as defined below), representing
   the contents of a directory at a certain point in time.
 - parent(s): The SHA1 name of some number of commits which represent the
-  immediately prevoius step(s) in the history of the project.  The
+  immediately previous step(s) in the history of the project.  The
   example above has one parent; merge commits may have more than
   one.  A commit with no parents is called a "root" commit, and
   represents the initial revision of a project.  Each project must have
@@ -3242,7 +3242,7 @@ to replace them by hand.  Back up your repository before attempting this
 in case you corrupt things even more in the process.
 
 We'll assume that the problem is a single missing or corrupted blob,
-which is sometimes a solveable problem.  (Recovering missing trees and
+which is sometimes a solvable problem.  (Recovering missing trees and
 especially commits is *much* harder).
 
 Before starting, verify that there is corruption, and figure out where
-- 
1.5.3.6

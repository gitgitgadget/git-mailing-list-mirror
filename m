From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Reference git-check-ref-format in git-branch.
Date: Sat, 20 May 2006 21:54:46 -0400
Message-ID: <20060521015446.GA7605@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 21 03:55:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhd9t-0006zs-N2
	for gcvg-git@gmane.org; Sun, 21 May 2006 03:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWEUByy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 21:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWEUByy
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 21:54:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44242 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751004AbWEUByx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 21:54:53 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fhd9U-0005iy-I1; Sat, 20 May 2006 21:54:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DCA90212691; Sat, 20 May 2006 21:54:46 -0400 (EDT)
To: Junio Hamano <junkio@cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20423>

Its nice to have git-check-ref-format actually get mentioned in
git-branch's documentation as the syntax of a ref name must conform
to what is described in git-check-ref-format.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

---
 Sorry about this patch being built on pu.  It clearly has no
 relationship to current pu, but the new -l appears in the hunk
 below...

1e2080dcf2f8e76e0fcf48684e5c6b182f695e0a
 Documentation/git-branch.txt   |    3 +++
 Documentation/git-checkout.txt |    5 ++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

1e2080dcf2f8e76e0fcf48684e5c6b182f695e0a
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index a7bec3c..d43ef1d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -49,6 +49,9 @@ OPTIONS
 
 <branchname>::
 	The name of the branch to create or delete.
+	The new branch name must pass all checks defined by
+	gitlink:git-check-ref-format[1].  Some of these checks
+	may restrict the characters allowed in a branch name.
 
 <start-point>::
 	The new branch will be created with a HEAD equal to this.  It may
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 0643943..fbdbadc 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -35,7 +35,10 @@ OPTIONS
 	Force a re-read of everything.
 
 -b::
-	Create a new branch and start it at <branch>.
+	Create a new branch named <new_branch> and start it at
+	<branch>.  The new branch name must pass all checks defined
+	by gitlink:git-check-ref-format[1].  Some of these checks
+	may restrict the characters allowed in a branch name.
 
 -l::
 	Create the new branch's ref log.  This activates recording of
-- 
1.3.3.gfad60

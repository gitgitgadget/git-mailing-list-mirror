From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH master] git p4 doc: fix formatting
Date: Sun, 6 May 2012 11:56:50 -0400
Message-ID: <20120506155650.GA12106@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 17:57:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR3pT-0006EO-HG
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 17:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888Ab2EFP4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 11:56:54 -0400
Received: from honk.padd.com ([74.3.171.149]:60222 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753851Ab2EFP4y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 11:56:54 -0400
Received: from arf.padd.com (unknown [50.55.155.59])
	by honk.padd.com (Postfix) with ESMTPSA id AE3C2D27;
	Sun,  6 May 2012 08:56:53 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 31CD85E827; Sun,  6 May 2012 11:56:50 -0400 (EDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197198>

Attach example sections to previous level of indenting.

Fix a trailing ::

Signed-off-by: Pete Wyckoff <pw@padd.com>
---

The nice git-scm.com redo made me proofread this doc.

Patch on origin/master.

Even though this looks like a job for maint, both hunks
will collide there.  maint version follows.

		-- Pete

 Documentation/git-p4.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 51955a5..fe1f49b 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -179,6 +179,7 @@ subsequent 'sync' operations.
 +
 This example imports a new remote "p4/proj2" into an existing
 git repository:
++
 ----
     $ git init
     $ git p4 sync --branch=refs/remotes/p4/proj2 //depot/proj2
@@ -438,7 +439,7 @@ git-p4.branchList::
 	enabled.  Each entry should be a pair of branch names separated
 	by a colon (:).  This example declares that both branchA and
 	branchB were created from main:
-
++
 -------------
 git config       git-p4.branchList main:branchA
 git config --add git-p4.branchList main:branchB
@@ -503,7 +504,7 @@ git-p4.skipUserNameCheck::
 	user map, 'git p4' exits.  This option can be used to force
 	submission regardless.
 
-git-p4.attemptRCSCleanup:
+git-p4.attemptRCSCleanup::
 	If enabled, 'git p4 submit' will attempt to cleanup RCS keywords
 	($Header$, etc). These would otherwise cause merge conflicts and prevent
 	the submit going ahead. This option should be considered experimental at
-- 
1.7.10.1.510.g2648e0e

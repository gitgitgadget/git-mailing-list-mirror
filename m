From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [PATCH] Documentation: Fix broken links
Date: Thu, 14 Sep 2006 05:04:33 +0400
Message-ID: <20060914010433.GC20593@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 14 03:04:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNfeg-0004bP-EV
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 03:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWINBEf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 21:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWINBEf
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 21:04:35 -0400
Received: from mh.altlinux.org ([217.16.24.5]:27288 "EHLO mh.altlinux.org")
	by vger.kernel.org with ESMTP id S1751301AbWINBEe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Sep 2006 21:04:34 -0400
Received: from nomad.office.altlinux.org (localhost.localdomain [127.0.0.1])
	by mh.altlinux.org (Postfix) with ESMTP
	id 46E302F3000D; Thu, 14 Sep 2006 05:04:33 +0400 (MSD)
Received: by nomad.office.altlinux.org (Postfix, from userid 501)
	id 5D18317103; Thu, 14 Sep 2006 05:04:33 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26970>

core-tutorial.txt, cvs-migration.txt, tutorial-2.txt:
	Fix broken links.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 Documentation/core-tutorial.txt |    2 +-
 Documentation/cvs-migration.txt |    2 +-
 Documentation/tutorial-2.txt    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 1185897..47505aa 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -1620,7 +1620,7 @@ suggested in the previous section may be
 have to worry. git supports "shared public repository" style of
 cooperation you are probably more familiar with as well.
 
-See link:cvs-migration.txt[git for CVS users] for the details.
+See link:cvs-migration.html[git for CVS users] for the details.
 
 Bundling your work together
 ---------------------------
diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index d2b0bd3..6812683 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -172,7 +172,7 @@ Advanced Shared Repository Management
 
 Git allows you to specify scripts called "hooks" to be run at certain
 points.  You can use these, for example, to send all commits to the shared
-repository to a mailing list.  See link:hooks.txt[Hooks used by git].
+repository to a mailing list.  See link:hooks.html[Hooks used by git].
 
 You can enforce finer grained permissions using update hooks.  See
 link:howto/update-hook-example.txt[Controlling access to branches using
diff --git a/Documentation/tutorial-2.txt b/Documentation/tutorial-2.txt
index 2f4fe12..42b6e7d 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/tutorial-2.txt
@@ -368,7 +368,7 @@ in the index file is identical to the on
 In addition to being the staging area for new commits, the index file
 is also populated from the object database when checking out a
 branch, and is used to hold the trees involved in a merge operation.
-See the link:core-tutorial.txt[core tutorial] and the relevant man
+See the link:core-tutorial.html[core tutorial] and the relevant man
 pages for details.
 
 What next?


-- 
ldv

From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: PATCH] cvsimport: Clarification on the use of -r
Date: Sun, 15 Jun 2008 15:05:28 +0200
Message-ID: <200806151505.28987.robin.rosenberg.lists@dewire.com>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz> <m3od63ozuf.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 15:10:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7rzz-0001E2-Pw
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 15:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757408AbYFONJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 09:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754013AbYFONI6
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 09:08:58 -0400
Received: from [83.140.172.130] ([83.140.172.130]:18959 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753461AbYFONI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 09:08:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E98ED1456A30;
	Sun, 15 Jun 2008 15:08:54 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W9ikd9p5PtxY; Sun, 15 Jun 2008 15:08:54 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 3C56B8006AA;
	Sun, 15 Jun 2008 15:08:54 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <m3od63ozuf.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85086>


Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 Documentation/git-cvsimport.txt |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 2f9b35f..b873882 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -28,8 +28,12 @@ You should *never* do any work of your own on the branches that are
 created by git-cvsimport.  By default initial import will create and populate a
 "master" branch from the CVS repository's main branch which you're free
 to work with; after that, you need to 'git merge' incremental imports, or
-any CVS branches, yourself.  It is advisable to specify a named remote via
--r to separate and protect the incoming branches.
+any CVS branches, yourself.
+
+It is advisable to specify a named remote via -r to separate and protect
+the incoming branches if you intend to do your work in the same repository. If
+you want to have a cvs import-only repostory which you clone to your work
+repository, then do not use the -r option.
 
 
 OPTIONS
@@ -56,7 +60,7 @@ OPTIONS
 -r <remote>::
 	The git remote to import this CVS repository into.
 	Moves all CVS branches into remotes/<remote>/<branch>
-	akin to the git-clone --use-separate-remote option.
+	akin what git clone does when cloning a repository.
 
 -o <branch-for-HEAD>::
 	When no remote is specified (via -r) the 'HEAD' branch
-- 
1.5.5.1.178.g1f811

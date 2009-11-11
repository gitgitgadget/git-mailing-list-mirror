From: Peter Krefting <peter@softwolves.pp.se>
Subject: [PATCH] Clarify documentation on the "ours" merge strategy.
Date: Wed, 11 Nov 2009 15:03:32 +0100
Message-ID: <200911111411.nABEBfox031023@ds9.cixit.se>
References: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 11 15:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8E57-0002Ft-OK
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 15:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755621AbZKKOVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 09:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754979AbZKKOVp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 09:21:45 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:53798 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754800AbZKKOVp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 09:21:45 -0500
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Nov 2009 09:21:45 EST
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id nABEBfDl031024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 11 Nov 2009 15:11:41 +0100
Received: (from peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) id nABEBfox031023;
	Wed, 11 Nov 2009 15:11:41 +0100
In-Reply-To: <alpine.DEB.1.00.0911031047510.4985@pacific.mpi-cbg.de>
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 11 Nov 2009 15:11:41 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132659>

Make it clear that the merge strategy will discard all changes made to
the branch being merged, and not just avoid creating merge conflicts.
---
 Documentation/merge-strategies.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

> If you want to use any merge strategy, you must understand what it does
> first.

Indeed. Perhaps this clarification will help the next poor soul that tries
doing what I tried?

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 4365b7e..a340dc9 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -30,7 +30,8 @@ octopus::
 
 ours::
 	This resolves any number of heads, but the result of the
-	merge is always the current branch head.  It is meant to
+	merge is always the current branch head, discarding any
+	changes on the merged branch.  It is meant to
 	be used to supersede old development history of side
 	branches.
 
-- 
1.6.4

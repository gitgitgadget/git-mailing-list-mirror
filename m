From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] git-blame: Kill warning "print_map defined but not used"
Date: Sun, 5 Mar 2006 12:16:50 +0100
Message-ID: <20060305111650.GC23448@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Mar 05 12:17:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFrEM-0006MI-83
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 12:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWCELQv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 06:16:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWCELQv
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 06:16:51 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:3050 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1750910AbWCELQv
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Mar 2006 06:16:51 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id B557F4118; Sun,  5 Mar 2006 12:32:09 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FFrEI-0001or-00; Sun, 05 Mar 2006 12:16:50 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17223>


Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 blame.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

aebef8969d11b04634b9ab7a6ae85a0844b2e4c7
diff --git a/blame.c b/blame.c
index 6dccae5..0fb30ee 100644
--- a/blame.c
+++ b/blame.c
@@ -235,6 +235,7 @@ static void print_patch(struct patch *p)
 }
 
 /* For debugging only */
+#if DEBUG
 static void print_map(struct commit *cmit, struct commit *other)
 {
 	struct util_info *util = cmit->object.util;
@@ -267,6 +268,7 @@ static void print_map(struct commit *cmi
 		printf("\n");
 	}
 }
+#endif
 
 // p is a patch from commit to other.
 static void fill_line_map(struct commit *commit, struct commit *other,
-- 
1.2.4.g4644-dirty

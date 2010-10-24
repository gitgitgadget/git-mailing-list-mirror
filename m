From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Fix copy-pasted comments related to tree diff handling.
Date: Sun, 24 Oct 2010 23:03:10 +0200
Message-ID: <1287954190-13905-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 23:03:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA7j1-0006td-BR
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 23:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933463Ab0JXVDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 17:03:21 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:40862 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933294Ab0JXVDT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 17:03:19 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 46D90D480DB;
	Sun, 24 Oct 2010 23:03:13 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PA7ih-0003cm-Vt; Sun, 24 Oct 2010 23:03:11 +0200
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159891>

---
 diff.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 71efa8e..ba57bfa 100644
--- a/diff.c
+++ b/diff.c
@@ -3532,7 +3532,7 @@ static void diff_flush_stat(struct diff_filepair *p, struct diff_options *o,
 
 	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
 	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
-		return; /* no tree diffs in patch format */
+		return; /* no useful stat for tree diffs */
 
 	run_diffstat(p, o, diffstat);
 }
@@ -3545,7 +3545,7 @@ static void diff_flush_checkdiff(struct diff_filepair *p,
 
 	if ((DIFF_FILE_VALID(p->one) && S_ISDIR(p->one->mode)) ||
 	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
-		return; /* no tree diffs in patch format */
+		return; /* nothing to check in tree diffs */
 
 	run_checkdiff(p, o);
 }
-- 
1.7.2.3

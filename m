From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] apply: delete unused deflate_origlen from patch struct
Date: Thu,  2 Aug 2012 18:25:30 -0400
Message-ID: <1343946330-20379-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 00:25:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx3px-0002j5-WE
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 00:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723Ab2HBWZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 18:25:41 -0400
Received: from mail.windriver.com ([147.11.1.11]:61273 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab2HBWZk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 18:25:40 -0400
Received: from yow-pgortmak-d1.corp.ad.wrs.com (yow-pgortmak-d1.wrs.com [128.224.146.65])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q72MPdue016665;
	Thu, 2 Aug 2012 15:25:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc1.1.ga9c166e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202807>

It hasn't been used since 2006, as of commit 3cd4f5e8

    "git-apply --binary: clean up and prepare for --reverse"

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/builtin/apply.c b/builtin/apply.c
index d453c83..3bf71dc 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -188,7 +188,6 @@ struct patch {
 	int is_new, is_delete;	/* -1 = unknown, 0 = false, 1 = true */
 	int rejected;
 	unsigned ws_rule;
-	unsigned long deflate_origlen;
 	int lines_added, lines_deleted;
 	int score;
 	unsigned int is_toplevel_relative:1;
-- 
1.7.12.rc1.1.ga9c166e

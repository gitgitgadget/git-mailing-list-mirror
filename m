From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Sync "git diff -h" with the manual, show options summary.
Date: Fri,  1 Oct 2010 09:32:45 +0200
Message-ID: <1285918365-15723-1-git-send-email-ydirson@altern.org>
Cc: Yann Dirson <ydirson@altern.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 01 09:23:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1Zxt-0007ER-FK
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 09:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949Ab0JAHX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 03:23:27 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:42564 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862Ab0JAHX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 03:23:27 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 725B5D48187;
	Fri,  1 Oct 2010 09:23:21 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P1a72-000467-3K; Fri, 01 Oct 2010 09:33:00 +0200
X-Mailer: git-send-email 1.7.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157736>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---
 builtin/diff.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index a43d326..8736225 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -22,7 +22,8 @@ struct blobinfo {
 };
 
 static const char builtin_diff_usage[] =
-"git diff <options> <rev>{0,2} -- <path>*";
+"git diff [<common diff options>] <commit>{0,2} -- <path>*"
+COMMON_DIFF_OPTIONS_HELP;
 
 static void stuff_change(struct diff_options *opt,
 			 unsigned old_mode, unsigned new_mode,
-- 
1.7.2.3

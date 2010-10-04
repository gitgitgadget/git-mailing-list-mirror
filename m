From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 1/2] diffcore-pickaxe.c: remove unnecessary curly braces
Date: Mon,  4 Oct 2010 17:51:47 -0500
Message-ID: <7B67fI3-KUXNMcC63_TwzSz0R5IrKAQx1Xuml4Po0PYEJroaM3Kd71QYcXsJK6NsImqnd3Sd4t0@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 05 00:52:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2ttI-0005eG-22
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 00:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757340Ab0JDWwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 18:52:10 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48800 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab0JDWwK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 18:52:10 -0400
Received: by mail.nrlssc.navy.mil id o94Mq1qk012170; Mon, 4 Oct 2010 17:52:01 -0500
X-OriginalArrivalTime: 04 Oct 2010 22:52:01.0136 (UTC) FILETIME=[C1A97F00:01CB6416]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158139>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 diffcore-pickaxe.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 84195e4..3857099 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -269,9 +269,8 @@ static void diffcore_pickaxe_count(struct diff_options *o)
 				diff_free_filepair(p);
 		}
 
-	if (opts & DIFF_PICKAXE_REGEX) {
+	if (opts & DIFF_PICKAXE_REGEX)
 		regfree(&regex);
-	}
 
 	free(q->queue);
 	*q = outq;
-- 
1.7.3.1

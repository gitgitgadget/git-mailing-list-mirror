From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] diffcore-pickaxe.c: a void function shouldn't try to return something
Date: Mon,  4 Oct 2010 17:51:48 -0500
Message-ID: <7B67fI3-KUXNMcC63_TwzWm3yMw3MBsO-UId6DCtnNEi0B_PuBGQVjh0xBHrwD3jb3ptTcw5d38@cipher.nrlssc.navy.mil>
References: <7B67fI3-KUXNMcC63_TwzSz0R5IrKAQx1Xuml4Po0PYEJroaM3Kd71QYcXsJK6NsImqnd3Sd4t0@cipher.nrlssc.navy.mil>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 05 00:52:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2ttT-0005fe-Bo
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 00:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757343Ab0JDWwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 18:52:15 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48802 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab0JDWwP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 18:52:15 -0400
Received: by mail.nrlssc.navy.mil id o94Mq4eE012178; Mon, 4 Oct 2010 17:52:04 -0500
In-Reply-To: <7B67fI3-KUXNMcC63_TwzSz0R5IrKAQx1Xuml4Po0PYEJroaM3Kd71QYcXsJK6NsImqnd3Sd4t0@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 04 Oct 2010 22:52:04.0699 (UTC) FILETIME=[C3C92AB0:01CB6416]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158140>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 diffcore-pickaxe.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 3857099..ea03b91 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -281,7 +281,7 @@ void diffcore_pickaxe(struct diff_options *o)
 {
 	/* Might want to warn when both S and G are on; I don't care... */
 	if (o->pickaxe_opts & DIFF_PICKAXE_KIND_G)
-		return diffcore_pickaxe_grep(o);
+		diffcore_pickaxe_grep(o);
 	else
-		return diffcore_pickaxe_count(o);
+		diffcore_pickaxe_count(o);
 }
-- 
1.7.3.1

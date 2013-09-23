From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] git-prune-packed.txt: Fix reference to GIT_OBJECT_DIRECTORY
Date: Mon, 23 Sep 2013 21:19:19 +0200
Message-ID: <1379963959-14774-1-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 21:20:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOBfv-0007Ef-JO
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 21:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652Ab3IWTT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 15:19:59 -0400
Received: from mailer.zib.de ([130.73.108.11]:63770 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555Ab3IWTT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 15:19:58 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id r8NJJWdk011653;
	Mon, 23 Sep 2013 21:19:32 +0200 (CEST)
Received: from vss6.zib.de (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id r8NJJWMU011648;
	Mon, 23 Sep 2013 21:19:32 +0200 (CEST)
X-Mailer: git-send-email 1.8.4.rc0.11.g35f5eaa
X-Miltered: at mailer.zib.de with ID 52409444.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 52409444.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 52409444.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235234>

git-prune-packed operates on GIT_OBJECT_DIRECTORY.  See 'environment.c',

    git_object_dir = getenv(DB_ENVIRONMENT);

and cache.h,

    #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-prune-packed.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 80dc022..6738055 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-This program searches the `$GIT_OBJECT_DIR` for all objects that currently
+This program searches the `$GIT_OBJECT_DIRECTORY` for all objects that currently
 exist in a pack file as well as the independent object directories.
 
 All such extra objects are removed.
-- 
1.8.4.477.gfa286b2

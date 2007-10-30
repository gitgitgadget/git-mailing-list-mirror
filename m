From: Emil Medve <Emilian.Medve@Freescale.com>
Subject: [PATCH] Fixed a command line option type for builtin-fsck.c
Date: Tue, 30 Oct 2007 14:15:21 -0500
Message-ID: <1193771721-2880-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
To: madcoder@debian.org, spearce@spearce.org, gitster@pobox.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 20:19:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImwcT-00088F-FO
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 20:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404AbXJ3TTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 15:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756214AbXJ3TTH
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 15:19:07 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:37682 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992AbXJ3TTF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 15:19:05 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id l9UJFXsj024469;
	Tue, 30 Oct 2007 12:15:33 -0700 (MST)
Received: from localhost.localdomain ([10.82.125.87])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9UJFWcc012710;
	Tue, 30 Oct 2007 14:15:32 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.4.1458.g3e72e-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62736>

The typo was introduced by this commit: 5ac0a2063e8f824f6e8ffb4d18de74c55aae7131

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

This patch applies to the 'next' branch

 builtin-fsck.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 64da3bd..e4874f6 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -680,7 +680,7 @@ static struct option fsck_opts[] = {
 	OPT_BOOLEAN(0, "cache", &keep_cache_objects, "make index objects head nodes"),
 	OPT_BOOLEAN(0, "reflogs", &include_reflogs, "make reflogs head nodes (default)"),
 	OPT_BOOLEAN(0, "full", &check_full, "also consider alternate objects"),
-	OPT_BOOLEAN(0, "struct", &check_strict, "enable more strict checking"),
+	OPT_BOOLEAN(0, "strict", &check_strict, "enable more strict checking"),
 	OPT_BOOLEAN(0, "lost-found", &write_lost_and_found,
 				"write dangling objects in .git/lost-found"),
 	OPT_END(),
-- 
1.5.3.4.1458.g3e72e-dirty

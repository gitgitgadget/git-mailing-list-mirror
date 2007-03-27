From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] use xrealloc in help.c
Date: Tue, 27 Mar 2007 18:30:08 -0400
Message-ID: <1175034608589-git-send-email-jbowes@dangerouslyinc.com>
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Mar 28 00:32:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWKDi-0007de-88
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 00:32:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934260AbXC0Wbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 18:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934247AbXC0Wbs
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 18:31:48 -0400
Received: from ms-smtp-01.southeast.rr.com ([24.25.9.100]:51627 "EHLO
	ms-smtp-01.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934260AbXC0Wbq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2007 18:31:46 -0400
Received: from localhost (cpe-066-057-086-146.nc.res.rr.com [66.57.86.146])
	by ms-smtp-01.southeast.rr.com (8.13.6/8.13.6) with ESMTP id l2RMViN0018612;
	Tue, 27 Mar 2007 18:31:44 -0400 (EDT)
X-Mailer: git-send-email 1.5.0.5
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43313>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---
 help.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/help.c b/help.c
index be8651a..34b1dda 100644
--- a/help.c
+++ b/help.c
@@ -54,7 +54,7 @@ static void add_cmdname(const char *name, int len)
 	struct cmdname *ent;
 	if (cmdname_alloc <= cmdname_cnt) {
 		cmdname_alloc = cmdname_alloc + 200;
-		cmdname = realloc(cmdname, cmdname_alloc * sizeof(*cmdname));
+		cmdname = xrealloc(cmdname, cmdname_alloc * sizeof(*cmdname));
 		if (!cmdname)
 			oom();
 	}
-- 
1.5.0.5

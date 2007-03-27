From: James Bowes <jbowes@dangerouslyinc.com>
Subject: [PATCH] read-tree: use xcalloc
Date: Tue, 27 Mar 2007 18:30:19 -0400
Message-ID: <11750346193538-git-send-email-jbowes@dangerouslyinc.com>
Cc: git@vger.kernel.org
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Mar 28 00:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWKDi-0007de-Ow
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 00:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934261AbXC0Wb7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 18:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934268AbXC0Wb7
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 18:31:59 -0400
Received: from ms-smtp-01.southeast.rr.com ([24.25.9.100]:51755 "EHLO
	ms-smtp-01.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934267AbXC0Wb5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2007 18:31:57 -0400
Received: from localhost (cpe-066-057-086-146.nc.res.rr.com [66.57.86.146])
	by ms-smtp-01.southeast.rr.com (8.13.6/8.13.6) with ESMTP id l2RMVt1Z018713;
	Tue, 27 Mar 2007 18:31:55 -0400 (EDT)
X-Mailer: git-send-email 1.5.0.5
X-Virus-Scanned: Symantec AntiVirus Scan Engine
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43314>

Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
---

This is the last 'replace blah with xblah' patch I'll send, honest.

 builtin-read-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 82df941..793eae0 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -184,7 +184,7 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 			if (opts.dir)
 				die("more than one --exclude-per-directory are given.");
 
-			dir = calloc(1, sizeof(*opts.dir));
+			dir = xcalloc(1, sizeof(*opts.dir));
 			dir->show_ignored = 1;
 			dir->exclude_per_dir = arg + 24;
 			opts.dir = dir;
-- 
1.5.0.5

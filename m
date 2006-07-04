From: beber.mailing@gmail.com
Subject: [PATCH] Beautifulise git-show output
Date: Tue, 4 Jul 2006 22:34:50 +0000 (UTC)
Message-ID: <11520525682686-git-send-email-beber.mailing@gmail.com>
Reply-To: beber.mailing@gmail.com
Cc: Bertrand Jacquin (Beber) <beber.mailing@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 05 00:34:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxtTV-0001QT-PK
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 00:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWGDWe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 18:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWGDWe1
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 18:34:27 -0400
Received: from meleeweb.net ([88.191.21.131]:20633 "EHLO meleeweb.net")
	by vger.kernel.org with ESMTP id S932299AbWGDWe0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 18:34:26 -0400
Received: from beber by meleeweb.net with local (Exim 4.60)
	(envelope-from <beber@meleeweb.net>)
	id 1FxtV2-0004y2-7O; Wed, 05 Jul 2006 00:36:08 +0200
To: git@vger.kernel.org
Date: mer, 05 jui 2006 00:36:08 +0200
X-Mailer: git-send-email 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23322>

From: Bertrand Jacquin (Beber) <beber.mailing@gmail.com>

diff --git a/log-tree.c b/log-tree.c
index ebb49f2..55f77ad 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -164,7 +164,7 @@ int log_tree_diff_flush(struct rev_info 
 	}
 
 	if (opt->loginfo && !opt->no_commit_id)
-		show_log(opt, opt->loginfo, opt->diffopt.with_stat ? "---\n" : "\n");
+		show_log(opt, opt->loginfo, opt->diffopt.with_stat ? "\n---\n" : "\n");
 	diff_flush(&opt->diffopt);
 	return 1;
 }
-- 
1.4.1

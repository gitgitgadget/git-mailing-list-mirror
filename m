From: Torstein Hegge <hegge@resisty.net>
Subject: [PATCH] Documentation/rev-list-options: add missing word in --*-parents
Date: Fri,  2 Aug 2013 20:40:07 +0200
Message-ID: <1375468807-27007-1-git-send-email-hegge@resisty.net>
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Torstein Hegge <hegge@resisty.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 02 21:06:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5KgW-0008KR-59
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 21:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754736Ab3HBTGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 15:06:40 -0400
Received: from microbel.pvv.ntnu.no ([129.241.210.179]:34917 "EHLO
	microbel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752754Ab3HBTGj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 15:06:39 -0400
X-Greylist: delayed 1569 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Aug 2013 15:06:39 EDT
Received: from 120.179.202.84.customer.cdi.no ([84.202.179.120] helo=stacker.resisty.net)
	by microbel.pvv.ntnu.no with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <torstehe@pvv.ntnu.no>)
	id 1V5KH5-0004t7-D3; Fri, 02 Aug 2013 20:40:29 +0200
X-Mailer: git-send-email 1.8.4.rc1.372.g12d6635
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231535>

A commit has "parent commits" or "parents", not "commits".

Signed-off-by: Torstein Hegge <hegge@resisty.net>
---
 Documentation/rev-list-options.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 27f8de3..5bdfb42 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -119,7 +119,7 @@ if it is part of the log message.
 --no-min-parents::
 --no-max-parents::
 
-	Show only commits which have at least (or at most) that many
+	Show only commits which have at least (or at most) that many parent
 	commits. In particular, `--max-parents=1` is the same as `--no-merges`,
 	`--min-parents=2` is the same as `--merges`.  `--max-parents=0`
 	gives all root commits and `--min-parents=3` all octopus merges.
-- 
1.8.4.rc1.372.g12d6635

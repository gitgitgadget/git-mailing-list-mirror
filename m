From: Marcus Karlsson <mk@acc.umu.se>
Subject: [PATCH] gitk: Show patch for initial commit
Date: Fri, 30 Sep 2011 23:50:21 +0200
Message-ID: <20110930215021.GA3005@kennedy.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 30 23:59:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9l7P-0006jV-GA
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 23:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756541Ab1I3V73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 17:59:29 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:58475 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754159Ab1I3V71 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 17:59:27 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Sep 2011 17:59:27 EDT
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 65D27A27;
	Fri, 30 Sep 2011 23:50:22 +0200 (MEST)
X-Virus-Scanned: amavisd-new at acc.umu.se
Received: from kennedy.acc.umu.se (kennedy.acc.umu.se [130.239.18.157])
	by mail.acc.umu.se (Postfix) with ESMTP id BEC67A26;
	Fri, 30 Sep 2011 23:50:21 +0200 (MEST)
Received: by kennedy.acc.umu.se (Postfix, from userid 24678)
	id 9EBC75F; Fri, 30 Sep 2011 23:50:21 +0200 (MEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182512>

Make gitk show the patch for the initial commit.

Signed-off-by: Marcus Karlsson <mk@acc.umu.se>
---
 gitk-git/gitk |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4cde0c4..20aeae6 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -7436,7 +7436,7 @@ proc diffcmd {ids flags} {
 	    lappend cmd HEAD
 	}
     } else {
-	set cmd [concat | git diff-tree -r $flags $ids]
+	set cmd [concat | git diff-tree -r --root $flags $ids]
     }
     return $cmd
 }
-- 
1.7.7.rc3.4.g8d714

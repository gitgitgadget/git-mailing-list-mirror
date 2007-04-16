From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] git-rm: Trivial fix for a comment typo.
Date: Mon, 16 Apr 2007 01:17:32 -0700
Message-ID: <20070416081732.GA21483@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 10:17:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdMP6-0000ba-HX
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 10:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbXDPIRd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 04:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbXDPIRd
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 04:17:33 -0400
Received: from tater.midwinter.com ([216.32.86.90]:53245 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965084AbXDPIRc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 04:17:32 -0400
Received: (qmail 21541 invoked by uid 1001); 16 Apr 2007 08:17:32 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44621>

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
 builtin-rm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index 71166fb..d2b91cc 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -183,7 +183,7 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	 * must match; but the file can already been removed, since
 	 * this sequence is a natural "novice" way:
 	 *
-	 *	rm F; git fm F
+	 *	rm F; git rm F
 	 *
 	 * Further, if HEAD commit exists, "diff-index --cached" must
 	 * report no changes unless forced.
-- 
1.5.1.1.99.g0ea98

From: apenwarr@gmail.com
Subject: [PATCH 1/3] git-svn: add documentation for --use-log-author option.
Date: Tue, 15 Apr 2008 21:04:16 -0400
Message-ID: <1208307858-31039-1-git-send-email-apenwarr@gmail.com>
Cc: Avery Pennarun <apenwarr@versabanq.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 07:26:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlwJx-0000IV-4w
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 03:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbYDPBTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 21:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbYDPBTe
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 21:19:34 -0400
Received: from static-216-18-85-234.gtcust.grouptelecom.net ([216.18.85.234]:38871
	"EHLO mailhost.pwcorp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752119AbYDPBTd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2008 21:19:33 -0400
X-Greylist: delayed 910 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Apr 2008 21:19:33 EDT
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Apr 2008 21:04:21 -0400
Received: (qmail 30590 invoked from network); 16 Apr 2008 01:04:21 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 16 Apr 2008 01:04:21 -0000
Received: (qmail 30579 invoked from network); 16 Apr 2008 01:04:20 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 16 Apr 2008 01:04:20 -0000
Received: (qmail 30551 invoked from network); 16 Apr 2008 01:04:18 -0000
Received: from unknown (HELO averyp-server.pwcorp.com) (10.65.1.129)
  by weaver.open.versabanq.com with SMTP; 16 Apr 2008 01:04:18 -0000
Received: by averyp-server.pwcorp.com (Postfix, from userid 1000)
	id 350768C064; Tue, 15 Apr 2008 21:04:18 -0400 (EDT)
X-Mailer: git-send-email 1.5.4.3
X-OriginalArrivalTime: 16 Apr 2008 01:04:21.0457 (UTC) FILETIME=[CDDBD410:01C89F5D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79661>

From: Avery Pennarun <apenwarr@versabanq.com>


Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 Documentation/git-svn.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index bec9acc..4ad567a 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -61,6 +61,10 @@ COMMANDS
 	Set the 'useSvnsyncProps' option in the [svn-remote] config.
 --rewrite-root=<URL>;;
 	Set the 'rewriteRoot' option in the [svn-remote] config.
+--use-log-author;;
+	When retrieving svn commits into git (as part of fetch, rebase, or
+	dcommit operations), look for the first From: or Signed-off-by: line
+	in the log message and use that as the author string.
 --username=<USER>;;
 	For transports that SVN handles authentication for (http,
 	https, and plain svn), specify the username.  For other
-- 
1.5.4.3

From: apenwarr@gmail.com
Subject: [PATCH 3/3] git-svn: add documentation for --add-author-from option.
Date: Tue, 15 Apr 2008 21:04:18 -0400
Message-ID: <1208307858-31039-3-git-send-email-apenwarr@gmail.com>
References: <1208307858-31039-1-git-send-email-apenwarr@gmail.com>
 <1208307858-31039-2-git-send-email-apenwarr@gmail.com>
Cc: Avery Pennarun <apenwarr@versabanq.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 07:26:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlwJy-0000IV-EF
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 03:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbYDPBTi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 21:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbYDPBTi
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 21:19:38 -0400
Received: from static-216-18-85-234.gtcust.grouptelecom.net ([216.18.85.234]:38871
	"EHLO mailhost.pwcorp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753091AbYDPBTg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Apr 2008 21:19:36 -0400
X-Greylist: delayed 910 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Apr 2008 21:19:33 EDT
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Apr 2008 21:04:19 -0400
Received: (qmail 30552 invoked from network); 16 Apr 2008 01:04:18 -0000
Received: from unknown (HELO averyp-server.pwcorp.com) (10.65.1.129)
  by weaver.open.versabanq.com with SMTP; 16 Apr 2008 01:04:18 -0000
Received: by averyp-server.pwcorp.com (Postfix, from userid 1000)
	id 5F22D8C069; Tue, 15 Apr 2008 21:04:18 -0400 (EDT)
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1208307858-31039-2-git-send-email-apenwarr@gmail.com>
X-OriginalArrivalTime: 16 Apr 2008 01:04:19.0973 (UTC) FILETIME=[CCF96350:01C89F5D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79660>

From: Avery Pennarun <apenwarr@versabanq.com>


Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 Documentation/git-svn.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4ad567a..acd77eb 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -65,6 +65,12 @@ COMMANDS
 	When retrieving svn commits into git (as part of fetch, rebase, or
 	dcommit operations), look for the first From: or Signed-off-by: line
 	in the log message and use that as the author string.
+--add-author-from;;
+	When committing to svn from git (as part of commit or dcommit
+	operations), if the existing log message doesn't already have a
+	From: or Signed-off-by: line, append a From: line based on the
+	git commit's author string.  If you use this, then --use-log-author
+	will retrieve a valid author string for all commits.
 --username=<USER>;;
 	For transports that SVN handles authentication for (http,
 	https, and plain svn), specify the username.  For other
-- 
1.5.4.3

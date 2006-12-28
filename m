From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/4] git-svn: print out the SVN library version in --version, too
Date: Thu, 28 Dec 2006 01:16:20 -0800
Message-ID: <11672973831737-git-send-email-normalperson@yhbt.net>
References: <11672973823960-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Dec 28 10:16:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzrNP-0002oO-Dx
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 10:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWL1JQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 04:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWL1JQ0
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 04:16:26 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43031 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964965AbWL1JQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 04:16:25 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 000B27DC093;
	Thu, 28 Dec 2006 01:16:23 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 28 Dec 2006 01:16:23 -0800
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.4.3.gd4ada
In-Reply-To: <11672973823960-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35547>

This could be useful in finding new problems and helping users
debug.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0ef13b2..a772ce8 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -216,7 +216,7 @@ information.
 }
 
 sub version {
-	print "git-svn version $VERSION\n";
+	print "git-svn version $VERSION (svn $SVN::Core::VERSION)\n";
 	exit 0;
 }
 
-- 
1.4.4.3.gd4ada

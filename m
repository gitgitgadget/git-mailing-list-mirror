From: Jeff Epler <unpythonic.net@unpythonic.net>
Subject: [PATCH 2/2] document new flags
Date: Fri, 29 May 2009 20:39:15 -0500
Message-ID: <1243647555-25098-2-git-send-email-user@lamp>
References: <1243647555-25098-1-git-send-email-user@lamp>
Cc: Jeff Epler <jepler@unpythonic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 03:49:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MADgx-0007WA-HE
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 03:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272AbZE3Bsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 21:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756895AbZE3Bsu
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 21:48:50 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:38769 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756413AbZE3Bsu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 21:48:50 -0400
Received: by unpythonic.net (Postfix, from userid 1000)
	id C7DC31146FE; Fri, 29 May 2009 20:39:15 -0500 (CDT)
X-Mailer: git-send-email 1.6.2.1
In-Reply-To: <1243647555-25098-1-git-send-email-user@lamp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120332>

From: Jeff Epler <jepler@unpythonic.net>

Signed-off-by: Jeff Epler <jepler@unpythonic.net>
---
 Documentation/git-cherry.txt |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 7deefda..100ed69 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -7,7 +7,7 @@ git-cherry - Find commits not merged upstream
 
 SYNOPSIS
 --------
-'git cherry' [-v] [<upstream> [<head> [<limit>]]]
+'git cherry' [-v] [-a|-#] [-r] [-d|-D] [<upstream> [<head> [<limit>]]]
 
 DESCRIPTION
 -----------
@@ -49,6 +49,18 @@ OPTIONS
 -v::
 	Verbose.
 
+-a|-#::
+	Abbreviate commit ids to the given number of characters, or 7 for -a
+
+-r::
+	Swap <upstream> and <head>
+
+-d::
+	Only show commits that don't exist in upstream ("+" lines)
+
+-D::
+	Only show commits that do exist in upstream ("-" lines)
+
 <upstream>::
 	Upstream branch to compare against.
 	Defaults to the first tracked remote branch, if available.
-- 
1.5.4.3

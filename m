From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 6/17] Document the [<head>...] and -- arguments to git-prune.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <1134084485869-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <1134084485547-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVCI-0004lM-Bj
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbVLHX2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932725AbVLHX2T
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:19 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:14030 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932729AbVLHX2N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:13 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051208232812.VWYN17186.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Fri, 9 Dec 2005 00:28:12 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 09 Dec 2005 00:28:32 +0100
X-BrightmailFiltered: true
X-IronPort-AV: i="3.99,232,1131318000"; 
   d="scan'208,217"; a="16674748:sNHT55809918"
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 67CE3ADFEE;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <1134084485547-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13397>

The documentation for git-prune was lacking descriptions of the head
arguments and the -- option.

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-prune.txt |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

b4491eee9b9e371f4c9ea65c93be998a4f37498c
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 3367c9b..04cea76 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -8,7 +8,7 @@ git-prune - Prunes all unreachable objec
 
 SYNOPSIS
 --------
-'git-prune' [-n]
+'git-prune' [-n] [--] [<head>...]
 
 DESCRIPTION
 -----------
@@ -26,7 +26,15 @@ OPTIONS
 -n::
 	Do not remove anything; just report what it would
 	remove.
+--::
+	Do not interpret any more arguments as options.
 
+<head>...::
+        The heads to look for unreachable objects in.  This is
+        relative to $GIT_DIR (e.g., "HEAD", "refs/heads/master").
+        When unspecified, all heads are updated to match the
+        remote repository.
+        
 
 Author
 ------
-- 
0.99.9l

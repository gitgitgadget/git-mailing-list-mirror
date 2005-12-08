From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 16/17] Documentation/git-tag.txt: Fix the order of sections (DESCRIPTION should come before OPTIONS).
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <11340844851233-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11340844852368-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVCM-0004lM-86
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932738AbVLHX2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbVLHX2c
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:32 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:38606 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932740AbVLHX2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:25 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051208232820.VWZM17186.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Fri, 9 Dec 2005 00:28:20 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 09 Dec 2005 00:28:33 +0100
X-BrightmailFiltered: true
X-IronPort-AV: i="3.99,232,1131318000"; 
   d="scan'208,217"; a="16674760:sNHT366246864"
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id F357CADFFB;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <11340844852368-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13399>

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-tag.txt |   40 ++++++++++++++++++++--------------------
 1 files changed, 20 insertions(+), 20 deletions(-)

4e7e431f15e54257e78beb23644bddffc6357c9b
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 841c9dc..e8892bb 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -10,26 +10,6 @@ SYNOPSIS
 --------
 'git-tag' [-a | -s | -u <key-id>] [-f | -d] [-m <msg>] <name> [<head>]
 
-OPTIONS
--------
--a::
-	Make an unsigned, annotated tag object
-
--s::
-	Make a GPG-signed tag, using the default e-mail address's key
-
--u <key-id>::
-	Make a GPG-signed tag, using the given key
-
--f::
-	Replace an existing tag with the given name (instead of failing)
-
--d::
-	Delete an existing tag with the given name
-
--m <msg>::
-	Use the given tag message (instead of prompting)
-
 DESCRIPTION
 -----------
 Adds a 'tag' reference in .git/refs/tags/
@@ -52,6 +32,26 @@ GnuPG key for signing.
 
 `-d <tag>` deletes the tag.
 
+OPTIONS
+-------
+-a::
+	Make an unsigned, annotated tag object
+
+-s::
+	Make a GPG-signed tag, using the default e-mail address's key
+
+-u <key-id>::
+	Make a GPG-signed tag, using the given key
+
+-f::
+	Replace an existing tag with the given name (instead of failing)
+
+-d::
+	Delete an existing tag with the given name
+
+-m <msg>::
+	Use the given tag message (instead of prompting)
+
 
 Author
 ------
-- 
0.99.9l

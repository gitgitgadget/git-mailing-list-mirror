From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] git-filter-branch: document --original option
Date: Thu, 30 Aug 2007 19:10:42 +0200
Message-ID: <11884938431525-git-send-email-giuseppe.bilotta@gmail.com>
References: <11884893671845-git-send-email-giuseppe.bilotta@gmail.com>
 <1188493842963-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 30 19:12:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQnZU-0000Io-QM
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 19:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbXH3RM1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 13:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbXH3RM1
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 13:12:27 -0400
Received: from averell.tiscali.it ([213.205.33.55]:32932 "EHLO
	averell.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757514AbXH3RM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 13:12:27 -0400
Received: from localhost.localdomain (84.221.55.162) by averell.tiscali.it (7.3.122)
        id 468D1A8000670725; Thu, 30 Aug 2007 19:12:21 +0200
X-Mailer: git-send-email 1.5.2.5
In-Reply-To: <1188493842963-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57056>

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-filter-branch.txt |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 8c43be6..ae03514 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -12,7 +12,8 @@ SYNOPSIS
 	[--index-filter <command>] [--parent-filter <command>]
 	[--msg-filter <command>] [--commit-filter <command>]
 	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
-	[-d <directory>] [-f | --force] [<rev-list options>...]
+	[--original <namespace>] [-d <directory>] [-f | --force]
+	[<rev-list options>...]
 
 DESCRIPTION
 -----------
@@ -134,6 +135,10 @@ definition impossible to preserve signatures at any rate.)
 	The result will contain that directory (and only that) as its
 	project root.
 
+--original <namespace>::
+	Use this option to set the namespace where the original commits
+	will be stored. The default value is 'refs/original'.
+
 -d <directory>::
 	Use this option to set the path to the temporary directory used for
 	rewriting.  When applying a tree filter, the command needs to
-- 
1.5.2.5

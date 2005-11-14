From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 3/3] Documentation nitpicking
Date: Tue, 15 Nov 2005 00:20:01 +0100
Message-ID: <1132010401671-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11320104011291-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Tue Nov 15 00:22:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbncN-0008EQ-Su
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 00:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVKNXUF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 18:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVKNXUF
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 18:20:05 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:63190 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751301AbVKNXT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 18:19:59 -0500
Received: from puritan.petwork ([213.112.43.250] [213.112.43.250])
          by mxfep01.bredband.com with ESMTP
          id <20051114231958.SCJW21433.mxfep01.bredband.com@puritan.petwork>;
          Tue, 15 Nov 2005 00:19:58 +0100
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 8C3DAADFEB;
	Tue, 15 Nov 2005 00:20:01 +0100 (CET)
In-Reply-To: <11320104011291-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11868>

This patch fixes some small problems with the documentation.

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-commit-tree.txt  |    2 +-
 Documentation/git-update-index.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

applies-to: 118fb90e721428900a0588074894a4b198044762
683a61f6648873de0a73c8c60a86064cf4f4911d
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index b64cd6a..5cf6bd3 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -8,7 +8,7 @@ git-commit-tree - Creates a new commit o
 
 SYNOPSIS
 --------
-'git-commit-tree' <tree> [-p <parent commit>]\   < changelog
+'git-commit-tree' <tree> [-p <parent commit>]\* < changelog
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 52874c8..fdcb8be 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -60,7 +60,7 @@ OPTIONS
 	Directly insert the specified info into the index.
 	
 --index-info::
-        Read index info from stdin.
+        Read index information from stdin.
 
 --chmod=(+|-)x::
         Set the execute permissions on the updated files.        
---
0.99.9g

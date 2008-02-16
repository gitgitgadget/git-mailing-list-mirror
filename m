From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH 2/2] Documentation: Add a usage case of git-reset with path
Date: Sat, 16 Feb 2008 17:48:46 +0100
Message-ID: <1203180526-12020-2-git-send-email-pdebie@ai.rug.nl>
References: <1203180526-12020-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 17:49:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQQEC-0002B2-0y
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 17:49:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbYBPQsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 11:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755620AbYBPQsv
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 11:48:51 -0500
Received: from smtp-2.orange.nl ([193.252.22.242]:14796 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbYBPQsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 11:48:50 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6109.orange.nl (SMTP Server) with ESMTP id 920297000092
	for <git@vger.kernel.org>; Sat, 16 Feb 2008 17:48:49 +0100 (CET)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6109.orange.nl (SMTP Server) with ESMTP id 93F1A700008F;
	Sat, 16 Feb 2008 17:48:48 +0100 (CET)
X-ME-UUID: 20080216164848606.93F1A700008F@mwinf6109.orange.nl
X-Mailer: git-send-email 1.5.4.3.gb183
In-Reply-To: <1203180526-12020-1-git-send-email-pdebie@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74046>


Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---
 Documentation/git-reset.txt |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 2b24641..39a9d64 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -176,6 +176,23 @@ $ git reset                                       <3>
     committed as 'snapshot WIP'.  This updates the index to show your
     WIP files as uncommitted.
 
+Reset a single file in the index::
++
+Suppose you have added a file to your index, but later decide you do not
+want to add it to your commit. You can remove the file from the index
+while keeping your changes with git reset.
++
+------------
+$ git reset -- frotz.c                      <1>
+$ git commit -m "Commit files in index"     <2>
+$ git add frotz.c                           <3>
+------------                                   
++
+<1> This removes the file from the index while keeping it in the working
+    directory.
+<2> This commits all other changes in the index.
+<3> Adds the file to the index again.
+
 Author
 ------
 Written by Junio C Hamano <junkio@cox.net> and Linus Torvalds <torvalds@osdl.org>
-- 
1.5.4.3.gb183

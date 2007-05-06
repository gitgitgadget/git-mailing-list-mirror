From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Document git add -u introduced earlier.
Date: Sun,  6 May 2007 23:11:55 +0200
Message-ID: <11784859173725-git-send-email-Matthieu.Moy@imag.fr>
References: <11784859173386-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 23:12:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hko1W-0007yg-Ix
	for gcvg-git@gmane.org; Sun, 06 May 2007 23:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758902AbXEFVMA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 17:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758899AbXEFVMA
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 17:12:00 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:34128 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758892AbXEFVL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2007 17:11:59 -0400
Received: from localhost (mut38-2-82-224-179-211.fbx.proxad.net [82.224.179.211])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 82EC9B93B8;
	Sun,  6 May 2007 23:11:58 +0200 (CEST)
Received: from moy by localhost with local (Exim 4.67)
	(envelope-from <moy@imag.fr>)
	id 1Hko1N-0004T1-Uu; Sun, 06 May 2007 23:11:58 +0200
X-Mailer: git-send-email 1.5.2.rc2.2.g6cfa-dirty
In-Reply-To: <11784859173386-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46375>

This command was implemented, but not documented in
dfdac5d9b877641d3aad8ec49f64c2730a3487e3.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/git-add.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 755d718..ea27018 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -7,7 +7,7 @@ git-add - Add file contents to the changeset to be committed next
 
 SYNOPSIS
 --------
-'git-add' [-n] [-v] [-f] [--interactive | -i] [--] <file>...
+'git-add' [-n] [-v] [-f] [--interactive | -i] [-u] [--] <file>...
 
 DESCRIPTION
 -----------
@@ -56,6 +56,10 @@ OPTIONS
 	Add modified contents in the working tree interactively to
 	the index.
 
+-u::
+	Update all files that git already knows about. This is what
+	"git commit -a" does in preparation for making a commit.
+
 \--::
 	This option can be used to separate command-line options from
 	the list of files, (useful when filenames might be mistaken
-- 
1.5.1.3

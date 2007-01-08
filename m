From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] Documentation: clarify glossary definition of "reachable"
Date: Sun, 7 Jan 2007 19:28:39 -0500
Message-ID: <20070108002839.GF18009@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 01:28:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3iNY-0007uR-4k
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 01:28:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965273AbXAHA2l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 19:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965274AbXAHA2l
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 19:28:41 -0500
Received: from mail.fieldses.org ([66.93.2.214]:33707 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965273AbXAHA2l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 19:28:41 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H3iNT-0005gy-Nu; Sun, 07 Jan 2007 19:28:39 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36208>

Clarify glossary definition of "reachable" (what chain?)

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/glossary.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 7c1a659..5886fa7 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -236,7 +236,7 @@ push::
 
 reachable::
 	An object is reachable from a ref/commit/tree/tag, if there is a
-	chain leading from the latter to the former.
+	chain of parent commits leading from the latter to the former.
 
 rebase::
 	To clean a branch by starting from the head of the main line of
-- 
1.5.0.rc0.ge16c2

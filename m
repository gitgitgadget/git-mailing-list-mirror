From: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
Subject: [PATCH] git-cherry-pick -x works with conflicting commits
Date: Mon, 24 Mar 2008 11:41:14 +0100
Message-ID: <1206355274-6052-1-git-send-email-rgarciasuarez@gmail.com>
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 11:42:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdk7z-0006H4-RI
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 11:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756400AbYCXKlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 06:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756256AbYCXKlR
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 06:41:17 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:35729 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755398AbYCXKlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 06:41:16 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 360EC5FE45;
	Mon, 24 Mar 2008 11:41:15 +0100 (CET)
Received: from localhost.localdomain (inv75-3-82-241-119-67.fbx.proxad.net [82.241.119.67])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 1DAB25FE7B;
	Mon, 24 Mar 2008 11:41:15 +0100 (CET)
X-Mailer: git-send-email 1.5.5.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78016>

So this patch fixes the docs to reflect that.

Signed-off-by: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
---
 Documentation/git-cherry-pick.txt |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index f0beb41..475e168 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -29,8 +29,7 @@ OPTIONS
 -x::
 	When recording the commit, append to the original commit
 	message a note that indicates which commit this change
-	was cherry-picked from.  Append the note only for cherry
-	picks without conflicts.  Do not use this option if
+	was cherry-picked from.  Do not use this option if
 	you are cherry-picking from your private branch because
 	the information is useless to the recipient.  If on the
 	other hand you are cherry-picking between two publicly
-- 
1.5.5.rc1

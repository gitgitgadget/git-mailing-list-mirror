From: Jyotirmoy Bhattacharya <jyotirmoy@jyotirmoy.net>
Subject: [PATCH] Fixed git-push manpage
Date: Sun,  5 Aug 2007 10:52:15 +0530
Message-ID: <11862913353314-git-send-email-jyotirmoy@jyotirmoy.net>
Cc: Jyotirmoy Bhattacharya <jyotirmoy@jyotirmoy.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 07:22:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHYZY-0007om-KA
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 07:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbXHEFWY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 01:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbXHEFWY
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 01:22:24 -0400
Received: from qb-out-0506.google.com ([72.14.204.234]:1876 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbXHEFWX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 01:22:23 -0400
Received: by qb-out-0506.google.com with SMTP id e11so1411660qbe
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 22:22:23 -0700 (PDT)
Received: by 10.141.42.10 with SMTP id u10mr1661590rvj.1186291342361;
        Sat, 04 Aug 2007 22:22:22 -0700 (PDT)
Received: from localhost ( [59.176.66.108])
        by mx.google.com with ESMTPS id b5sm6865525rva.2007.08.04.22.22.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Aug 2007 22:22:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54952>

In git-push it is the remote repository and not the
local repository which is fast forwarded. The description
of the -f option in the git-push manpage gets it the other
way round.

Signed-off-by: Jyotirmoy Bhattacharya <jyotirmoy@jyotirmoy.net>
---
 Documentation/git-push.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 74a0da1..0dd9caf 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -79,7 +79,7 @@ the remote repository.
 
 -f, \--force::
 	Usually, the command refuses to update a remote ref that is
-	not a descendant of the local ref used to overwrite it.
+	not an ancestor of the local ref used to overwrite it.
 	This flag disables the check.  This can cause the
 	remote repository to lose commits; use it with care.
 
-- 
1.5.2.4

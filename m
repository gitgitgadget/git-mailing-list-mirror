From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH] user-manual: remove temporary branch entry from todo list
Date: Wed, 23 Dec 2015 17:47:03 -0700
Message-ID: <1450918023-30309-1-git-send-email-ischis2@cox.net>
Cc: "Stephen P. Smith" <ischis2@cox.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 24 01:46:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBu3R-0004IS-UH
	for gcvg-git-2@plane.gmane.org; Thu, 24 Dec 2015 01:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbbLXAqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 19:46:16 -0500
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:41395 "EHLO
	fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbbLXAqP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 19:46:15 -0500
Received: from fed1rmimpo110 ([68.230.241.159]) by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151224004614.MBDP331.fed1rmfepo101.cox.net@fed1rmimpo110>
          for <git@vger.kernel.org>; Wed, 23 Dec 2015 19:46:14 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo110 with cox
	id xCmD1r00C2tqoqC01CmDGm; Wed, 23 Dec 2015 19:46:13 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020202.567B4055.0156,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=B55nJpRM c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=VuZfbI19qYR0Br25P-0A:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id 6F941142741;
	Wed, 23 Dec 2015 17:47:08 -0700 (MST)
X-Mailer: git-send-email 2.7.0-rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282969>

Remove the suggestion for using a detached HEAD instead of a
temporary branch.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---

Notes:
    A search of the user manual found only one location which refers to
    temporary branches.  This has to do with how Tony Luck uses them.
    
    Even then there is a clarifying parenthetical noting that the
    temporary branches are topic branches.
    
    A git blame showed that the last time that the entry was updated was
    in 2007.

 Documentation/user-manual.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1c790ac..18e2f1e 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4636,9 +4636,6 @@ Scan email archives for other stuff left out
 Scan man pages to see if any assume more background than this manual
 provides.
 
-Simplify beginning by suggesting disconnected head instead of
-temporary branch creation?
-
 Add more good examples.  Entire sections of just cookbook examples
 might be a good idea; maybe make an "advanced examples" section a
 standard end-of-chapter section?
-- 
2.7.0-rc2

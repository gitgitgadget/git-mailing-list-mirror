From: "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH V2] user-manual: remove temporary branch entry from todo list
Date: Mon, 28 Dec 2015 13:16:44 -0700
Message-ID: <1451333804-6431-1-git-send-email-ischis2@cox.net>
References: <xmqqr3i6lbx2.fsf@gitster.mtv.corp.google.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Stephen P. Smith" <ischis2@cox.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 28 21:16:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDeDa-0006M6-Jf
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 21:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbbL1UQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2015 15:16:31 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:60979 "EHLO
	fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbbL1UQa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2015 15:16:30 -0500
Received: from fed1rmimpo110 ([68.230.241.159]) by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151228201629.LTUO7752.fed1rmfepo102.cox.net@fed1rmimpo110>
          for <git@vger.kernel.org>; Mon, 28 Dec 2015 15:16:29 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo110 with cox
	id z8GU1r00F2tqoqC018GUzw; Mon, 28 Dec 2015 15:16:28 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020201.5681989C.020E,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=B55nJpRM c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=e3FEnRuY1qRH-CzJMJIA:9 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.smith.home (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id B9300143320;
	Mon, 28 Dec 2015 13:16:50 -0700 (MST)
X-Mailer: git-send-email 2.7.0-rc2
In-Reply-To: <xmqqr3i6lbx2.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283047>

In the section on "How to check out a differnet version of a project"
the "new" branch is used as a temporary branch.

A detached HEAD was not used since it was a new feature introduced
just a couple weeks prior.

The section could be changed to use and explain a detached HEAD,
except that would increase the learning curve early in the manual.

Detached HEADs are discussed a couple sections later under
"Examining an old version without creating a new branch".

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
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

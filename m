From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 07/10] t3409: use dashless "git commit" instead of "git-commit"
Date: Sat, 24 Jan 2009 16:43:18 -0700
Message-ID: <1232840601-24696-8-git-send-email-mmogilvi_git@miniinfo.net>
References: <1232840601-24696-1-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-2-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-4-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-5-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-6-git-send-email-mmogilvi_git@miniinfo.net>
 <1232840601-24696-7-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 00:45:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQsBe-0006Ei-Qr
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 00:45:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbZAXXnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 18:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754004AbZAXXnu
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 18:43:50 -0500
Received: from qmta04.emeryville.ca.mail.comcast.net ([76.96.30.40]:48199 "EHLO
	QMTA04.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753498AbZAXXnd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jan 2009 18:43:33 -0500
Received: from OMTA11.emeryville.ca.mail.comcast.net ([76.96.30.36])
	by QMTA04.emeryville.ca.mail.comcast.net with comcast
	id 7W9S1b0070mlR8UA4bjZl6; Sat, 24 Jan 2009 23:43:33 +0000
Received: from mmogilvi.homeip.net ([75.70.161.67])
	by OMTA11.emeryville.ca.mail.comcast.net with comcast
	id 7bjX1b0091TYyYj8XbjYre; Sat, 24 Jan 2009 23:43:32 +0000
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 41D548911B;
	Sat, 24 Jan 2009 16:43:25 -0700 (MST)
X-Mailer: git-send-email 1.6.1.81.g9833d.dirty
In-Reply-To: <1232840601-24696-7-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107022>

This is needed to allow test suite to run against a minimal bin
directory instead of GIT_EXEC_PATH.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---

Semi-related:

I noticed that there are actually two test cases numbered
t3409: t3409-rebase-hook.sh and t3409-rebase-preserve-merges.sh.
Should one of them be renumbered, or is it good enough as-is?  I'm
just pointing this out; I don't intend to change it myself.

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]

 t/t3409-rebase-preserve-merges.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index e6c8327..8878771 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -32,14 +32,14 @@ export GIT_AUTHOR_EMAIL
 test_expect_success 'setup for merge-preserving rebase' \
 	'echo First > A &&
 	git add A &&
-	git-commit -m "Add A1" &&
+	git commit -m "Add A1" &&
 	git checkout -b topic &&
 	echo Second > B &&
 	git add B &&
-	git-commit -m "Add B1" &&
+	git commit -m "Add B1" &&
 	git checkout -f master &&
 	echo Third >> A &&
-	git-commit -a -m "Modify A2" &&
+	git commit -a -m "Modify A2" &&
 
 	git clone ./. clone1 &&
 	cd clone1 &&
-- 
1.6.1.81.g9833d.dirty

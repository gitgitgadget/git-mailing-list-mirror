From: Johan Herland <johan@herland.net>
Subject: [PATCH 05/18] (trivial) t3303: Indent with tabs instead of spaces for
 consistency
Date: Wed, 29 Sep 2010 02:23:18 +0200
Message-ID: <1285719811-10871-6-git-send-email-johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 02:24:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0kSi-0000uw-G3
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 02:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab0I2AXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 20:23:51 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44298 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752857Ab0I2AXr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 20:23:47 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H003YXFRKTS70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:44 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 246891EEF84B_CA28710B	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:44 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 147471EEF84A_CA28710F	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:43 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H00IQEFRHZC10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:41 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1285719811-10871-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157501>

The rest of the file uses tabs for indenting. Fix the one function
that doesn't.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3303-notes-subtrees.sh |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
index 75ec187..d571708 100755
--- a/t/t3303-notes-subtrees.sh
+++ b/t/t3303-notes-subtrees.sh
@@ -168,15 +168,15 @@ INPUT_END
 }
 
 verify_concatenated_notes () {
-    git log | grep "^    " > output &&
-    i=$number_of_commits &&
-    while [ $i -gt 0 ]; do
-        echo "    commit #$i" &&
-        echo "    first note for commit #$i" &&
-        echo "    second note for commit #$i" &&
-        i=$(($i-1));
-    done > expect &&
-    test_cmp expect output
+	git log | grep "^    " > output &&
+	i=$number_of_commits &&
+	while [ $i -gt 0 ]; do
+		echo "    commit #$i" &&
+		echo "    first note for commit #$i" &&
+		echo "    second note for commit #$i" &&
+		i=$(($i-1));
+	done > expect &&
+	test_cmp expect output
 }
 
 test_expect_success 'test notes in no fanout concatenated with 2/38-fanout' 'test_concatenated_notes "s|^..|&/|" ""'
-- 
1.7.3.98.g5ad7d9

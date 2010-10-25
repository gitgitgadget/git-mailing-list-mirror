From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 07/23] (trivial) t3303: Indent with tabs instead of spaces
 for consistency
Date: Mon, 25 Oct 2010 02:08:37 +0200
Message-ID: <1287965333-5099-8-git-send-email-johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 02:09:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAAct-0000Uz-M6
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 02:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825Ab0JYAJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 20:09:22 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59867 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751782Ab0JYAJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 20:09:20 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT005ZXKFGGG40@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:16 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 84D77179913F_CC4CAACB	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:16 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 6B6051796C56_CC4CAACF	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:15 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT004SRKFAVB20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:12 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1287965333-5099-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159900>

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

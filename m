From: Johan Herland <johan@herland.net>
Subject: [WIP/RFC 05/13] (trivial) t3303: Indent with tabs instead of spaces
 for consistency
Date: Fri, 23 Jul 2010 12:14:56 +0200
Message-ID: <1279880104-29796-6-git-send-email-johan@herland.net>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 12:16:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcFIW-0001FC-8z
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 12:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089Ab0GWKPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 06:15:23 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43952 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755798Ab0GWKPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 06:15:16 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6000G9Q9TAM390@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:10 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id A947B1EA553F_C496BAEB	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:10 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 93A111EA3704_C496BAEF	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:10 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L60005R49T9TN00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:10 +0200 (MEST)
X-Mailer: git-send-email 1.7.2.220.gea1d3
In-reply-to: <1279880104-29796-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151518>

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
1.7.2.220.gea1d3

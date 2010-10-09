From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 07/21] (trivial) t3303: Indent with tabs instead of spaces for consistency
Date: Sat,  9 Oct 2010 03:11:27 +0200
Message-ID: <1286586701-3586-8-git-send-email-johan@herland.net>
References: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:13:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Nzw-0002nk-AT
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760074Ab0JIBNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 21:13:08 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:63632 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759990Ab0JIBNH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:13:07 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4Nzm-0001bt-4d; Sat, 09 Oct 2010 03:13:06 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
In-Reply-To: <Message-Id: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158556>

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
1.7.3.1.104.g92b87a

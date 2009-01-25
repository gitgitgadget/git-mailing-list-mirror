From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH 2/3] Documentation: more git push examples
Date: Mon, 26 Jan 2009 00:45:32 +0100
Message-ID: <1232927133-30377-3-git-send-email-mail@cup.kalibalik.dk>
References: <1232927133-30377-1-git-send-email-mail@cup.kalibalik.dk>
 <1232927133-30377-2-git-send-email-mail@cup.kalibalik.dk>
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 26 00:47:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREgx-0004qh-Gy
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:47:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbZAYXpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbZAYXpi
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:45:38 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:44949 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751003AbZAYXph (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:45:37 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id BFEB830B55;
	Mon, 26 Jan 2009 00:45:10 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 9267430B23;
	Mon, 26 Jan 2009 00:45:08 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
In-Reply-To: <1232927133-30377-2-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107137>

Include examples of using HEAD. The order of examples
introduces new concepts one by one. This pushes the
example of deleting a ref to the end of the list.

---
 Documentation/git-push.txt |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 3fd4bbb..6d478c5 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -190,9 +190,9 @@ git push origin master::
 	with it.  If `master` did not exist remotely, it would be
 	created.
 
-git push origin :experimental::
-	Find a ref that matches `experimental` in the `origin` repository
-	(e.g. `refs/heads/experimental`), and delete it.
+git push origin HEAD::
+	A handy way to push the current branch to the same name on the
+	remote.
 
 git push origin master:satellite/master dev:satellite/dev::
 	Use the source ref that matches `master` (e.g. `refs/heads/master`)
@@ -200,6 +200,11 @@ git push origin master:satellite/master dev:satellite/dev::
 	`refs/remotes/satellite/master`) in the `origin` repository, then
 	do the same for `dev` and `satellite/dev`.
 
+git push origin HEAD:master::
+	Push the current branch to the remote ref matching `master` in the
+	`origin` repository. This form is convenient to push the current
+	branch without thinking about its local name.
+
 git push origin master:refs/heads/experimental::
 	Create the branch `experimental` in the `origin` repository
 	by copying the current `master` branch.  This form is only
@@ -207,6 +212,11 @@ git push origin master:refs/heads/experimental::
 	the local name and the remote name are different; otherwise,
 	the ref name on its own will work.
 
+git push origin :experimental::
+	Find a ref that matches `experimental` in the `origin` repository
+	(e.g. `refs/heads/experimental`), and delete it.
+
+
 Author
 ------
 Written by Junio C Hamano <gitster@pobox.com>, later rewritten in C
-- 
1.6.0.2.514.g23abd3

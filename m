From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH 1/3] Documentation: simplify refspec format description
Date: Mon, 26 Jan 2009 00:45:31 +0100
Message-ID: <1232927133-30377-2-git-send-email-mail@cup.kalibalik.dk>
References: <1232927133-30377-1-git-send-email-mail@cup.kalibalik.dk>
Cc: git@vger.kernel.org, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 26 00:47:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LREhH-0004vQ-1t
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 00:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbZAYXpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 18:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbZAYXpo
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 18:45:44 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:44946 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbZAYXph (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 18:45:37 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id B39EB308CF;
	Mon, 26 Jan 2009 00:45:10 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 7D9B8308D4;
	Mon, 26 Jan 2009 00:45:08 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
In-Reply-To: <1232927133-30377-1-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107140>

The refspec format description was a mix of regexp and BNF, making it
very difficult to read. The format was also wrong: it did not show
that each part of a refspec is optional in different situations.

Rather than having a confusing grammar, just present the format in
informal prose.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---

This is a rework of
http://article.gmane.org/gmane.comp.version-control.git/99552/


 Documentation/git-push.txt         |    8 ++++----
 Documentation/pull-fetch-param.txt |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 7b27dc6..3fd4bbb 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -33,10 +33,10 @@ OPTIONS
 	of a remote (see the section <<REMOTES,REMOTES>> below).
 
 <refspec>...::
-	The canonical format of a <refspec> parameter is
-	`+?<src>:<dst>`; that is, an optional plus `{plus}`, followed
-	by the source ref, followed by a colon `:`, followed by
-	the destination ref.
+	The format of a <refspec> parameter is an optional plus
+	`{plus}`, followed by the source ref <src>, followed
+	by a colon `:`, followed by the destination ref <dst>.
+	Find various forms of refspecs in examples section.
 +
 The <src> side represents the source branch (or arbitrary
 "SHA1 expression", such as `master~4` (four parents before the
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index ebdd948..820c140 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -5,10 +5,10 @@
 	of a remote (see the section <<REMOTES,REMOTES>> below).
 
 <refspec>::
-	The canonical format of a <refspec> parameter is
-	`+?<src>:<dst>`; that is, an optional plus `{plus}`, followed
-	by the source ref, followed by a colon `:`, followed by
-	the destination ref.
+	The format of a <refspec> parameter is an optional plus
+	`{plus}`, followed by the source ref <src>, followed
+	by a colon `:`, followed by the destination ref <dst>.
+	Find various forms of refspecs in examples section.
 +
 The remote ref that matches <src>
 is fetched, and if <dst> is not empty string, the local
-- 
1.6.0.2.514.g23abd3

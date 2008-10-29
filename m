From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: [PATCH 1/7] Documentation: do not use regexp in refspec descriptions
Date: Wed, 29 Oct 2008 21:25:39 +0100
Message-ID: <1225311945-17100-2-git-send-email-mail@cup.kalibalik.dk>
References: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk>
Cc: gitster@pobox.com, Anders Melchiorsen <mail@cup.kalibalik.dk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 21:27:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvHd7-0005zb-41
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 21:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754567AbYJ2UZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 16:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754292AbYJ2UZt
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 16:25:49 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:42687 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754222AbYJ2UZs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 16:25:48 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 0BA111407D;
	Wed, 29 Oct 2008 21:25:49 +0100 (CET)
Received: from localhost.localdomain (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id B515414062;
	Wed, 29 Oct 2008 21:25:48 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.514.g23abd3
In-Reply-To: <1225311945-17100-1-git-send-email-mail@cup.kalibalik.dk>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99402>

The refspec format description was a mix of regexp and BNF, making it
very difficult to read.

The syntax is now easier to read, though wrong: all parts of the
refspec are actually optional.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 Documentation/git-push.txt         |    2 +-
 Documentation/pull-fetch-param.txt |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 6150b1b..df99c0b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -32,7 +32,7 @@ OPTIONS
 
 <refspec>...::
 	The canonical format of a <refspec> parameter is
-	`+?<src>:<dst>`; that is, an optional plus `{plus}`, followed
+	`[+]<src>:<dst>`; that is, an optional plus `{plus}`, followed
 	by the source ref, followed by a colon `:`, followed by
 	the destination ref.
 +
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index ebdd948..0ff1700 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -6,7 +6,7 @@
 
 <refspec>::
 	The canonical format of a <refspec> parameter is
-	`+?<src>:<dst>`; that is, an optional plus `{plus}`, followed
+	`[+]<src>:<dst>`; that is, an optional plus `{plus}`, followed
 	by the source ref, followed by a colon `:`, followed by
 	the destination ref.
 +
-- 
1.6.0.2.514.g23abd3

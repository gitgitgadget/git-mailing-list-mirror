From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] fast-import: Remove redundant assignment of 'oe' to itself.
Date: Sun, 26 May 2013 22:05:19 +0200
Message-ID: <1369598719-10798-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: David Barr <david.barr@cordelta.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 26 22:05:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UghCE-0007iU-1G
	for gcvg-git-2@plane.gmane.org; Sun, 26 May 2013 22:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014Ab3EZUFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 May 2013 16:05:22 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:33616 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab3EZUFV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 May 2013 16:05:21 -0400
Received: by mail-ee0-f51.google.com with SMTP id e51so3567079eek.38
        for <git@vger.kernel.org>; Sun, 26 May 2013 13:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=JvB2AjOja+0et3tISicCjHTDGt2TS72mUHHF7B00BwE=;
        b=zdZzTyqDipkVW9mbG3l24BQSsE4xujMfdkr/MUNC6YmAYTQuLXVBjZTlMCJpCi5w6I
         /r4KEGE0ozdpCkF/KqsZIqD1yzzsbGyalcHJ2BwjmexDN7lYgfezFsc1k9pZxdcqI2Xr
         fdvTf04Aiao3EG3sNeWemFbeEgFIPd+uh26MaK+Zr6OgUGwGTCM1R0nf1Uy0xC28mTIg
         8Dx0w1QXFo2PzVF+Y05H7Tpbf+Kyz7TNImIdiDes9AU7bBdqmVeMm4v0wwbkN3MRlFMB
         Qd7U2BNLcO559Fw3qafPPlotsbv34z8THfSCtzjvVP18DclKN/0niLn0bDmUrWHF/Fnt
         wnxA==
X-Received: by 10.15.101.1 with SMTP id bo1mr7417362eeb.128.1369598719798;
        Sun, 26 May 2013 13:05:19 -0700 (PDT)
Received: from localhost (ip-109-90-70-123.unitymediagroup.de. [109.90.70.123])
        by mx.google.com with ESMTPSA id y10sm37298635eev.3.2013.05.26.13.05.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 26 May 2013 13:05:19 -0700 (PDT)
X-Mailer: git-send-email 1.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225566>

Reported by cppcheck.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 fast-import.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index 5f539d7..0142e3a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2914,7 +2914,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 static void parse_cat_blob(void)
 {
 	const char *p;
-	struct object_entry *oe = oe;
+	struct object_entry *oe;
 	unsigned char sha1[20];
 
 	/* cat-blob SP <object> LF */
-- 
1.8.3

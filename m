From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH] Fix compilation of test-delta
Date: Tue,  1 May 2007 11:47:55 +0200
Message-ID: <11780128752722-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 11:48:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hioxo-0000oY-2r
	for gcvg-git@gmane.org; Tue, 01 May 2007 11:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031632AbXEAJr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 05:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031636AbXEAJr6
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 05:47:58 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:46764 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031632AbXEAJr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 05:47:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id A34006808AC6;
	Tue,  1 May 2007 11:47:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x4V03RoyegHs; Tue,  1 May 2007 11:47:55 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 2850068006B0; Tue,  1 May 2007 11:47:55 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45936>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 test-delta.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/test-delta.c b/test-delta.c
index 16595ef..3d885ff 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -10,8 +10,9 @@
 
 #include "git-compat-util.h"
 #include "delta.h"
+#include "cache.h"
 
-static const char usage[] =
+static const char usage_str[] =
 	"test-delta (-d|-p) <from_file> <data_file> <out_file>";
 
 int main(int argc, char *argv[])
@@ -22,7 +23,7 @@ int main(int argc, char *argv[])
 	unsigned long from_size, data_size, out_size;
 
 	if (argc != 5 || (strcmp(argv[1], "-d") && strcmp(argv[1], "-p"))) {
-		fprintf(stderr, "Usage: %s\n", usage);
+		fprintf(stderr, "Usage: %s\n", usage_str);
 		return 1;
 	}
 
-- 
1.4.4.4

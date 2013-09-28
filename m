From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 02/10] describe: trivial style fixes
Date: Sat, 28 Sep 2013 16:51:38 -0500
Message-ID: <1380405106-29430-3-git-send-email-felipe.contreras@gmail.com>
References: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 23:57:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2WE-00028E-5R
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 23:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab3I1V5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 17:57:36 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:49896 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140Ab3I1V5e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 17:57:34 -0400
Received: by mail-ob0-f170.google.com with SMTP id va2so4205388obc.29
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 14:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IwlzI8Sc7YSnJPsTMGJ8AGDRK9TqJKh3FB0TDzJ07bs=;
        b=FHBYRibUd3S0XLMlp5RvSi3hUi3RxwEeprhQPUWKjn1Xg/WcdRWoGtMwCuoVbmfH+J
         rCjT/x/vN+f3Gv+Wynx3azB6cTgofR2mSuNBQo6IJ1hE6ynkuKR+cdV5ujQrzmloJqbZ
         CLOIZd7znPXAHJ5Ql1v812fxCWzyQbpchyvCpAPwnZWI1CWj9x5C10YgV4BTyW1LjxN1
         ibZqp8ycik8Pf6qeEPoZy7J/V2Fifzsk4jQj0R8tw7/fbCMcWB/Q36WC+Lc1hw3cUXhy
         PWgWeK/kv5HMW+42qkXnEzFyW8w6ZLOjXz5dPOXbXmpvYCh4ujdRtMc2X1TfLVfT/MIV
         N3ig==
X-Received: by 10.182.114.231 with SMTP id jj7mr12363409obb.33.1380405453611;
        Sat, 28 Sep 2013 14:57:33 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm19490424obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 14:57:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235510>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/describe.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index b9d3603..6f62109 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -9,7 +9,7 @@
 #include "hash.h"
 #include "argv-array.h"
 
-#define SEEN		(1u<<0)
+#define SEEN		(1u << 0)
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char * const describe_usage[] = {
@@ -36,7 +36,6 @@ static const char *diff_index_args[] = {
 	"diff-index", "--quiet", "HEAD", "--", NULL
 };
 
-
 struct commit_name {
 	struct commit_name *next;
 	unsigned char peeled[20];
@@ -46,6 +45,7 @@ struct commit_name {
 	unsigned char sha1[20];
 	char *path;
 };
+
 static const char *prio_names[] = {
 	"head", "lightweight", "annotated",
 };
@@ -488,9 +488,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	} else if (dirty) {
 		die(_("--dirty is incompatible with commit-ishes"));
 	} else {
-		while (argc-- > 0) {
+		while (argc-- > 0)
 			describe(*argv++, argc == 0);
-		}
 	}
 	return 0;
 }
-- 
1.8.4-fc

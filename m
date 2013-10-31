From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/16] describe: trivial style fixes
Date: Thu, 31 Oct 2013 03:25:41 -0600
Message-ID: <1383211547-9145-11-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:33:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vboci-0008Ez-N6
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760Ab3JaJcz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:32:55 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53081 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714Ab3JaJcx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:32:53 -0400
Received: by mail-oa0-f46.google.com with SMTP id g12so2768178oah.5
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U+VDM/qs/t9YKgYDV1Oh9AHJz7e/fjrrjXwZh2MZLX8=;
        b=twCRXZrkWMXONmj5Gs+1vNtflMAg15aZYpoKvPnx5GRpaZFWa6wpwg4xmg9rrW4rud
         kHaXYVYpj2Fr5/1IGR3E9P/f4UvFHHLhoSxH83qEuMBJvTSSULPMMcUdGaAZr0Y8SsGx
         IdpvtdF4LodEmYkTzyU58kJvKAMGQcxP+9d/1MzRdaJyoVI4PBlmFGmMlANieKedwV28
         n6p5bcnMz5PEPlxM69tPm2mMoMlHI76wbRGWM7N+xTAqyKNyQ3mRw2PzcuNOdn9bDox6
         hLhtXe+h7RLOB4DBAkbEhDIk8/QoNryG2LozpsqDthTyNy5bBgH06k+Nro48Kt/4h3rw
         LzZg==
X-Received: by 10.182.227.136 with SMTP id sa8mr1815655obc.39.1383211973014;
        Thu, 31 Oct 2013 02:32:53 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm4518350obb.0.2013.10.31.02.32.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:32:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237096>

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
1.8.4.2+fc1

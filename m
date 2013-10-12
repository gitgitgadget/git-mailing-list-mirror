From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 14/20] describe: trivial style fixes
Date: Sat, 12 Oct 2013 02:07:16 -0500
Message-ID: <1381561636-20717-21-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:14:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtP6-0006B4-LM
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845Ab3JLHOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:14:12 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:60411 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830Ab3JLHOI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:14:08 -0400
Received: by mail-oa0-f53.google.com with SMTP id i7so3138093oag.12
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IwlzI8Sc7YSnJPsTMGJ8AGDRK9TqJKh3FB0TDzJ07bs=;
        b=y2qpqBVmjlBXTi+H9x7jc1WK3w0h7/LBqwcIvyZTn7fkjK4iHpIRpCDldyPEjOB979
         Vr2TkA1dNI+MY1NRapC2QNvszP/Pb1e228QtEYneE0P3Am6x+Tnm366LUDmh5l0jfwc1
         3WGKwI7o1huZfg80snt1HI25U8/zPlEQTZ//W0NZOQQ5F+F4WoMAEfSxRQiujczrjuya
         vFVioTuLaxvSz7yw+8yi48P0F3Ke9nJvDdQpZ2u7fu5jQID00UdqeAwVY/xyxZ78Owdo
         VbA517UQ6nV9Zg3tMop01SC3mUTArKX1fU+c8UX03pW2IYGoCtkFV/zOc26jLPLOMK5U
         S4VA==
X-Received: by 10.60.145.207 with SMTP id sw15mr13716078oeb.38.1381562048361;
        Sat, 12 Oct 2013 00:14:08 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id u8sm28650044obd.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:14:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236031>

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

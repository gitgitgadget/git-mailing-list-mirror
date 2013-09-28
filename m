From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/10] setup: trivial style fixes
Date: Sat, 28 Sep 2013 16:51:46 -0500
Message-ID: <1380405106-29430-11-git-send-email-felipe.contreras@gmail.com>
References: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 28 23:58:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2Wg-0002VZ-R8
	for gcvg-git-2@plane.gmane.org; Sat, 28 Sep 2013 23:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755364Ab3I1V6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 17:58:06 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:48151 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348Ab3I1V6B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 17:58:01 -0400
Received: by mail-ob0-f178.google.com with SMTP id uy5so4221178obc.9
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 14:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=puLK65/FUs39Qi+A5BScR8szVIKHIQTXSaXyHoTVdG8=;
        b=st+A8VI8P0wpPjEhGCsID/74aj55myK9ZhklOzoutY4vGC0YxPrln62x2e/dRkElPx
         rG/ixTeFRRkwHIsZESrg0dfMbwO8fHGqrOtZjs2yInTf7neVe29NMdM1QE4a9p40wSqz
         gUWNu7Qd9MsFGfXI3j5J6QTipdxOXm8Yuc/DlEnGxVeGj8GC7SR5Z17kHrDw9e9GnaJh
         Yvf6ArkgaPK8dZc80yqCMMflC3b1S/f98Jjun9PbL/cD5EEcq6Kt2InDIM8TkzNF6ODk
         IftyR3tl4yhNCr0eOJf2PJlpFOdN0JlhqePssIiHFsldTbVTZM99kZCM2UVtApuFJPIt
         dz+w==
X-Received: by 10.60.51.196 with SMTP id m4mr12202325oeo.1.1380405481190;
        Sat, 28 Sep 2013 14:58:01 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rr6sm25413955oeb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 14:58:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405106-29430-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235519>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index f08dd64..c717db4 100644
--- a/setup.c
+++ b/setup.c
@@ -566,7 +566,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 {
 	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
 	struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
-	static char cwd[PATH_MAX+1];
+	static char cwd[PATH_MAX + 1];
 	const char *gitdirenv, *ret;
 	char *gitfile;
 	int len, offset, offset_parent, ceil_offset = -1;
@@ -581,7 +581,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	if (nongit_ok)
 		*nongit_ok = 0;
 
-	if (!getcwd(cwd, sizeof(cwd)-1))
+	if (!getcwd(cwd, sizeof(cwd) - 1))
 		die_errno("Unable to read current working directory");
 	offset = len = strlen(cwd);
 
-- 
1.8.4-fc

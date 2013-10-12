From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 19/20] setup: trivial style fixes
Date: Sat, 12 Oct 2013 02:07:02 -0500
Message-ID: <1381561636-20717-7-git-send-email-felipe.contreras@gmail.com>
References: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:13:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtOP-0005ga-2Z
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624Ab3JLHNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:13:34 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:58420 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508Ab3JLHNc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:13:32 -0400
Received: by mail-oa0-f42.google.com with SMTP id g12so3188796oah.29
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=puLK65/FUs39Qi+A5BScR8szVIKHIQTXSaXyHoTVdG8=;
        b=A6LM1XZ4DWbbP1s4kQTo72fy9Ei0KC1DUnBnfj6d/ty73QUxjE5WnYSFjSm19lRG3w
         v0rTS9vjmCfg+P3Ss6iJkvgbHaBU3jHD7L9gHijmkLjcBqlza6ymx0vOIX4vG9aLsiDr
         9NsnwaucXKQlJZVevp0UM3A1HezCecIIV6Di+TS9sAc90Sv6zpSO5gvT7qpDlQVFjHx/
         vRcewHv0/AWOvlUNYj8w9HHqbv9LxTw6u07Yi0GEp+0x1288xI+WYtiolde2cUxulF4p
         SvhoD6ZKz+pAqeK/s8dB03pUE+LJgjnPVpxXEzjNYDh+/1Hk5JN8X4VbtJSzEya1qoXw
         nUQg==
X-Received: by 10.182.50.130 with SMTP id c2mr17835776obo.35.1381562012455;
        Sat, 12 Oct 2013 00:13:32 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm28656162obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:13:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561636-20717-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236015>

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

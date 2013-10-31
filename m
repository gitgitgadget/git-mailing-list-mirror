From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 15/16] setup: trivial style fixes
Date: Thu, 31 Oct 2013 03:25:46 -0600
Message-ID: <1383211547-9145-16-git-send-email-felipe.contreras@gmail.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 31 10:33:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbocx-0008Mw-Sb
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 10:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849Ab3JaJdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 05:33:07 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:44619 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821Ab3JaJdE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 05:33:04 -0400
Received: by mail-ob0-f170.google.com with SMTP id wp18so2781174obc.29
        for <git@vger.kernel.org>; Thu, 31 Oct 2013 02:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MYsgwc+YOmy8DRt305v29/8Ke8EMDCXvubAhTa+b6Jc=;
        b=TxrIZG1wHqLq3IHtQCQBp2upE4gHfpmHv/nrpvTntvKuw/9+Bav8acH+CyL2musvIr
         927LasNjjWZErBeIuZbjjAlzmQaTQMno2dp9cjrevt3K9AWwAV+thrPhzbmRRQJQ3es3
         y0ljtkvrOgGpRx1zz7BToHxEeO05SPpCoYXRVUoRk9f46geO+ZIeNkZ8SjLeOS3PiQFJ
         iCyuEYuR01paRTxcGiTwa7fkmcjAv19HoA5Qq30nBIasg4aPry3PAlH3YmvX0/w6hZOG
         /HSM3NBOb304bJ7oyTw4W5uvsNmJLWtYU8pxJVyXs7PiYuOOYKCMRy8rFdca4m5+qXh5
         oSjg==
X-Received: by 10.60.133.233 with SMTP id pf9mr1899294oeb.46.1383211984244;
        Thu, 31 Oct 2013 02:33:04 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm5423769oeo.1.2013.10.31.02.33.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2013 02:33:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237099>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index dbf4138..5432a31 100644
--- a/setup.c
+++ b/setup.c
@@ -563,7 +563,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 {
 	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
 	struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
-	static char cwd[PATH_MAX+1];
+	static char cwd[PATH_MAX + 1];
 	const char *gitdirenv, *ret;
 	char *gitfile;
 	int len, offset, offset_parent, ceil_offset = -1;
@@ -578,7 +578,7 @@ static const char *setup_git_directory_gently_1(int *nongit_ok)
 	if (nongit_ok)
 		*nongit_ok = 0;
 
-	if (!getcwd(cwd, sizeof(cwd)-1))
+	if (!getcwd(cwd, sizeof(cwd) - 1))
 		die_errno("Unable to read current working directory");
 	offset = len = strlen(cwd);
 
-- 
1.8.4.2+fc1

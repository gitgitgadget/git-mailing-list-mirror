From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 01/20] dir.c: coding style fix
Date: Wed,  7 May 2014 21:51:41 +0700
Message-ID: <1399474320-6840-2-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:52:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3Cl-0005VP-GR
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246AbaEGOwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:52:09 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:49048 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbaEGOwH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:52:07 -0400
Received: by mail-pa0-f52.google.com with SMTP id kx10so1290750pab.39
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n+BzkJ2SdRpKstvwwvrcHSCrObyabEsCmZW8ksRxhks=;
        b=DVQG9ld8DlV4Wq7juVolHSiPB5scZ0KJaZpWTMZQp+DJvEvVGR6wxort6/raoU+1hE
         YskDO1m+u2j+dNn7lNn9i7ILxwfrHbD8zw8ba6kOtIn4hKNAouHkumD+cNmdstGkucpw
         Fyo20nGVlA7PgMoc5UP6py24p/BCAkyMryl9MxuhmS8nlDqdKNPlwSMEbHE5mbtbCw3j
         fNvKNlTbJlS6HrQt21QkCa3hfnAfIWbaDS+oAkt4lrBkHuJbJnLqeKMRS71kPLiJFuNH
         XCqE3RKjLi0gAjD5P0nGZ9i8f3+5vWBLQ3hhSsPyzVCansQiXVI9ssHMa2qIOsCVudMm
         D7+A==
X-Received: by 10.66.180.34 with SMTP id dl2mr19946829pac.124.1399474326810;
        Wed, 07 May 2014 07:52:06 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id di3sm3663663pbc.11.2014.05.07.07.52.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:52:06 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:52:07 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248307>

---
 dir.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index eb6f581..7a83f70 100644
--- a/dir.c
+++ b/dir.c
@@ -553,8 +553,7 @@ int add_excludes_from_file_to_list(const char *fname,
 			buf = xrealloc(buf, size+1);
 			buf[size++] = '\n';
 		}
-	}
-	else {
+	} else {
 		size = xsize_t(st.st_size);
 		if (size == 0) {
 			close(fd);
@@ -789,9 +788,11 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 
 	group = &dir->exclude_list_group[EXC_DIRS];
 
-	/* Pop the exclude lists from the EXCL_DIRS exclude_list_group
+	/*
+	 * Pop the exclude lists from the EXCL_DIRS exclude_list_group
 	 * which originate from directories not in the prefix of the
-	 * path being checked. */
+	 * path being checked.
+	 */
 	while ((stk = dir->exclude_stack) != NULL) {
 		if (stk->baselen <= baselen &&
 		    !strncmp(dir->basebuf, base, stk->baselen))
@@ -818,8 +819,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		if (current < 0) {
 			cp = base;
 			current = 0;
-		}
-		else {
+		} else {
 			cp = strchr(base + current + 1, '/');
 			if (!cp)
 				die("oops in prep_exclude");
-- 
1.9.1.346.ga2b5940

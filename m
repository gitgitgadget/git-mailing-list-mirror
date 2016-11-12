Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B8B42079C
	for <e@80x24.org>; Sat, 12 Nov 2016 02:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966339AbcKLCYm (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 21:24:42 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35863 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938518AbcKLCYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 21:24:36 -0500
Received: by mail-pg0-f68.google.com with SMTP id x23so3161147pgx.3
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 18:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aOauha+nSiiSmjkWk4tLBDO49/npU1aRQE5qbIowPUA=;
        b=yFUfICtS3cigscJ9yH9JewQVS7LCcuuN9wG6pA1e/z3wb/Nuc9U+pg/LbJ0t1g1/Qb
         M6gcBJkdIK2UuGWU42xiTebrG7fWsNwMagr36kNxIzYtCEcE2zefVQl7ZxXbzmZw99fm
         n0B4DVhJPGJgxdAYh+xw95MvIJULTXDRJ0nWgt4J86HCx65Yb27U6TEb6Hn976NudcHl
         8Tcf+oJ2ptdPxzBAPwBH8O9TYxmlsWK72xPxVYN/EwQV5xyFAcXFp8XM3ObZP1bHXWWS
         WjnocIeCU7BYyvJa2Jce+VmEj3qk8Tz6xluRujfH+1Gzj3DbMMrDoVrctJBzy9aGmp3Y
         M7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aOauha+nSiiSmjkWk4tLBDO49/npU1aRQE5qbIowPUA=;
        b=IkVNOM4ZIOt+iEAdD4+APPBZcJUEzWNlX9M/Rq2fjEzFo89ud/pShoQHN8n/A4mJui
         9fkUJF8nQTTexCK39NmgqQPWiW8eVUdtnB8a+yf5dQ9aTtKOmbKI8AVJu2Njas2TG8n5
         6PzZqyQ0M1amTdY3W9d9djjbZJ6/EuwHTnNpdDKYSkJwy+A6C0Rw8cmYKTTfum79PTBv
         qWgNHyv3J2F3tdMfy3WGGwZk0a6bxLUrpQO74qg7pAL6YDBxc+34nBoOP535N/ZqUror
         f7N+zUfwp2DjfTGumYp7IIcciortnKSSudnEfrI1vH2xy6yhO5FZGY8u5642FbIYcyNq
         TpIw==
X-Gm-Message-State: ABUngvf0d0dZ2U1MlqPlANdCd8B14P/a5VGWtJ35Z0oeSxzEPo8QdqtnDdqP4ZliulIUvQ==
X-Received: by 10.98.14.143 with SMTP id 15mr12825524pfo.11.1478917442758;
        Fri, 11 Nov 2016 18:24:02 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id po8sm18065141pab.20.2016.11.11.18.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 18:24:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Nov 2016 09:23:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/11] copy.c: style fix
Date:   Sat, 12 Nov 2016 09:23:30 +0700
Message-Id: <20161112022337.13317-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161112022337.13317-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 copy.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/copy.c b/copy.c
index 074b609..60c7d8a 100644
--- a/copy.c
+++ b/copy.c
@@ -111,8 +111,10 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 		if (dest_exists) {
 			if (!S_ISDIR(dest_stat.st_mode))
 				return error(_("target '%s' is not a directory"), dest);
-			/* race here: user can substitute a symlink between
-			 * this check and actual creation of files inside dest */
+			/*
+			 * race here: user can substitute a symlink between
+			 * this check and actual creation of files inside dest
+			 */
 		} else {
 			/* Create DEST */
 			mode_t mode;
@@ -130,22 +132,24 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 			if (lstat(dest, &dest_stat) < 0)
 				return error_errno(_("can't stat '%s'"), dest);
 		}
-		/* remember (dev,inode) of each created dir.
-		 * NULL: name is not remembered */
+		/*
+		 * remember (dev,inode) of each created dir. name is
+		 * not remembered
+		 */
 		add_to_ino_dev_hashtable(&dest_stat, NULL);
 
 		/* Recursively copy files in SOURCE */
 		dp = opendir(source);
-		if (dp == NULL) {
+		if (!dp) {
 			retval = -1;
 			goto preserve_mode_ugid_time;
 		}
 
-		while ((d = readdir(dp)) != NULL) {
+		while ((d = readdir(dp))) {
 			char *new_source, *new_dest;
 
 			new_source = concat_subpath_file(source, d->d_name);
-			if (new_source == NULL)
+			if (!new_source)
 				continue;
 			new_dest = concat_path_file(dest, d->d_name);
 			if (copy_file(new_source, new_dest, flags & ~FILEUTILS_DEREFERENCE_L0) < 0)
@@ -155,16 +159,15 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 		}
 		closedir(dp);
 
-		if (!dest_exists
-		 && chmod(dest, source_stat.st_mode & ~saved_umask) < 0
-		) {
+		if (!dest_exists &&
+		    chmod(dest, source_stat.st_mode & ~saved_umask) < 0) {
 			error_errno(_("can't preserve permissions of '%s'"), dest);
 			/* retval = -1; - WRONG! copy *WAS* made */
 		}
 		goto preserve_mode_ugid_time;
 	}
 
-	if (S_ISREG(source_stat.st_mode) ) { /* "cp [-opts] regular_file thing2" */
+	if (S_ISREG(source_stat.st_mode)) { /* "cp [-opts] regular_file thing2" */
 		int src_fd;
 		int dst_fd;
 		mode_t new_mode;
@@ -199,7 +202,7 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 		if (!S_ISREG(source_stat.st_mode))
 			new_mode = 0666;
 
-		// POSIX way is a security problem versus (sym)link attacks
+		/* POSIX way is a security problem versus (sym)link attacks */
 		if (!ENABLE_FEATURE_NON_POSIX_CP) {
 			dst_fd = open(dest, O_WRONLY|O_CREAT|O_TRUNC, new_mode);
 		} else { /* safe way: */
@@ -226,13 +229,15 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 			retval = error_errno(_("error writing to '%s'"), dest);
 		/* ...but read size is already checked by bb_copyfd_eof */
 		close(src_fd);
-		/* "cp /dev/something new_file" should not
-		 * copy mode of /dev/something */
+		/*
+		 * "cp /dev/something new_file" should not
+		 * copy mode of /dev/something
+		 */
 		if (!S_ISREG(source_stat.st_mode))
 			return retval;
 		goto preserve_mode_ugid_time;
 	}
- dont_cat:
+dont_cat:
 
 	/* Source is a symlink or a special file */
 	/* We are lazy here, a bit lax with races... */
@@ -252,20 +257,23 @@ int FAST_FUNC copy_file(const char *source, const char *dest, int flags)
 			if (lchown(dest, source_stat.st_uid, source_stat.st_gid) < 0)
 				error_errno(_("can't preserve %s of '%s'"), "ownership", dest);
 		}
-		/* _Not_ jumping to preserve_mode_ugid_time:
-		 * symlinks don't have those */
+		/*
+		 * _Not_ jumping to preserve_mode_ugid_time: symlinks
+		 * don't have those
+		 */
 		return 0;
 	}
-	if (S_ISBLK(source_stat.st_mode) || S_ISCHR(source_stat.st_mode)
-	 || S_ISSOCK(source_stat.st_mode) || S_ISFIFO(source_stat.st_mode)
-	) {
+	if (S_ISBLK(source_stat.st_mode) ||
+	    S_ISCHR(source_stat.st_mode) ||
+	    S_ISSOCK(source_stat.st_mode) ||
+	    S_ISFIFO(source_stat.st_mode)) {
 		if (mknod(dest, source_stat.st_mode, source_stat.st_rdev) < 0)
 			return error_errno(_("can't create '%s'"), dest);
 	} else
 		return error(_("unrecognized file '%s' with mode %x"),
 			     source, source_stat.st_mode);
 
- preserve_mode_ugid_time:
+preserve_mode_ugid_time:
 
 	if (1 /*FILEUTILS_PRESERVE_STATUS*/) {
 		struct timeval times[2];
-- 
2.8.2.524.g6ff3d78


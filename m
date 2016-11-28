Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F04DF1FC96
	for <e@80x24.org>; Mon, 28 Nov 2016 09:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754382AbcK1JoH (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:44:07 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35695 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754317AbcK1JoF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:44:05 -0500
Received: by mail-pg0-f68.google.com with SMTP id p66so12692990pga.2
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aOauha+nSiiSmjkWk4tLBDO49/npU1aRQE5qbIowPUA=;
        b=aiK4i3zrmuV5YuI4iUIBteIVLk7yd62S86WvHQYiy9EHC2oIcutkTn2HB6R3jRMpb/
         SlGfK/I0sFaeh5kT9NGPJf0X40xHJW0gc4LJxRxDCNaW4+qj/fMd07W60BkB/oLWaFCV
         5MbBb3fEiyhgxz8KAo1F2A4mYF5lB9gMDPXcD13g+xp0aPlVk0gThDe6wdi3URgXITrU
         eevNvJA3g0NNn16wy5OwilmG7uEwxQwKWmt7bwn6aXKn6CfuD0Nf8kLkBSEmkWqeLL1I
         wETeZbU9qsYOzjR9aF3wO7t+ROzZWn+pHQbSuyHyQWGel2LCIotzVIeGCEl3xkfIkIb5
         VjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aOauha+nSiiSmjkWk4tLBDO49/npU1aRQE5qbIowPUA=;
        b=CYe8c+47NmwU3H21dM/+nWj6y+HhjbFq0diai8pGlCTFPd3x0qIztICIf/3FbkCUUh
         d+p+vAslQVoXAQmo9Q5mj2QImQUe2teEUdgOYpvC5NAQVkQVpn1nsnwUdrI+tgia160j
         XR1ds9GG7PoG+E8zgqZYk63rLUVO/8fdHcnSVicom/TNKy6I8TE972xRKaAFAcO4KKb3
         xbAx+Uz0BXMAv6HAoSHjUPJW+YLbGB/+Sw0373VN5BJfJ0FewsO73KQSgUxm4i4Ny5rl
         5LrauShU8RUBahxol9dOhERFQliZCmmy+i1ft/vyLwLebSLQ1NbYlNI8/PcZ2KDkq2Uh
         Nk/w==
X-Gm-Message-State: AKaTC00lfEAXZd5diQqCF7skGqvERVnMtM8/rjwMYC3kwWsFwK7Ap2ZDdWD9BRpkI+Z/Xg==
X-Received: by 10.99.218.85 with SMTP id l21mr38347196pgj.102.1480326244806;
        Mon, 28 Nov 2016 01:44:04 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id n17sm85749610pfg.80.2016.11.28.01.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:44:04 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:43:59 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 04/11] copy.c: style fix
Date:   Mon, 28 Nov 2016 16:43:12 +0700
Message-Id: <20161128094319.16176-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161128094319.16176-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
 <20161128094319.16176-1-pclouds@gmail.com>
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


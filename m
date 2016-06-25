Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF1CC1FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 08:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbcFYIGs (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 04:06:48 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36237 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbcFYIGY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 04:06:24 -0400
Received: by mail-lf0-f68.google.com with SMTP id a2so23895408lfe.3
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 01:06:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P0nQgsscso15+Uat7lrdTKVMNk90FA6H869cTbcirkQ=;
        b=DwiBGEr61o9Y1ZbTB+MtL1C9zlpVYdk9o5o26jhO8bAvhL0pGQodJFZut2fSjSYeYu
         JqaAUYT6HoIOLFO6u82381UHZyB02IZyxJngfAMlaZYRuVAwJ93Huat7mZWaAWpp6YI5
         TJMyMuSHaI/e106o2uPipihsWLn6ZmU33P7a0OC4kdK9iJslbDgwOJbpBE6ur2nsSe+y
         XMDtflnyyRRLBsY5uCFQG8qsMO7k0cMRT2j/E7VgE5vETBUQL2JAntBIcOMPE7OBDO28
         zTMQWr7IePhSbPDWjbkkE5/ZqdZxMnes4sH5RS2tGSUDqW+cI7UUZh3Uitl5Lq6OzlMN
         Hatg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P0nQgsscso15+Uat7lrdTKVMNk90FA6H869cTbcirkQ=;
        b=VcfvAcxyxju/qTLTd7FR/zZ70wjHYLcobRDNlEnIQ5szF8Ll3g4SzyEHfFynhd7k9I
         VMRdhcG+uuDlJuUuoTkZvg+AjZpehV0C2ikGtXjBr4Bjh0QEq/RgISSFAllZPhBkRHJu
         +yTMCkzu28yCThqs3rSxvtNEoerL1klHNIt3//kFWBRt/u+OxQBFTBMtus9JO3siUKvn
         T+s4SmtbRU4hQw2fIffBdccb8GyrMsWUaOb3Qg18OrxeYa5sVOUoh5AR6TWbGoNp/cGu
         t8cvQbiVst1bsuu9X2R3Lk8OK7MKoeVVQISWHfXuAJAc1pwAMzpwZxQBABbA0WG3rIjI
         9bVw==
X-Gm-Message-State: ALyK8tJvqOibzC/duznOM1hz8z+Asx1NAeWjnrtZdpZJqhkYg/RsaN/89RkmaDPoV6+8CQ==
X-Received: by 10.25.150.75 with SMTP id y72mr2667946lfd.92.1466841284355;
        Sat, 25 Jun 2016 00:54:44 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g79sm1536122ljg.26.2016.06.25.00.54.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 00:54:42 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/10] copy.c: style fix
Date:	Sat, 25 Jun 2016 09:54:27 +0200
Message-Id: <20160625075433.4608-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625075433.4608-1-pclouds@gmail.com>
References: <20160625075433.4608-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
2.8.2.526.g02eed6d


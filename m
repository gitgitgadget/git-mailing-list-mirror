From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/26] copy.c: style fix
Date: Tue, 16 Feb 2016 20:29:07 +0700
Message-ID: <1455629367-26193-7-git-send-email-pclouds@gmail.com>
References: <1454492150-10628-1-git-send-email-pclouds@gmail.com>
 <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 14:30:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVfhT-0002YS-Lk
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 14:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbcBPN3u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2016 08:29:50 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33926 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbcBPN3t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 08:29:49 -0500
Received: by mail-pa0-f51.google.com with SMTP id fy10so64097234pac.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 05:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2VqWNCxy+NMn1rcC0ZSLyzKUi+dbE6L6k8bKJjuTeW8=;
        b=BURUPFOkxlQjLMf28HyvtLTLDVxchItdFUz8W1r2pMh0gcvEwYAaw1TlivPRTVSaad
         EDVgoDyqFzSOx+vijGFZ9NJZg/7bKY2jiyc7ZHIMyZmik5dsjvEdZqvAVwfclxPi0Nzu
         s/olB+aEd3U7Ck/05WT0m5IIh2NcfCFs6uZJ6cpZY3vrLXubivkbrlXG3zWb885KpDyy
         BdsHjI2RxUnFZxganiSw0YbQrfJfPdUZvWksiGK8RgIYHQ56nyanJFZAypd+lAFwesyU
         5EuF9jiHVyQvQx8Z0YejMm5WpWcHiR9pyq1NCRvx4kzCpKDTBS9n8CwQZgUR1aewxsfv
         NI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=2VqWNCxy+NMn1rcC0ZSLyzKUi+dbE6L6k8bKJjuTeW8=;
        b=R5baJWi+coWeIJvDbq+gf2g0XOkH2ZcP2iHq6y8TTEXtl32mF3VnUCobyAmGc8OmAx
         Buvn0LQTxjDO0h/SEqfFfg9F+Ju6qYfCb58/EkUx5XBY2ZCveZT2xTc63eeXyuCEMtkK
         ZAe1x/RXV4/EuC9TJ4iH6vhATZ8Lj+tbuU5nwheSSdZkDZNn9jxzQMGZQQXrdv2tArEl
         zfKqBVsvX/yV8Rqxma5atbaVZI/raFIPGdG43jbwUNLMZSfBdO1+Q5XXZ8ApfJ8AMR/I
         JRdEwJl5y9X1IzJLBnMLTpVT5LJzoLl/aSeOwsGfxUsFmIc/rM/L4i2EqCT7m85SHRUX
         aZIQ==
X-Gm-Message-State: AG10YOQpRMU+6ZqqgXLjz8WyyWMFpU343YhgPpLRnD2R6GsJ/GUSMTQrdW8rspoo7gZLVQ==
X-Received: by 10.67.8.100 with SMTP id dj4mr31175557pad.88.1455629388817;
        Tue, 16 Feb 2016 05:29:48 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 67sm44324526pfi.2.2016.02.16.05.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2016 05:29:47 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 16 Feb 2016 20:30:11 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1455629367-26193-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286366>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 copy.c | 50 +++++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/copy.c b/copy.c
index cdb38d5..00f8349 100644
--- a/copy.c
+++ b/copy.c
@@ -111,8 +111,10 @@ int FAST_FUNC copy_file(const char *source, const =
char *dest, int flags)
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
@@ -130,22 +132,24 @@ int FAST_FUNC copy_file(const char *source, const=
 char *dest, int flags)
 			if (lstat(dest, &dest_stat) < 0)
 				return sys_error(_("can't stat '%s'"), dest);
 		}
-		/* remember (dev,inode) of each created dir.
-		 * NULL: name is not remembered */
+		/*
+		 * remember (dev,inode) of each created dir. name is
+		 * not remembered
+		 */
 		add_to_ino_dev_hashtable(&dest_stat, NULL);
=20
 		/* Recursively copy files in SOURCE */
 		dp =3D opendir(source);
-		if (dp =3D=3D NULL) {
+		if (!dp) {
 			retval =3D -1;
 			goto preserve_mode_ugid_time;
 		}
=20
-		while ((d =3D readdir(dp)) !=3D NULL) {
+		while ((d =3D readdir(dp))) {
 			char *new_source, *new_dest;
=20
 			new_source =3D concat_subpath_file(source, d->d_name);
-			if (new_source =3D=3D NULL)
+			if (!new_source)
 				continue;
 			new_dest =3D concat_path_file(dest, d->d_name);
 			if (copy_file(new_source, new_dest, flags & ~FILEUTILS_DEREFERENCE_=
L0) < 0)
@@ -155,16 +159,15 @@ int FAST_FUNC copy_file(const char *source, const=
 char *dest, int flags)
 		}
 		closedir(dp);
=20
-		if (!dest_exists
-		 && chmod(dest, source_stat.st_mode & ~saved_umask) < 0
-		) {
+		if (!dest_exists &&
+		    chmod(dest, source_stat.st_mode & ~saved_umask) < 0) {
 			sys_error(_("can't preserve permissions of '%s'"), dest);
 			/* retval =3D -1; - WRONG! copy *WAS* made */
 		}
 		goto preserve_mode_ugid_time;
 	}
=20
-	if (S_ISREG(source_stat.st_mode) ) { /* "cp [-opts] regular_file thin=
g2" */
+	if (S_ISREG(source_stat.st_mode)) { /* "cp [-opts] regular_file thing=
2" */
 		int src_fd;
 		int dst_fd;
 		mode_t new_mode;
@@ -199,7 +202,7 @@ int FAST_FUNC copy_file(const char *source, const c=
har *dest, int flags)
 		if (!S_ISREG(source_stat.st_mode))
 			new_mode =3D 0666;
=20
-		// POSIX way is a security problem versus (sym)link attacks
+		/* POSIX way is a security problem versus (sym)link attacks */
 		if (!ENABLE_FEATURE_NON_POSIX_CP) {
 			dst_fd =3D open(dest, O_WRONLY|O_CREAT|O_TRUNC, new_mode);
 		} else { /* safe way: */
@@ -226,13 +229,15 @@ int FAST_FUNC copy_file(const char *source, const=
 char *dest, int flags)
 			retval =3D sys_error(_("error writing to '%s'"), dest);
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
=20
 	/* Source is a symlink or a special file */
 	/* We are lazy here, a bit lax with races... */
@@ -252,20 +257,23 @@ int FAST_FUNC copy_file(const char *source, const=
 char *dest, int flags)
 			if (lchown(dest, source_stat.st_uid, source_stat.st_gid) < 0)
 				sys_error(_("can't preserve %s of '%s'"), "ownership", dest);
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
 			return sys_error(_("can't create '%s'"), dest);
 	} else
 		return error(_("unrecognized file '%s' with mode %x"),
 			     source, source_stat.st_mode);
=20
- preserve_mode_ugid_time:
+preserve_mode_ugid_time:
=20
 	if (1 /*FILEUTILS_PRESERVE_STATUS*/) {
 		struct timeval times[2];
--=20
2.7.0.377.g4cd97dd

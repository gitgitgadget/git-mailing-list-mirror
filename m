From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/25] copy.c: style fix
Date: Wed, 13 Apr 2016 20:15:27 +0700
Message-ID: <1460553346-12985-7-git-send-email-pclouds@gmail.com>
References: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 15:16:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKek-00045M-VG
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 15:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760586AbcDMNQV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 09:16:21 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34132 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759970AbcDMNQU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 09:16:20 -0400
Received: by mail-pf0-f194.google.com with SMTP id d184so4102858pfc.1
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+7I1Mc5gDfrezZP876DBAiABD3kcN9n44C5Ib7YPvM=;
        b=1Fq/Z5juFHuLAgC++TNgOmW+J7dENPAawpxwYnObmRa/gLxdvAJG3KclNVEqGnfDZ9
         oR88yfOnY0F6AykDA5haouStyaFOd4boFRjs6qixck1KdWeD3WNudJasadSg4ugOfpc4
         XKqN8da9QuGpjOZ97l8nuvpaGUmlb39rbStClVsDQb4AkVXhfgICus+h8XI0LMiyPm5g
         737lUPLPhaoH72wXOxBhwOSazbVQZxbhfU3rFrEZFKCKTQrJcsxym43PXNcjXcSs4+A+
         cW32Tw0yF6sTfeVVLOgm5fw+kbz9EBaQgKg4HpdHum8zq4Fv5BMW0v0ixVBe/rkt9/VG
         lUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+7I1Mc5gDfrezZP876DBAiABD3kcN9n44C5Ib7YPvM=;
        b=KHFaJ4p9uFG4HlUDJ3Pv4+gR1IDpW4GeSRH1SEjyUx4lmMTFxuOiGk3yCYl3pnrJna
         sdgwczTs2Xpc+NQV/6RGFRZbKKPW0MwKegfxk/lHbOmTe++L+DnkIX6cv7u/Ea2ZKJsJ
         v1vsxAOplWIrWd02scTNqKn5ewcl0hJ7PUaq5pgOX8UWPIJzSivYcYHODGb56tVqudnE
         agzmXk1EwBmnHgHH0FSMLOGH7hbscka8+hsnddTuaSlKgY6GuJGtO/ecNSKgA9w33j/q
         2JMVx30tSyYtQnZad/QQZ/acMm1WhgfTP8OnIyr7AR8cHtYkSRVUioAZ6E77d/UjRYli
         IwZw==
X-Gm-Message-State: AOPr4FXS5ulPrUCxK7PkQdVqv7fHHKt9hSqTcrkGdC24n5ke4aQlB6msPMtT3zIzgtnHpw==
X-Received: by 10.98.36.25 with SMTP id r25mr11191165pfj.5.1460553379339;
        Wed, 13 Apr 2016 06:16:19 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id ak9sm51302561pac.13.2016.04.13.06.16.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 06:16:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 20:16:25 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460553346-12985-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291429>

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
2.8.0.rc0.210.gd302cd2

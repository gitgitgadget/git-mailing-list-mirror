From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/26] upload-pack: remove unused variable "backup"
Date: Wed, 13 Apr 2016 19:54:49 +0700
Message-ID: <1460552110-5554-6-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:55:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKKp-00046X-Oq
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:55:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030546AbcDMMzj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:55:39 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35569 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030495AbcDMMzg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:55:36 -0400
Received: by mail-pa0-f67.google.com with SMTP id zy2so3921121pac.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R57g/tS9wCRyyqkbtWXM2Wo0IeZqI7GEBI9xnafSab0=;
        b=OjYd52KNLSYC3x8+YZgWO13WzrzwF6CjR/5ST53Z60nhuQeMzD9CsJLE9YmYaD0WWt
         rH6btfcnnF7poiiaPl9AHgFtCEbjVwf0b/vwF3p8YBo5s0eTJGNkQbXGUenYFioB7Kwi
         GQU4okClBfU2G9WnvdFIlwLVcvDl8+EYF+Q7+T+VvusPYJD3n2WvtImXWRpiP0WIjN9m
         8p3RVeGiW+sNal1DvKTdnw3VIT70OrepQr+fHws0ZlTEUUv4bn2mM29DMUCqymHP6GZ9
         wEl/KSslYROcJo2+KP7VLU3kAsLpgGe4Pf+xRj5ta6sFrokww7y5kD7wuLDWzMfsfOMo
         wp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R57g/tS9wCRyyqkbtWXM2Wo0IeZqI7GEBI9xnafSab0=;
        b=CN4RX8a9daQEyA9NjB/PwDxPJXOBw/T7NmfPUO+H+kJTwvgyE40uEUqLtbNV2Jjwxi
         FAm0+Ts8Bm1mRkEEabRD7zyOhXvjAwuMuYY7ePspsLgYoFYyJPKn0LQH/yrDQ9QWWhBX
         0xgD2zZn+Ofs51ZsImWuTU881Vuiaj1LcJ2eQMfY35gpH5MBZzyQVPxt0Ste4W2eQ//S
         O7UuiNYwU3+xtGJWURKFHEbLh5+G/uijZI82258nPM+236ZF87Gjz0EVqrTRM3421iJA
         3llxzcHqQgvIC2C1Z7lscGHri29bQbN0tiv7DBltmGVASZTzCl+0bzaMJ27vpCi4mcNQ
         Tv6Q==
X-Gm-Message-State: AOPr4FWAEHjgGzKzXm/CjvkFQGhz+yGLkiX6//A2LQncMfJlQHdsmcgkHQD+VWXfZCkzlA==
X-Received: by 10.66.243.35 with SMTP id wv3mr12624282pac.93.1460552135422;
        Wed, 13 Apr 2016 05:55:35 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id 26sm6616002pft.41.2016.04.13.05.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:55:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:55:41 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291398>

After the last patch, "result" and "backup" are the same. "result" used
to move, but the movement is now contained in send_shallow(). Delete
this redundant variable.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 upload-pack.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0eb9a0b..ee5d20b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -554,7 +554,7 @@ static void send_shallow(struct commit_list *result=
)
=20
 static void deepen(int depth, const struct object_array *shallows)
 {
-	struct commit_list *result =3D NULL, *backup =3D NULL;
+	struct commit_list *result =3D NULL;
 	int i;
 	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
 		for (i =3D 0; i < shallows->nr; i++) {
@@ -562,11 +562,10 @@ static void deepen(int depth, const struct object=
_array *shallows)
 			object->flags |=3D NOT_SHALLOW;
 		}
 	else
-		backup =3D result =3D
-			get_shallow_commits(&want_obj, depth,
-					    SHALLOW, NOT_SHALLOW);
+		result =3D get_shallow_commits(&want_obj, depth,
+					     SHALLOW, NOT_SHALLOW);
 	send_shallow(result);
-	free_commit_list(backup);
+	free_commit_list(result);
 	for (i =3D 0; i < shallows->nr; i++) {
 		struct object *object =3D shallows->objects[i].item;
 		if (object->flags & NOT_SHALLOW) {
--=20
2.8.0.rc0.210.gd302cd2

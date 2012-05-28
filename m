From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/65] i18n: cat-file: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:20 +0700
Message-ID: <1338203657-26486-6-git-send-email-pclouds@gmail.com>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 28 13:19:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYxyu-0006GA-1P
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab2E1LTT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:19:19 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59749 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab2E1LTS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:19:18 -0400
Received: by dady13 with SMTP id y13so4033567dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=efdbtVA01xT9qYiTgEKxdXBIsE6a81nWWaRyxHoUhng=;
        b=NywMbUHso1H6YebcgfqQ0l1nRfENNyf5wnTtL8d1p7ukUr/kgtPqt9UBZkVbw0aMN1
         o3VWMkMGEClzwikFem9aDPE0llOL62FVFYGhECyF3QlSfs6HNrRvx1ThEFROBsp4d6cy
         qNz39RJxfOBSqw+qA1iDd0KWYYzn7Eu4H2ADZi/M4d8aUAIKIJrkenv2OJ1mcYje/0bN
         Z/gSs/LeAc1RnLOPBVF3KIoYU0pMqOvSIRNNEofIjQl7PsLFzo1u2PW4Zci2wljLBezK
         EF2by/A6HhBU6TMtGvGmy4S71gH5RUO/OG8Xb/aEK7F9NQ0fpBdCirpvUSWAjH/8jdYl
         dtwA==
Received: by 10.68.242.197 with SMTP id ws5mr26066622pbc.12.1338203958547;
        Mon, 28 May 2012 04:19:18 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id mt9sm19003301pbb.14.2012.05.28.04.19.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:19:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:15:13 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198644>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/cat-file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 36a9104..fd08338 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -244,8 +244,8 @@ static int batch_objects(int print_contents)
 }
=20
 static const char * const cat_file_usage[] =3D {
-	"git cat-file (-t|-s|-e|-p|<type>|--textconv) <object>",
-	"git cat-file (--batch|--batch-check) < <list_of_objects>",
+	N_("git cat-file (-t|-s|-e|-p|<type>|--textconv) <object>"),
+	N_("git cat-file (--batch|--batch-check) < <list_of_objects>"),
 	NULL
 };
=20
@@ -263,19 +263,19 @@ int cmd_cat_file(int argc, const char **argv, con=
st char *prefix)
 	const char *exp_type =3D NULL, *obj_name =3D NULL;
=20
 	const struct option options[] =3D {
-		OPT_GROUP("<type> can be one of: blob, tree, commit, tag"),
-		OPT_SET_INT('t', NULL, &opt, "show object type", 't'),
-		OPT_SET_INT('s', NULL, &opt, "show object size", 's'),
+		OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
+		OPT_SET_INT('t', NULL, &opt, N_("show object type"), 't'),
+		OPT_SET_INT('s', NULL, &opt, N_("show object size"), 's'),
 		OPT_SET_INT('e', NULL, &opt,
-			    "exit with zero when there's no error", 'e'),
-		OPT_SET_INT('p', NULL, &opt, "pretty-print object's content", 'p'),
+			    N_("exit with zero when there's no error"), 'e'),
+		OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p=
'),
 		OPT_SET_INT(0, "textconv", &opt,
-			    "for blob objects, run textconv on object's content", 'c'),
+			    N_("for blob objects, run textconv on object's content"), 'c'),
 		OPT_SET_INT(0, "batch", &batch,
-			    "show info and content of objects fed from the standard input",
+			    N_("show info and content of objects fed from the standard inpu=
t"),
 			    BATCH),
 		OPT_SET_INT(0, "batch-check", &batch,
-			    "show info about objects fed from the standard input",
+			    N_("show info about objects fed from the standard input"),
 			    BATCH_CHECK),
 		OPT_END()
 	};
--=20
1.7.10.2.549.g9354186

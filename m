From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/65] i18n: clean: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:25 +0700
Message-ID: <1338203657-26486-11-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:20:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYxzb-00079g-H1
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753840Ab2E1LUA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:20:00 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59749 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746Ab2E1LT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:19:58 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4033567dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=k8SltTFxjhUmhkengRt52aQyO8GOMQQE+4n5Lh+TlY4=;
        b=WNC75xWCbEEalTgQ6DGwgx5Bho3yU+axLBUC/qCANyJmJz8zp0phDp3xeDfk4t9YHX
         Iama6Sb4Hf1Alr4vkaem9VCDjmKRejdYf0lGm8Xce8xxTUKXySRFngJxiTvCb4rvCnyg
         SjezXsYukM+yrZntY7fyopvRqmVrN7gaZPen4O8jWbZ/j2aRW6VbCPGA/SkvSbHjWjHd
         X6kSB9IFuScE0996eL9U8l/1jcMTP1XU1lv3/sUkO03SIY7TadL15YSeD0W5QRAJ3+XP
         ZEYlH6jdG/ZTgpgY5Lr6B2cDmCH+htAh+bKSa+qTunOVHxaLTmHBf0HLFuKA6s6yYnez
         +42Q==
Received: by 10.68.237.71 with SMTP id va7mr26219145pbc.119.1338203998722;
        Mon, 28 May 2012 04:19:58 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id ph10sm2025378pbc.55.2012.05.28.04.19.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:19:57 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:15:53 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198649>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clean.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 0c7b3d0..69c1cda 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -16,7 +16,7 @@
 static int force =3D -1; /* unset */
=20
 static const char *const builtin_clean_usage[] =3D {
-	"git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <paths>.=
=2E.",
+	N_("git clean [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path=
s>..."),
 	NULL
 };
=20
@@ -48,16 +48,16 @@ int cmd_clean(int argc, const char **argv, const ch=
ar *prefix)
 	const char *qname;
 	char *seen =3D NULL;
 	struct option options[] =3D {
-		OPT__QUIET(&quiet, "do not print names of files removed"),
-		OPT__DRY_RUN(&show_only, "dry run"),
-		OPT__FORCE(&force, "force"),
+		OPT__QUIET(&quiet, N_("do not print names of files removed")),
+		OPT__DRY_RUN(&show_only, N_("dry run")),
+		OPT__FORCE(&force, N_("force")),
 		OPT_BOOLEAN('d', NULL, &remove_directories,
-				"remove whole directories"),
-		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, "pattern",
-		  "add <pattern> to ignore rules", PARSE_OPT_NONEG, exclude_cb },
-		OPT_BOOLEAN('x', NULL, &ignored, "remove ignored files, too"),
+				N_("remove whole directories")),
+		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, N_("pattern"),
+		  N_("add <pattern> to ignore rules"), PARSE_OPT_NONEG, exclude_cb }=
,
+		OPT_BOOLEAN('x', NULL, &ignored, N_("remove ignored files, too")),
 		OPT_BOOLEAN('X', NULL, &ignored_only,
-				"remove only ignored files"),
+				N_("remove only ignored files")),
 		OPT_END()
 	};
=20
--=20
1.7.10.2.549.g9354186

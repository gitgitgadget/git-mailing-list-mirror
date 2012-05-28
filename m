From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 30/65] i18n: init-db: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:42 +0700
Message-ID: <1338203657-26486-28-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:22:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy20-0001kp-Fn
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176Ab2E1LW1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:22:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43145 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab2E1LWY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:22:24 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4539054pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=R1kaTiBfeuK4XixehNlUoxiItb3Pd6YIt5z1mEioyBE=;
        b=f0TA7Kf9o7PnJlsd0pjOt+HuCOdPu5oPrqMjVwlaj0h1Sb/2OuFGMBFXm6IBGTxowD
         UHCrChxDuGnnDJQHXVaxcbykPyxuOwFQ6BJQeM++EMduGz3l8roc09Lrk8uPYXvsQxo6
         mTv7metuVEQjOvjtEM8D3/AQJrIQ3qidCkiLIppj/4nxT+bvHxERNXn0LKM/nbXyPfql
         SluVmujxgQAzl8OdcbNgFACkP2sWc+7TQ4NFzaBHgl6sgui/9LdQExTmQil7JKSGw+wk
         UTtTk5bnZ92gAQolahZgG45maQOnp3tGYGd4Q/jKsWX3pacj86XTeLTJppxmr7ywI9Tg
         QFmA==
Received: by 10.68.229.2 with SMTP id sm2mr26347207pbc.57.1338204143924;
        Mon, 28 May 2012 04:22:23 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id po10sm19006883pbb.21.2012.05.28.04.22.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:22:23 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:18:18 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198666>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/init-db.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0dacb8b..08854d5 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -463,7 +463,7 @@ static int shared_callback(const struct option *opt=
, const char *arg, int unset)
 }
=20
 static const char *const init_db_usage[] =3D {
-	"git init [-q | --quiet] [--bare] [--template=3D<template-directory>]=
 [--shared[=3D<permissions>]] [directory]",
+	N_("git init [-q | --quiet] [--bare] [--template=3D<template-director=
y>] [--shared[=3D<permissions>]] [directory]"),
 	NULL
 };
=20
@@ -481,17 +481,17 @@ int cmd_init_db(int argc, const char **argv, cons=
t char *prefix)
 	const char *template_dir =3D NULL;
 	unsigned int flags =3D 0;
 	const struct option init_db_options[] =3D {
-		OPT_STRING(0, "template", &template_dir, "template-directory",
-				"directory from which templates will be used"),
+		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
+				N_("directory from which templates will be used")),
 		OPT_SET_INT(0, "bare", &is_bare_repository_cfg,
-				"create a bare repository", 1),
+				N_("create a bare repository"), 1),
 		{ OPTION_CALLBACK, 0, "shared", &init_shared_repository,
-			"permissions",
-			"specify that the git repository is to be shared amongst several us=
ers",
+			N_("permissions"),
+			N_("specify that the git repository is to be shared amongst several=
 users"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG, shared_callback, 0},
-		OPT_BIT('q', "quiet", &flags, "be quiet", INIT_DB_QUIET),
-		OPT_STRING(0, "separate-git-dir", &real_git_dir, "gitdir",
-			   "separate git dir from working tree"),
+		OPT_BIT('q', "quiet", &flags, N_("be quiet"), INIT_DB_QUIET),
+		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
+			   N_("separate git dir from working tree")),
 		OPT_END()
 	};
=20
--=20
1.7.10.2.549.g9354186

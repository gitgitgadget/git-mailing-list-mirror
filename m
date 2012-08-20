From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 29/66] i18n: init-db: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:18 +0700
Message-ID: <1345465975-16927-30-git-send-email-pclouds@gmail.com>
References: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 14:42:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RJR-0007JR-Rg
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234Ab2HTMm2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:42:28 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37322 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755219Ab2HTMm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:42:26 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2155685dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5uBp1c7xXPV7n6Bcc18X4LniY16S1PiiHUNJi642pUs=;
        b=rcVXZrYDD3u9bP5hcYdk2ItQuzztT6nC+9CQf9Kuk0TS/AzGRAV63okten1MGGUWO9
         wtW2/5UxHIfMIp53usHFnWM3bkXw9K9NxU2axqjd5Wy5SUNsKvbIIUgmboN9AvtiJzG7
         N7lw7JMm/8oMcA8RtCZDNAVSNlS8xONKK3ey8llTlZ98tb+BHycD1mIc0+nLWnGGe9Hv
         iPSboGDO1gxyf/Rn6SP26sqTKnWUCTBkBAGvfnIxtqzPyCoPy5HDcek3qRf+NqDD8b1J
         iBkYZqpHmQ5pibaaRSs+pIdy4Fv9Oi/bUNidS3u7zYEA/XcG0ACHexPs8OUo1ueJOge0
         ilwA==
Received: by 10.66.84.130 with SMTP id z2mr29361281pay.77.1345466546215;
        Mon, 20 Aug 2012 05:42:26 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id uy3sm10402000pbc.29.2012.08.20.05.42.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:42:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:36:26 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203801>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/init-db.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 244fb7f..78aa387 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -464,7 +464,7 @@ static int shared_callback(const struct option *opt=
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
@@ -482,17 +482,17 @@ int cmd_init_db(int argc, const char **argv, cons=
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
1.7.12.rc2.18.g61b472e

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/65] i18n: checkout-index: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:22 +0700
Message-ID: <1338203657-26486-8-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:19:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYxzB-0006eq-IW
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab2E1LTf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:19:35 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48872 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab2E1LTe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:19:34 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4538023pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=6e9tCAu4/fS/xEcnH0O9AUxPnsHCYqjRBDvZ1aDnmjw=;
        b=g/06wzUymmrw97iVJ3FfylnYIxD1pygn+8QsHER8D/nfe3ASwn0n7o/mkZAojVs46F
         uQmzx+I6ZeJH5/5h9ELO/b0LNoO8HK7FUJ37wDkg4v655HgIZDG6gMzO0FTaJ5ENdgX6
         a1CVL6vjNFDcFUMAr1ek4qA3aM4odIJQN+1LUmwnJDrD6kAvpp9In+LNQZuWF68DApkk
         nryHayInxoea9lV0kSzqyi8Pk6IBHWRVwPdBl9cXTao7kyBPuQU6T+QfXw0rj8xvH804
         PdkWuLNSYLwrRRvEdjGkuIcx+Pg8/33wX0dFhtwUDf4hWk0Dvc+yqHfxEDhBXJEsDsAi
         yFFw==
Received: by 10.68.212.197 with SMTP id nm5mr25717091pbc.110.1338203974657;
        Mon, 28 May 2012 04:19:34 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id i1sm18982870pbv.49.2012.05.28.04.19.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:19:33 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:15:29 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198646>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout-index.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index c16d82b..86b7d36 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -123,7 +123,7 @@ static void checkout_all(const char *prefix, int pr=
efix_length)
 }
=20
 static const char * const builtin_checkout_index_usage[] =3D {
-	"git checkout-index [options] [--] [<file>...]",
+	N_("git checkout-index [options] [--] [<file>...]"),
 	NULL
 };
=20
@@ -184,27 +184,27 @@ int cmd_checkout_index(int argc, const char **arg=
v, const char *prefix)
 	int force =3D 0, quiet =3D 0, not_new =3D 0;
 	struct option builtin_checkout_index_options[] =3D {
 		OPT_BOOLEAN('a', "all", &all,
-			"checks out all files in the index"),
-		OPT__FORCE(&force, "forces overwrite of existing files"),
+			N_("checks out all files in the index")),
+		OPT__FORCE(&force, N_("forces overwrite of existing files")),
 		OPT__QUIET(&quiet,
-			"no warning for existing files and files not in index"),
+			N_("no warning for existing files and files not in index")),
 		OPT_BOOLEAN('n', "no-create", &not_new,
-			"don't checkout new files"),
+			N_("don't checkout new files")),
 		{ OPTION_CALLBACK, 'u', "index", &newfd, NULL,
-			"update stat information in the index file",
+			N_("update stat information in the index file"),
 			PARSE_OPT_NOARG, option_parse_u },
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
-			"paths are separated with NUL character",
+			N_("paths are separated with NUL character"),
 			PARSE_OPT_NOARG, option_parse_z },
 		OPT_BOOLEAN(0, "stdin", &read_from_stdin,
-			"read list of paths from the standard input"),
+			N_("read list of paths from the standard input")),
 		OPT_BOOLEAN(0, "temp", &to_tempfile,
-			"write the content to temporary files"),
-		OPT_CALLBACK(0, "prefix", NULL, "string",
-			"when creating files, prepend <string>",
+			N_("write the content to temporary files")),
+		OPT_CALLBACK(0, "prefix", NULL, N_("string"),
+			N_("when creating files, prepend <string>"),
 			option_parse_prefix),
 		OPT_CALLBACK(0, "stage", NULL, NULL,
-			"copy out the files from named stage",
+			N_("copy out the files from named stage"),
 			option_parse_stage),
 		OPT_END()
 	};
--=20
1.7.10.2.549.g9354186

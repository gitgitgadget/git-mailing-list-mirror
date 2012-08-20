From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/66] i18n: checkout-index: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:31:58 +0700
Message-ID: <1345465975-16927-10-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:39:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RGw-0005aB-Lr
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677Ab2HTMjz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:39:55 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab2HTMjx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:39:53 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=eKr/z1EN/G3AstLtBZ2E2fG5Wa6o4ijotf+QAtrQpo4=;
        b=ZAkuhC9Buw+sUpheKU9skcVKcIh7j8VAX3k3d+dDHtProO2mm/kuxDEQjQeijRef8v
         ObQMdATwDAxgqAnjCzCI4EL/gk12UShJ9Jk/C1sxP/BtRVdxmGrXcp6+0tqWqADI2TUJ
         6rp5e/p2yuhdGLkf7wdbskbb7Do6GJf+7/EVhzPqhrkbc1WN9QbJHu4IcTAJMYsGuSF7
         1NThllup+q3dhMv/k74fesI0jarcBA8uztxkPhCPHLNQ+m9ha9RZyPzSBcV79WhD0pY9
         KU38G7ac+wGSb8rklRw/xFVYnCXRWM0zTjihVQDlJ1VQyPhsfoLRztuPcgbLYVHn6nod
         DVNw==
Received: by 10.68.229.228 with SMTP id st4mr26593361pbc.106.1345466393607;
        Mon, 20 Aug 2012 05:39:53 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id tv6sm11040850pbc.24.2012.08.20.05.39.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:39:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:33:53 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203781>

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
1.7.12.rc2.18.g61b472e

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/66] i18n: blame: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:31:54 +0700
Message-ID: <1345465975-16927-6-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RGb-0005NG-31
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224Ab2HTMjb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:39:31 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab2HTMj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:39:29 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NYZQWXbp87aZ7o11oe41ZcTep6ZX6Am9tkzZs8edjtM=;
        b=whigoyw3IB5Sk9dxB0eC7oitxdxMdpQyvhUA3Z6s5MPk0j/gnjbiqQf87eS2tWjG+3
         Xdx6CZQKZwf5+djNkqa8Qz4Lb3XaJXMZeXaljTF6F8sAYpSVUoUKlHhsFRUhFfBcgEOD
         M4fPXP3Qjxrbdb1AvpSuDjych9uitsgYAyHUyb2r6PLTq3XmJQt3wEex6ip9zkU4u11H
         m658UtM7YSS7+69eh+XetvVEVkBXFGCW81Ikgf72K3A43ebET692FvCAAcOTCtQGbreB
         C5YCoUJEaPWzFy8d3nSAMWJyEARSxwnw11Ywnh3PeGmfruw/8n3tPDaYL+utGgyVPpFj
         cHQQ==
Received: by 10.66.83.234 with SMTP id t10mr29445079pay.39.1345466368993;
        Mon, 20 Aug 2012 05:39:28 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id jz4sm11044073pbc.17.2012.08.20.05.39.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:39:28 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:33:28 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203777>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/blame.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 0d50273..c0c99c3 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -22,12 +22,12 @@
 #include "utf8.h"
 #include "userdiff.h"
=20
-static char blame_usage[] =3D "git blame [options] [rev-opts] [rev] [-=
-] file";
+static char blame_usage[] =3D N_("git blame [options] [rev-opts] [rev]=
 [--] file");
=20
 static const char *blame_opt_usage[] =3D {
 	blame_usage,
 	"",
-	"[rev-opts] are documented in git-rev-list(1)",
+	N_("[rev-opts] are documented in git-rev-list(1)"),
 	NULL
 };
=20
@@ -2315,27 +2315,27 @@ int cmd_blame(int argc, const char **argv, cons=
t char *prefix)
 	static const char *revs_file =3D NULL;
 	static const char *contents_from =3D NULL;
 	static const struct option options[] =3D {
-		OPT_BOOLEAN(0, "incremental", &incremental, "Show blame entries as w=
e find them, incrementally"),
-		OPT_BOOLEAN('b', NULL, &blank_boundary, "Show blank SHA-1 for bounda=
ry commits (Default: off)"),
-		OPT_BOOLEAN(0, "root", &show_root, "Do not treat root commits as bou=
ndaries (Default: off)"),
-		OPT_BOOLEAN(0, "show-stats", &show_stats, "Show work cost statistics=
"),
-		OPT_BIT(0, "score-debug", &output_option, "Show output score for bla=
me entries", OUTPUT_SHOW_SCORE),
-		OPT_BIT('f', "show-name", &output_option, "Show original filename (D=
efault: auto)", OUTPUT_SHOW_NAME),
-		OPT_BIT('n', "show-number", &output_option, "Show original linenumbe=
r (Default: off)", OUTPUT_SHOW_NUMBER),
-		OPT_BIT('p', "porcelain", &output_option, "Show in a format designed=
 for machine consumption", OUTPUT_PORCELAIN),
-		OPT_BIT(0, "line-porcelain", &output_option, "Show porcelain format =
with per-line commit information", OUTPUT_PORCELAIN|OUTPUT_LINE_PORCELA=
IN),
-		OPT_BIT('c', NULL, &output_option, "Use the same output mode as git-=
annotate (Default: off)", OUTPUT_ANNOTATE_COMPAT),
-		OPT_BIT('t', NULL, &output_option, "Show raw timestamp (Default: off=
)", OUTPUT_RAW_TIMESTAMP),
-		OPT_BIT('l', NULL, &output_option, "Show long commit SHA1 (Default: =
off)", OUTPUT_LONG_OBJECT_NAME),
-		OPT_BIT('s', NULL, &output_option, "Suppress author name and timesta=
mp (Default: off)", OUTPUT_NO_AUTHOR),
-		OPT_BIT('e', "show-email", &output_option, "Show author email instea=
d of name (Default: off)", OUTPUT_SHOW_EMAIL),
-		OPT_BIT('w', NULL, &xdl_opts, "Ignore whitespace differences", XDF_I=
GNORE_WHITESPACE),
-		OPT_BIT(0, "minimal", &xdl_opts, "Spend extra cycles to find better =
match", XDF_NEED_MINIMAL),
-		OPT_STRING('S', NULL, &revs_file, "file", "Use revisions from <file>=
 instead of calling git-rev-list"),
-		OPT_STRING(0, "contents", &contents_from, "file", "Use <file>'s cont=
ents as the final image"),
-		{ OPTION_CALLBACK, 'C', NULL, &opt, "score", "Find line copies withi=
n and across files", PARSE_OPT_OPTARG, blame_copy_callback },
-		{ OPTION_CALLBACK, 'M', NULL, &opt, "score", "Find line movements wi=
thin and across files", PARSE_OPT_OPTARG, blame_move_callback },
-		OPT_CALLBACK('L', NULL, &bottomtop, "n,m", "Process only line range =
n,m, counting from 1", blame_bottomtop_callback),
+		OPT_BOOLEAN(0, "incremental", &incremental, N_("Show blame entries a=
s we find them, incrementally")),
+		OPT_BOOLEAN('b', NULL, &blank_boundary, N_("Show blank SHA-1 for bou=
ndary commits (Default: off)")),
+		OPT_BOOLEAN(0, "root", &show_root, N_("Do not treat root commits as =
boundaries (Default: off)")),
+		OPT_BOOLEAN(0, "show-stats", &show_stats, N_("Show work cost statist=
ics")),
+		OPT_BIT(0, "score-debug", &output_option, N_("Show output score for =
blame entries"), OUTPUT_SHOW_SCORE),
+		OPT_BIT('f', "show-name", &output_option, N_("Show original filename=
 (Default: auto)"), OUTPUT_SHOW_NAME),
+		OPT_BIT('n', "show-number", &output_option, N_("Show original linenu=
mber (Default: off)"), OUTPUT_SHOW_NUMBER),
+		OPT_BIT('p', "porcelain", &output_option, N_("Show in a format desig=
ned for machine consumption"), OUTPUT_PORCELAIN),
+		OPT_BIT(0, "line-porcelain", &output_option, N_("Show porcelain form=
at with per-line commit information"), OUTPUT_PORCELAIN|OUTPUT_LINE_POR=
CELAIN),
+		OPT_BIT('c', NULL, &output_option, N_("Use the same output mode as g=
it-annotate (Default: off)"), OUTPUT_ANNOTATE_COMPAT),
+		OPT_BIT('t', NULL, &output_option, N_("Show raw timestamp (Default: =
off)"), OUTPUT_RAW_TIMESTAMP),
+		OPT_BIT('l', NULL, &output_option, N_("Show long commit SHA1 (Defaul=
t: off)"), OUTPUT_LONG_OBJECT_NAME),
+		OPT_BIT('s', NULL, &output_option, N_("Suppress author name and time=
stamp (Default: off)"), OUTPUT_NO_AUTHOR),
+		OPT_BIT('e', "show-email", &output_option, N_("Show author email ins=
tead of name (Default: off)"), OUTPUT_SHOW_EMAIL),
+		OPT_BIT('w', NULL, &xdl_opts, N_("Ignore whitespace differences"), X=
DF_IGNORE_WHITESPACE),
+		OPT_BIT(0, "minimal", &xdl_opts, N_("Spend extra cycles to find bett=
er match"), XDF_NEED_MINIMAL),
+		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("Use revisions from=
 <file> instead of calling git-rev-list")),
+		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("Use <file>=
's contents as the final image")),
+		{ OPTION_CALLBACK, 'C', NULL, &opt, N_("score"), N_("Find line copie=
s within and across files"), PARSE_OPT_OPTARG, blame_copy_callback },
+		{ OPTION_CALLBACK, 'M', NULL, &opt, N_("score"), N_("Find line movem=
ents within and across files"), PARSE_OPT_OPTARG, blame_move_callback }=
,
+		OPT_CALLBACK('L', NULL, &bottomtop, N_("n,m"), N_("Process only line=
 range n,m, counting from 1"), blame_bottomtop_callback),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
--=20
1.7.12.rc2.18.g61b472e

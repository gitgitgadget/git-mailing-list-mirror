From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/65] i18n: apply: mark parseopt strings for translation
Date: Sun,  6 May 2012 21:23:52 +0700
Message-ID: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
References: <1336314232-21002-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 16:27:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR2RH-00069v-Ib
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 16:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753665Ab2EFO1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 10:27:51 -0400
Received: from mail-pz0-f51.google.com ([209.85.210.51]:53899 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab2EFO1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 10:27:50 -0400
Received: by mail-pz0-f51.google.com with SMTP id t11so245393daj.10
        for <git@vger.kernel.org>; Sun, 06 May 2012 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Zk4zMfXp36+upNuObtAl73aNALUVYOSkLXlTyX6Ih+Q=;
        b=rq1ok4h2Wdz/4E5/DesrhZGP3/LrxyyP8pROmvUBj5oejM1381fCr4h+VpaP5eqaLd
         1/JisGIy5/ZS/3wWPUhc2BRLMUn+A8RG1Ic5qQ2KONvLlEe9sKvNKzEJaYZIsBl3xcg6
         Rr1uJAkJFPtJ6qAwTQf6D3dRfOUfUoLr8vAsQYzWkB4TfXSSdDj7GGcl7TPJWiY3vy1e
         2xdUYA0pzAJCVhXcJvL7znjkA1IPzF2tcbHqXdw7p6U4ohOjtA3tI2fICy10dW3GQF5m
         ngESlaPzx5oauPjmEkWC6Amd0eKvifwsash2mkL9FkO7PyKbOHlln9ik8eeCCBfrLav5
         VByA==
Received: by 10.68.226.5 with SMTP id ro5mr37603935pbc.74.1336314470581;
        Sun, 06 May 2012 07:27:50 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.32.70])
        by mx.google.com with ESMTPS id ms7sm7681008pbb.19.2012.05.06.07.27.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 07:27:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 06 May 2012 21:24:14 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1336314232-21002-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197193>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/apply.c |   62 +++++++++++++++++++++++++++--------------------=
-------
 1 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 725712d..5621a66 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -50,7 +50,7 @@ static const char *fake_ancestor;
 static int line_termination =3D '\n';
 static unsigned int p_context =3D UINT_MAX;
 static const char * const apply_usage[] =3D {
-	"git apply [options] [<patch>...]",
+	N_("git apply [options] [<patch>...]"),
 	NULL
 };
=20
@@ -3952,66 +3952,66 @@ int cmd_apply(int argc, const char **argv, cons=
t char *prefix_)
 	const char *whitespace_option =3D NULL;
=20
 	struct option builtin_apply_options[] =3D {
-		{ OPTION_CALLBACK, 0, "exclude", NULL, "path",
-			"don't apply changes matching the given path",
+		{ OPTION_CALLBACK, 0, "exclude", NULL, N_("path"),
+			N_("don't apply changes matching the given path"),
 			0, option_parse_exclude },
-		{ OPTION_CALLBACK, 0, "include", NULL, "path",
-			"apply changes matching the given path",
+		{ OPTION_CALLBACK, 0, "include", NULL, N_("path"),
+			N_("apply changes matching the given path"),
 			0, option_parse_include },
-		{ OPTION_CALLBACK, 'p', NULL, NULL, "num",
-			"remove <num> leading slashes from traditional diff paths",
+		{ OPTION_CALLBACK, 'p', NULL, NULL, N_("num"),
+			N_("remove <num> leading slashes from traditional diff paths"),
 			0, option_parse_p },
 		OPT_BOOLEAN(0, "no-add", &no_add,
-			"ignore additions made by the patch"),
+			N_("ignore additions made by the patch")),
 		OPT_BOOLEAN(0, "stat", &diffstat,
-			"instead of applying the patch, output diffstat for the input"),
+			N_("instead of applying the patch, output diffstat for the input"))=
,
 		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
 		OPT_NOOP_NOARG(0, "binary"),
 		OPT_BOOLEAN(0, "numstat", &numstat,
-			"shows number of added and deleted lines in decimal notation"),
+			N_("shows number of added and deleted lines in decimal notation")),
 		OPT_BOOLEAN(0, "summary", &summary,
-			"instead of applying the patch, output a summary for the input"),
+			N_("instead of applying the patch, output a summary for the input")=
),
 		OPT_BOOLEAN(0, "check", &check,
-			"instead of applying the patch, see if the patch is applicable"),
+			N_("instead of applying the patch, see if the patch is applicable")=
),
 		OPT_BOOLEAN(0, "index", &check_index,
-			"make sure the patch is applicable to the current index"),
+			N_("make sure the patch is applicable to the current index")),
 		OPT_BOOLEAN(0, "cached", &cached,
-			"apply a patch without touching the working tree"),
+			N_("apply a patch without touching the working tree")),
 		OPT_BOOLEAN(0, "apply", &force_apply,
-			"also apply the patch (use with --stat/--summary/--check)"),
+			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
-			"build a temporary index based on embedded index information"),
+			N_("build a temporary index based on embedded index information")),
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
-			"paths are separated with NUL character",
+			N_("paths are separated with NUL character"),
 			PARSE_OPT_NOARG, option_parse_z },
 		OPT_INTEGER('C', NULL, &p_context,
-				"ensure at least <n> lines of context match"),
-		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, "action",
-			"detect new or modified lines that have whitespace errors",
+				N_("ensure at least <n> lines of context match")),
+		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, N_("action")=
,
+			N_("detect new or modified lines that have whitespace errors"),
 			0, option_parse_whitespace },
 		{ OPTION_CALLBACK, 0, "ignore-space-change", NULL, NULL,
-			"ignore changes in whitespace when finding context",
+			N_("ignore changes in whitespace when finding context"),
 			PARSE_OPT_NOARG, option_parse_space_change },
 		{ OPTION_CALLBACK, 0, "ignore-whitespace", NULL, NULL,
-			"ignore changes in whitespace when finding context",
+			N_("ignore changes in whitespace when finding context"),
 			PARSE_OPT_NOARG, option_parse_space_change },
 		OPT_BOOLEAN('R', "reverse", &apply_in_reverse,
-			"apply the patch in reverse"),
+			N_("apply the patch in reverse")),
 		OPT_BOOLEAN(0, "unidiff-zero", &unidiff_zero,
-			"don't expect at least one line of context"),
+			N_("don't expect at least one line of context")),
 		OPT_BOOLEAN(0, "reject", &apply_with_reject,
-			"leave the rejected hunks in corresponding *.rej files"),
+			N_("leave the rejected hunks in corresponding *.rej files")),
 		OPT_BOOLEAN(0, "allow-overlap", &allow_overlap,
-			"allow overlapping hunks"),
-		OPT__VERBOSE(&apply_verbosely, "be verbose"),
+			N_("allow overlapping hunks")),
+		OPT__VERBOSE(&apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
-			"tolerate incorrectly detected missing new-line at the end of file"=
,
+			N_("tolerate incorrectly detected missing new-line at the end of fi=
le"),
 			INACCURATE_EOF),
 		OPT_BIT(0, "recount", &options,
-			"do not trust the line counts in the hunk headers",
+			N_("do not trust the line counts in the hunk headers"),
 			RECOUNT),
-		{ OPTION_CALLBACK, 0, "directory", NULL, "root",
-			"prepend <root> to all filenames",
+		{ OPTION_CALLBACK, 0, "directory", NULL, N_("root"),
+			N_("prepend <root> to all filenames"),
 			0, option_parse_directory },
 		OPT_END()
 	};
--=20
1.7.8.36.g69ee2

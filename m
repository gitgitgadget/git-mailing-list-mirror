From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 32/65] i18n: ls-files: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:44 +0700
Message-ID: <1338203657-26486-30-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:22:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy2C-00026F-Vx
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187Ab2E1LWp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:22:45 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43145 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab2E1LWo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:22:44 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4539054pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ImMBDaAY6pzBEt2BDNervPxSWRLe7+PPI3MX7Z+c75w=;
        b=C66eWYKfjVBbhbp3RgIfhAuZ2opFUN/fEZJE9wCUct68/IxnnhMMnUWH4RVz/K2fo2
         3KHBuy91f4K5+lQZXGcIrJNkoaIzwSapaXKbdrbNHgiM47wrowWBmjIAy2GpBNajBoF4
         8R2VuoA6zOU3ZSWJUIPFSRJFxOpzsOxk3nk+N6Wmm+SPH/KN1B3LFcGvaeKuqBU9gn5W
         +4tbx0eeWNDi/gRqnb749/8zNkU0EIPCcp9UbMm2GmFx5qXr3SWYAIWz4Xf/Dx4s12yu
         gOunHFRF47B1udzMeUTsiI14YIxaHePVoTYmhbA7H3GZ2a8VtEi2S8lSlMr16mIJfk9h
         OsPA==
Received: by 10.68.130.67 with SMTP id oc3mr26497630pbb.18.1338204164268;
        Mon, 28 May 2012 04:22:44 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id kd6sm19006692pbc.24.2012.05.28.04.22.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:22:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:18:38 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198668>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 54 +++++++++++++++++++++++++++-------------------=
--------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7cff175..23ba31c 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -394,7 +394,7 @@ int report_path_error(const char *ps_matched, const=
 char **pathspec, const char
 }
=20
 static const char * const ls_files_usage[] =3D {
-	"git ls-files [options] [<file>...]",
+	N_("git ls-files [options] [<file>...]"),
 	NULL
 };
=20
@@ -446,57 +446,57 @@ int cmd_ls_files(int argc, const char **argv, con=
st char *cmd_prefix)
 	struct dir_struct dir;
 	struct option builtin_ls_files_options[] =3D {
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
-			"paths are separated with NUL character",
+			N_("paths are separated with NUL character"),
 			PARSE_OPT_NOARG, option_parse_z },
 		OPT_BOOLEAN('t', NULL, &show_tag,
-			"identify the file status with tags"),
+			N_("identify the file status with tags")),
 		OPT_BOOLEAN('v', NULL, &show_valid_bit,
-			"use lowercase letters for 'assume unchanged' files"),
+			N_("use lowercase letters for 'assume unchanged' files")),
 		OPT_BOOLEAN('c', "cached", &show_cached,
-			"show cached files in the output (default)"),
+			N_("show cached files in the output (default)")),
 		OPT_BOOLEAN('d', "deleted", &show_deleted,
-			"show deleted files in the output"),
+			N_("show deleted files in the output")),
 		OPT_BOOLEAN('m', "modified", &show_modified,
-			"show modified files in the output"),
+			N_("show modified files in the output")),
 		OPT_BOOLEAN('o', "others", &show_others,
-			"show other files in the output"),
+			N_("show other files in the output")),
 		OPT_BIT('i', "ignored", &dir.flags,
-			"show ignored files in the output",
+			N_("show ignored files in the output"),
 			DIR_SHOW_IGNORED),
 		OPT_BOOLEAN('s', "stage", &show_stage,
-			"show staged contents' object name in the output"),
+			N_("show staged contents' object name in the output")),
 		OPT_BOOLEAN('k', "killed", &show_killed,
-			"show files on the filesystem that need to be removed"),
+			N_("show files on the filesystem that need to be removed")),
 		OPT_BIT(0, "directory", &dir.flags,
-			"show 'other' directories' name only",
+			N_("show 'other' directories' name only"),
 			DIR_SHOW_OTHER_DIRECTORIES),
 		OPT_NEGBIT(0, "empty-directory", &dir.flags,
-			"don't show empty directories",
+			N_("don't show empty directories"),
 			DIR_HIDE_EMPTY_DIRECTORIES),
 		OPT_BOOLEAN('u', "unmerged", &show_unmerged,
-			"show unmerged files in the output"),
+			N_("show unmerged files in the output")),
 		OPT_BOOLEAN(0, "resolve-undo", &show_resolve_undo,
-			    "show resolve-undo information"),
-		{ OPTION_CALLBACK, 'x', "exclude", &dir.exclude_list[EXC_CMDL], "pat=
tern",
-			"skip files matching pattern",
+			    N_("show resolve-undo information")),
+		{ OPTION_CALLBACK, 'x', "exclude", &dir.exclude_list[EXC_CMDL], N_("=
pattern"),
+			N_("skip files matching pattern"),
 			0, option_parse_exclude },
-		{ OPTION_CALLBACK, 'X', "exclude-from", &dir, "file",
-			"exclude patterns are read from <file>",
+		{ OPTION_CALLBACK, 'X', "exclude-from", &dir, N_("file"),
+			N_("exclude patterns are read from <file>"),
 			0, option_parse_exclude_from },
-		OPT_STRING(0, "exclude-per-directory", &dir.exclude_per_dir, "file",
-			"read additional per-directory exclude patterns in <file>"),
+		OPT_STRING(0, "exclude-per-directory", &dir.exclude_per_dir, N_("fil=
e"),
+			N_("read additional per-directory exclude patterns in <file>")),
 		{ OPTION_CALLBACK, 0, "exclude-standard", &dir, NULL,
-			"add the standard git exclusions",
+			N_("add the standard git exclusions"),
 			PARSE_OPT_NOARG, option_parse_exclude_standard },
 		{ OPTION_SET_INT, 0, "full-name", &prefix_len, NULL,
-			"make the output relative to the project top directory",
+			N_("make the output relative to the project top directory"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL },
 		OPT_BOOLEAN(0, "error-unmatch", &error_unmatch,
-			"if any <file> is not in the index, treat this as an error"),
-		OPT_STRING(0, "with-tree", &with_tree, "tree-ish",
-			"pretend that paths removed since <tree-ish> are still present"),
+			N_("if any <file> is not in the index, treat this as an error")),
+		OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish"),
+			N_("pretend that paths removed since <tree-ish> are still present")=
),
 		OPT__ABBREV(&abbrev),
-		OPT_BOOLEAN(0, "debug", &debug_mode, "show debugging data"),
+		OPT_BOOLEAN(0, "debug", &debug_mode, N_("show debugging data")),
 		OPT_END()
 	};
=20
--=20
1.7.10.2.549.g9354186

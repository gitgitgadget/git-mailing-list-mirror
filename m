From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 31/66] i18n: ls-files: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:20 +0700
Message-ID: <1345465975-16927-32-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:42:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RJg-0007Ts-Bd
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298Ab2HTMmn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:42:43 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37322 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231Ab2HTMml (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:42:41 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2155685dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ZfhOCnyEACDB6fEMaibfOGy4W3W9tMB2pjy0lO+RbjM=;
        b=nokwJDA/0/8Uze5szCwlsgoH/1jXuK3HZEZmT7xynwAQaliMBoDA7VyJj6abcVCeC+
         FDI3MPc/jznMYnZyVjZ05H9KC7n/magiOca/zu1GhxC033OmwgflC/4iKIdzxHp8uR8g
         DJehjWy3CX4ukiWbcspVZn/CqpzIhGptxrggeLZR0EfxozA3X3FF/iTPsXb4gkfWsbnt
         C+7WJmHisXovwxeZhcuyT0w3+HAkfA7A3HsbkOTz2d5av3QOEkcWf5OVa+ZZs90QtzI/
         h5cM1oDQ9sH3ccQa53+efoTAcWLdZibatLOJs0KgS3OQ+SGKj04uLDvEuykAKi8ve4GY
         mePA==
Received: by 10.68.222.40 with SMTP id qj8mr33955673pbc.139.1345466558320;
        Mon, 20 Aug 2012 05:42:38 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id nv6sm11039725pbc.42.2012.08.20.05.42.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:42:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:36:38 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203803>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-files.c | 54 +++++++++++++++++++++++++++-------------------=
--------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 31b3f2d..b5434af 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -405,7 +405,7 @@ int report_path_error(const char *ps_matched, const=
 char **pathspec, const char
 }
=20
 static const char * const ls_files_usage[] =3D {
-	"git ls-files [options] [<file>...]",
+	N_("git ls-files [options] [<file>...]"),
 	NULL
 };
=20
@@ -457,57 +457,57 @@ int cmd_ls_files(int argc, const char **argv, con=
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
1.7.12.rc2.18.g61b472e

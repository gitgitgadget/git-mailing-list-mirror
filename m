From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 60/65] i18n: update-index: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:12 +0700
Message-ID: <1338203657-26486-58-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:27:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy6M-0007Pp-1R
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493Ab2E1L1B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:27:01 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36112 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab2E1L1A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:27:00 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4038533dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=W4Zqere9PaSUq0Sst0RVF9GP3bWfghfDQhjg3Rd3luk=;
        b=qHEmA6rGftLFKGl4em5ew/4KlMpyxpzuzoxXrXemgMZ14sO+r/iAN4M+PLbl+/8OqZ
         R4x3NxxFLdQFh5ZKCcquTrfWN1V22rHjAyBndqjhfkdnfoSazjy1MywD6qPrSc13I2IR
         pG60btB87Dd6z/11Rp1MyJOnJw1wTTvhNckZTuvCr5S5YX9W8OVcYfTTKRL03CouPQKs
         tg8pbGOkbkqxM4zpltjgr5d0L4hTqHEXyG+yXWBvHUYfSQ9afO16uRoURzatyBOWGM/z
         gIwUNOl7blNSOT8N/9ZB8kCEMypICFwahCTf47E5YctpFFVxEp7bIp8OWCVeTGRLPCV6
         cjRg==
Received: by 10.68.219.199 with SMTP id pq7mr26628108pbc.93.1338204419824;
        Mon, 28 May 2012 04:26:59 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id gj8sm15490091pbc.39.2012.05.28.04.26.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:26:59 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:22:54 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198696>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-index.c | 54 +++++++++++++++++++++++++-----------------=
--------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 5f038d6..d611b98 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -402,7 +402,7 @@ static void read_index_info(int line_termination)
 }
=20
 static const char * const update_index_usage[] =3D {
-	"git update-index [options] [--] [<file>...]",
+	N_("git update-index [options] [--] [<file>...]"),
 	NULL
 };
=20
@@ -717,79 +717,79 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
 	int parseopt_state =3D PARSE_OPT_UNKNOWN;
 	struct option options[] =3D {
 		OPT_BIT('q', NULL, &refresh_args.flags,
-			"continue refresh even when index needs update",
+			N_("continue refresh even when index needs update"),
 			REFRESH_QUIET),
 		OPT_BIT(0, "ignore-submodules", &refresh_args.flags,
-			"refresh: ignore submodules",
+			N_("refresh: ignore submodules"),
 			REFRESH_IGNORE_SUBMODULES),
 		OPT_SET_INT(0, "add", &allow_add,
-			"do not ignore new files", 1),
+			N_("do not ignore new files"), 1),
 		OPT_SET_INT(0, "replace", &allow_replace,
-			"let files replace directories and vice-versa", 1),
+			N_("let files replace directories and vice-versa"), 1),
 		OPT_SET_INT(0, "remove", &allow_remove,
-			"notice files missing from worktree", 1),
+			N_("notice files missing from worktree"), 1),
 		OPT_BIT(0, "unmerged", &refresh_args.flags,
-			"refresh even if index contains unmerged entries",
+			N_("refresh even if index contains unmerged entries"),
 			REFRESH_UNMERGED),
 		{OPTION_CALLBACK, 0, "refresh", &refresh_args, NULL,
-			"refresh stat information",
+			N_("refresh stat information"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			refresh_callback},
 		{OPTION_CALLBACK, 0, "really-refresh", &refresh_args, NULL,
-			"like --refresh, but ignore assume-unchanged setting",
+			N_("like --refresh, but ignore assume-unchanged setting"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			really_refresh_callback},
 		{OPTION_LOWLEVEL_CALLBACK, 0, "cacheinfo", NULL,
-			"<mode> <object> <path>",
-			"add the specified entry to the index",
+			N_("<mode> <object> <path>"),
+			N_("add the specified entry to the index"),
 			PARSE_OPT_NOARG |	/* disallow --cacheinfo=3D<mode> form */
 			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 			(parse_opt_cb *) cacheinfo_callback},
-		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, "(+/-)x",
-			"override the executable bit of the listed files",
+		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, N_("(+/-)x"),
+			N_("override the executable bit of the listed files"),
 			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 			chmod_callback},
 		{OPTION_SET_INT, 0, "assume-unchanged", &mark_valid_only, NULL,
-			"mark files as \"not changing\"",
+			N_("mark files as \"not changing\""),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
 		{OPTION_SET_INT, 0, "no-assume-unchanged", &mark_valid_only, NULL,
-			"clear assumed-unchanged bit",
+			N_("clear assumed-unchanged bit"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
 		{OPTION_SET_INT, 0, "skip-worktree", &mark_skip_worktree_only, NULL,
-			"mark files as \"index-only\"",
+			N_("mark files as \"index-only\""),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
 		{OPTION_SET_INT, 0, "no-skip-worktree", &mark_skip_worktree_only, NU=
LL,
-			"clear skip-worktree bit",
+			N_("clear skip-worktree bit"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, UNMARK_FLAG},
 		OPT_SET_INT(0, "info-only", &info_only,
-			"add to index only; do not add content to object database", 1),
+			N_("add to index only; do not add content to object database"), 1),
 		OPT_SET_INT(0, "force-remove", &force_remove,
-			"remove named paths even if present in worktree", 1),
+			N_("remove named paths even if present in worktree"), 1),
 		OPT_SET_INT('z', NULL, &line_termination,
-			"with --stdin: input lines are terminated by null bytes", '\0'),
+			N_("with --stdin: input lines are terminated by null bytes"), '\0')=
,
 		{OPTION_LOWLEVEL_CALLBACK, 0, "stdin", &read_from_stdin, NULL,
-			"read list of paths to be updated from standard input",
+			N_("read list of paths to be updated from standard input"),
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			(parse_opt_cb *) stdin_callback},
 		{OPTION_LOWLEVEL_CALLBACK, 0, "index-info", &line_termination, NULL,
-			"add entries from standard input to the index",
+			N_("add entries from standard input to the index"),
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			(parse_opt_cb *) stdin_cacheinfo_callback},
 		{OPTION_LOWLEVEL_CALLBACK, 0, "unresolve", &has_errors, NULL,
-			"repopulate stages #2 and #3 for the listed paths",
+			N_("repopulate stages #2 and #3 for the listed paths"),
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			(parse_opt_cb *) unresolve_callback},
 		{OPTION_LOWLEVEL_CALLBACK, 'g', "again", &has_errors, NULL,
-			"only update entries that differ from HEAD",
+			N_("only update entries that differ from HEAD"),
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			(parse_opt_cb *) reupdate_callback},
 		OPT_BIT(0, "ignore-missing", &refresh_args.flags,
-			"ignore files missing from worktree",
+			N_("ignore files missing from worktree"),
 			REFRESH_IGNORE_MISSING),
 		OPT_SET_INT(0, "verbose", &verbose,
-			"report actions to standard output", 1),
+			N_("report actions to standard output"), 1),
 		{OPTION_CALLBACK, 0, "clear-resolve-undo", NULL, NULL,
-			"(for porcelains) forget saved unresolved conflicts",
+			N_("(for porcelains) forget saved unresolved conflicts"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			resolve_undo_clear_callback},
 		OPT_INTEGER(0, "index-version", &preferred_index_format,
--=20
1.7.10.2.549.g9354186

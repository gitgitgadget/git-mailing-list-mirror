From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 59/66] i18n: update-index: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:48 +0700
Message-ID: <1345465975-16927-60-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:45:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RMV-0001AT-OK
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781Ab2HTMpi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:45:38 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab2HTMpf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:45:35 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=5BegtpxzisF5wHd/9KQeu/ahdagxAQaftQuR+sht6KE=;
        b=MKlIFGa7aEC419f6oCiFf+Z4WGlYDbJqXLSjTIxe/xHFrfcgjCF+O4wdb1z8hBXwOM
         LPDFFUpWWHhlxnK3mdIbI/lwVhDfhuSza6aXNFB2VFPexg3ra42qlAGOeORjnqwFexbe
         +8Wruw7aFboq17Go0uOcS2X3fGalH5yYvdA+wKsqC3kMdSxE78mMq8yPLItHNY9Fx+K+
         ejnidcjkA+pLCHXyVw2RY+HC6z8k0hTd3e82PaywAeC4bJfsb96CeuP8HfHMqSmmAwoJ
         piXVnWJU1KcYAweXTeoeMXs1XuGKvqtSqT90x1+TeK3eeegckKW1TdrRiojUSoISfNA8
         35cA==
Received: by 10.68.221.70 with SMTP id qc6mr34613429pbc.92.1345466735506;
        Mon, 20 Aug 2012 05:45:35 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id gt2sm11032490pbc.62.2012.08.20.05.45.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:45:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:39:35 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203831>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-index.c | 56 +++++++++++++++++++++++++-----------------=
--------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 4ce341c..74986bf 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -398,7 +398,7 @@ static void read_index_info(int line_termination)
 }
=20
 static const char * const update_index_usage[] =3D {
-	"git update-index [options] [--] [<file>...]",
+	N_("git update-index [options] [--] [<file>...]"),
 	NULL
 };
=20
@@ -714,83 +714,83 @@ int cmd_update_index(int argc, const char **argv,=
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
-			    "write index in this format"),
+			N_("write index in this format")),
 		OPT_END()
 	};
=20
--=20
1.7.12.rc2.18.g61b472e

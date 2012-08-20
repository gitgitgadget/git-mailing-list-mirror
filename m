From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 46/66] i18n: remote: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:35 +0700
Message-ID: <1345465975-16927-47-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RLB-00005C-3p
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563Ab2HTMoS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:44:18 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54012 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555Ab2HTMoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:44:16 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2156474dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Zfc5FB4roVytAUKIqHyRVWD2mmi56AVj3dG7mbEwUYc=;
        b=jjvoFjyOZknGuaUdSElhE/PDaU4rJXDQWENklDYDnwT/gX/nh9tSlEEj3mWby7zLPF
         PvJ1OQfyeR8P27S/7Y13HDBvl+LEqASGH0qlwfCmJg3kUgcAS9HYiW6P1bsq3hHaFJLw
         o0yNH7pNSpe4NppTb82dSDQPpuxwYLBwpNItlPpJF0Xj8aZqUINad62Fxp/6dPZsvXAu
         oe1iG+JF++f3hKvhy93ApQVecg0Wa7X/vB8qwVDULdrfuA93GwK7YJ/eG4ToEnb6VRhv
         RvNiqbole5J7GBukJZmBZK4ZofQ0jI74VJeFUuBhpbRIixGOyCZHp1CCxzU7vxMLyOFA
         GH3Q==
Received: by 10.66.75.195 with SMTP id e3mr29504660paw.32.1345466656231;
        Mon, 20 Aug 2012 05:44:16 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id ko8sm1251922pbc.40.2012.08.20.05.44.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:44:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:38:15 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203818>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/remote.c | 84 ++++++++++++++++++++++++++++--------------------=
--------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 920262d..8a670d8 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -8,66 +8,66 @@
 #include "refs.h"
=20
 static const char * const builtin_remote_usage[] =3D {
-	"git remote [-v | --verbose]",
-	"git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [=
--mirror=3D<fetch|push>] <name> <url>",
-	"git remote rename <old> <new>",
-	"git remote rm <name>",
-	"git remote set-head <name> (-a | -d | <branch>)",
-	"git remote [-v | --verbose] show [-n] <name>",
-	"git remote prune [-n | --dry-run] <name>",
-	"git remote [-v | --verbose] update [-p | --prune] [(<group> | <remot=
e>)...]",
-	"git remote set-branches [--add] <name> <branch>...",
-	"git remote set-url [--push] <name> <newurl> [<oldurl>]",
-	"git remote set-url --add <name> <newurl>",
-	"git remote set-url --delete <name> <url>",
+	N_("git remote [-v | --verbose]"),
+	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags=
] [--mirror=3D<fetch|push>] <name> <url>"),
+	N_("git remote rename <old> <new>"),
+	N_("git remote rm <name>"),
+	N_("git remote set-head <name> (-a | -d | <branch>)"),
+	N_("git remote [-v | --verbose] show [-n] <name>"),
+	N_("git remote prune [-n | --dry-run] <name>"),
+	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <re=
mote>)...]"),
+	N_("git remote set-branches [--add] <name> <branch>..."),
+	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
+	N_("git remote set-url --add <name> <newurl>"),
+	N_("git remote set-url --delete <name> <url>"),
 	NULL
 };
=20
 static const char * const builtin_remote_add_usage[] =3D {
-	"git remote add [<options>] <name> <url>",
+	N_("git remote add [<options>] <name> <url>"),
 	NULL
 };
=20
 static const char * const builtin_remote_rename_usage[] =3D {
-	"git remote rename <old> <new>",
+	N_("git remote rename <old> <new>"),
 	NULL
 };
=20
 static const char * const builtin_remote_rm_usage[] =3D {
-	"git remote rm <name>",
+	N_("git remote rm <name>"),
 	NULL
 };
=20
 static const char * const builtin_remote_sethead_usage[] =3D {
-	"git remote set-head <name> (-a | -d | <branch>])",
+	N_("git remote set-head <name> (-a | -d | <branch>])"),
 	NULL
 };
=20
 static const char * const builtin_remote_setbranches_usage[] =3D {
-	"git remote set-branches <name> <branch>...",
-	"git remote set-branches --add <name> <branch>...",
+	N_("git remote set-branches <name> <branch>..."),
+	N_("git remote set-branches --add <name> <branch>..."),
 	NULL
 };
=20
 static const char * const builtin_remote_show_usage[] =3D {
-	"git remote show [<options>] <name>",
+	N_("git remote show [<options>] <name>"),
 	NULL
 };
=20
 static const char * const builtin_remote_prune_usage[] =3D {
-	"git remote prune [<options>] <name>",
+	N_("git remote prune [<options>] <name>"),
 	NULL
 };
=20
 static const char * const builtin_remote_update_usage[] =3D {
-	"git remote update [<options>] [<group> | <remote>]...",
+	N_("git remote update [<options>] [<group> | <remote>]..."),
 	NULL
 };
=20
 static const char * const builtin_remote_seturl_usage[] =3D {
-	"git remote set-url [--push] <name> <newurl> [<oldurl>]",
-	"git remote set-url --add <name> <newurl>",
-	"git remote set-url --delete <name> <url>",
+	N_("git remote set-url [--push] <name> <newurl> [<oldurl>]"),
+	N_("git remote set-url --add <name> <newurl>"),
+	N_("git remote set-url --delete <name> <url>"),
 	NULL
 };
=20
@@ -160,17 +160,17 @@ static int add(int argc, const char **argv)
 	int i;
=20
 	struct option options[] =3D {
-		OPT_BOOLEAN('f', "fetch", &fetch, "fetch the remote branches"),
+		OPT_BOOLEAN('f', "fetch", &fetch, N_("fetch the remote branches")),
 		OPT_SET_INT(0, "tags", &fetch_tags,
-			    "import all tags and associated objects when fetching",
+			    N_("import all tags and associated objects when fetching"),
 			    TAGS_SET),
 		OPT_SET_INT(0, NULL, &fetch_tags,
-			    "or do not fetch any tag at all (--no-tags)", TAGS_UNSET),
-		OPT_STRING_LIST('t', "track", &track, "branch",
-				"branch(es) to track"),
-		OPT_STRING('m', "master", &master, "branch", "master branch"),
-		{ OPTION_CALLBACK, 0, "mirror", &mirror, "push|fetch",
-			"set up remote as a mirror to push to or fetch from",
+			    N_("or do not fetch any tag at all (--no-tags)"), TAGS_UNSET),
+		OPT_STRING_LIST('t', "track", &track, N_("branch"),
+				N_("branch(es) to track")),
+		OPT_STRING('m', "master", &master, N_("branch"), N_("master branch")=
),
+		{ OPTION_CALLBACK, 0, "mirror", &mirror, N_("push|fetch"),
+			N_("set up remote as a mirror to push to or fetch from"),
 			PARSE_OPT_OPTARG, parse_mirror_opt },
 		OPT_END()
 	};
@@ -1088,7 +1088,7 @@ static int show(int argc, const char **argv)
 {
 	int no_query =3D 0, result =3D 0, query_flag =3D 0;
 	struct option options[] =3D {
-		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),
+		OPT_BOOLEAN('n', NULL, &no_query, N_("do not query remotes")),
 		OPT_END()
 	};
 	struct ref_states states;
@@ -1196,9 +1196,9 @@ static int set_head(int argc, const char **argv)
=20
 	struct option options[] =3D {
 		OPT_BOOLEAN('a', "auto", &opt_a,
-			    "set refs/remotes/<name>/HEAD according to remote"),
+			    N_("set refs/remotes/<name>/HEAD according to remote")),
 		OPT_BOOLEAN('d', "delete", &opt_d,
-			    "delete refs/remotes/<name>/HEAD"),
+			    N_("delete refs/remotes/<name>/HEAD")),
 		OPT_END()
 	};
 	argc =3D parse_options(argc, argv, NULL, options, builtin_remote_seth=
ead_usage,
@@ -1250,7 +1250,7 @@ static int prune(int argc, const char **argv)
 {
 	int dry_run =3D 0, result =3D 0;
 	struct option options[] =3D {
-		OPT__DRY_RUN(&dry_run, "dry run"),
+		OPT__DRY_RUN(&dry_run, N_("dry run")),
 		OPT_END()
 	};
=20
@@ -1318,7 +1318,7 @@ static int update(int argc, const char **argv)
 	int i, prune =3D 0;
 	struct option options[] =3D {
 		OPT_BOOLEAN('p', "prune", &prune,
-			    "prune remotes after fetching"),
+			    N_("prune remotes after fetching")),
 		OPT_END()
 	};
 	const char **fetch_argv;
@@ -1404,7 +1404,7 @@ static int set_branches(int argc, const char **ar=
gv)
 {
 	int add_mode =3D 0;
 	struct option options[] =3D {
-		OPT_BOOLEAN('\0', "add", &add_mode, "add branch"),
+		OPT_BOOLEAN('\0', "add", &add_mode, N_("add branch")),
 		OPT_END()
 	};
=20
@@ -1433,11 +1433,11 @@ static int set_url(int argc, const char **argv)
 	struct strbuf name_buf =3D STRBUF_INIT;
 	struct option options[] =3D {
 		OPT_BOOLEAN('\0', "push", &push_mode,
-			    "manipulate push URLs"),
+			    N_("manipulate push URLs")),
 		OPT_BOOLEAN('\0', "add", &add_mode,
-			    "add URL"),
+			    N_("add URL")),
 		OPT_BOOLEAN('\0', "delete", &delete_mode,
-			    "delete URLs"),
+			    N_("delete URLs")),
 		OPT_END()
 	};
 	argc =3D parse_options(argc, argv, NULL, options, builtin_remote_setu=
rl_usage,
@@ -1566,7 +1566,7 @@ static int show_all(void)
 int cmd_remote(int argc, const char **argv, const char *prefix)
 {
 	struct option options[] =3D {
-		OPT__VERBOSE(&verbose, "be verbose; must be placed before a subcomma=
nd"),
+		OPT__VERBOSE(&verbose, N_("be verbose; must be placed before a subco=
mmand")),
 		OPT_END()
 	};
 	int result;
--=20
1.7.12.rc2.18.g61b472e

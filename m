From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/66] i18n: branch: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:31:55 +0700
Message-ID: <1345465975-16927-7-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:39:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RGj-0005QB-7r
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404Ab2HTMjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:39:37 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab2HTMjf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:39:35 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cNFOJYzsumTFv5eIPzvhTem741n5GKvH70ZLUioZE7I=;
        b=0Z+dGQg+ePSgLEsqeylTiNMgCKSIq1dAG6hN4jEWCfHufD2sWVdlHUeE7vWe1Ero7Y
         wd1/E6tUwHSZp6BKLCNuQlFOLPArjXMg8k/rWketejiXreBkbgIcsZR8qb+EkVc0FPnH
         sEfA9lPWXz3SR6fiAnLktbANJo55ALDLEbw9OngDluWM4NIOZnt4glOOn4Er2i0mSeov
         FmQHFvo8PuXnOwGvv32GFAGTdcWJDXvPANg1HC24U1GmzTRLiNniWvCi17VcnY2MxTMd
         +L9UjY5nIF5nq3uOrUz3COGvfhd4Top0Sj8pN/xfzDnv4o9u1hsLzX5LooC8Jn8Ot4i8
         aKrg==
Received: by 10.66.88.198 with SMTP id bi6mr29494157pab.23.1345466375024;
        Mon, 20 Aug 2012 05:39:35 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id iq1sm11034411pbc.37.2012.08.20.05.39.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:39:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:33:35 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203778>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c | 56 ++++++++++++++++++++++++++++--------------------=
--------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0e060f2..3f34101 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -19,10 +19,10 @@
 #include "column.h"
=20
 static const char * const builtin_branch_usage[] =3D {
-	"git branch [options] [-r | -a] [--merged | --no-merged]",
-	"git branch [options] [-l] [-f] <branchname> [<start-point>]",
-	"git branch [options] [-r] (-d | -D) <branchname>...",
-	"git branch [options] (-m | -M) [<oldbranch>] <newbranch>",
+	N_("git branch [options] [-r | -a] [--merged | --no-merged]"),
+	N_("git branch [options] [-l] [-f] <branchname> [<start-point>]"),
+	N_("git branch [options] [-r] (-d | -D) <branchname>..."),
+	N_("git branch [options] (-m | -M) [<oldbranch>] <newbranch>"),
 	NULL
 };
=20
@@ -718,56 +718,56 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
 	struct commit_list *with_commit =3D NULL;
=20
 	struct option options[] =3D {
-		OPT_GROUP("Generic options"),
+		OPT_GROUP(N_("Generic options")),
 		OPT__VERBOSE(&verbose,
-			"show hash and subject, give twice for upstream branch"),
-		OPT__QUIET(&quiet, "suppress informational messages"),
-		OPT_SET_INT('t', "track",  &track, "set up tracking mode (see git-pu=
ll(1))",
+			N_("show hash and subject, give twice for upstream branch")),
+		OPT__QUIET(&quiet, N_("suppress informational messages")),
+		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see git=
-pull(1))"),
 			BRANCH_TRACK_EXPLICIT),
-		OPT_SET_INT( 0, "set-upstream",  &track, "change upstream info",
+		OPT_SET_INT( 0, "set-upstream",  &track, N_("change upstream info"),
 			BRANCH_TRACK_OVERRIDE),
-		OPT__COLOR(&branch_use_color, "use colored output"),
-		OPT_SET_INT('r', "remotes",     &kinds, "act on remote-tracking bran=
ches",
+		OPT__COLOR(&branch_use_color, N_("use colored output")),
+		OPT_SET_INT('r', "remotes",     &kinds, N_("act on remote-tracking b=
ranches"),
 			REF_REMOTE_BRANCH),
 		{
-			OPTION_CALLBACK, 0, "contains", &with_commit, "commit",
-			"print only branches that contain the commit",
+			OPTION_CALLBACK, 0, "contains", &with_commit, N_("commit"),
+			N_("print only branches that contain the commit"),
 			PARSE_OPT_LASTARG_DEFAULT,
 			parse_opt_with_commit, (intptr_t)"HEAD",
 		},
 		{
-			OPTION_CALLBACK, 0, "with", &with_commit, "commit",
-			"print only branches that contain the commit",
+			OPTION_CALLBACK, 0, "with", &with_commit, N_("commit"),
+			N_("print only branches that contain the commit"),
 			PARSE_OPT_HIDDEN | PARSE_OPT_LASTARG_DEFAULT,
 			parse_opt_with_commit, (intptr_t) "HEAD",
 		},
 		OPT__ABBREV(&abbrev),
=20
-		OPT_GROUP("Specific git-branch actions:"),
-		OPT_SET_INT('a', "all", &kinds, "list both remote-tracking and local=
 branches",
+		OPT_GROUP(N_("Specific git-branch actions:")),
+		OPT_SET_INT('a', "all", &kinds, N_("list both remote-tracking and lo=
cal branches"),
 			REF_REMOTE_BRANCH | REF_LOCAL_BRANCH),
-		OPT_BIT('d', "delete", &delete, "delete fully merged branch", 1),
-		OPT_BIT('D', NULL, &delete, "delete branch (even if not merged)", 2)=
,
-		OPT_BIT('m', "move", &rename, "move/rename a branch and its reflog",=
 1),
-		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target ex=
ists", 2),
-		OPT_BOOLEAN(0, "list", &list, "list branch names"),
-		OPT_BOOLEAN('l', "create-reflog", &reflog, "create the branch's refl=
og"),
+		OPT_BIT('d', "delete", &delete, N_("delete fully merged branch"), 1)=
,
+		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)")=
, 2),
+		OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflo=
g"), 1),
+		OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target=
 exists"), 2),
+		OPT_BOOLEAN(0, "list", &list, N_("list branch names")),
+		OPT_BOOLEAN('l', "create-reflog", &reflog, N_("create the branch's r=
eflog")),
 		OPT_BOOLEAN(0, "edit-description", &edit_description,
-			    "edit the description for the branch"),
-		OPT__FORCE(&force_create, "force creation (when already exists)"),
+			    N_("edit the description for the branch")),
+		OPT__FORCE(&force_create, N_("force creation (when already exists)")=
),
 		{
 			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
-			"commit", "print only not merged branches",
+			N_("commit"), N_("print only not merged branches"),
 			PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
 			opt_parse_merge_filter, (intptr_t) "HEAD",
 		},
 		{
 			OPTION_CALLBACK, 0, "merged", &merge_filter_ref,
-			"commit", "print only merged branches",
+			N_("commit"), N_("print only merged branches"),
 			PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
 			opt_parse_merge_filter, (intptr_t) "HEAD",
 		},
-		OPT_COLUMN(0, "column", &colopts, "list branches in columns"),
+		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
 		OPT_END(),
 	};
=20
--=20
1.7.12.rc2.18.g61b472e

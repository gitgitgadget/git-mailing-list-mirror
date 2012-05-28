From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/65] i18n: branch: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:19 +0700
Message-ID: <1338203657-26486-5-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:19:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYxyn-0006C3-QK
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474Ab2E1LTM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:19:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48872 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab2E1LTL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:19:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4538023pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dH4ZvH+bIWYm5nqn8/6HthCBA4bKQTVeJmyZRd92ZGM=;
        b=urynsFfO25Tg3YsKIjhSzwsF9NR5D/jfYZmNQ3MvB4QvW8xmuQY8P9CGkGOc5Mh8vN
         JE3zcWazpGl5Cztk7yOhv3oHtoA7vSXixPX93o403HS12d34ERJWPa28U5WABJodAGVZ
         aK8KxNxC7n84fu3jPSCQDayrODAVPAusMUf3EJdfe068nSjGRtbwyIFeZksWA7cMQgS4
         5PiTuK0z3btlCoNsFy0GXs1heRokREwz95w2JUcaYIOyw2UrC//cHOJ9MAvkJRahKcd2
         8zIzJo7KRxbdfYAHhqMSYJp76WSI9kWB2LYm9tfFA4OGrHGR5cY9Rd4/5cm11/uQoEPK
         D7lA==
Received: by 10.68.230.68 with SMTP id sw4mr26451563pbc.142.1338203950895;
        Mon, 28 May 2012 04:19:10 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id ms1sm17127797pbb.63.2012.05.28.04.19.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:19:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:15:05 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198643>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/branch.c | 54 +++++++++++++++++++++++++++---------------------=
------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0e060f2..f9135ed 100644
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
@@ -718,52 +718,52 @@ int cmd_branch(int argc, const char **argv, const=
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
--=20
1.7.10.2.549.g9354186

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 56/65] i18n: show-branch: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:08 +0700
Message-ID: <1338203657-26486-54-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:26:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy5j-0006Zq-FH
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754455Ab2E1L0X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:26:23 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36112 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671Ab2E1L0W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:26:22 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4038533dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zfcGwZoUbq8Q+nPPrwHdfbVXhMiA7vwg5/+MaxOSyL0=;
        b=ap9ynzO8Rbx5uGlq8133ftXTUCx7JZ6s2sHZ9X2AVOnBI2l5JMzIvPemUu4kcmfLh5
         LJfXs5NG6E/HDhV0bhBv6ccpCk0mkRG80bRTD9bIvTS/sfScsjyUSnj9Vw9AbmIG37m0
         kWt4Fsfw7TS8s5BIThNPpjBUc2oHBBcQo+86i9rJI7Op9dkATEQ8W184mr87MgPQAxlC
         /muh+8nkJGhMZU4fS8+jkhk/P/D1p0sWhEVY3KtUc1CTJ3uSlygRrM8i/iegfUye6HRc
         f6Kj2+FWsVulJ7TKiAzg4B2MsKMQqiQNsBpEZmn9683bk1ZuJ3la39zfcXqeDB6v0RqQ
         U0Uw==
Received: by 10.68.226.226 with SMTP id rv2mr11935675pbc.101.1338204382028;
        Mon, 28 May 2012 04:26:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id rs3sm19003718pbc.47.2012.05.28.04.26.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:26:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:22:16 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198692>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/show-branch.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index a59e088..d208fd6 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -6,8 +6,8 @@
 #include "parse-options.h"
=20
 static const char* show_branch_usage[] =3D {
-    "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-=
order] [--current] [--color[=3D<when>] | --no-color] [--sparse] [--more=
=3D<n> | --list | --independent | --merge-base] [--no-name | --sha1-nam=
e] [--topics] [(<rev> | <glob>)...]",
-    "git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>]",
+    N_("git show-branch [-a|--all] [-r|--remotes] [--topo-order | --da=
te-order] [--current] [--color[=3D<when>] | --no-color] [--sparse] [--m=
ore=3D<n> | --list | --independent | --merge-base] [--no-name | --sha1-=
name] [--topics] [(<rev> | <glob>)...]"),
+    N_("git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref>=
]"),
     NULL
 };
=20
@@ -648,36 +648,36 @@ int cmd_show_branch(int ac, const char **av, cons=
t char *prefix)
 	const char *reflog_base =3D NULL;
 	struct option builtin_show_branch_options[] =3D {
 		OPT_BOOLEAN('a', "all", &all_heads,
-			    "show remote-tracking and local branches"),
+			    N_("show remote-tracking and local branches")),
 		OPT_BOOLEAN('r', "remotes", &all_remotes,
-			    "show remote-tracking branches"),
+			    N_("show remote-tracking branches")),
 		OPT__COLOR(&showbranch_use_color,
-			    "color '*!+-' corresponding to the branch"),
-		{ OPTION_INTEGER, 0, "more", &extra, "n",
-			    "show <n> more commits after the common ancestor",
+			    N_("color '*!+-' corresponding to the branch")),
+		{ OPTION_INTEGER, 0, "more", &extra, N_("n"),
+			    N_("show <n> more commits after the common ancestor"),
 			    PARSE_OPT_OPTARG, NULL, (intptr_t)1 },
-		OPT_SET_INT(0, "list", &extra, "synonym to more=3D-1", -1),
-		OPT_BOOLEAN(0, "no-name", &no_name, "suppress naming strings"),
+		OPT_SET_INT(0, "list", &extra, N_("synonym to more=3D-1"), -1),
+		OPT_BOOLEAN(0, "no-name", &no_name, N_("suppress naming strings")),
 		OPT_BOOLEAN(0, "current", &with_current_branch,
-			    "include the current branch"),
+			    N_("include the current branch")),
 		OPT_BOOLEAN(0, "sha1-name", &sha1_name,
-			    "name commits with their object names"),
+			    N_("name commits with their object names")),
 		OPT_BOOLEAN(0, "merge-base", &merge_base,
-			    "show possible merge bases"),
+			    N_("show possible merge bases")),
 		OPT_BOOLEAN(0, "independent", &independent,
-			    "show refs unreachable from any other ref"),
+			    N_("show refs unreachable from any other ref")),
 		OPT_BOOLEAN(0, "topo-order", &lifo,
-			    "show commits in topological order"),
+			    N_("show commits in topological order")),
 		OPT_BOOLEAN(0, "topics", &topics,
-			    "show only commits not on the first branch"),
+			    N_("show only commits not on the first branch")),
 		OPT_SET_INT(0, "sparse", &dense,
-			    "show merges reachable from only one tip", 0),
+			    N_("show merges reachable from only one tip"), 0),
 		OPT_SET_INT(0, "date-order", &lifo,
-			    "show commits where no parent comes before its "
-			    "children", 0),
-		{ OPTION_CALLBACK, 'g', "reflog", &reflog_base, "<n>[,<base>]",
-			    "show <n> most recent ref-log entries starting at "
-			    "base",
+			    N_("show commits where no parent comes before its "
+			       "children"), 0),
+		{ OPTION_CALLBACK, 'g', "reflog", &reflog_base, N_("<n>[,<base>]"),
+			    N_("show <n> most recent ref-log entries starting at "
+			       "base"),
 			    PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
 			    parse_reflog_param },
 		OPT_END()
--=20
1.7.10.2.549.g9354186

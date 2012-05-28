From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/65] i18n: checkout: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:23 +0700
Message-ID: <1338203657-26486-9-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:20:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYxzS-0006vv-Ut
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835Ab2E1LTy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:19:54 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59749 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746Ab2E1LTn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:19:43 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4033567dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ul3z9Weanv8E/q8t2gzixxO/8UxcGRB4IW+xbQ7pU3Q=;
        b=lcg5g9OSlhODBg120Uxio56Q2v1+dOmHo7sUhH6fiCIpRvfcjZHULJLBpmgEPYK9W6
         dWEz2W/35/NwG2E+30yk9O47oWx4qjqWBfxjnhRnAOgfqF9v2UR4vFDzq9/n8Du/Hz+n
         cfa5QfLoZt7NG6vkE3oWRZNcYtXNEHPSxGoRzJmeSFLeF/6XrwNqPkK/bI12r50wlNiP
         ecDYNaD7qEXVQLip53oByXYrRtRJnQoJXZAj5DOyVxENGWvXEl9D7Dty09pYqYf7iJbC
         MW9ECfFdad533xydERA2H0ngjyvonAJyOAkA93xWZ9XA8oRcxXXyqaKybx9AQh4ru+LF
         ZAuA==
Received: by 10.68.226.228 with SMTP id rv4mr26667780pbc.167.1338203982731;
        Mon, 28 May 2012 04:19:42 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id z2sm18990147pbv.34.2012.05.28.04.19.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:19:41 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:15:37 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198648>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e8c1b1f..77d2b5a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -22,8 +22,8 @@
 #include "argv-array.h"
=20
 static const char * const checkout_usage[] =3D {
-	"git checkout [options] <branch>",
-	"git checkout [options] [<branch>] -- <file>...",
+	N_("git checkout [options] <branch>"),
+	N_("git checkout [options] [<branch>] -- <file>..."),
 	NULL,
 };
=20
@@ -931,28 +931,28 @@ int cmd_checkout(int argc, const char **argv, con=
st char *prefix)
 	int patch_mode =3D 0;
 	int dwim_new_local_branch =3D 1;
 	struct option options[] =3D {
-		OPT__QUIET(&opts.quiet, "suppress progress reporting"),
-		OPT_STRING('b', NULL, &opts.new_branch, "branch",
-			   "create and checkout a new branch"),
-		OPT_STRING('B', NULL, &opts.new_branch_force, "branch",
-			   "create/reset and checkout a branch"),
-		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, "create reflog for new =
branch"),
-		OPT_BOOLEAN(0, "detach", &opts.force_detach, "detach the HEAD at nam=
ed commit"),
-		OPT_SET_INT('t', "track",  &opts.track, "set upstream info for new b=
ranch",
+		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
+		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
+			   N_("create and checkout a new branch")),
+		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
+			   N_("create/reset and checkout a branch")),
+		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, N_("create reflog for n=
ew branch")),
+		OPT_BOOLEAN(0, "detach", &opts.force_detach, N_("detach the HEAD at =
named commit")),
+		OPT_SET_INT('t', "track",  &opts.track, N_("set upstream info for ne=
w branch"),
 			BRANCH_TRACK_EXPLICIT),
-		OPT_STRING(0, "orphan", &opts.new_orphan_branch, "new branch", "new =
unparented branch"),
-		OPT_SET_INT('2', "ours", &opts.writeout_stage, "checkout our version=
 for unmerged files",
+		OPT_STRING(0, "orphan", &opts.new_orphan_branch, N_("new branch"), N=
_("new unparented branch")),
+		OPT_SET_INT('2', "ours", &opts.writeout_stage, N_("checkout our vers=
ion for unmerged files"),
 			    2),
-		OPT_SET_INT('3', "theirs", &opts.writeout_stage, "checkout their ver=
sion for unmerged files",
+		OPT_SET_INT('3', "theirs", &opts.writeout_stage, N_("checkout their =
version for unmerged files"),
 			    3),
-		OPT__FORCE(&opts.force, "force checkout (throw away local modificati=
ons)"),
-		OPT_BOOLEAN('m', "merge", &opts.merge, "perform a 3-way merge with t=
he new branch"),
-		OPT_BOOLEAN(0, "overwrite-ignore", &opts.overwrite_ignore, "update i=
gnored files (default)"),
-		OPT_STRING(0, "conflict", &conflict_style, "style",
-			   "conflict style (merge or diff3)"),
-		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively")=
,
+		OPT__FORCE(&opts.force, N_("force checkout (throw away local modific=
ations)")),
+		OPT_BOOLEAN('m', "merge", &opts.merge, N_("perform a 3-way merge wit=
h the new branch")),
+		OPT_BOOLEAN(0, "overwrite-ignore", &opts.overwrite_ignore, N_("updat=
e ignored files (default)")),
+		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
+			   N_("conflict style (merge or diff3)")),
+		OPT_BOOLEAN('p', "patch", &patch_mode, N_("select hunks interactivel=
y")),
 		{ OPTION_BOOLEAN, 0, "guess", &dwim_new_local_branch, NULL,
-		  "second guess 'git checkout no-such-branch'",
+		  N_("second guess 'git checkout no-such-branch'"),
 		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
 		OPT_END(),
 	};
--=20
1.7.10.2.549.g9354186

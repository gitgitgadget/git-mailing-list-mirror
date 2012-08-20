From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 10/66] i18n: checkout: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:31:59 +0700
Message-ID: <1345465975-16927-11-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:40:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RH8-0005iZ-Jx
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806Ab2HTMkE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:40:04 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab2HTMkB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:40:01 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DsVwylcuK0sJ3HkOnqmIfxuxh17GY9hXPK9k0386n4o=;
        b=DHkeMOrNGoXba2nbajBpBYEmMwz7fnpZl2UvEgMonHGTbMpfZwed6kfoqv0Fi24axs
         ENXECZBbh5SZKm/0IZicj8Bm/ghUSdsN8TsaTiAwCnoZbNTdd/obmFhbmteYHXXGXJVl
         MFurOuk5pRRdmWQiGpjsgcmQMGVqRhwLElQjYHLL6XgL01cqw8RLv+ZLdALedMYoxGDn
         4hvUktb601dFmEOCMvRFQKhx+q088wa2sJiE44H+bVChayaqWcAQjPSTI3GPPOoZWgIJ
         rF8FUT5JLfvd1UTlc7l2D/bWurF/mi8BrrdhaedIyn6HqYv9lt0i6v6QvcDqWr2TUKvz
         SGfw==
Received: by 10.68.238.138 with SMTP id vk10mr34598688pbc.75.1345466400965;
        Mon, 20 Aug 2012 05:40:00 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id oa5sm11041182pbb.14.2012.08.20.05.39.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:39:58 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:33:59 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203782>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d812219..9f6dbe6 100644
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
@@ -934,28 +934,28 @@ int cmd_checkout(int argc, const char **argv, con=
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
1.7.12.rc2.18.g61b472e

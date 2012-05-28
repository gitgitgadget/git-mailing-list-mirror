From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/65] i18n: fetch: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:33 +0700
Message-ID: <1338203657-26486-19-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:21:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy0l-0000Gq-LJ
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051Ab2E1LVL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:21:11 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57776 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960Ab2E1LVH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:21:07 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4034594dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=v+FjkYoWZ3Sz1pXgrtNszyb3C6xBJ4kT03qCdklxv20=;
        b=ZDWORkXVWtXrxq3KTQW4Jkr6UftjEA7wUuLF2bY2Zn3z3GNj87ouq1UpCLRiHEavPC
         K4cS+XMH6qCeCiC4pBq8nqq1Bued+of2bTfzkIN8SvAn8l7HUpYjvvxCewV9WYVpHQCj
         OGfsDIA0A+4q8Ht/33q48fttk6K+yBO2jcGHBxF5iNsBOaTggvDXUEX2H5U6VrLF43Fz
         99GbrWG5RAcho7K/F17VywdCoRF+bLMLhGeZLmXpOrqsuU0gM6TjxU3MN8Q9Z8OaNIoe
         rk8mNFXXZRGZz57rJFmoAKt7FC00cA0aS/x3kYjOh+D1BPVKZvKPyV0zpDKb0PUoJolY
         2Tzg==
Received: by 10.68.231.36 with SMTP id td4mr26637707pbc.141.1338204067183;
        Mon, 28 May 2012 04:21:07 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id po10sm19003765pbb.21.2012.05.28.04.21.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:21:06 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:17:01 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198656>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index bb9a074..3f2ad77 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -16,10 +16,10 @@
 #include "connected.h"
=20
 static const char * const builtin_fetch_usage[] =3D {
-	"git fetch [<options>] [<repository> [<refspec>...]]",
-	"git fetch [<options>] <group>",
-	"git fetch --multiple [<options>] [(<repository> | <group>)...]",
-	"git fetch --all [<options>]",
+	N_("git fetch [<options>] [<repository> [<refspec>...]]"),
+	N_("git fetch [<options>] <group>"),
+	N_("git fetch --multiple [<options>] [(<repository> | <group>)...]"),
+	N_("git fetch --all [<options>]"),
 	NULL
 };
=20
@@ -56,36 +56,36 @@ static int option_parse_recurse_submodules(const st=
ruct option *opt,
 static struct option builtin_fetch_options[] =3D {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOLEAN(0, "all", &all,
-		    "fetch from all remotes"),
+		    N_("fetch from all remotes")),
 	OPT_BOOLEAN('a', "append", &append,
-		    "append to .git/FETCH_HEAD instead of overwriting"),
-	OPT_STRING(0, "upload-pack", &upload_pack, "path",
-		   "path to upload pack on remote end"),
-	OPT__FORCE(&force, "force overwrite of local branch"),
+		    N_("append to .git/FETCH_HEAD instead of overwriting")),
+	OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
+		   N_("path to upload pack on remote end")),
+	OPT__FORCE(&force, N_("force overwrite of local branch")),
 	OPT_BOOLEAN('m', "multiple", &multiple,
-		    "fetch from multiple remotes"),
+		    N_("fetch from multiple remotes")),
 	OPT_SET_INT('t', "tags", &tags,
-		    "fetch all tags and associated objects", TAGS_SET),
+		    N_("fetch all tags and associated objects"), TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
-		    "do not fetch all tags (--no-tags)", TAGS_UNSET),
+		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
 	OPT_BOOLEAN('p', "prune", &prune,
-		    "prune remote-tracking branches no longer on remote"),
-	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, "on-demand",
-		    "control recursive fetching of submodules",
+		    N_("prune remote-tracking branches no longer on remote")),
+	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, N_("on-demand"),
+		    N_("control recursive fetching of submodules"),
 		    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
-		    "dry run"),
-	OPT_BOOLEAN('k', "keep", &keep, "keep downloaded pack"),
+		    N_("dry run")),
+	OPT_BOOLEAN('k', "keep", &keep, N_("keep downloaded pack")),
 	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
-		    "allow updating of HEAD ref"),
-	OPT_BOOL(0, "progress", &progress, "force progress reporting"),
-	OPT_STRING(0, "depth", &depth, "depth",
-		   "deepen history of shallow clone"),
-	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, "dir",
-		   "prepend this to submodule path output", PARSE_OPT_HIDDEN },
+		    N_("allow updating of HEAD ref")),
+	OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
+	OPT_STRING(0, "depth", &depth, N_("depth"),
+		   N_("deepen history of shallow clone")),
+	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
+		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
 	{ OPTION_STRING, 0, "recurse-submodules-default",
 		   &recurse_submodules_default, NULL,
-		   "default mode for recursion", PARSE_OPT_HIDDEN },
+		   N_("default mode for recursion"), PARSE_OPT_HIDDEN },
 	OPT_END()
 };
=20
--=20
1.7.10.2.549.g9354186

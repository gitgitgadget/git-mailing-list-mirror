From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 14/65] i18n: clone: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:26 +0700
Message-ID: <1338203657-26486-12-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:20:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYxzk-0007NC-8m
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861Ab2E1LUI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:20:08 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43145 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab2E1LUG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:20:06 -0400
Received: by pbbrp8 with SMTP id rp8so4539054pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=rFytqxLQyD55JTcl2chOlSQHfoPQEBjup54rro9M6Ug=;
        b=xP7hHuaur35Zuba8MC5+w1wrVO+MSJStwwREfJhElkZgwyKLM70gIOB4Kb67DbzOaH
         M1whWZZMzau+ndUqAipNHNdcgfdFX5282ThkqdPLJxKJscmySgnCzAHxsGFYZhmyQ9Nc
         YzaWbolVIRgW+ZSNGe9hRwF+2PUAsFRAIlyEeOSwA0a2dC0E/MmQLd0sWNcGPP6wKpOb
         UB1EksjrKwydA5+4VELN/uRp9tiWyf4+fcYFLxuHYMB5SVlGCQfKTb/z9tk2k3LQKIep
         n3f3SX1sj5RTK9aHagKprmhInnd4nXhwmE5oizCQ2A3E23aTiFUicuEouO3ySgHM4t/2
         njjw==
Received: by 10.68.189.133 with SMTP id gi5mr26170522pbc.154.1338204006416;
        Mon, 28 May 2012 04:20:06 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id pq1sm18988808pbb.5.2012.05.28.04.20.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:20:05 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:16:01 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198650>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c | 56 ++++++++++++++++++++++++++++---------------------=
-------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index a4d8d25..579319c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -33,7 +33,7 @@
  *
  */
 static const char * const builtin_clone_usage[] =3D {
-	"git clone [options] [--] <repo> [<dir>]",
+	N_("git clone [options] [--] <repo> [<dir>]"),
 	NULL
 };
=20
@@ -61,43 +61,43 @@ static int opt_parse_reference(const struct option =
*opt, const char *arg, int un
 static struct option builtin_clone_options[] =3D {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
-		 "force progress reporting"),
+		 N_("force progress reporting")),
 	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
-		    "don't create a checkout"),
-	OPT_BOOLEAN(0, "bare", &option_bare, "create a bare repository"),
+		    N_("don't create a checkout")),
+	OPT_BOOLEAN(0, "bare", &option_bare, N_("create a bare repository")),
 	{ OPTION_BOOLEAN, 0, "naked", &option_bare, NULL,
-		"create a bare repository",
+		N_("create a bare repository"),
 		PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
 	OPT_BOOLEAN(0, "mirror", &option_mirror,
-		    "create a mirror repository (implies bare)"),
+		    N_("create a mirror repository (implies bare)")),
 	OPT_BOOLEAN('l', "local", &option_local,
-		    "to clone from a local repository"),
+		    N_("to clone from a local repository")),
 	OPT_BOOLEAN(0, "no-hardlinks", &option_no_hardlinks,
-		    "don't use local hardlinks, always copy"),
+		    N_("don't use local hardlinks, always copy")),
 	OPT_BOOLEAN('s', "shared", &option_shared,
-		    "setup as shared repository"),
+		    N_("setup as shared repository")),
 	OPT_BOOLEAN(0, "recursive", &option_recursive,
-		    "initialize submodules in the clone"),
+		    N_("initialize submodules in the clone")),
 	OPT_BOOLEAN(0, "recurse-submodules", &option_recursive,
-		    "initialize submodules in the clone"),
-	OPT_STRING(0, "template", &option_template, "template-directory",
-		   "directory from which templates will be used"),
-	OPT_CALLBACK(0 , "reference", &option_reference, "repo",
-		     "reference repository", &opt_parse_reference),
-	OPT_STRING('o', "origin", &option_origin, "name",
-		   "use <name> instead of 'origin' to track upstream"),
-	OPT_STRING('b', "branch", &option_branch, "branch",
-		   "checkout <branch> instead of the remote's HEAD"),
-	OPT_STRING('u', "upload-pack", &option_upload_pack, "path",
-		   "path to git-upload-pack on the remote"),
-	OPT_STRING(0, "depth", &option_depth, "depth",
-		    "create a shallow clone of that depth"),
+		    N_("initialize submodules in the clone")),
+	OPT_STRING(0, "template", &option_template, N_("template-directory"),
+		   N_("directory from which templates will be used")),
+	OPT_CALLBACK(0 , "reference", &option_reference, N_("repo"),
+		     N_("reference repository"), &opt_parse_reference),
+	OPT_STRING('o', "origin", &option_origin, N_("name"),
+		   N_("use <name> instead of 'origin' to track upstream")),
+	OPT_STRING('b', "branch", &option_branch, N_("branch"),
+		   N_("checkout <branch> instead of the remote's HEAD")),
+	OPT_STRING('u', "upload-pack", &option_upload_pack, N_("path"),
+		   N_("path to git-upload-pack on the remote")),
+	OPT_STRING(0, "depth", &option_depth, N_("depth"),
+		    N_("create a shallow clone of that depth")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
-		    "clone only one branch, HEAD or --branch"),
-	OPT_STRING(0, "separate-git-dir", &real_git_dir, "gitdir",
-		   "separate git dir from working tree"),
-	OPT_STRING_LIST('c', "config", &option_config, "key=3Dvalue",
-			"set config inside the new repository"),
+		    N_("clone only one branch, HEAD or --branch")),
+	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
+		   N_("separate git dir from working tree")),
+	OPT_STRING_LIST('c', "config", &option_config, N_("key=3Dvalue"),
+			N_("set config inside the new repository")),
 	OPT_END()
 };
=20
--=20
1.7.10.2.549.g9354186

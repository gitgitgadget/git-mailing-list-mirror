From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 13/66] i18n: clone: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:02 +0700
Message-ID: <1345465975-16927-14-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:40:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RHS-0005ws-Vn
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889Ab2HTMkY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:40:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab2HTMkW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:40:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IOut0jFe7as6j97t1J8l8/y6Q78oSwZk/VGmvKl94Zk=;
        b=fg6PpuLpkJNKTOmhm95bEy8rMRLeFlEXSqXo7sAW/95XqgDSIijTS7oMRYWr/bVOK+
         UqqGKWYePgvunwYWVhKvNc+lUyP2/XsTdljMauoCt3er56rfc385uZNRfwTOlj+2YUe+
         OLf0XVLR35BCIzpARv5zWprGaXZUH+kWahKa7xluqVlv/2RvSVYbA6+ZaKlUB/PmZm9Q
         oVC+lIb5gCODPmjF8n0NlT9w2RPRJuUw0B7aCUxdDx2RhOQspKQ4CEHFsFR5qIFsQpy/
         nxf+kmKA9Bwt7A+TfgLhTrpKtHHih0kyGRlx81ACq8hBmFzyUyVclqgbEnN0SF4w9bwy
         GGXQ==
Received: by 10.68.136.67 with SMTP id py3mr33902295pbb.156.1345466422174;
        Mon, 20 Aug 2012 05:40:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id qn13sm11024822pbb.71.2012.08.20.05.40.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:40:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:34:22 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203785>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c | 56 ++++++++++++++++++++++++++++---------------------=
-------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index e314b0b..5e8f3ba 100644
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
 	OPT_BOOL('l', "local", &option_local,
-		"to clone from a local repository"),
+		N_("to clone from a local repository")),
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
1.7.12.rc2.18.g61b472e

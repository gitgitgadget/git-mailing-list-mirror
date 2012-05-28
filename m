From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 33/65] i18n: ls-tree: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:45 +0700
Message-ID: <1338203657-26486-31-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:22:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy2M-0002Iz-Kb
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab2E1LWy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:22:54 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58121 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753677Ab2E1LWx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:22:53 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4036469dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oobH0rQuaM87gVmkeuTgiqaqpqS65EhpxHAUHjW+GVQ=;
        b=yph3UtNFET49KC4xu6gV8CJrDgzMv1vmgt7LuRQmzEoABrmKct722cX+E0m6BQAPx2
         z8s+i6WnA8/OTH2UjeQ4XqKfVs4JA5EOvgpSX1hfYsX8d2ixmvcDPVxMdBTcty3HHbEW
         b77YtyXMwRwEBDI2acI6+LFZJCI/Nc+WkKBh65cPXg9hh5+uGXwFEA+4DNQZR4P0o2U+
         aiLuen0DntuvL1jdjbacYX9t5rT8wMnxAkcXuBM7qdIRNw1P913Y3o8VJLfuYXEJFHde
         E9JBcbhpxx6Q+FRPCrS4CdgeDNsgS+ntjnq3Td840hj6AjiB4a3KjS52BBb9dDFcpjA+
         oUDw==
Received: by 10.68.225.6 with SMTP id rg6mr26792536pbc.100.1338204173054;
        Mon, 28 May 2012 04:22:53 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id ud10sm19003002pbc.25.2012.05.28.04.22.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:22:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:18:47 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198669>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/ls-tree.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 6b666e1..235c17c 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -24,7 +24,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
=20
 static const  char * const ls_tree_usage[] =3D {
-	"git ls-tree [<options>] <tree-ish> [<path>...]",
+	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
 	NULL
 };
=20
@@ -122,25 +122,25 @@ int cmd_ls_tree(int argc, const char **argv, cons=
t char *prefix)
 	struct tree *tree;
 	int i, full_tree =3D 0;
 	const struct option ls_tree_options[] =3D {
-		OPT_BIT('d', NULL, &ls_options, "only show trees",
+		OPT_BIT('d', NULL, &ls_options, N_("only show trees"),
 			LS_TREE_ONLY),
-		OPT_BIT('r', NULL, &ls_options, "recurse into subtrees",
+		OPT_BIT('r', NULL, &ls_options, N_("recurse into subtrees"),
 			LS_RECURSIVE),
-		OPT_BIT('t', NULL, &ls_options, "show trees when recursing",
+		OPT_BIT('t', NULL, &ls_options, N_("show trees when recursing"),
 			LS_SHOW_TREES),
 		OPT_SET_INT('z', NULL, &line_termination,
-			    "terminate entries with NUL byte", 0),
-		OPT_BIT('l', "long", &ls_options, "include object size",
+			    N_("terminate entries with NUL byte"), 0),
+		OPT_BIT('l', "long", &ls_options, N_("include object size"),
 			LS_SHOW_SIZE),
-		OPT_BIT(0, "name-only", &ls_options, "list only filenames",
+		OPT_BIT(0, "name-only", &ls_options, N_("list only filenames"),
 			LS_NAME_ONLY),
-		OPT_BIT(0, "name-status", &ls_options, "list only filenames",
+		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
 			LS_NAME_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
-			    "use full path names", 0),
+			    N_("use full path names"), 0),
 		OPT_BOOLEAN(0, "full-tree", &full_tree,
-			    "list entire tree; not just current directory "
-			    "(implies --full-name)"),
+			    N_("list entire tree; not just current directory "
+			       "(implies --full-name)")),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
--=20
1.7.10.2.549.g9354186

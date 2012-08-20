From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 32/66] i18n: ls-tree: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:21 +0700
Message-ID: <1345465975-16927-33-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:42:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RJm-0007Vx-A4
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755312Ab2HTMmq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:42:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:37322 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231Ab2HTMmo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:42:44 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2155685dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=I3mMu9XLQjRQaIDECkWziSiSLhKw/s0LYzHpwOo0hCI=;
        b=D/I7ugifJVcm6xeJeKobWw0DaHlN2sY5cd2/yNX+RDD0Cb7o60Nc8ObTR2hoN5/24r
         TdINH9d6gqmwa9eaDeqIOmhJtDU8Ne+QUpSotRZ3CH88T0GUHg8S++X2HQOIOPj03dv0
         NaN89uaVdzp2j/wOP/DO9bw/tKp+X34+HXCgnbsCvYqLnZ8GTNF6BhU0bUMB3HVbRxRn
         UVOI+4yhe10NIn/dMxEp4AP3Bt5s+qe1++nXzeLUFKJ4dP2a6AZKairipczhVuWu6wOh
         p77+4BK+kr98j7Os6oMNtUgRE/iJ8e5VNQkeczFAtjhWrMZ+AM1EqDPRiSJzFO9i/urI
         fS7g==
Received: by 10.68.231.130 with SMTP id tg2mr33999068pbc.70.1345466564640;
        Mon, 20 Aug 2012 05:42:44 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id kp3sm11026911pbc.64.2012.08.20.05.42.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:42:43 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:36:44 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203804>

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
1.7.12.rc2.18.g61b472e

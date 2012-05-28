From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 25/65] i18n: fsck: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:37 +0700
Message-ID: <1338203657-26486-23-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:21:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy1D-0000qC-7h
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000Ab2E1LVn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:21:43 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57776 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab2E1LVm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:21:42 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4034594dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yCNpeMHi33LskELtL8u9By+gAESaQ1JZJDoD9JALhBg=;
        b=ej4w0aSbQhJam6q+Q9b+tDbdLW7/yPMjqfrDy019aLDDzKTGZ5W3pjKllsMkU2bMK8
         m/+nkg9/dy0IGNEcfchILn8sbjlqRnUphoywMlhf2YVYApANDnW23iEbPYEjDI67oZOn
         8bSMvGN4qUAWshokjgk9ZgMiE+twUy3Naxz+Au7xaSF5Q+GK1XbeiUwQRGMMkAlz1+iS
         zT+4vqBVUvKZOll+HH9kvA/lu0AnqA8tiawJcmdFqDNVdwayn8ajUP1e7gV3CDRg/2ZG
         2+Ry8B0ys96wau52AtC9dsGv5Gmpuyw89OC/6cAzSzKdvNu5v+8DR2x8eufAjetr1kYn
         RYdg==
Received: by 10.68.200.9 with SMTP id jo9mr26101580pbc.122.1338204101874;
        Mon, 28 May 2012 04:21:41 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id b10sm18998895pbr.46.2012.05.28.04.21.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:21:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:17:36 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198661>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fsck.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index a710227..bb9a2cd 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -605,23 +605,23 @@ static int fsck_cache_tree(struct cache_tree *it)
 }
=20
 static char const * const fsck_usage[] =3D {
-	"git fsck [options] [<object>...]",
+	N_("git fsck [options] [<object>...]"),
 	NULL
 };
=20
 static struct option fsck_opts[] =3D {
-	OPT__VERBOSE(&verbose, "be verbose"),
-	OPT_BOOLEAN(0, "unreachable", &show_unreachable, "show unreachable ob=
jects"),
-	OPT_BOOL(0, "dangling", &show_dangling, "show dangling objects"),
-	OPT_BOOLEAN(0, "tags", &show_tags, "report tags"),
-	OPT_BOOLEAN(0, "root", &show_root, "report root nodes"),
-	OPT_BOOLEAN(0, "cache", &keep_cache_objects, "make index objects head=
 nodes"),
-	OPT_BOOLEAN(0, "reflogs", &include_reflogs, "make reflogs head nodes =
(default)"),
-	OPT_BOOLEAN(0, "full", &check_full, "also consider packs and alternat=
e objects"),
-	OPT_BOOLEAN(0, "strict", &check_strict, "enable more strict checking"=
),
+	OPT__VERBOSE(&verbose, N_("be verbose")),
+	OPT_BOOLEAN(0, "unreachable", &show_unreachable, N_("show unreachable=
 objects")),
+	OPT_BOOL(0, "dangling", &show_dangling, N_("show dangling objects")),
+	OPT_BOOLEAN(0, "tags", &show_tags, N_("report tags")),
+	OPT_BOOLEAN(0, "root", &show_root, N_("report root nodes")),
+	OPT_BOOLEAN(0, "cache", &keep_cache_objects, N_("make index objects h=
ead nodes")),
+	OPT_BOOLEAN(0, "reflogs", &include_reflogs, N_("make reflogs head nod=
es (default)")),
+	OPT_BOOLEAN(0, "full", &check_full, N_("also consider packs and alter=
nate objects")),
+	OPT_BOOLEAN(0, "strict", &check_strict, N_("enable more strict checki=
ng")),
 	OPT_BOOLEAN(0, "lost-found", &write_lost_and_found,
-				"write dangling objects in .git/lost-found"),
-	OPT_BOOL(0, "progress", &show_progress, "show progress"),
+				N_("write dangling objects in .git/lost-found")),
+	OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 	OPT_END(),
 };
=20
--=20
1.7.10.2.549.g9354186

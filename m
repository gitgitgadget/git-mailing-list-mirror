From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 24/66] i18n: fsck: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:13 +0700
Message-ID: <1345465975-16927-25-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:42:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RIr-0006vJ-FL
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab2HTMlv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:41:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140Ab2HTMlu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:41:50 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MigtJkrNBQVLIEE77vOOjhRkJaUprv/eUUO0DykQM0w=;
        b=mtqop/yQ2+Mgi9s88DBUUx7gSUgx+yZuWvbISaVc8GBOLoWjA+X/AjtrulPC6EG3hG
         RWYMEvHod1YRvQpYFP7QIwV58eELwOycJr5ZWGYIZVMoorPcuXLH7Ir8yl/iPpe7gOJm
         j9jyKMrUohRK9PNllhNAPEh5GjcJWzWsKiz83ySuVYV4O7For/LHNa+SootRObYN2J1a
         Mmw3eZbJKTdQmaeFZ2r0Q/zd8rlXspVRVfijRCZ2QkwN8u5TTTr5HTKYvV0rpMcrRNxS
         kCWynnxwL6Ee4dXxtW9xvhHSmlfbklOV3i+uMYBP0YTDpPtNwayHgZmXzduPyVE36Azb
         Bykg==
Received: by 10.68.138.234 with SMTP id qt10mr34202125pbb.26.1345466509998;
        Mon, 20 Aug 2012 05:41:49 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id kp3sm11025660pbc.64.2012.08.20.05.41.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:41:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:35:49 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203796>

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
1.7.12.rc2.18.g61b472e

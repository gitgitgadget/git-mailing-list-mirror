From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/66] i18n: add: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:31:52 +0700
Message-ID: <1345465975-16927-4-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:39:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RGP-0005Bu-OE
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab2HTMjT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:39:19 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753802Ab2HTMjR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:39:17 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xjpXuFI9pvB184bC1bxeIzT0YHIOf3LIo9dMKJQIp6s=;
        b=YIm3HtnMpTqT0X/t0mMJ5weOFCaTObyTjXea3pPtweqY7xMUYBoWe93omAOvY5XSAf
         Gw487r1XaJkKPeeCPVr+kY/GgTJa7sA1LI6hb0MoXiAa2/EKx8QrzTVSeHCyk/6Vla4I
         rNNaZw6ay5ttSMJj4FE48rsMAvmwz99ddsY8kaSO0y61ssqklMpnfMBW+oADuJjFtOf3
         OmoY+Ar/zOWare9prO0S3Vb3VRt9JfdiN84YAmhDMMKHkfj35QkiV1KaPs2iYUbQ3zd7
         eQ7lA+UBW3L7X2R1FoIf0UrvSMdJDmXRxvjiZGJJq12TRuXV1ivoFSrycNDV4OK3w9k+
         mX9w==
Received: by 10.66.85.71 with SMTP id f7mr29378562paz.5.1345466356901;
        Mon, 20 Aug 2012 05:39:16 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id ka4sm5664799pbc.61.2012.08.20.05.39.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:39:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:33:16 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203776>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 89dce56..2816789 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -16,7 +16,7 @@
 #include "bulk-checkin.h"
=20
 static const char * const builtin_add_usage[] =3D {
-	"git add [options] [--] <filepattern>...",
+	N_("git add [options] [--] <filepattern>..."),
 	NULL
 };
 static int patch_interactive, add_interactive, edit_interactive;
@@ -315,19 +315,19 @@ static int verbose =3D 0, show_only =3D 0, ignore=
d_too =3D 0, refresh_only =3D 0;
 static int ignore_add_errors, addremove, intent_to_add, ignore_missing=
 =3D 0;
=20
 static struct option builtin_add_options[] =3D {
-	OPT__DRY_RUN(&show_only, "dry run"),
-	OPT__VERBOSE(&verbose, "be verbose"),
+	OPT__DRY_RUN(&show_only, N_("dry run")),
+	OPT__VERBOSE(&verbose, N_("be verbose")),
 	OPT_GROUP(""),
-	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive pickin=
g"),
-	OPT_BOOLEAN('p', "patch", &patch_interactive, "select hunks interacti=
vely"),
-	OPT_BOOLEAN('e', "edit", &edit_interactive, "edit current diff and ap=
ply"),
-	OPT__FORCE(&ignored_too, "allow adding otherwise ignored files"),
-	OPT_BOOLEAN('u', "update", &take_worktree_changes, "update tracked fi=
les"),
-	OPT_BOOLEAN('N', "intent-to-add", &intent_to_add, "record only the fa=
ct that the path will be added later"),
-	OPT_BOOLEAN('A', "all", &addremove, "add changes from all tracked and=
 untracked files"),
-	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh t=
he index"),
-	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, "just skip file=
s which cannot be added because of errors"),
-	OPT_BOOLEAN( 0 , "ignore-missing", &ignore_missing, "check if - even =
missing - files are ignored in dry run"),
+	OPT_BOOLEAN('i', "interactive", &add_interactive, N_("interactive pic=
king")),
+	OPT_BOOLEAN('p', "patch", &patch_interactive, N_("select hunks intera=
ctively")),
+	OPT_BOOLEAN('e', "edit", &edit_interactive, N_("edit current diff and=
 apply")),
+	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files")),
+	OPT_BOOLEAN('u', "update", &take_worktree_changes, N_("update tracked=
 files")),
+	OPT_BOOLEAN('N', "intent-to-add", &intent_to_add, N_("record only the=
 fact that the path will be added later")),
+	OPT_BOOLEAN('A', "all", &addremove, N_("add changes from all tracked =
and untracked files")),
+	OPT_BOOLEAN( 0 , "refresh", &refresh_only, N_("don't add, only refres=
h the index")),
+	OPT_BOOLEAN( 0 , "ignore-errors", &ignore_add_errors, N_("just skip f=
iles which cannot be added because of errors")),
+	OPT_BOOLEAN( 0 , "ignore-missing", &ignore_missing, N_("check if - ev=
en missing - files are ignored in dry run")),
 	OPT_END(),
 };
=20
--=20
1.7.12.rc2.18.g61b472e

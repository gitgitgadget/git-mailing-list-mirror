From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 04/65] i18n: add: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:16 +0700
Message-ID: <1338203657-26486-2-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:18:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYxyN-0005d2-0D
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209Ab2E1LSq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:18:46 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43442 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539Ab2E1LSq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:18:46 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4032956dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2i6gFOF3eYf67/3BmjWnn2uFwaYdD7jkhvJwTEkzCcs=;
        b=WK2cZkEb9ETpOCJsUD24kOS3b+Z1vJgIhiYJrZEiEESr70Cc/rZy9h2rdrCJVaGN9x
         Z8yq6XNfM8zARSLHkEgdPZj5lg4tNdwE5ZS15o8PvRpPUWPEgTiSW3xYiMVO/YFXDZit
         gERqfCF9HxUhIisXL3yXt1m6LJ4+ECD3x0/nOIaRml+wBvfMnryrLidylOXq2gr7Zr/R
         AAdtWHLhPiF9dzG2SictDUIj6zuW+EU9annYS1RK5Ic/qKR/7Gs5rZG8qeIKJstVXSNq
         50d7m/h3MaumsZhIJZsWKx1uNJm+2DyNjLAn0LmxqXmH3AR8FdWLoVWTjt9xkXO3ywqy
         g5zw==
Received: by 10.68.218.7 with SMTP id pc7mr26260573pbc.88.1338203925878;
        Mon, 28 May 2012 04:18:45 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id nw7sm18969893pbb.73.2012.05.28.04.18.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:18:44 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:14:40 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198640>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/add.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index b79336d..6f7c7e1 100644
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
1.7.10.2.549.g9354186

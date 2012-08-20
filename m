From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 50/66] i18n: reset: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:39 +0700
Message-ID: <1345465975-16927-51-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:44:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RLb-0000S3-1b
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719Ab2HTMom convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:44:42 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54012 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755696Ab2HTMok (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:44:40 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2156474dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vH2GloBCVTddKzQ4/aYhr0MIhPOB2XA7gNSYQlbHXp4=;
        b=vkfszfmby0HpCx6df8vgQEKS+dx8uiWkwnNF2qVkBVQrBVxueqom+mvOBmHw9fT9PS
         C2MHLZ+htqrsfVW0vHuG6rwuS8CJ2wtqNXTv+ush8Lde6V+jYPDVMaVL1aswdFexS9x2
         iOj4Y4fVi5r9FWyeVZOeXBVf2zl701cDGp5u7FpU0pttdqgtmngbDPD4KPEx4eRIgR3+
         980gphPE2OpJRqBi52itaklZ8R8qBtcL7RpOvSNO8EY9recQfnZANmeeyUMGI+YcXNwH
         AILP6mA6+5qALOPUJL+Iw4KMlijc718/IB+CBr33Smbe0FTZU73den616UMECMdkK90Z
         i6kA==
Received: by 10.68.189.99 with SMTP id gh3mr34073212pbc.31.1345466680320;
        Mon, 20 Aug 2012 05:44:40 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id ro7sm11053201pbc.8.2012.08.20.05.44.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:44:39 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:38:40 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203822>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/reset.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 74442bd..915cc9f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -22,9 +22,9 @@
 #include "cache-tree.h"
=20
 static const char * const git_reset_usage[] =3D {
-	"git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<comm=
it>]",
-	"git reset [-q] <commit> [--] <paths>...",
-	"git reset --patch [<commit>] [--] [<paths>...]",
+	N_("git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<c=
ommit>]"),
+	N_("git reset [-q] <commit> [--] <paths>..."),
+	N_("git reset --patch [<commit>] [--] [<paths>...]"),
 	NULL
 };
=20
@@ -235,17 +235,17 @@ int cmd_reset(int argc, const char **argv, const =
char *prefix)
 	struct commit *commit;
 	struct strbuf msg =3D STRBUF_INIT;
 	const struct option options[] =3D {
-		OPT__QUIET(&quiet, "be quiet, only report errors"),
+		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_SET_INT(0, "mixed", &reset_type,
-						"reset HEAD and index", MIXED),
-		OPT_SET_INT(0, "soft", &reset_type, "reset only HEAD", SOFT),
+						N_("reset HEAD and index"), MIXED),
+		OPT_SET_INT(0, "soft", &reset_type, N_("reset only HEAD"), SOFT),
 		OPT_SET_INT(0, "hard", &reset_type,
-				"reset HEAD, index and working tree", HARD),
+				N_("reset HEAD, index and working tree"), HARD),
 		OPT_SET_INT(0, "merge", &reset_type,
-				"reset HEAD, index and working tree", MERGE),
+				N_("reset HEAD, index and working tree"), MERGE),
 		OPT_SET_INT(0, "keep", &reset_type,
-				"reset HEAD but keep local changes", KEEP),
-		OPT_BOOLEAN('p', "patch", &patch_mode, "select hunks interactively")=
,
+				N_("reset HEAD but keep local changes"), KEEP),
+		OPT_BOOLEAN('p', "patch", &patch_mode, N_("select hunks interactivel=
y")),
 		OPT_END()
 	};
=20
--=20
1.7.12.rc2.18.g61b472e

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 51/65] i18n: reset: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:03 +0700
Message-ID: <1338203657-26486-49-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:25:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy51-0005ko-VI
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754377Ab2E1LZj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:25:39 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36112 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367Ab2E1LZi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:25:38 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4038533dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mMvDnRVzKXnGlnPFiZPi1OJ9w2fBY3gR94JSc14nj1w=;
        b=vP3vuKlenzMgkVjA+EzV51HTUgx0APDzyJOtc3EqwgkMXA1gtUvza0uedqENoSvpEk
         7wlVlv/i7/oUHw0i/ivpzZUPOnCVwOVjq5dAB12G0H5WBybk2jFPGs0Oyxai2GbRt6Hn
         Cb6BIRm1C6I2iDSP/Jx2qdKMBmk2gguPuLPSdp3ccS7gwaHxZTQilrc6kglpNfXWsPDN
         4t+9L2B7QVlwm2zrvkiIL+G4WA/iD5kYWYgop4YKpU5LCrLIPU0invptX2NpVcfunug/
         1/aaE+m78URCJCNSJsRZqWnEwV8b0SmevHNFi4/uiuLxlmmN5gKSW0p29adTVxyJSfY1
         eLew==
Received: by 10.68.132.199 with SMTP id ow7mr26029837pbb.144.1338204338666;
        Mon, 28 May 2012 04:25:38 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id rv8sm18997050pbc.64.2012.05.28.04.25.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:25:37 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:21:33 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198686>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/reset.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 8c2c1d5..813b3a6 100644
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
1.7.10.2.549.g9354186

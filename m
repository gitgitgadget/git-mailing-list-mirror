From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 48/65] i18n: replace: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:00 +0700
Message-ID: <1338203657-26486-46-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:25:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy4d-0005E8-PJ
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754317Ab2E1LZN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:25:13 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36112 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607Ab2E1LZM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:25:12 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4038533dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MAuQWg7rfgpwyjZ+dnXaczM7es0T0oRQ3qAnUvnmzj8=;
        b=XzJ/rPcgPurN/oA2/dGfao3C9YqR1Bn5HGBYCtinEisROQfcrk1NhnhNPA5FhzYGOV
         fRK/Ue3RyQcYWVXhBl7vVnStJu1E+TrQfdjMbBm1NnMuc6EN2qtajtPbGHamRUEpebXy
         NCph60Ui9CV5IpY5ZMcFUyaRB47BdDt5zBaa75uFNUfeeoyIR6Q/2fX1hbguiUoQuOge
         Y+UVD/iA/ddAEnBqXs2hNOmtG5RVPObQorrfwncGi32q2uVs4BIrUn1i9JkOUee2chuz
         v4Cqt8Kj6M+kHgAVY359JrjZmi8sYb7Cj0vSBuFWWMuIe/9425iHhArT84tgI8umsDX7
         RVLA==
Received: by 10.68.219.7 with SMTP id pk7mr26565106pbc.36.1338204311739;
        Mon, 28 May 2012 04:25:11 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id uz7sm19008861pbc.35.2012.05.28.04.25.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:25:10 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:21:05 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198684>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/replace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 4a8970e..e3aaf70 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -14,9 +14,9 @@
 #include "parse-options.h"
=20
 static const char * const git_replace_usage[] =3D {
-	"git replace [-f] <object> <replacement>",
-	"git replace -d <object>...",
-	"git replace -l [<pattern>]",
+	N_("git replace [-f] <object> <replacement>"),
+	N_("git replace -d <object>..."),
+	N_("git replace -l [<pattern>]"),
 	NULL
 };
=20
@@ -115,9 +115,9 @@ int cmd_replace(int argc, const char **argv, const =
char *prefix)
 {
 	int list =3D 0, delete =3D 0, force =3D 0;
 	struct option options[] =3D {
-		OPT_BOOLEAN('l', NULL, &list, "list replace refs"),
-		OPT_BOOLEAN('d', NULL, &delete, "delete replace refs"),
-		OPT_BOOLEAN('f', NULL, &force, "replace the ref if it exists"),
+		OPT_BOOLEAN('l', NULL, &list, N_("list replace refs")),
+		OPT_BOOLEAN('d', NULL, &delete, N_("delete replace refs")),
+		OPT_BOOLEAN('f', NULL, &force, N_("replace the ref if it exists")),
 		OPT_END()
 	};
=20
--=20
1.7.10.2.549.g9354186

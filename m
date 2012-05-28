From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 61/65] i18n: update-ref: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:13 +0700
Message-ID: <1338203657-26486-59-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:27:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy6U-0007Zd-MU
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515Ab2E1L1J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:27:09 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36112 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab2E1L1I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:27:08 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4038533dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SeoU/2333eeW74PKfEbkVU+zPascVET3pEw08dAKUxE=;
        b=dJBQRn525AC2pWHdhtsWg8YMagJwgYJgRuVnnmxd8yQm6rKyHK/E64pEFqs7ngOGvh
         png50b199kGhN/1jfgqMgzqAFZHPSJgHLM1SJC2NopqEkciNgRGfbxnsye9wdZ6gU/vq
         6xuESv2N/D4Sh0L1plIX3+p9slgq71j0Su8QYx6g/t3ayfz4fD9M/5BqfW7+d3xZVaBE
         dhns0y8iBQJEuyyJyQCn8kBBELICIPDtr9sqguR9J1k8xdvEA7npDRdTEZEQVWvzWb3p
         ynvsPMTwtIbpnsI9/ZQjzpcwumtGzMihI8stVMU+hH6Hlgd+nwcuGaOoh7xCKXcEDHrp
         c+QA==
Received: by 10.68.222.9 with SMTP id qi9mr274750pbc.164.1338204428096;
        Mon, 28 May 2012 04:27:08 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id jw3sm6321178pbc.65.2012.05.28.04.27.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:27:07 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:23:02 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198698>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 835c62a..b30394f 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -4,8 +4,8 @@
 #include "parse-options.h"
=20
 static const char * const git_update_ref_usage[] =3D {
-	"git update-ref [options] -d <refname> [<oldval>]",
-	"git update-ref [options]    <refname> <newval> [<oldval>]",
+	N_("git update-ref [options] -d <refname> [<oldval>]"),
+	N_("git update-ref [options]    <refname> <newval> [<oldval>]"),
 	NULL
 };
=20
@@ -15,10 +15,10 @@ int cmd_update_ref(int argc, const char **argv, con=
st char *prefix)
 	unsigned char sha1[20], oldsha1[20];
 	int delete =3D 0, no_deref =3D 0, flags =3D 0;
 	struct option options[] =3D {
-		OPT_STRING( 'm', NULL, &msg, "reason", "reason of the update"),
-		OPT_BOOLEAN('d', NULL, &delete, "deletes the reference"),
+		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update"=
)),
+		OPT_BOOLEAN('d', NULL, &delete, N_("deletes the reference")),
 		OPT_BOOLEAN( 0 , "no-deref", &no_deref,
-					"update <refname> not the one it points to"),
+					N_("update <refname> not the one it points to")),
 		OPT_END(),
 	};
=20
--=20
1.7.10.2.549.g9354186

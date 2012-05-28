From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 63/65] i18n: verify-pack: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:15 +0700
Message-ID: <1338203657-26486-61-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:27:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy6j-0007oZ-IM
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754548Ab2E1L1Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:27:25 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36112 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908Ab2E1L1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:27:24 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4038533dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+F2j5dYnQx0IwQqV7htD+smyCLzNmzGxldqtNEvbTrE=;
        b=s9ePzErElYJjinn/KA4kRypD3OBmYSWrUrXO0AboosFU1jtcGMQyH0tClfqYCc5pT6
         WU2vh/xb/NI700bSvhET1S5zxJHBZSsGKF1CNgGBhLiRSukJc2CwWY+zlUZjS7l8l+I7
         kBUDFXL9RTBpv8z6MinxJhcKSlnd6Cdv/r5LxyHDLAqVWdqRPe1/JIUOtidO+ty8KFk/
         DkI4AhoBsS8NR3YxEpbHhff+SvSx/YF+zJcNdSfzx90Os7yOQcI6UvMqeU7kfentR/zj
         +dloEnBdUg3nOKrrO+SDm4Nvf5xjLafa/O86C/d6VVYZ13ydNnmHk3vhC6A6Du80aXsl
         aZCw==
Received: by 10.68.228.170 with SMTP id sj10mr26226919pbc.106.1338204444678;
        Mon, 28 May 2012 04:27:24 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id qt10sm19003531pbc.57.2012.05.28.04.27.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:27:23 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:23:19 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198700>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/verify-pack.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index e841b4a..66cd2df 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -53,7 +53,7 @@ static int verify_one_pack(const char *path, unsigned=
 int flags)
 }
=20
 static const char * const verify_pack_usage[] =3D {
-	"git verify-pack [-v|--verbose] [-s|--stat-only] <pack>...",
+	N_("git verify-pack [-v|--verbose] [-s|--stat-only] <pack>..."),
 	NULL
 };
=20
@@ -63,9 +63,9 @@ int cmd_verify_pack(int argc, const char **argv, cons=
t char *prefix)
 	unsigned int flags =3D 0;
 	int i;
 	const struct option verify_pack_options[] =3D {
-		OPT_BIT('v', "verbose", &flags, "verbose",
+		OPT_BIT('v', "verbose", &flags, N_("verbose"),
 			VERIFY_PACK_VERBOSE),
-		OPT_BIT('s', "stat-only", &flags, "show statistics only",
+		OPT_BIT('s', "stat-only", &flags, N_("show statistics only"),
 			VERIFY_PACK_STAT_ONLY),
 		OPT_END()
 	};
--=20
1.7.10.2.549.g9354186

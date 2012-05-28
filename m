From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 42/65] i18n: pack-refs: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:54 +0700
Message-ID: <1338203657-26486-40-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:24:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy3f-0003zo-Eq
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226Ab2E1LYP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:24:15 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58121 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208Ab2E1LYO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:24:14 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4036469dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sJ5cpe8UCM8LWKzLKX9Okcf2Dt2d9we+I1R0Cc5dd1s=;
        b=EEglGhtbGtGKsrIAmch3RkDAOFR2ZirZOZzSrRonaEq1RDh1Va49AC4tuDCn4eAVnF
         CMTqsGm3e4fRv2MpqDK/8B2xOt9CYjWHQT1Pj0quLbWVWSzuoTxWBTQybdEf+Iqy5BF4
         gWH24ZZvmA87Ues540C8Hv3e6zpsu4BfkUCHDOMhfcdZE5jzqbMbLN8DZK0R/dpasfx+
         7SlcI6kjpROhJd3TlFXMgM+PQL/NMVF4l8sDW0F8f81Z32WfU/DRwicIZyPmlMyxhLps
         1Hbw1wANd6BM5Tu8zTZCYN336iy9zr4qZn8Mumv0GII/2ZmO0nn5Ny22I8nHVnTDDAEE
         zhIg==
Received: by 10.68.213.200 with SMTP id nu8mr15862465pbc.133.1338204254034;
        Mon, 28 May 2012 04:24:14 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id pe2sm18988917pbc.59.2012.05.28.04.24.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:24:13 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:20:08 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198678>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/pack-refs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 39a9d89..b5a0f88 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -3,7 +3,7 @@
 #include "pack-refs.h"
=20
 static char const * const pack_refs_usage[] =3D {
-	"git pack-refs [options]",
+	N_("git pack-refs [options]"),
 	NULL
 };
=20
@@ -11,8 +11,8 @@ int cmd_pack_refs(int argc, const char **argv, const =
char *prefix)
 {
 	unsigned int flags =3D PACK_REFS_PRUNE;
 	struct option opts[] =3D {
-		OPT_BIT(0, "all",   &flags, "pack everything", PACK_REFS_ALL),
-		OPT_BIT(0, "prune", &flags, "prune loose refs (default)", PACK_REFS_=
PRUNE),
+		OPT_BIT(0, "all",   &flags, N_("pack everything"), PACK_REFS_ALL),
+		OPT_BIT(0, "prune", &flags, N_("prune loose refs (default)"), PACK_R=
EFS_PRUNE),
 		OPT_END(),
 	};
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
--=20
1.7.10.2.549.g9354186

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 18/65] i18n: count-objects: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:30 +0700
Message-ID: <1338203657-26486-16-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:20:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy0L-000870-2t
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:20:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328Ab2E1LUq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:20:46 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43145 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab2E1LUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:20:41 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4539054pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Dq0rtRw6O+ET9P/h5f4SSCi4TheLCuIUuo1iB1xCmV0=;
        b=fHELFju3y6zjVTYGxa2p9Oq8GDvcVQeIMY4AzFX6KxkMbIXY//fPrXCU2UmnfammV0
         3f0x1K1aT/kXDxh6mNR0GrYTTX58CostOA9M1d5btBSUWqh0WRvWUHDy4QjVHpAoDX9M
         BYw8YPpIQDj4zoAoFdMC+RtnJ97oITFEERZOpFRd6EybhKSwKMGGWY0lPwBVvwx03EQ/
         8cNuZImLEoQwxmr/jRPRFNZXeyW7RrCoZFlQWMOrZ1lA1qOC2fqsieWW8dBjByYEbvHc
         BFZyWFa0ajc9iucGU7Q19KM3rmZK9jh43OEK6tJ8ej/SJx4VfVftH1pD3fTkpjZWHN17
         cEwQ==
Received: by 10.68.240.99 with SMTP id vz3mr26462736pbc.60.1338204041748;
        Mon, 28 May 2012 04:20:41 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id tj4sm18992968pbc.33.2012.05.28.04.20.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:20:40 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:16:36 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198654>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/count-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index c37cb98..9afaa88 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -66,7 +66,7 @@ static void count_objects(DIR *d, char *path, int len=
, int verbose,
 }
=20
 static char const * const count_objects_usage[] =3D {
-	"git count-objects [-v]",
+	N_("git count-objects [-v]"),
 	NULL
 };
=20
@@ -79,7 +79,7 @@ int cmd_count_objects(int argc, const char **argv, co=
nst char *prefix)
 	unsigned long loose =3D 0, packed =3D 0, packed_loose =3D 0, garbage =
=3D 0;
 	off_t loose_size =3D 0;
 	struct option opts[] =3D {
-		OPT__VERBOSE(&verbose, "be verbose"),
+		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_END(),
 	};
=20
--=20
1.7.10.2.549.g9354186

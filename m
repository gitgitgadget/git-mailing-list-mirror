From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 64/65] i18n: verify-tag: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:16 +0700
Message-ID: <1338203657-26486-62-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:27:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy6s-000826-AF
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556Ab2E1L1e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:27:34 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36112 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908Ab2E1L1d (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:27:33 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4038533dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GeKZlCD8CLjgIdzhyzTuWDyBxp5Bl3X366gdCOo+pLM=;
        b=GPocB1BgwOwhpGEj9+a/HmeIedQeIeufcwJC3Kre8fqRQDYxQbd00x8L2fBv7uPZ78
         JCuqlGfBC+qLti3bEsEXY+VJVY9saMCynLv++KidFTMPYEZbV2KIAjS7D64ZiUFm4qNu
         iNTC/3Ia0FbQrW3rqneKCEIW654FAz1sIFe9yZoO6gw8GqkIm+dkjuVM1foX7nCzepgr
         1EAlLU4gmvxXVHJK1PKUA6lsWC2AZ+D0m5K8GvZYSuqsgdSNYfTC1K9ld+vwwftqA/gM
         QI3pyg3QdXnor3S8J+tBZppQHNyfEa3XdfKvVqq1imCX70iDNdhUFb0mcOeC5vFwytcg
         irLg==
Received: by 10.68.192.5 with SMTP id hc5mr15353977pbc.49.1338204453497;
        Mon, 28 May 2012 04:27:33 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id qr2sm19021142pbb.19.2012.05.28.04.27.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:27:32 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:23:27 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198701>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/verify-tag.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 986789f..a8eee88 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -14,7 +14,7 @@
 #include "gpg-interface.h"
=20
 static const char * const verify_tag_usage[] =3D {
-		"git verify-tag [-v|--verbose] <tag>...",
+		N_("git verify-tag [-v|--verbose] <tag>..."),
 		NULL
 };
=20
@@ -70,7 +70,7 @@ int cmd_verify_tag(int argc, const char **argv, const=
 char *prefix)
 {
 	int i =3D 1, verbose =3D 0, had_error =3D 0;
 	const struct option verify_tag_options[] =3D {
-		OPT__VERBOSE(&verbose, "print tag contents"),
+		OPT__VERBOSE(&verbose, N_("print tag contents")),
 		OPT_END()
 	};
=20
--=20
1.7.10.2.549.g9354186

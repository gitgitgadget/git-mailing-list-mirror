From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 26/65] i18n: gc: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:38 +0700
Message-ID: <1338203657-26486-24-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:22:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy1L-00014y-EZ
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008Ab2E1LVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:21:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43145 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784Ab2E1LVu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:21:50 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4539054pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=emu5gT8m9Xbs+IngukEQaBl9vkgh6PGyrXlroQe7bgY=;
        b=aOtjQHNlAEzP5vVy856Q7ZIWHRo3juRDjOMuWxnMUt23R7xBI0BcK9IvmTIt2+aAWT
         AUO4RyVlvT2ocAS+iCkWMbMxj6/ITU/kCUNfRujp3ukJ/K/q+xkNlWRZcby0Na/0B6sb
         tiCyEREYFGv+Om0GAZ4MxBXTBmWIk0uwd2oiVJO/g5U1MvZX5qX+xcDckJApCB0jZ55H
         5uYs9kDnag03CpN4K5juYdiIPz0ip9+YSX/Ry39AIfcGErkYBl7ElN33Kh7kcSRPjfsS
         tG9hD7qibHDx9N7R+Ru47MTDXwBIP2LMUpRIYt8sPcX3969kl17elZPLxPw7DTtdiHQG
         sf/A==
Received: by 10.68.238.71 with SMTP id vi7mr26645998pbc.159.1338204110159;
        Mon, 28 May 2012 04:21:50 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id tt5sm14839753pbc.12.2012.05.28.04.21.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:21:49 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:17:45 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198662>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/gc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 9b4232c..6d46608 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -19,7 +19,7 @@
 #define FAILED_RUN "failed to run %s"
=20
 static const char * const builtin_gc_usage[] =3D {
-	"git gc [options]",
+	N_("git gc [options]"),
 	NULL
 };
=20
@@ -174,12 +174,12 @@ int cmd_gc(int argc, const char **argv, const cha=
r *prefix)
 	int quiet =3D 0;
=20
 	struct option builtin_gc_options[] =3D {
-		OPT__QUIET(&quiet, "suppress progress reporting"),
-		{ OPTION_STRING, 0, "prune", &prune_expire, "date",
-			"prune unreferenced objects",
+		OPT__QUIET(&quiet, N_("suppress progress reporting")),
+		{ OPTION_STRING, 0, "prune", &prune_expire, N_("date"),
+			N_("prune unreferenced objects"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
-		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increas=
ed runtime)"),
-		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
+		OPT_BOOLEAN(0, "aggressive", &aggressive, N_("be more thorough (incr=
eased runtime)")),
+		OPT_BOOLEAN(0, "auto", &auto_gc, N_("enable auto-gc mode")),
 		OPT_END()
 	};
=20
--=20
1.7.10.2.549.g9354186

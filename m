From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 23/65] i18n: for-each-ref: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:35 +0700
Message-ID: <1338203657-26486-21-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:21:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy11-0000aY-Ae
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075Ab2E1LV2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:21:28 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43145 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054Ab2E1LVY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:21:24 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4539054pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Z8lTQHT7kVHIK0btqmEuhNKlzXD/aim7tsR1yFdY5ns=;
        b=KRlaE1TZOINQW1uSoD6oibnlf9PMh8jQlM2eyUqYQ/XeSeFPlK5IH0ks4M3jQSaXmB
         psSMLnTU92thf53DISfJI1AkFjhGqIWW7rU3YtSbiSBtxHuDKWrZj0w+pzRFFPzFesrT
         xgnmhx6lXUw+mCfHaqtEpdYq2UZmSbzFfIw7n/dxHyrSrjQgZZGdiu8eNjHin3wdHtT8
         4W4GI5F04S6ffKxb0f5aZnod3Orky66xzJreM9KSXy+3pKUWmHfh67rgnUDon087p7hk
         JYH7I9LtNolecPirQOylgLmGWf+wOoh9PYxA7ML0rbcVIVMVsZLLNj8gBxlD5MfNLDpe
         muyQ==
Received: by 10.68.227.198 with SMTP id sc6mr26333983pbc.138.1338204084536;
        Mon, 28 May 2012 04:21:24 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id gj8sm15476487pbc.39.2012.05.28.04.21.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:21:23 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:17:18 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198658>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/for-each-ref.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index b01d76a..afe83b9 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -974,7 +974,7 @@ static int opt_parse_sort(const struct option *opt,=
 const char *arg, int unset)
 }
=20
 static char const * const for_each_ref_usage[] =3D {
-	"git for-each-ref [options] [<pattern>]",
+	N_("git for-each-ref [options] [<pattern>]"),
 	NULL
 };
=20
@@ -989,19 +989,19 @@ int cmd_for_each_ref(int argc, const char **argv,=
 const char *prefix)
=20
 	struct option opts[] =3D {
 		OPT_BIT('s', "shell", &quote_style,
-		        "quote placeholders suitably for shells", QUOTE_SHELL),
+			N_("quote placeholders suitably for shells"), QUOTE_SHELL),
 		OPT_BIT('p', "perl",  &quote_style,
-		        "quote placeholders suitably for perl", QUOTE_PERL),
+			N_("quote placeholders suitably for perl"), QUOTE_PERL),
 		OPT_BIT(0 , "python", &quote_style,
-		        "quote placeholders suitably for python", QUOTE_PYTHON),
+			N_("quote placeholders suitably for python"), QUOTE_PYTHON),
 		OPT_BIT(0 , "tcl",  &quote_style,
-		        "quote placeholders suitably for tcl", QUOTE_TCL),
+			N_("quote placeholders suitably for tcl"), QUOTE_TCL),
=20
 		OPT_GROUP(""),
-		OPT_INTEGER( 0 , "count", &maxcount, "show only <n> matched refs"),
-		OPT_STRING(  0 , "format", &format, "format", "format to use for the=
 output"),
-		OPT_CALLBACK(0 , "sort", sort_tail, "key",
-		            "field name to sort on", &opt_parse_sort),
+		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs"=
)),
+		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use =
for the output")),
+		OPT_CALLBACK(0 , "sort", sort_tail, N_("key"),
+			    N_("field name to sort on"), &opt_parse_sort),
 		OPT_END(),
 	};
=20
--=20
1.7.10.2.549.g9354186

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 22/66] i18n: for-each-ref: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:11 +0700
Message-ID: <1345465975-16927-23-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:41:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RIe-0006mC-Um
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371Ab2HTMlj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:41:39 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59936 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab2HTMli (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:41:38 -0400
Received: by dady13 with SMTP id y13so2155385dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=soyZRIs3DWDvmVQ3RZ6msYP1l6McNL3vrn18Gynky0o=;
        b=g/WT1K1H/9DEdOgMAqxP21geBme9Lkf32lIE77Y/m14ubKX/HZCFbKvbDgE4NwPWit
         eQLhPQ3dBP4mEBU8m1MiYSiCc+e8V3KcZghR0voFEss/8M7adkA99K/6zd1kmXBMdf9f
         OhVanwhoDL+HfqTGkuzDajbmFabRQfwNW7CC9BHg0Nmm8yvokrt0iIzwYNdfwBuMxuNi
         QXld0wSoh8/za3NmkA3izq81xWOcqfhk3qrP+h3MXRhphHY4NmRPgy+0ykxuEmX7TWyE
         Nzy3OK+EKgv5iWOdRa3a/MOY5XJh5mNgh15Ba1vbng7VspD4n81i32Zx7EQZoFVPZ7Qf
         HFIw==
Received: by 10.68.231.233 with SMTP id tj9mr34084927pbc.39.1345466497954;
        Mon, 20 Aug 2012 05:41:37 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id sr3sm11039688pbc.44.2012.08.20.05.41.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:41:17 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:35:17 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203794>

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
1.7.12.rc2.18.g61b472e

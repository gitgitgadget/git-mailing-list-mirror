From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 08/66] i18n: check-attr: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:31:57 +0700
Message-ID: <1345465975-16927-9-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:39:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RGw-0005aB-5t
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753977Ab2HTMjt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:39:49 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35576 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753880Ab2HTMjr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:39:47 -0400
Received: by dady13 with SMTP id y13so2154416dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=4nE7Z0qOK7o1gfNM0zD9THJbMJqgrEuu8v8IvtB5W4s=;
        b=FZfN6Ky+La0L8uzsKJBk2LOwQv2FDCTK2PPwIzx0cWzKubRb4F/pW2IruObpgus9bE
         hBbjK6GG5jsfZaYJsrtTngx0XJTZqtYfz9e8M74eLIUPOR8eXiAQZCLiez63LOwQJfZM
         /e26kJrKtWPmznTlsCAtD5LSFm0NNhpunYaroS7s8D4RFuh4OAgH9p8maNUd6wrxllFm
         VQxU6VgnXag9G9DyvLXyfsM5TBPJylWUUCZigX1bjh07YpDw2EsYgef8JaXn11y5biye
         Cps11l7/3J4X12YAxLr2FaY7JMTPs7aoZULasx1qLw/2iiXaaR39uGMbUFLowXFKsrTc
         NExw==
Received: by 10.68.200.98 with SMTP id jr2mr34159071pbc.81.1345466387325;
        Mon, 20 Aug 2012 05:39:47 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id nv6sm11035585pbc.42.2012.08.20.05.39.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:39:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:33:47 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203780>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/check-attr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 44c421e..e1ff575 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -8,19 +8,19 @@ static int all_attrs;
 static int cached_attrs;
 static int stdin_paths;
 static const char * const check_attr_usage[] =3D {
-"git check-attr [-a | --all | attr...] [--] pathname...",
-"git check-attr --stdin [-a | --all | attr...] < <list-of-paths>",
+N_("git check-attr [-a | --all | attr...] [--] pathname..."),
+N_("git check-attr --stdin [-a | --all | attr...] < <list-of-paths>"),
 NULL
 };
=20
 static int null_term_line;
=20
 static const struct option check_attr_options[] =3D {
-	OPT_BOOLEAN('a', "all", &all_attrs, "report all attributes set on fil=
e"),
-	OPT_BOOLEAN(0,  "cached", &cached_attrs, "use .gitattributes only fro=
m the index"),
-	OPT_BOOLEAN(0 , "stdin", &stdin_paths, "read file names from stdin"),
+	OPT_BOOLEAN('a', "all", &all_attrs, N_("report all attributes set on =
file")),
+	OPT_BOOLEAN(0,  "cached", &cached_attrs, N_("use .gitattributes only =
from the index")),
+	OPT_BOOLEAN(0 , "stdin", &stdin_paths, N_("read file names from stdin=
")),
 	OPT_BOOLEAN('z', NULL, &null_term_line,
-		"input paths are terminated by a null character"),
+		N_("input paths are terminated by a null character")),
 	OPT_END()
 };
=20
--=20
1.7.12.rc2.18.g61b472e

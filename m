From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 28/66] i18n: help: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:17 +0700
Message-ID: <1345465975-16927-29-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:42:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RJL-0007HP-CK
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227Ab2HTMmV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:42:21 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129Ab2HTMmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:42:20 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=RikGDCVcbd4K07+MDlFNjNt0xbH2iT4AiAthf8YjtWA=;
        b=mtYoPcJMmM0rlThe7bBuphCPNGT4hJ9B/X5znW9tw9DdUcfaOdhPPhA6hhbcwEJv5U
         GDCfEl/ERMCr9ATb5obL56cbkQtfucRcShBFBZ0QhAS2+QuANNgVQDhUTDkGI4chx6cN
         Fjs0A1eF8Cp3HXqFEpbcoZGfl6R0RAfaAWBFLA8N0itTgZhQMkYbSxfC1F91A8kzaGLC
         wQ4NkjlapeWIu7+FPdJH9pQeUKZ/uaHcytvMhD5/1/NeAnwwlHo7F76Vjp5lRewJRQZX
         jhRKpgL6LCiqIzXsxuyVoBkxut8QiHl1MD74qJPNbk9Bw7FxU1WjCI8FY+/LWltAyGvF
         yhoA==
Received: by 10.68.225.196 with SMTP id rm4mr34036043pbc.131.1345466540051;
        Mon, 20 Aug 2012 05:42:20 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id sr3sm11041222pbc.44.2012.08.20.05.42.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:42:18 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:36:19 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203800>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/help.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index efea4f5..bd86253 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -40,17 +40,17 @@ static int show_all =3D 0;
 static unsigned int colopts;
 static enum help_format help_format =3D HELP_FORMAT_NONE;
 static struct option builtin_help_options[] =3D {
-	OPT_BOOLEAN('a', "all", &show_all, "print all available commands"),
-	OPT_SET_INT('m', "man", &help_format, "show man page", HELP_FORMAT_MA=
N),
-	OPT_SET_INT('w', "web", &help_format, "show manual in web browser",
+	OPT_BOOLEAN('a', "all", &show_all, N_("print all available commands")=
),
+	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMA=
T_MAN),
+	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"=
),
 			HELP_FORMAT_WEB),
-	OPT_SET_INT('i', "info", &help_format, "show info page",
+	OPT_SET_INT('i', "info", &help_format, N_("show info page"),
 			HELP_FORMAT_INFO),
 	OPT_END(),
 };
=20
 static const char * const builtin_help_usage[] =3D {
-	"git help [--all] [--man|--web|--info] [command]",
+	N_("git help [--all] [--man|--web|--info] [command]"),
 	NULL
 };
=20
--=20
1.7.12.rc2.18.g61b472e

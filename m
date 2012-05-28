From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 29/65] i18n: help: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:41 +0700
Message-ID: <1338203657-26486-27-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:22:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy20-0001kp-0Y
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab2E1LWR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:22:17 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43145 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab2E1LWP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:22:15 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4539054pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Ehb+xj6XocMTo2LUqVNwalYpOHkYM7+5yZmRkcI14VI=;
        b=DUK24gwKUCmACu+Wai+yMSUzsqb1ndc4nMvXavekzRQ7vEg1/eqLrtMbMvv3+8qr+4
         jXYLO/gSvLQrh1IhjMXO3brZUCrdZ6ui8MAWXmbvvT4kVMOXMJrAkm21G493/scl0Zla
         mp9xE7FS3L28hGDQy7lQtqwvbV9AvRRkHCEcijj3QDv874QCMO+/xbKGOL23FlHx7U29
         uiog/ast3kEms8WM0SPE1z1NYV9KEsS9iuSIRQURO8XqIpRYNfKyAMBG98LQdw+mknhC
         MljfAyqUTI3otQOZ/mGsN1Av0AN9pw+3ahHYGMgChJC9GHnxBe2OKlgKODg5kCWb78Ck
         HqzQ==
Received: by 10.68.211.131 with SMTP id nc3mr25857527pbc.4.1338204135706;
        Mon, 28 May 2012 04:22:15 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id tt5sm14840764pbc.12.2012.05.28.04.22.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:22:14 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:18:10 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198665>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/help.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 43d3c84..05ddd76 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -34,17 +34,17 @@ static int show_all =3D 0;
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
1.7.10.2.549.g9354186

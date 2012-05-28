From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 09/65] i18n: check-attr: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:21 +0700
Message-ID: <1338203657-26486-7-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:19:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYxz2-0006TN-7H
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518Ab2E1LT1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:19:27 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48872 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab2E1LT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:19:26 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so4538023pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=PTlMNQxo14lx2/tBD8Wu3KIxkyhhEuoFZnkpYSbND9s=;
        b=TgM0SPkwPkajJwBDhkgk9mybkfzGRAH3fb0eXFFx8EnspfhfFNzgWw3zahDg61bjyx
         Qt4m+fcH/DRIWhXR+oGKQA4KW4SX2QY1jWS93YuAEfb61LvtWezQ59Zo9sUbvUE+mDwy
         DtXibrgUjBuLU/3twm9Oca+Yco+OQ/x3BC9ifRyId6ArVYo6X2SujK5LwWbHDr35j5B1
         qOts9D0XVaslf6GHJjGbPWjpuqhEzjwFRAvQiz/0Hf6c4liQzyvLvLpTaJc7WVS7r/g9
         Wgo7dObPa0VtoZ8C5AEWGD1tZmL02u4dQ0rnLxRvkRw99Q3DQmSCwoxfUW6nGtskO+dH
         SflA==
Received: by 10.68.227.69 with SMTP id ry5mr26802294pbc.16.1338203966769;
        Mon, 28 May 2012 04:19:26 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id ou5sm18982920pbb.54.2012.05.28.04.19.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:19:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:15:21 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198645>

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
1.7.10.2.549.g9354186

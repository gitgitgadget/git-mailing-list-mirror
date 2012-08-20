From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 63/66] i18n: verify-tag: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:52 +0700
Message-ID: <1345465975-16927-64-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:46:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RMt-0001TM-ER
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab2HTMqB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:46:01 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45598 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab2HTMqA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:46:00 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2157219dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=N6QtxYbW7Px688+cHDUdfWTmflX4P2toLxxGoHAKL7Y=;
        b=0NpBXNSRFRkvoIPS5YDlV6sn+vNH2Zu3VXbIMYuKPAPtwNYIX9/bmxY34LBW23cOwl
         es7Me9HO3w1mD5jU+xB6jvmxlYTsAc9yWpIF4XoMY4BNE+sHmbwFaG/XHG/ah8qPL7Vp
         g7nh1zr3n1CBi2ME0369FZjkTAu/umFmWjFK5HqipTMgHFt6TyZTsFuSSskuGfBs8ZHx
         rOttR897J5q7mcN8MHvjncZw8eGRBFBTItvAgxi/lLLk1SJprlaEXuiqNk2bt8ud0YXt
         jkiM7LQ952Vh+m/K3kHtQ9GZaBVEa6TCUSOPmuujY/u6V2vDQ47ljLQtakAyEsEwsi4Q
         6JfA==
Received: by 10.68.239.166 with SMTP id vt6mr27223118pbc.7.1345466760025;
        Mon, 20 Aug 2012 05:46:00 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id pn4sm11040394pbb.50.2012.08.20.05.45.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:45:59 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:39:59 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203835>

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
1.7.12.rc2.18.g61b472e

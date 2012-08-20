From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 47/66] i18n: replace: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:36 +0700
Message-ID: <1345465975-16927-48-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:44:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RLJ-0000Dq-MS
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755579Ab2HTMoX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:44:23 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555Ab2HTMoW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:44:22 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WJWdQyT0cVQ1kT9NBNtHEF/Wsit4IfPQ34OIabB04t8=;
        b=x7cA2qtnP7dMPHBMYIoFRlZFd4qJFUKZy9NDXKxmESHyEEhlxEjZbwjLXWlzqg+y+U
         tBu8B6DfYyaK2D8yLOeArddQitQzHykLqmuL1GOXPEFrWnCQnGcHx0EoN59lRTRVShl7
         haPqQ5x7VJtuiD7O2c+TQGD5lLXlsGDuFdZK+bNYaiwItxgt0LIOu/o6Pyh8AkmOkF0+
         WiwQJI5idQK5fkyTGCwVufoBnwmGt7KlQPp5tN30TnnIWMa06iuZ+vD7675wPuL6WiR9
         SdX6XpsAr28Bz7UkrxejZzyAyp0aw0QtaXpSAgzyHNFWpf+p86+z4T0l1UZKxgLmdj+g
         txoQ==
Received: by 10.68.197.136 with SMTP id iu8mr26806475pbc.151.1345466662269;
        Mon, 20 Aug 2012 05:44:22 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id kt2sm11029887pbc.73.2012.08.20.05.44.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:44:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:38:22 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203819>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/replace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 4a8970e..e3aaf70 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -14,9 +14,9 @@
 #include "parse-options.h"
=20
 static const char * const git_replace_usage[] =3D {
-	"git replace [-f] <object> <replacement>",
-	"git replace -d <object>...",
-	"git replace -l [<pattern>]",
+	N_("git replace [-f] <object> <replacement>"),
+	N_("git replace -d <object>..."),
+	N_("git replace -l [<pattern>]"),
 	NULL
 };
=20
@@ -115,9 +115,9 @@ int cmd_replace(int argc, const char **argv, const =
char *prefix)
 {
 	int list =3D 0, delete =3D 0, force =3D 0;
 	struct option options[] =3D {
-		OPT_BOOLEAN('l', NULL, &list, "list replace refs"),
-		OPT_BOOLEAN('d', NULL, &delete, "delete replace refs"),
-		OPT_BOOLEAN('f', NULL, &force, "replace the ref if it exists"),
+		OPT_BOOLEAN('l', NULL, &list, N_("list replace refs")),
+		OPT_BOOLEAN('d', NULL, &delete, N_("delete replace refs")),
+		OPT_BOOLEAN('f', NULL, &force, N_("replace the ref if it exists")),
 		OPT_END()
 	};
=20
--=20
1.7.12.rc2.18.g61b472e

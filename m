From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 61/66] i18n: update-server-info: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:50 +0700
Message-ID: <1345465975-16927-62-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:45:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RMg-0001In-HG
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315Ab2HTMpt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:45:49 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753080Ab2HTMps (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:45:48 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pUwPWfGjv3bWvGCEZU/yExAtPEebRCGkfl9tq/w2vK0=;
        b=ZFJudD70brnpHBvoirtQMKzd6VTOF74xbBOm57F+h1d35w1zgn4IExLECBSSn8H+nj
         8fMc3kSoekrw8m5nIqdk/fMEPaFfWNCEqJrB73v3Uqbu/VQuA9gjEX1Dww7A14pMwx9w
         XXWKma/EqMKaefFp/6uSFUP3I61ro2azczBeZ6kNSfX2RHXkwLRafR6RJ++AagIZWo8l
         tXwqGCrAeIZBHtRCY/J62UKF5CXqMenY5ACd0S79587KzXtp7i/fxOu5hZ8TmbVGspG/
         m0B1uV1zgk9OPLjTmAW38YL3hm7kM5scJZG9zGgIFzvFyH+6lG+lJmOJIxBzHWQ6+ka2
         B4GA==
Received: by 10.68.212.161 with SMTP id nl1mr34530165pbc.84.1345466747739;
        Mon, 20 Aug 2012 05:45:47 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id wn1sm11037630pbc.57.2012.08.20.05.45.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:45:47 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:39:47 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203833>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-server-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/update-server-info.c b/builtin/update-server-info.=
c
index 0d63c44..6c8cc3e 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -3,7 +3,7 @@
 #include "parse-options.h"
=20
 static const char * const update_server_info_usage[] =3D {
-	"git update-server-info [--force]",
+	N_("git update-server-info [--force]"),
 	NULL
 };
=20
@@ -11,7 +11,7 @@ int cmd_update_server_info(int argc, const char **arg=
v, const char *prefix)
 {
 	int force =3D 0;
 	struct option options[] =3D {
-		OPT__FORCE(&force, "update the info files from scratch"),
+		OPT__FORCE(&force, N_("update the info files from scratch")),
 		OPT_END()
 	};
=20
--=20
1.7.12.rc2.18.g61b472e

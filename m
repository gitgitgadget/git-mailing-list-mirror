From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/65] i18n: bisect--helper: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:13:17 +0700
Message-ID: <1338203657-26486-3-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:19:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYxyV-0005m7-4J
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378Ab2E1LSz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:18:55 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48872 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab2E1LSy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:18:54 -0400
Received: by pbbrp8 with SMTP id rp8so4538023pbb.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3ykyJ2VYrPviKtKyATtXLO/IoZc92nMXLW2wXL0r9zc=;
        b=G8SbKQUl7DGtbXPgHsENGzoRPZEkuwiGOxAQM+OlXtnSjmUiNe5kQLOhw2xGczaZbY
         KyFXmX+yJ8v06lSHvtWBbOFJj7tHui6f0vTIyKeaInN4k14dXgkB0XUdpOLindG0b8EZ
         DNBgUIVT6XO4qgIJOvwwmBVowilzMeGz6dL7fOcp1c+GrqqgCCYS6DxtXQriVR95cBQH
         PUdNRAkBpksTbOArBwVVWRPYELJELTY2ZvfZGaKQ+Bq9oBDrdDrcrD8rnHVzimC/Mh8S
         tk6ziIg+2ovr2hQfAze7Z1yjh052PCuC1jB+mtlNk7E2TpFoVJH/4gIzpHtKn7w2g2y4
         pMIw==
Received: by 10.68.201.136 with SMTP id ka8mr1485557pbc.124.1338203934032;
        Mon, 28 May 2012 04:18:54 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id uz7sm18993587pbc.35.2012.05.28.04.18.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:18:53 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:14:48 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198641>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/bisect--helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 8d325a5..e3884e3 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -4,7 +4,7 @@
 #include "bisect.h"
=20
 static const char * const git_bisect_helper_usage[] =3D {
-	"git bisect--helper --next-all [--no-checkout]",
+	N_("git bisect--helper --next-all [--no-checkout]"),
 	NULL
 };
=20
@@ -14,9 +14,9 @@ int cmd_bisect__helper(int argc, const char **argv, c=
onst char *prefix)
 	int no_checkout =3D 0;
 	struct option options[] =3D {
 		OPT_BOOLEAN(0, "next-all", &next_all,
-			    "perform 'git bisect next'"),
+			    N_("perform 'git bisect next'")),
 		OPT_BOOLEAN(0, "no-checkout", &no_checkout,
-			    "update BISECT_HEAD instead of checking out the current commit"=
),
+			    N_("update BISECT_HEAD instead of checking out the current comm=
it")),
 		OPT_END()
 	};
=20
--=20
1.7.10.2.549.g9354186

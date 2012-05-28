From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 62/65] i18n: update-server-info: mark parseopt strings for translation
Date: Mon, 28 May 2012 18:14:14 +0700
Message-ID: <1338203657-26486-60-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon May 28 13:27:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYy6a-0007bQ-O4
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 13:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754536Ab2E1L1S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 07:27:18 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36112 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908Ab2E1L1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2012 07:27:16 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so4038533dad.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 04:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=m/EjYryEmx4E3n7moPnFtzpHGmNZDoF3M6kpi2FueL8=;
        b=ogN2y920bkLtSSKz3cDgrw/Cb2+ceL6KcDHcpq1cJO9RtbnkFnWSKa8HK9b//jOmc0
         zYz/AmDG2n6IJT78z9z9dvR86CY4NiVnp6CrjSvA99D/njC4IxmdjQDgfEK2ooxTxQJj
         bn4tFpAugiUmHl0ZpleB81IJZRy1thBOuiALzrlW7ZFRj6gt1xFozswFEywrten64Mh7
         M86s2TNMxbWEATWWuaVcVXFtSfg3tSNhByGc23FEdtZHh8jHuIfLuFW35DLm13pmipFb
         +rIbXiUggGklN9LpCTJDdDYPbPLmPwc/7GeGAiLDUgpOQRb6rUNChmuAKBojmNd3aQwC
         n7hw==
Received: by 10.68.223.129 with SMTP id qu1mr26078796pbc.165.1338204436693;
        Mon, 28 May 2012 04:27:16 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.41.88])
        by mx.google.com with ESMTPS id gk8sm19027094pbc.16.2012.05.28.04.27.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 May 2012 04:27:15 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 28 May 2012 18:23:11 +0700
X-Mailer: git-send-email 1.7.10.2.549.g9354186
In-Reply-To: <1338203657-26486-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198697>

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
1.7.10.2.549.g9354186

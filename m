From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 60/66] i18n: update-ref: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:49 +0700
Message-ID: <1345465975-16927-61-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:45:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RMa-0001E6-Pn
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070Ab2HTMpn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:45:43 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45598 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab2HTMpl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:45:41 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2157219dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2GTnIarf9I+0gAstEOJDLC3l9s5G3xkYz93Jo+tnrC4=;
        b=OeldcjxaLcJDAIH0+q5TvPke+yCEUIXAnDddyW1sYC+aENDQb6fGBX65qUi6OLfL7o
         ZXu1bAXJDUuh4xanEGPMK/bqcP3+2uOsN6TGUiP2gsmUTFhvGGTqwLKXa3Ze0zLfWSXr
         rnw5FvdcqeA/tvJJ86mBwbAAnZjdTPw/q/eGfaCqNRN67XjdTDNMu2cO8uRlsGwylO4l
         zgTyaYQE2WHU8Hss4FLFfDj/LZwtrzFQHBo689/7ticbTKTnCwyyb1QGqnzb9GZoN3e7
         LSn27vQ/CAQ0hkbYJVRcDOD0Twt1rnt4FBCUTEd2ySx0eHNK2ugvg6L4lR5dlYpUzAPZ
         JVpA==
Received: by 10.66.89.6 with SMTP id bk6mr29271921pab.81.1345466741724;
        Mon, 20 Aug 2012 05:45:41 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id ns9sm4636926pbb.13.2012.08.20.05.45.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:45:41 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:39:41 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203832>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 835c62a..b30394f 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -4,8 +4,8 @@
 #include "parse-options.h"
=20
 static const char * const git_update_ref_usage[] =3D {
-	"git update-ref [options] -d <refname> [<oldval>]",
-	"git update-ref [options]    <refname> <newval> [<oldval>]",
+	N_("git update-ref [options] -d <refname> [<oldval>]"),
+	N_("git update-ref [options]    <refname> <newval> [<oldval>]"),
 	NULL
 };
=20
@@ -15,10 +15,10 @@ int cmd_update_ref(int argc, const char **argv, con=
st char *prefix)
 	unsigned char sha1[20], oldsha1[20];
 	int delete =3D 0, no_deref =3D 0, flags =3D 0;
 	struct option options[] =3D {
-		OPT_STRING( 'm', NULL, &msg, "reason", "reason of the update"),
-		OPT_BOOLEAN('d', NULL, &delete, "deletes the reference"),
+		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update"=
)),
+		OPT_BOOLEAN('d', NULL, &delete, N_("deletes the reference")),
 		OPT_BOOLEAN( 0 , "no-deref", &no_deref,
-					"update <refname> not the one it points to"),
+					N_("update <refname> not the one it points to")),
 		OPT_END(),
 	};
=20
--=20
1.7.12.rc2.18.g61b472e

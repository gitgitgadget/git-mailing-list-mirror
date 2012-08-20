From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/66] i18n: count-objects: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:06 +0700
Message-ID: <1345465975-16927-18-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:40:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RHp-0006EX-EL
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755086Ab2HTMks convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:40:48 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46092 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755067Ab2HTMkr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:40:47 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2154786dad.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=95cufJzCYODNAmPjFTSr/gQMB9X8le6FDRUESVUkz58=;
        b=IMBbkjpSaRHY8mn8SEE7P2IW98CzjUIeOdN4akwYd9fLH3iZ0eFZ3SsxnffDrgX46Q
         VPEyzxg5ehkKsXR7tKpAuk4RDiG7qc2KzwluDISMqQujvucCPSNO/fQRmJ4vho5bFXYS
         SdibDfgT6nI/OL3/kAqDz9atnU7VoQI5/6TOXFvBkAGWhVQLVgCSHr1cUa5zT0gnV93N
         iy5KGSA4au25wdRNNYBZztdEJOgyV1iWD4Hd/5MhT+1XAep4bPYENOQRBPWuSWaKqEdX
         coSRMQuNq3m4pOn/aQnJiTKWfD0Rb7PQLZ68y9XEDNHwKddHGf5obW7Lc+x09Ug58DY4
         5DIQ==
Received: by 10.66.73.69 with SMTP id j5mr29591699pav.8.1345466446847;
        Mon, 20 Aug 2012 05:40:46 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id tv6sm11042146pbc.24.2012.08.20.05.40.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:40:46 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:34:46 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203788>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/count-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index c37cb98..9afaa88 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -66,7 +66,7 @@ static void count_objects(DIR *d, char *path, int len=
, int verbose,
 }
=20
 static char const * const count_objects_usage[] =3D {
-	"git count-objects [-v]",
+	N_("git count-objects [-v]"),
 	NULL
 };
=20
@@ -79,7 +79,7 @@ int cmd_count_objects(int argc, const char **argv, co=
nst char *prefix)
 	unsigned long loose =3D 0, packed =3D 0, packed_loose =3D 0, garbage =
=3D 0;
 	off_t loose_size =3D 0;
 	struct option opts[] =3D {
-		OPT__VERBOSE(&verbose, "be verbose"),
+		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_END(),
 	};
=20
--=20
1.7.12.rc2.18.g61b472e

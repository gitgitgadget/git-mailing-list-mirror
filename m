From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 37/66] i18n: mv: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:26 +0700
Message-ID: <1345465975-16927-38-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:43:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RKE-0007rh-34
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755373Ab2HTMnQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:43:16 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441Ab2HTMnP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:43:15 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=13MXEQkd2cEhaTPV1k07SAn5PVlnu1M2HrLOVNjWZkQ=;
        b=t+xYOAf3xPEAGOXWG/+QowIbGvzgeWR9wmnbEPG+T293tmBUCm+/VJk7BVpHx4+yrz
         g3d6qD5mNizRPZt/OnXpcw781UPs8xV0n+edm7gbV8fSXHavvRUJMGcMIRIPriAHo2u0
         Z5auzaMh7ghERIA+Nym8E9zqKoaUIEhpi+jTM1n0d+qklwr2CA2VfK/LmeBzYCDkaW+n
         CNVp1CbR9cp1QeUJF3a36a39taqnkZFaTAS+1uLBlEn3I7c7Fy3M8KXzsn/SCq/XJE12
         POQ5yZ89p6cDi85KDNLLn9kFtl5kJATLh1kOozh6KGzKWDNvVRHnhpZOwQ4PUv1YFp0g
         IeKg==
Received: by 10.68.224.70 with SMTP id ra6mr34153714pbc.11.1345466594875;
        Mon, 20 Aug 2012 05:43:14 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id pj8sm11028115pbb.60.2012.08.20.05.43.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:43:14 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:37:14 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203809>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 2a144b0..034fec9 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -11,7 +11,7 @@
 #include "parse-options.h"
=20
 static const char * const builtin_mv_usage[] =3D {
-	"git mv [options] <source>... <destination>",
+	N_("git mv [options] <source>... <destination>"),
 	NULL
 };
=20
@@ -59,10 +59,10 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 	int i, newfd;
 	int verbose =3D 0, show_only =3D 0, force =3D 0, ignore_errors =3D 0;
 	struct option builtin_mv_options[] =3D {
-		OPT__VERBOSE(&verbose, "be verbose"),
-		OPT__DRY_RUN(&show_only, "dry run"),
-		OPT__FORCE(&force, "force move/rename even if target exists"),
-		OPT_BOOLEAN('k', NULL, &ignore_errors, "skip move/rename errors"),
+		OPT__VERBOSE(&verbose, N_("be verbose")),
+		OPT__DRY_RUN(&show_only, N_("dry run")),
+		OPT__FORCE(&force, N_("force move/rename even if target exists")),
+		OPT_BOOLEAN('k', NULL, &ignore_errors, N_("skip move/rename errors")=
),
 		OPT_END(),
 	};
 	const char **source, **destination, **dest_path;
--=20
1.7.12.rc2.18.g61b472e

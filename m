From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 57/66] i18n: symbolic-ref: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:46 +0700
Message-ID: <1345465975-16927-58-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:45:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RMJ-00010q-C4
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169Ab2HTMp0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:45:26 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab2HTMpX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:45:23 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2LHe5mArwO9nPU9SP1EQqDe1cvwphny3A4/PrqC8Ovo=;
        b=xcBwRuVGKRKVX5E6F8/v1yuCWpSMpRH7uR/qdQjMxenxAzaI80WWytBHR2TTFy6zCv
         MY/dtYEY91eTp03xFZy8FhLHrsLOEhAxKy2SZc50Z+eBIS1EuQyNbzMNz+N/oul4jDA3
         AVD9YrfdEoHvpuIxqG6+RyBIcim+uI/LuAFVBFrkBimVdYQoAaNePEjiNpY4Zgc/Rygz
         dVP67/cLIYUYY3lLWsYnw2nmyImOCb8d+DK9JVD6iFpCLDOuPURGswTJG67h6OSNoaFj
         teOGwuuM33izcYVaPecGcrjXfVN+H2bsmTB95u4GlZxDvHF7acVsfL8Zua01ucFcmnN4
         gp1g==
Received: by 10.66.89.234 with SMTP id br10mr29409515pab.25.1345466723465;
        Mon, 20 Aug 2012 05:45:23 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id oj8sm11035387pbb.54.2012.08.20.05.45.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:45:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:39:23 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203829>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/symbolic-ref.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 801d62e..9e92828 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -4,7 +4,7 @@
 #include "parse-options.h"
=20
 static const char * const git_symbolic_ref_usage[] =3D {
-	"git symbolic-ref [options] name [ref]",
+	N_("git symbolic-ref [options] name [ref]"),
 	NULL
 };
=20
@@ -35,9 +35,9 @@ int cmd_symbolic_ref(int argc, const char **argv, con=
st char *prefix)
 	const char *msg =3D NULL;
 	struct option options[] =3D {
 		OPT__QUIET(&quiet,
-			"suppress error message for non-symbolic (detached) refs"),
-		OPT_BOOL(0, "short", &shorten, "shorten ref output"),
-		OPT_STRING('m', NULL, &msg, "reason", "reason of the update"),
+			N_("suppress error message for non-symbolic (detached) refs")),
+		OPT_BOOL(0, "short", &shorten, N_("shorten ref output")),
+		OPT_STRING('m', NULL, &msg, N_("reason"), N_("reason of the update")=
),
 		OPT_END(),
 	};
=20
--=20
1.7.12.rc2.18.g61b472e

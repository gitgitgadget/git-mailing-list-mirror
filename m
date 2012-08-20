From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 11/66] i18n: cherry: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:00 +0700
Message-ID: <1345465975-16927-12-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:40:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RHF-0005nX-UZ
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852Ab2HTMkM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:40:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58663 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab2HTMkK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:40:10 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6883151pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=CHfegBMbZfsV6mp2m+jMvdCI5nxSHkE8kg8Omb1xWJs=;
        b=R+yiigIL4iJZ50wv16xU0UDPkV1VVczbRNeZ6J0vw35e5On3cmCgkN0nEwegDJOLcN
         kT1Yw9THocMGMzkhOy42DJ7f9Iwu2f38OXqBcX1INKwQtgHSEn15BzaQg2VTF2g7p2E1
         u6Bl6VLgETnyvOyqzXQFdZSIOE60fLI5iASWLY4+V+w2oKat1kpOodQmIs3VW7ZCRvpT
         a628WU4jv3IX4thDC7EdOPBCV1fw9bzlqZGr5IHwG7tx83Qu9hF9/oOZLG+dywkTt0Ak
         PgTd7pj2j20RWUO9yuZ+RcIJts3osjkUPcS9LwWhbLeuyGTicJx+//HC9FejeUSlwW7Y
         OmVQ==
Received: by 10.68.193.162 with SMTP id hp2mr34111818pbc.34.1345466409873;
        Mon, 20 Aug 2012 05:40:09 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id qn13sm11024521pbb.71.2012.08.20.05.40.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:40:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:34:09 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203783>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ecc2793..dcd3e13 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1443,7 +1443,7 @@ static int add_pending_commit(const char *arg, st=
ruct rev_info *revs, int flags)
 }
=20
 static const char * const cherry_usage[] =3D {
-	"git cherry [-v] [<upstream> [<head> [<limit>]]]",
+	N_("git cherry [-v] [<upstream> [<head> [<limit>]]]"),
 	NULL
 };
=20
@@ -1477,7 +1477,7 @@ int cmd_cherry(int argc, const char **argv, const=
 char *prefix)
=20
 	struct option options[] =3D {
 		OPT__ABBREV(&abbrev),
-		OPT__VERBOSE(&verbose, "be verbose"),
+		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_END()
 	};
=20
--=20
1.7.12.rc2.18.g61b472e

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 30/66] i18n: log: mark parseopt strings for translation
Date: Mon, 20 Aug 2012 19:32:19 +0700
Message-ID: <1345465975-16927-31-git-send-email-pclouds@gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Aug 20 14:42:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3RJX-0007OK-Sn
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 14:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261Ab2HTMme convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Aug 2012 08:42:34 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:50850 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231Ab2HTMmc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 08:42:32 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so6886118pbb.19
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 05:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=BywGefdHryiAQUbpPSCLAh/k+7CAflaQxnGsWNbchMw=;
        b=hIFtg9fBEgexCkubj65JuaIkSwJ4RASJDCKnr/7C0NhKbfXo0JxBxrzsGJqBxJ8bRS
         QSok5eCNDpsZAPa8nJY8n6bLkMyBHb+I74SW5J6nNk8FrhDANgi4qNgPRDx02RYzKXuc
         1R1vk3quQAisn+JPQjdj3tu4OSb6p7+72l8AAwRqCyGZXq+YvRCJbW2QotqXoUyVE+cx
         KmcMuWzUOJYe9kuudr6EFdq39SlP4XiSb4fUlbx2RIeZOxQfC0wpgcWsJuHundxWSfdc
         +SUw13b6Wtujj8usSFrHdWCwAnjmIejRcDCARrsjXaVBXGIHKt5EBGANnHPb4ko4KtcW
         3e+w==
Received: by 10.68.219.226 with SMTP id pr2mr34160469pbc.1.1345466552323;
        Mon, 20 Aug 2012 05:42:32 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.247])
        by mx.google.com with ESMTPS id vd4sm11040649pbc.41.2012.08.20.05.42.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 05:42:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 20 Aug 2012 19:36:32 +0700
X-Mailer: git-send-email 1.7.12.rc2.18.g61b472e
In-Reply-To: <1345465975-16927-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203802>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/log.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ba59110..1ff2d8d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -34,8 +34,8 @@ static const char *fmt_patch_subject_prefix =3D "PATC=
H";
 static const char *fmt_pretty;
=20
 static const char * const builtin_log_usage[] =3D {
-	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
-	"   or: git show [options] <object>...",
+	N_("git log [<options>] [<since>..<until>] [[--] <path>...]\n")
+	N_("   or: git show [options] <object>..."),
 	NULL
 };
=20
@@ -97,9 +97,9 @@ static void cmd_log_init_finish(int argc, const char =
**argv, const char *prefix,
 	int quiet =3D 0, source =3D 0;
=20
 	const struct option builtin_log_options[] =3D {
-		OPT_BOOLEAN(0, "quiet", &quiet, "suppress diff output"),
-		OPT_BOOLEAN(0, "source", &source, "show source"),
-		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, "decorate options",
+		OPT_BOOLEAN(0, "quiet", &quiet, N_("suppress diff output")),
+		OPT_BOOLEAN(0, "source", &source, N_("show source")),
+		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options")=
,
 		  PARSE_OPT_OPTARG, decorate_callback},
 		OPT_END()
 	};
--=20
1.7.12.rc2.18.g61b472e

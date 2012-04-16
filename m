From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH i18n 04/11] i18n: help: mark parseopt strings for translation
Date: Mon, 16 Apr 2012 19:49:56 +0700
Message-ID: <1334580603-11577-5-git-send-email-pclouds@gmail.com>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 14:51:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJlPC-0006ml-BW
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 14:51:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753894Ab2DPMvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 08:51:38 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:33059 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab2DPMvh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 08:51:37 -0400
Received: by mail-pz0-f52.google.com with SMTP id e40so6880805dak.11
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IyLxLkHbzrCY96qNL1/8uPFzKfGeAvpW6AZSYi5bWWk=;
        b=VltE0JH4YT46rlGAEPC2/M7uYBKtRdCsr37HKsdbAM8pyYLWErN3FGXFhMMBQCRtNi
         O5dOWamm9r/fGinIf+UMp2R4c/iYGG+ZrgBvQYmIm71tYJEnkDsnAc08O8Z9Plvp79vg
         JSHsrYDz4yeEpayornZZNZZOY8T+ZuFXFo4wlOruXOODRH6eFk/AGcDr2NhHvaBYfihu
         0neivpTi8asz68FYCBQiBsQ8IwgSYoHBRyCUB7oeRy5FLslij5neQW7hAw17y/GrcNlR
         31iXb+lOBurd/nez+7zPeQ9PdJU1Z82aBd5CXsIw6stn8+ig+DtiMAp0amVVsR2QNgbb
         Y3ZQ==
Received: by 10.68.204.228 with SMTP id lb4mr27588776pbc.37.1334580697074;
        Mon, 16 Apr 2012 05:51:37 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id k9sm17623687pbf.65.2012.04.16.05.51.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 05:51:36 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 16 Apr 2012 19:50:46 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195627>

---
 builtin/help.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 61ff798..22756bd 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -32,17 +32,17 @@ enum help_format {
 static int show_all = 0;
 static enum help_format help_format = HELP_FORMAT_NONE;
 static struct option builtin_help_options[] = {
-	OPT_BOOLEAN('a', "all", &show_all, "print all available commands"),
-	OPT_SET_INT('m', "man", &help_format, "show man page", HELP_FORMAT_MAN),
-	OPT_SET_INT('w', "web", &help_format, "show manual in web browser",
+	OPT_BOOLEAN('a', "all", &show_all, N_("print all available commands")),
+	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
+	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
 			HELP_FORMAT_WEB),
-	OPT_SET_INT('i', "info", &help_format, "show info page",
+	OPT_SET_INT('i', "info", &help_format, N_("show info page"),
 			HELP_FORMAT_INFO),
 	OPT_END(),
 };
 
 static const char * const builtin_help_usage[] = {
-	"git help [--all] [--man|--web|--info] [command]",
+	N_("git help [--all] [--man|--web|--info] [command]"),
 	NULL
 };
 
-- 
1.7.3.1.256.g2539c.dirty

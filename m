From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/5] i18n: help: mark parseopt strings for translation
Date: Thu,  8 Mar 2012 16:16:37 +0700
Message-ID: <1331198198-22409-5-git-send-email-pclouds@gmail.com>
References: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 10:17:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5ZTt-0000Ji-Uj
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 10:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647Ab2CHJRw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 04:17:52 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54679 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755148Ab2CHJRt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 04:17:49 -0500
Received: by mail-pz0-f46.google.com with SMTP id r28so259341daj.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 01:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=90E/kAZv5lXcE3sVbCAbxirETgOIWyfxAmWmez8adrQ=;
        b=0jZfxEqCBeFMH8nN1s0aKnxqHoPuMBjS4/Aan3w4jAQewKROdzw9larxBaBdnOY/V2
         2lb5EjONpo+0iUwiFalaZIBX5dhoKjOd3LumEW3ZVjN55eFBruqfyizG9Woy1F/WMCtj
         v+uVTTOSEUJw+4+E/75rYyVm9Chtx8JqzILzA3fRVeu3cywOdRAIgdHT6E1v7BWGnhnP
         HCfg1AaMSjjRM5AVh5P41Ap341mU2opxm5xWHYnObw8yMt+jEwhvlJU+m/hbwsurInld
         13JYlYAT0H53pEbtcBrf9ttyUFWS4ZHIsJmPq8ZMdfLwvW6J9utGtfgsgkjKh4sb9iXD
         P4/g==
Received: by 10.68.234.131 with SMTP id ue3mr8456305pbc.5.1331198268963;
        Thu, 08 Mar 2012 01:17:48 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id u7sm2302975pbm.49.2012.03.08.01.17.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 01:17:47 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 08 Mar 2012 16:17:18 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192544>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 A demonstration of the previous patch.

 builtin/help.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index 61ff798..22756bd 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -32,17 +32,17 @@ enum help_format {
 static int show_all =3D 0;
 static enum help_format help_format =3D HELP_FORMAT_NONE;
 static struct option builtin_help_options[] =3D {
-	OPT_BOOLEAN('a', "all", &show_all, "print all available commands"),
-	OPT_SET_INT('m', "man", &help_format, "show man page", HELP_FORMAT_MA=
N),
-	OPT_SET_INT('w', "web", &help_format, "show manual in web browser",
+	OPT_BOOLEAN('a', "all", &show_all, N_("print all available commands")=
),
+	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMA=
T_MAN),
+	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"=
),
 			HELP_FORMAT_WEB),
-	OPT_SET_INT('i', "info", &help_format, "show info page",
+	OPT_SET_INT('i', "info", &help_format, N_("show info page"),
 			HELP_FORMAT_INFO),
 	OPT_END(),
 };
=20
 static const char * const builtin_help_usage[] =3D {
-	"git help [--all] [--man|--web|--info] [command]",
+	N_("git help [--all] [--man|--web|--info] [command]"),
 	NULL
 };
=20
--=20
1.7.3.1.256.g2539c.dirty

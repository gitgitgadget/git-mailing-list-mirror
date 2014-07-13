From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v7 26/31] gc: style change -- no SP before closing bracket
Date: Sun, 13 Jul 2014 11:51:03 +0700
Message-ID: <1405227068-25506-27-git-send-email-pclouds@gmail.com>
References: <1404891197-18067-1-git-send-email-pclouds@gmail.com>
 <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 06:55:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6Bp2-0001aA-Mr
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 06:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbaGMEzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jul 2014 00:55:32 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:62734 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbaGMEzb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 00:55:31 -0400
Received: by mail-pd0-f179.google.com with SMTP id w10so3498901pde.10
        for <git@vger.kernel.org>; Sat, 12 Jul 2014 21:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=yaSsuoYZOl8DboaExyGNpfcliGQ5Ep58J2BL+ejY8Mo=;
        b=EokRNyeiiK3PRz1ewudZTKxO5LrKM587DTM8lkacGHxcStY+Dz7c+iSA51VXU+LpWV
         rHj7Xkv7OCut3zRqCfb8DfJy9TAQ45din1pm4ag/tZd4+AFofUTTpG0oRjHrSdpqyLI6
         Lv184PQrvvfWuaHyg2FWYh2CcBNL8u8jRbuiqNmkruf9JbqJDAsqZdRu2zyB5yXeXFxR
         k+y2fUr+slY5R2U/679zQhIk1KiVlVO6zgJ7FvfOY9T+Y5lTet+3bViYG8QEH72jKGP6
         uQcZBoGt8FpPsWAtkmY7JO14sYofwqILeFvhE2eS2wfd6DqB6ZGLyYqNK7XPE+LkCsHN
         79yA==
X-Received: by 10.70.34.6 with SMTP id v6mr8836768pdi.29.1405227330743;
        Sat, 12 Jul 2014 21:55:30 -0700 (PDT)
Received: from lanh ([115.73.227.1])
        by mx.google.com with ESMTPSA id fd5sm29019367pad.12.2014.07.12.21.55.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jul 2014 21:55:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 13 Jul 2014 11:55:30 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1405227068-25506-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253429>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8d219d8..3bfb990 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -298,7 +298,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	argv_array_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NUL=
L);
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
-	argv_array_pushl(&prune, "prune", "--expire", NULL );
+	argv_array_pushl(&prune, "prune", "--expire", NULL);
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
=20
 	git_config(gc_config, NULL);
--=20
1.9.1.346.ga2b5940

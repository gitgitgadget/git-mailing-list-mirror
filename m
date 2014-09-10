From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 26/32] gc: style change -- no SP before closing parenthesis
Date: Thu, 11 Sep 2014 05:42:02 +0700
Message-ID: <1410388928-32265-27-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
 <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 00:44:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRqcp-0002Px-6K
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 00:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbaIJWo1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Sep 2014 18:44:27 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:34813 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbaIJWo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 18:44:26 -0400
Received: by mail-pd0-f181.google.com with SMTP id w10so7185366pde.40
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 15:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oXo8CkRlOYHcReFngBVtDqAu5HF9ywAz+MD/WE1cPBc=;
        b=T1z2ukZR/3eFAlRpA2JHkI8T6+U1b4zm3R+yyLLfERNfLcJafk3vPmGvvvwD2p0Sno
         nm83kGbzFltxSu0fbKvPD8X6BY3YV9lGy0vrDtnIdJ4usLgrSTBfK4tjS3USUy0WBLO3
         gfDu/25HVBb9oOYtlQC6epPccrbJ7WwFMl/O7GtNoHU1mZ0PDWtLRFq5H4ybAhv61lYD
         waZVHSxvaYDHEpPFASU/QFCrd7TOcY6wrxL0ItKdjVuy3QXrFV+YuXDs9VaAAXf2X+Ky
         PcMnoetcCBJ6yXe3vI5Qo7TZkRnK6QO8Lec+YtE2jjxVYYukNJqcJCXVI7TkDrJh2PFC
         uDaw==
X-Received: by 10.68.201.138 with SMTP id ka10mr42828963pbc.23.1410389066386;
        Wed, 10 Sep 2014 15:44:26 -0700 (PDT)
Received: from lanh ([115.73.197.210])
        by mx.google.com with ESMTPSA id fk10sm16348536pab.29.2014.09.10.15.44.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Sep 2014 15:44:25 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 11 Sep 2014 05:44:46 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1410388928-32265-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256803>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.1.0.rc0.78.gc0d8480

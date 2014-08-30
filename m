From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 26/32] gc: style change -- no SP before closing parenthesis
Date: Sat, 30 Aug 2014 15:33:56 +0700
Message-ID: <1409387642-24492-27-git-send-email-pclouds@gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 10:36:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNe8y-00037H-9h
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 10:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbaH3IgP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 04:36:15 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:47155 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbaH3IgN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2014 04:36:13 -0400
Received: by mail-pd0-f176.google.com with SMTP id g10so2061009pdj.21
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=oXo8CkRlOYHcReFngBVtDqAu5HF9ywAz+MD/WE1cPBc=;
        b=QGHKpXVMChGk0mDF6rfCXf+mcnhLbX+0KwesbeibD2VrKf/m+pwVzG8qyxz8Sq3S/+
         6cmwCzxcEVr6nbITV572VvSLJnGQB4n3MEhi31gF2aNT+IxaXMuVQEAvW9u42Cdwmiqw
         +avJTuiQuoRjllmknbQAD5hZSzcTy/HWXa6VhfYGHxhZ9zvz3FoHqYAGM2TOODidF/m7
         18D2qTGci6BjC8r8m8jHv5iFx99j0IW1HOcsYaP7YDc47h5VSBhGPTSLbVDqdcxkXvG2
         PgbOJpa0aNUaWjTrfkpsPa1OkSMwq0iS4UmwJuSTV3UKFzpAep/vXUZbZON9q1RA5HWf
         QEsw==
X-Received: by 10.66.165.34 with SMTP id yv2mr22149868pab.27.1409387773068;
        Sat, 30 Aug 2014 01:36:13 -0700 (PDT)
Received: from lanh ([115.73.195.142])
        by mx.google.com with ESMTPSA id fk5sm2137851pbb.13.2014.08.30.01.36.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Aug 2014 01:36:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 30 Aug 2014 15:36:22 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1409387642-24492-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256235>

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

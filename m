From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 26/34] gc: style change -- no SP before closing parenthesis
Date: Sun, 30 Nov 2014 15:24:51 +0700
Message-ID: <1417335899-27307-27-git-send-email-pclouds@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 09:29:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xuzt4-0000Og-1N
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 09:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbaK3I3m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 03:29:42 -0500
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36300 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbaK3I3l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 03:29:41 -0500
Received: by mail-pd0-f174.google.com with SMTP id w10so8899687pde.5
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 00:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=DG1Y57vtV22p23yFRmgN5bgTb8DAgO2ql//dBBM66CU=;
        b=e6HowsZn4XMdH0yq9jJEyb5mxOGTbDUiL982flgrYjuCoiIL8tXsbIRd6KqGW9NhNa
         2zDWN7b9KWRJrNWrbzdHk8HbTcrAIC/uEQgRVaKc+cObiQOykygP8YOqpZ9sHz/9azhu
         npChR+gtqfpfKp/AfCLBqlPg7BUOASuqfW23OznsyeuavIxiqojdgnJYkaGMHe4PxyCp
         J0e7Eu0CqjSh4rHGY8hqdCMwmmyaJhm/shoCzPTbwD2GJajBAPq6cPwlQM9++74RbR9i
         UZvhwEavOul/cmVALFUq0G0VXb/ISVf8d0gVluSf2M2xYNoi4H7fjHcZLV3R2P9n7rvw
         yf3Q==
X-Received: by 10.68.190.42 with SMTP id gn10mr88815439pbc.69.1417336181234;
        Sun, 30 Nov 2014 00:29:41 -0800 (PST)
Received: from lanh ([115.73.247.22])
        by mx.google.com with ESMTPSA id oz7sm853804pbb.14.2014.11.30.00.29.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 00:29:40 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 30 Nov 2014 15:29:39 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1417335899-27307-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260413>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 005adbe..0e65eff 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -287,7 +287,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 	argv_array_pushl(&pack_refs_cmd, "pack-refs", "--all", "--prune", NUL=
L);
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
-	argv_array_pushl(&prune, "prune", "--expire", NULL );
+	argv_array_pushl(&prune, "prune", "--expire", NULL);
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
=20
 	gc_config();
--=20
2.1.0.rc0.78.gc0d8480

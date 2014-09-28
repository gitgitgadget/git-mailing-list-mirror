From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 26/32] gc: style change -- no SP before closing parenthesis
Date: Sun, 28 Sep 2014 08:22:40 +0700
Message-ID: <1411867366-3821-27-git-send-email-pclouds@gmail.com>
References: <xmqqk34r9z3r.fsf@gitster.dls.corp.google.com>
 <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 03:25:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XY3Ep-0002lV-A5
	for gcvg-git-2@plane.gmane.org; Sun, 28 Sep 2014 03:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbaI1BZO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Sep 2014 21:25:14 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:53629 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaI1BZN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2014 21:25:13 -0400
Received: by mail-pa0-f54.google.com with SMTP id ey11so3724428pad.41
        for <git@vger.kernel.org>; Sat, 27 Sep 2014 18:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=s01RQSeNKGn84EH2RW36evXqMWiqs7DegsIOqIH1GiQ=;
        b=eLvzYOPnbcHnxf1faUp/cCo+d/wNhhDBAKdhsYIJS5sK71kv1PJhg6jGJCedjAPfVj
         WDe/+3iZk6qQdqLEvKI+6qiGA2XNe7F/dBmTlv4POnpljWFgZBtgJwNFVEGJIROWfOSZ
         n1T8lVJHqF2CzAfQg1lmkFVHlrFSetft+P+RdA54mxZtJRded8FgvXniivVgCd97+UNH
         0XgSZhyVxsJc0VEB/UfLU6ft9DUb5cz5KukRnzgAJcM7eMHgtTGTQyZbt0qpXkKUr84f
         abEKX24ONPhA3i6XW0BXGyZNWNilJMNCaNVYmkvWwiKhc6gry016R0TAdrnQiq0yenww
         yqUA==
X-Received: by 10.68.57.226 with SMTP id l2mr390517pbq.147.1411867512873;
        Sat, 27 Sep 2014 18:25:12 -0700 (PDT)
Received: from lanh ([115.73.212.224])
        by mx.google.com with ESMTPSA id ei1sm8525437pbd.46.2014.09.27.18.25.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Sep 2014 18:25:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 28 Sep 2014 08:25:15 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1411867366-3821-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257585>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index ced1456..b690929 100644
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

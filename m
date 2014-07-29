From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/8] gitrepository-layout.txt: s/ignored/ignored if/
Date: Tue, 29 Jul 2014 20:50:24 +0700
Message-ID: <1406641831-2390-2-git-send-email-pclouds@gmail.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
 <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git@drmicha.warpmail.net,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 15:52:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC7pZ-0005ZU-DM
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 15:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753704AbaG2Nwg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 09:52:36 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:49837 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbaG2Nwf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 09:52:35 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so12254424pad.8
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 06:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KYRd+fdqNFaDFVaQ5hlKrG6Nk/ufEnm61XAFSudss6A=;
        b=csxAOv/7DRsjYuWsaWhxRbrvBgyknRDznO9mEY46vcc6VpWS6+nxHVoS09vkaNOehP
         DyxCZXsx5VHczI5bTDtA8MAfBHOkpWZQSYag0bgRCQU1v1A12JTMA404O9fCFVFEJ075
         p6MOojeRlbXrFkcmWQyg5fCsr5hvA+z3DbxHkDNhBeYXEbKWwcWEEAztXu19j66hVgCb
         9IZ4Myg6++fDMkxMpSaZK5R6jYrbJThQuFg4HjQHvg/e0a3UoIljjinHsZIBnv/p5hng
         LFrVKf3gKNkesW93L0e/qsDWw7X/YsaP0F/y4fdUfgHhQi27gl2ZjSEgxpH9DM5TX7E8
         x/YA==
X-Received: by 10.70.138.45 with SMTP id qn13mr2329347pdb.20.1406641955006;
        Tue, 29 Jul 2014 06:52:35 -0700 (PDT)
Received: from lanh ([115.73.243.195])
        by mx.google.com with ESMTPSA id or10sm29069029pdb.26.2014.07.29.06.52.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jul 2014 06:52:34 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 29 Jul 2014 20:52:37 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1406641831-2390-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254435>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/gitrepository-layout.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/git=
repository-layout.txt
index bed4f1a..6bd82af 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -139,7 +139,7 @@ is often called 'detached HEAD.'  See linkgit:git-c=
heckout[1]
 for details.
=20
 config::
-	Repository specific configuration file. This file is ignored
+	Repository specific configuration file. This file is ignored if
 	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/config" will be
 	used instead.
=20
@@ -220,7 +220,7 @@ remotes::
 logs::
 	Records of changes made to refs are stored in this
 	directory.  See linkgit:git-update-ref[1]
-	for more information. This directory is ignored
+	for more information. This directory is ignored if
 	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/logs" will be used
 	instead.
=20
@@ -252,7 +252,7 @@ modules::
 repos::
 	Contains worktree specific information of linked
 	checkouts. Each subdirectory contains the worktree-related
-	part of a linked checkout. This directory is ignored
+	part of a linked checkout. This directory is ignored if
 	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/repos" will be
 	used instead.
=20
--=20
2.1.0.rc0.78.gc0d8480

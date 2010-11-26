From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 47/47] git.txt: correct where --work-tree path is relative to
Date: Fri, 26 Nov 2010 22:32:43 +0700
Message-ID: <1290785563-15339-48-git-send-email-pclouds@gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 16:52:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM0ab-0002TE-Rh
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 16:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755403Ab0KZPvo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 10:51:44 -0500
Received: from mail-pz0-f66.google.com ([209.85.210.66]:53985 "EHLO
	mail-pz0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381Ab0KZPvn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 10:51:43 -0500
Received: by mail-pz0-f66.google.com with SMTP id 26so458657pzk.1
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 07:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=uS4QYvEa7znfGZGl6w6BA32aECkrD3Qqcb/r2944xrA=;
        b=oG3O4rr2DO/qNpqaG1BXKmg5XPg0vAsIRAOM7/pBV9Iga2afP/DIRnfbJmT26lhSMm
         SF4a0IUkkWswdkrAdtxmsfFpjnH7q23ycx+ess1SkcXhEBAGjaRb6EiIL/jFWIa/bAPk
         bDBCxLYbu8NsAjQe27KwQhk/AvEBnb3HNoIHE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=VxWOp7LeAMe2tVBiZmGXxg7cXmMAreX7P2x9MKPS0zEgeg5dVRECO5Sq0P8rbnx4Fs
         avx/WMYXKpINicLfzQA+3XInZHB3e4096DX3BaK11xVaiAkKU0HHrbTeu54Evb+czWYo
         Bdy/2P/K7wU/mDPWDGAbUhfGZrD735JLEALTg=
Received: by 10.142.43.12 with SMTP id q12mr2501617wfq.238.1290786703117;
        Fri, 26 Nov 2010 07:51:43 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.252.168])
        by mx.google.com with ESMTPS id f5sm2696306wfg.2.2010.11.26.07.51.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Nov 2010 07:51:42 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 26 Nov 2010 22:50:29 +0700
X-Mailer: git-send-email 1.7.3.2.316.gda8b3
In-Reply-To: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162255>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 0c897df..7433601 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -285,7 +285,7 @@ help ...`.
 	This can also be controlled by setting the GIT_WORK_TREE
 	environment variable and the core.worktree configuration
 	variable. It can be an absolute path or relative path to
-	the directory specified by --git-dir or GIT_DIR.
+	current working directory.
 	Note: If --git-dir or GIT_DIR are specified but none of
 	--work-tree, GIT_WORK_TREE and core.worktree is specified,
 	the current working directory is regarded as the top directory
--=20
1.7.3.2.316.gda8b3

From: Zhang Le <r0bertz@gentoo.org>
Subject: [PATCH] Improved git-mailinfo's documentation
Date: Mon, 14 Jun 2010 02:49:47 +0800
Message-ID: <1276454987-14604-1-git-send-email-r0bertz@gentoo.org>
Cc: Zhang Le <r0bertz@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 13 20:51:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONsHL-0007fp-Ue
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 20:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637Ab0FMSuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 14:50:18 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:38998 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab0FMSuR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 14:50:17 -0400
Received: by pxi8 with SMTP id 8so2239868pxi.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=+lx1Vk34Vl/Uq41yY9V7hROZuoBYOt+egsq3hene9wU=;
        b=iTzQojIZ9HPEbc7UndBsLXRWOL7Nov7lMhsaLKD6BgFCHFzGBSvDm2LPsTSSQQ6EOI
         tdzwsTXLIe9GCPXL9qDLwZBVKAsIUK4EjzmZwM04IhgprGiutvt6VWWXfY+KdJ82PspO
         C8Jh7NRB6qLMconboliPql59Nt0bLjYaGS4Jo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        b=K9JUYVQI/wU0gTxNoW4KRbzO8LSM+KBXQkHl0e9psjwennf8PM5PRknMnJ1BNeKAJn
         bzF5gd114C6U91t+n+vRhBiWD3S2tmeY9V1R8p6RZ3stZG8VyvtdT7g6zKaapYKe3qFH
         E2GDlc0iMLsR1dxPb0NRYp8dZpz2nTQBYmFtQ=
Received: by 10.115.39.17 with SMTP id r17mr3735610waj.40.1276455016467;
        Sun, 13 Jun 2010 11:50:16 -0700 (PDT)
Received: from localhost ([121.34.28.151])
        by mx.google.com with ESMTPS id 33sm44542750wad.20.2010.06.13.11.50.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Jun 2010 11:50:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149057>

Improved the description of -u and --encoding

Signed-off-by: Zhang Le <r0bertz@gentoo.org>
---
 Documentation/git-mailinfo.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index e3d58cb..3ea5aad 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -40,16 +40,16 @@ OPTIONS
 -u::
 	The commit log message, author name and author email are
 	taken from the e-mail, and after minimally decoding MIME
-	transfer encoding, re-coded in UTF-8 by transliterating
+	transfer encoding, re-coded in the charset specified by
+	i18n.commitencoding (defaulting to UTF-8) by transliterating
 	them.  This used to be optional but now it is the default.
 +
 Note that the patch is always used as-is without charset
 conversion, even with this flag.
 
 --encoding=<encoding>::
-	Similar to -u but if the local convention is different
-	from what is specified by i18n.commitencoding, this flag
-	can be used to override it.
+	Similar to -u.  But when re-coding, the charset specified here is
+	used instead of the one specified by i18n.commitencoding or UTF-8.
 
 -n::
 	Disable all charset re-coding of the metadata.
-- 
1.7.1

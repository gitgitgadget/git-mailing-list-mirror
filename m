From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] Correct typo in gitweb's Makefile's CSSMIN rule
Date: Fri, 18 Jun 2010 17:01:25 -0400
Message-ID: <1276894885-2112-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junio@kernel.org>,
	Mark Rada <marada@uwaterloo.ca>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 18 23:01:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPih5-0000XS-IC
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 23:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258Ab0FRVBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 17:01:37 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:56949 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab0FRVBg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 17:01:36 -0400
Received: by gwj15 with SMTP id 15so1016888gwj.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 14:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=mYxa+HOeW/3McNGsKT5yCQqT2uJaNhC/ftl8VGe/mL4=;
        b=KfzLrfNWPcPlLtbVfSDFZOsTaO8AG2gFWnLfoAAXALSmhrXlHKkLQvTcFpVJFOUjSP
         aG1EPfZt5XPhN8bW9g4WQ/K3KKgEGLRhSaHLuHI/B632hBofX1txCduaepVGedrAUpga
         MEoDS5kZM45aztTaoNU17ad0xt359h/9B8CLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=CLZZbuEZT8pYfVUjbdQrDqcKg3u56GYqLLaPTEuf55+8r+lTdwaoHrEN2gPujhf64c
         dvi5YfVafcPkULtJI/4J3DC5NeRQJ05CRwa1321HQrJXZas8nHrO7fRE0yH68YXiYr6j
         09vkXo6x8AQj102q2PQZBdqUMmLUrkwpKUccg=
Received: by 10.151.29.4 with SMTP id g4mr1681856ybj.94.1276894895869;
        Fri, 18 Jun 2010 14:01:35 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id v3sm64087734ybe.12.2010.06.18.14.01.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Jun 2010 14:01:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149362>

This typo has been in place since the rule was originally added by
0e6ce21 (Gitweb: add support for minifying gitweb.css).

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 gitweb/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 935d2d2..d9e3629 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -102,7 +102,7 @@ GITWEB_FILES += gitweb.min.css
 GITWEB_CSS = gitweb.min.css
 all:: gitweb.min.css
 gitweb.min.css: gitweb.css GITWEB-BUILD-OPTIONS
-	$(QUIET_GEN)$(CSSMIN) <$ >$@
+	$(QUIET_GEN)$(CSSMIN) <$< >$@
 else
 GITWEB_FILES += gitweb.css
 endif
-- 
1.7.1

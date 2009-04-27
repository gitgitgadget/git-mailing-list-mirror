From: Mark Drago <markdrago@gmail.com>
Subject: [PATCH] Add semicolon to curly brace group in main Makefile
Date: Sun, 26 Apr 2009 22:36:48 -0400
Message-ID: <1240799808-7340-1-git-send-email-markdrago@gmail.com>
Cc: Mark Drago <markdrago@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 27 10:11:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyGjp-0000fK-4v
	for gcvg-git-2@gmane.org; Mon, 27 Apr 2009 04:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbZD0Cg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 22:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbZD0Cg6
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 22:36:58 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:7451 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbZD0Cg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 22:36:58 -0400
Received: by fk-out-0910.google.com with SMTP id 18so999327fkq.5
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 19:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=BWW+HlAiscep0kDBjzU6jteEoibeclLgQJFV5uHGWYw=;
        b=gtiQUMsT9DF7H9ZLvTs4nSHMalLOsFIFXkAe//o7MSA7yoLZgyV5EgrWr5DILZ9fKY
         gFaIvPWwC1mmpf0sm6I453yx5jOk2utbtJ5X4ukl87ze9FC1CgKByhcZ69wrrZ0CTXb1
         ahbsbff4YkBMsiLz4lRus8Fjqwzg9KCM30U6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=DmRIvTM2IRoMTU9RAdeG2LiEO92fAE7SJpLIdW59aNrR2FKjiI61deEOUxqJ4lIXjJ
         yFpV3hKhTCkaiI1QpTtY5PzX8Qv2AWuKRTXPeGKF7UXx38Pvgk5pP786dgFMndrDhbII
         UI+VWHYY7uHDxfZm5kwVvECyrwsGfjiQtPLfI=
Received: by 10.103.107.1 with SMTP id j1mr2886059mum.30.1240799815758;
        Sun, 26 Apr 2009 19:36:55 -0700 (PDT)
Received: from localhost.localdomain (ool-18ba9e5c.dyn.optonline.net [24.186.158.92])
        by mx.google.com with ESMTPS id j6sm10975559mue.31.2009.04.26.19.36.53
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Apr 2009 19:36:55 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117603>

This semicolon is technically required by bash and indeed caused a syntax error
on a system that I came across running, an admittedly very old, bash-2.04.0.

http://www.gnu.org/software/bash/manual/bashref.html#Command-Grouping

Signed-off-by: Mark Drago <markdrago@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 5c8e83a..f006d2c 100644
--- a/Makefile
+++ b/Makefile
@@ -1557,7 +1557,7 @@ endif
 		ln "$$execdir/git-add$X" "$$execdir/$$p" 2>/dev/null || \
 		ln -s "git-add$X" "$$execdir/$$p" 2>/dev/null || \
 		cp "$$execdir/git-add$X" "$$execdir/$$p" || exit; \
-	  done } && \
+	  done; } && \
 	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
 
 install-doc:
-- 
1.5.6.3

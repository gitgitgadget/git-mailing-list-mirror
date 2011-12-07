From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 12/15] t3419 (rebase-patch-id): fix && chaining
Date: Thu,  8 Dec 2011 01:06:48 +0530
Message-ID: <1323286611-4806-13-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:38:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNKJ-0001Jr-Ra
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757596Ab1LGTim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:38:42 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52491 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154Ab1LGTil (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:38:41 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so1353523iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Id/1GZPuXatvZVSCgyKwGCblacsyhL10x+R2ncYT7iA=;
        b=tTFjLJeg954fK1CxIf0M0onBea8AhIfSsXVlWLAAXCn1qjBatd3Yiwfq32Z9rS69a3
         tyZmR4NrLZVjaIp07JoQT1jzsAxSlwKjkHExSkLgpJW1dtZV5pEMStdm6FkB4IunfWSC
         ZexzyoiLCLaJkzUBsxt/BIYProcYOMlCn0gpY=
Received: by 10.42.156.195 with SMTP id a3mr248546icx.25.1323286721178;
        Wed, 07 Dec 2011 11:38:41 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.38.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:38:40 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186492>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3419-rebase-patch-id.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index bd8efaf..e70ac10 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -39,7 +39,7 @@ run()
 }
 
 test_expect_success 'setup' '
-	git commit --allow-empty -m initial
+	git commit --allow-empty -m initial &&
 	git tag root
 '
 
-- 
1.7.7.3

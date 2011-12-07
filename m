From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 03/15] t1412 (reflog-loop): fix && chaining
Date: Thu,  8 Dec 2011 01:06:39 +0530
Message-ID: <1323286611-4806-4-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:38:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNJn-00013p-OC
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757189Ab1LGTiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:38:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52491 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757116Ab1LGTiG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:38:06 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so1353523iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lHt9W1eNY+TakmHuVqJfu2nFtctvwmmQwTPcsAnC1Y8=;
        b=wmidU+7q1/wbFq0IN1q7y5rBoATEADywfmABbA6YrZDJejkeXY3eWAtZYSxqhlGYm7
         GMj+Hoy7bIpMESvJHthsMJCsWNfOAHeCNw40ESUjTScpAzdy2qgj1aHjAWEJ2ZD2Fa8n
         ddzJDACAZIQCJxIWijgHM2azqJKGZ0p5WS7QI=
Received: by 10.231.81.146 with SMTP id x18mr4806811ibk.23.1323286685805;
        Wed, 07 Dec 2011 11:38:05 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.38.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:38:03 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186484>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1412-reflog-loop.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1412-reflog-loop.sh b/t/t1412-reflog-loop.sh
index 647d888..3acd895 100755
--- a/t/t1412-reflog-loop.sh
+++ b/t/t1412-reflog-loop.sh
@@ -20,7 +20,7 @@ test_expect_success 'setup reflog with alternating commits' '
 '
 
 test_expect_success 'reflog shows all entries' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 		topic@{0} reset: moving to two
 		topic@{1} reset: moving to one
 		topic@{2} reset: moving to two
-- 
1.7.7.3

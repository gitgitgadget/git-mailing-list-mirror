From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 01/15] t1013 (loose-object-format): fix && chaining
Date: Thu,  8 Dec 2011 01:06:37 +0530
Message-ID: <1323286611-4806-2-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:38:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNJg-0000zp-F2
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030Ab1LGTh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:37:59 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52491 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756712Ab1LGTh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:37:57 -0500
Received: by iakc1 with SMTP id c1so1353523iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NIJ8xMFNNpl0Tg8XUEDB76nbDc7OUHlTMi4G32J1wCo=;
        b=b2zXwlGllEhYUFk4RqL2KTLJkzSATvgGXmoBnPWfnb7iNchmUPnLESrLUVGMFUpaNj
         NrycirHC6sfKYWBKpKel8lzy0eJqHFGlTP6SUjGQwZvCpdU1g4YXyVNYhyEoFgiK2psL
         3GR1s1Rtbi7fwRf6rQew9MCs41BSQnFap3irQ=
Received: by 10.43.132.201 with SMTP id hv9mr177489icc.42.1323286676817;
        Wed, 07 Dec 2011 11:37:56 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.37.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:37:56 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186483>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t1013-loose-object-format.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1013-loose-object-format.sh b/t/t1013-loose-object-format.sh
index 0a9cedd..fbf5f2f 100755
--- a/t/t1013-loose-object-format.sh
+++ b/t/t1013-loose-object-format.sh
@@ -34,7 +34,7 @@ assert_blob_equals() {
 }
 
 test_expect_success setup '
-	cp -R "$TEST_DIRECTORY/t1013/objects" .git/
+	cp -R "$TEST_DIRECTORY/t1013/objects" .git/ &&
 	git --version
 '
 
-- 
1.7.7.3

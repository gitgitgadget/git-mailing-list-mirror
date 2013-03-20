From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] t5516 (fetch-push): update test description
Date: Wed, 20 Mar 2013 18:14:57 +0530
Message-ID: <1363783501-27981-3-git-send-email-artagnon@gmail.com>
References: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 20 13:44:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIINZ-0001lB-F8
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 13:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491Ab3CTMoC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 08:44:02 -0400
Received: from mail-da0-f49.google.com ([209.85.210.49]:41921 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab3CTMoA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 08:44:00 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so956337daj.8
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 05:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=p30bmBgvk4OVjmMlFmdrSf/1q+YEpJ1a/lEZF9qxsS8=;
        b=l26bqmspNKHo5eWnyTFuRZ/7V6xSM4eXvuHLzD8es9X+oH2R1N9VtmgVLLZmujHp+y
         dAh6yBwrf3xKCl/SquKAdvvvIZcyIrPMr+89idHd7w+hqjaYXWJPteIex2isRqb+yuH5
         n51mAXLLLMQRioHfnFSa0Ro7oEuEFq1pEId/VAvERpBTIWQc0HAfXZBe4VVCuxNNNIAq
         Y4CPS4mXkDxnZzg++KDd2nHhAmtS0jJZr0x4ZTi9X6U7P7pIElYjHwbbtpq1JaIQy454
         De+izP2BE3P5TjcF9LhgFSSMfK2YCVDQ1ejsbY6fmoePcBeItQKie5+bZEjbdPe9BoXm
         UdLA==
X-Received: by 10.66.121.194 with SMTP id lm2mr8787037pab.144.1363783440142;
        Wed, 20 Mar 2013 05:44:00 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id y13sm2031559pbv.0.2013.03.20.05.43.56
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 05:43:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1363783501-27981-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218599>

The file was originally created in bcdb34f (Test wildcard push/fetch,
2007-06-08), and only contained tests that exercised wildcard
functionality at the time.  In subsequent commits, many other tests
unrelated to wildcards were added but the test description was never
updated.  Fix this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5516-fetch-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c31e5c1..bfeec60 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='fetching and pushing, with or without wildcard'
+test_description='fetching and pushing'
 
 . ./test-lib.sh
 
-- 
1.8.2

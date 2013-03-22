From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] t5516 (fetch-push): update test description
Date: Fri, 22 Mar 2013 13:22:32 +0530
Message-ID: <1363938756-13722-3-git-send-email-artagnon@gmail.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 08:52:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIwld-0002Ky-Cg
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 08:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab3CVHvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 03:51:33 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:45227 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab3CVHvb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 03:51:31 -0400
Received: by mail-pd0-f171.google.com with SMTP id 10so1484750pdc.2
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 00:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=XgpWOH62rm3hOk61VLT6MTSxO+Sz0cgMtNGmnfpvgJM=;
        b=UofrOuu9Mu7y155UxsuKKzdvtZtwlmuNntW3lvWYyKfB0Qk2qMiSbn27yRsy1xrdn8
         j+QXfDPY12LTEMwmbyWfdicZAeb5jNl6z9NltvsIjKO+RVn2+rJ+O7uCn3lwB2wxZxG6
         UkFJK54lxZW1ji8AlkssN0FEZhBgC+1IXSRaTyWFuLDE/PRt782fheEAzL/q1v/WbdXd
         Y9qrePMlIe7iKKiQ8wz8NR1l1KCZas/dw12y6fvd6lxyDvf/DNH8NqqkdkskaRPRtgLz
         RJ4t4AWkBfL0S73aJt/rsnK4BpOdIiA/SWAk1W2eUcxaUNTlYRu9UI8c4+lVlkJg9lIZ
         m5eg==
X-Received: by 10.66.122.97 with SMTP id lr1mr1746630pab.147.1363938691313;
        Fri, 22 Mar 2013 00:51:31 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id fh1sm2025227pac.1.2013.03.22.00.51.28
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 00:51:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.62.ga35d936.dirty
In-Reply-To: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218781>

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
1.8.2.62.ga35d936.dirty

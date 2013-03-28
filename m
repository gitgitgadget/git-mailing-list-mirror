From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] t5516 (fetch-push): update test description
Date: Thu, 28 Mar 2013 18:56:38 +0530
Message-ID: <1364477202-5742-3-git-send-email-artagnon@gmail.com>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 14:26:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULCqC-00039X-VO
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 14:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086Ab3C1NZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 09:25:36 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36354 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043Ab3C1NZd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 09:25:33 -0400
Received: by mail-pa0-f42.google.com with SMTP id kq13so2052493pab.15
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 06:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=BsggkT09zpRm1jY0gYCpRaTeq42MXVZPy7ybwD9wW+E=;
        b=oc8ZRl1fttLhR4gI4b5XbGay9v+MWfEeb8KjvZRDML/feofjXYqD8fP2t4VXl95uqC
         vhUWcvDslzKBAGGo+d9fKtMrqSStP8hR8q/7fuhiyt0H8StRmq4Pg249X09cjzer3ECQ
         yFL9s39oHRQuf66J8Po9YHKM1bu3ItmkbCpq7VIKb1L26bgMfwalgHVz6gCERE9bb66W
         eOqdr4hHoCzerqx++IX5DYtCVqUnOEhdfIrIInDUwSGBxDP+6kyq5ALKDnosvJAfLnBU
         RIsMQJRafYIJEVNF6WBD/DR0HOIQFT0TPE9EfIcWqRA1gQXh5r3uuCkZAjs1cRxpVXzs
         HwfQ==
X-Received: by 10.66.50.2 with SMTP id y2mr35513757pan.179.1364477133025;
        Thu, 28 Mar 2013 06:25:33 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id tm1sm25586603pbc.11.2013.03.28.06.25.30
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 06:25:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.g3797f84
In-Reply-To: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219388>

The file was originally created in bcdb34f (Test wildcard push/fetch,
2007-06-08), and only contained tests that exercised wildcard
functionality at the time.  In subsequent commits, many other tests
unrelated to wildcards were added but the test description was never
updated.  Fix this.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t5516-fetch-push.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 6fd125a..38f8fc0 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1,6 +1,17 @@
 #!/bin/sh
 
-test_description='fetching and pushing, with or without wildcard'
+test_description='Basic fetch/push functionality.
+
+This test checks the following functionality:
+
+* command-line syntax
+* refspecs
+* fast-forward detection, and overriding it
+* configuration
+* hooks
+* --porcelain output format
+* hiderefs
+'
 
 . ./test-lib.sh
 
-- 
1.8.2.141.g3797f84

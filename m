From: Xue Fuqiao <xfq.free@gmail.com>
Subject: [PATCH] Documentation: fix header markup
Date: Thu, 22 Oct 2015 20:59:00 +0800
Message-ID: <1445518740-18221-1-git-send-email-xfq.free@gmail.com>
Cc: Xue Fuqiao <xfq.free@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 14:59:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpFTC-0006JC-SY
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 14:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757490AbbJVM7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 08:59:46 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34355 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757485AbbJVM7q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 08:59:46 -0400
Received: by padhk11 with SMTP id hk11so86611576pad.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2015 05:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=M8KCYcS9dUVCIl07LSyy+/rCOiLzP7cKBuUl0iqepPo=;
        b=OIZ/ulkyLEbsbneV0z6OR693LUy9C21tZCfCeHOcxwv2EcC9Dvhb6j+8t1KXv7RklW
         vOCNItUJPiSvvv7hm1Y5+Ca9/6XHBxeiavSyPp2c6NanYqA3dndO622l+Os7BsSlAToF
         ExVqIiNOqtPX3TLCRUdk2THItvYFRY2MjmJfQvw5jB8/IP2kEbKYxdauTASOWVyIQYNR
         X2uqFsUkEuGnHXla3d0s1j6Oc17nq2GYWhkkB1mSQGN3vHcUonkOBUwEUTxzhvifND8n
         klUjWUEbK6iFF63XS7S+mT+H2qMfYc6QdzerYDICLPsm7+cfQ7qoRnpuG6pTzZN3alQG
         qmHQ==
X-Received: by 10.68.69.79 with SMTP id c15mr17368313pbu.90.1445518785432;
        Thu, 22 Oct 2015 05:59:45 -0700 (PDT)
Received: from XFQ-Mac.vpn ([119.81.160.236])
        by smtp.gmail.com with ESMTPSA id ou3sm13907161pbb.44.2015.10.22.05.59.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Oct 2015 05:59:45 -0700 (PDT)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280051>

Asciidoctor is stricter than AsciiDoc when deciding if underlining
is a section title or the start of preformatted text.  Make the
length of the underlining match the text to ensure that it renders
correctly in all implementations.

Signed-off-by: Xue Fuqiao <xfq.free@gmail.com>
---
Currently, "Fixing a mistake by rewriting history" is surrounded by a
pair of <p> tags instead of a pair of <h3> tags in
https://git-scm.com/docs/user-manual.html.  This patch will (hopefully)
fix that.

 Documentation/user-manual.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1b7987e..764a270 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1491,7 +1491,7 @@ resolving a merge>>.
 
 [[fixing-a-mistake-by-rewriting-history]]
 Fixing a mistake by rewriting history
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If the problematic commit is the most recent commit, and you have not
 yet made that commit public, then you may just
-- 
2.6.2

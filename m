From: Leila Muhtasib <muhtasib@gmail.com>
Subject: [PATCH/RFC] Documenation update: use of braces in if/else if/else chain
Date: Sun, 10 Jun 2012 13:26:30 -0400
Message-ID: <1339349190-84552-1-git-send-email-muhtasib@gmail.com>
Cc: Leila Muhtasib <muhtasib@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 19:26:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdluQ-0006wo-L7
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 19:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab2FJR0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 13:26:33 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:55641 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab2FJR0d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 13:26:33 -0400
Received: by qcro28 with SMTP id o28so38934qcr.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=XurDOw29ta+5U1ofwnA7dI7B3t/aw4aqJaTI0ZFOFak=;
        b=YF5Mb7tv3EkCYaSdcoEINDQSDKZQ76LKsJvwDDkp/NErTnVNZBlP7gd38YdCf4Tsn3
         L9lbLGDM6GJuNAInIpScAu1Qe7sAeqd/dhbl69nYkc/zXir64PcgHjcBJsQPUh4/pnba
         hpumcFJz7r+yopXRk0nS8n+Y6ZGCduJMS2hpXzk9YgCTKal7xTd4hfp8GrE4KpaN25e1
         rdnOPD20Y/HCW3HQeu7W7LrIA/Bg/qAGM/n8wywPuCmnM4HQFH3ubg6+TMr+5YNUir9U
         X0zq1S78FhvyfxPRdcRJJUVGbVYxFFcbx1vk/rlWpSd2KBXCo44RhyROHzjyl4Z+fhlJ
         yIkQ==
Received: by 10.229.135.193 with SMTP id o1mr5110965qct.34.1339349192202;
        Sun, 10 Jun 2012 10:26:32 -0700 (PDT)
Received: from localhost (user-160v4aj.cable.mindspring.com. [76.15.145.83])
        by mx.google.com with ESMTPS id u16sm15149287qaa.14.2012.06.10.10.26.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Jun 2012 10:26:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.5 (Apple Git-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199610>


Signed-off-by: Leila Muhtasib <muhtasib@gmail.com>
---
Does the below more accruately represent the coding guidelines?
I can modify it, if it doesn't.

Thanks,
Leila


 Documentation/CodingGuidelines |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 4557711..ea90521 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -117,9 +117,26 @@ For C programs:
 
    is frowned upon.  A gray area is when the statement extends
    over a few lines, and/or you have a lengthy comment atop of
-   it.  Also, like in the Linux kernel, if there is a long list
-   of "else if" statements, it can make sense to add braces to
-   single line blocks.
+   it.  Also, like in the Linux kernel, if one of the
+   "if/else if/else" chain has a multiple statement block, use {}
+   even for a single statement block in that chain. And "else"
+   should come on the same line as the closing "}" of its "if" block.
+
+	//correct
+	if (bla) {
+		x = 1;
+		...
+	} else {
+		x = 2;
+	}
+
+	//incorrect
+	if (bla) {
+		x = 1;
+		...
+	}
+	else
+		x = 2;
 
  - We try to avoid assignments inside if().
 
-- 
1.7.7.5 (Apple Git-26)

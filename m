From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/2] Documentation/git-read-tree: fix table layout
Date: Mon, 15 Mar 2010 11:54:45 +0100
Message-ID: <5fb2461fbc5266c8be5ba09c4d74b621c718374e.1268650319.git.git@drmicha.warpmail.net>
References: <8c627c4f1003131432g26598d22m9795177ab56a463e@mail.gmail.com>
Cc: Christian Halstrick <christian.halstrick@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 11:57:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr7zP-0002er-RM
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 11:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936077Ab0COK5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 06:57:31 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59218 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934154Ab0COK51 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 06:57:27 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 23135E4DC8;
	Mon, 15 Mar 2010 06:57:27 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 15 Mar 2010 06:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=0fghbt5IkzxD21MeJMV60BrOBq8=; b=GTZVIfzTKd9ypdtI2cTG3IIXPtI60l4agxDKN2JMKniQUbsCEbvVq90TJuVbXSYBiRLPNRrcvbshaPgvX0dd2hkGv97hgJY+8BtWPW/6Djh+phNi/oZQhm70nsFIhfY+jQwaODXM6zbtcCPgmlB1XDVU9BrEikElOlPvQWI1xZ0=
X-Sasl-enc: acBbGX0CZlmqz2aBpJWtG8idRvxQML9/sbkHcGewwIiA 1268650646
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8B5AF4AF244;
	Mon, 15 Mar 2010 06:57:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.1.300.gd855a
In-Reply-To: <8c627c4f1003131432g26598d22m9795177ab56a463e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142201>

Asciidoc takes the first non-space character in the first line of the
paragraph as a reference point for preformatted layout, so adjust to
that to make the table align.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-read-tree.txt |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 567671c..5aaf0d5 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -164,23 +164,23 @@ Here are the "carry forward" rules:
 
         I (index)           H        M        Result
        -------------------------------------------------------
-      0 nothing             nothing  nothing  (does not happen)
-      1 nothing             nothing  exists   use M
-      2 nothing             exists   nothing  remove path from index
-      3 nothing             exists   exists,  use M if "initial checkout"
+     0  nothing             nothing  nothing  (does not happen)
+     1  nothing             nothing  exists   use M
+     2  nothing             exists   nothing  remove path from index
+     3  nothing             exists   exists,  use M if "initial checkout"
 				     H == M   keep index otherwise
 				     exists   fail
 				     H != M
 
         clean I==H  I==M
        ------------------
-      4 yes   N/A   N/A     nothing  nothing  keep index
-      5 no    N/A   N/A     nothing  nothing  keep index
+     4  yes   N/A   N/A     nothing  nothing  keep index
+     5  no    N/A   N/A     nothing  nothing  keep index
 
-      6 yes   N/A   yes     nothing  exists   keep index
-      7 no    N/A   yes     nothing  exists   keep index
-      8 yes   N/A   no      nothing  exists   fail
-      9 no    N/A   no      nothing  exists   fail
+     6  yes   N/A   yes     nothing  exists   keep index
+     7  no    N/A   yes     nothing  exists   keep index
+     8  yes   N/A   no      nothing  exists   fail
+     9  no    N/A   no      nothing  exists   fail
 
      10 yes   yes   N/A     exists   nothing  remove path from index
      11 no    yes   N/A     exists   nothing  fail
-- 
1.7.0.1.300.gd855a

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] rev-list-options: clarify --parents and --children
Date: Thu, 30 Sep 2010 17:31:43 +0200
Message-ID: <e7f6a7b7bdd9b0c4b425b04cf536d64c7ed8265f.1285860651.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 30 17:31:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1L6i-0002k5-90
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 17:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105Ab0I3Pbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 11:31:34 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:51786 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932082Ab0I3Pbe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 11:31:34 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 960D9D9;
	Thu, 30 Sep 2010 11:31:33 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 30 Sep 2010 11:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=ai25Enf2G03hSxJauC78xd6Cau4=; b=p1Z6QhJc2ZgNUr/6xe1tMBB7nAKfJyAchYV3aS9nn64xab5WpjVBQTTqbIFD1nqzsvbDMnFr1kaEIKkUrr624HNcRYDyYoCAzxQBdJtjc0d3gmmF3u1TTRPi4ES4tq0ifJLVkXiS6vwPa77BCDLpObfxtJfv84SVH+qOpfLv2CM=
X-Sasl-enc: J+TBldNr+i5QVYnHPh/mDvLHOKlzdf73SIuh8H7fI2w9 1285860693
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 15082406A7A;
	Thu, 30 Sep 2010 11:31:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.98.g5ad7d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157681>

Make it clearer that --parents resp. --children list the parent resp.
child commits next to each commit, so that I understand next time.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/rev-list-options.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index e2237ae..ebc0108 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -45,13 +45,13 @@ endif::git-rev-list[]
 
 --parents::
 
-	Print the parents of the commit.  Also enables parent
-	rewriting, see 'History Simplification' below.
+	Print also the parents of the commit (in the form "commit parent...").
+	Also enables parent rewriting, see 'History Simplification' below.
 
 --children::
 
-	Print the children of the commit.  Also enables parent
-	rewriting, see 'History Simplification' below.
+	Print also the children of the commit (in the form "commit child...").
+	Also enables parent rewriting, see 'History Simplification' below.
 
 ifdef::git-rev-list[]
 --timestamp::
-- 
1.7.3.98.g5ad7d

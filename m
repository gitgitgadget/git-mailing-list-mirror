From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-show-ref.txt: clarify the pattern matching
Date: Mon, 18 Oct 2010 13:33:32 +0200
Message-ID: <21215c6fd41bd344c4226f410b69680f3901549b.1287401559.git.git@drmicha.warpmail.net>
References: <201010181203.38554.jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 18 13:34:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7nyc-0001th-I4
	for gcvg-git-2@lo.gmane.org; Mon, 18 Oct 2010 13:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062Ab0JRLdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Oct 2010 07:33:14 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60127 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753473Ab0JRLdO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Oct 2010 07:33:14 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id AB4B6303;
	Mon, 18 Oct 2010 07:33:13 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 18 Oct 2010 07:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=gTrHCQ1tT13o7GIo5fRld80jRXc=; b=iJMZi4szrWPtKxolQiW/QK+d5vLTqimFZVBKr8v3wnBDjHaj5Rb4q4ZkCf+VkycyCKIhK/hNTLjB61vgM1Ukx6AsGR9Xiz+nkBtyPZIBa6598hXsdeTJFcqWJRmecT6pgzjKRysMux7ovucM5QLRbIAr+c8qEdNzHre9aTPXNhw=
X-Sasl-enc: mQcWokMiwIP71V2h30IQ5m+2T8kWv1ZIlJNslqEqO38V 1287401593
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 28D2E407A2E;
	Mon, 18 Oct 2010 07:33:13 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.1.208.g53ea2
In-Reply-To: <201010181203.38554.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159252>

git-show-ref really does not do what one would expect under the name
pattern matching, so describe it.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-show-ref.txt |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 4696af7..be0ec18 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -84,7 +84,11 @@ OPTIONS
 
 <pattern>...::
 
-	Show references matching one or more patterns.
+	Show references matching one or more patterns. Patterns are matched from
+	the end of the full name, and only complete parts are matched, e.g.
+	'master' matches 'refs/heads/master', 'refs/remotes/origin/master',
+	'refs/tags/jedi/master' but not 'refs/heads/mymaster' nor
+	'refs/remotes/master/jedi'.
 
 OUTPUT
 ------
-- 
1.7.3.1.208.g53ea2

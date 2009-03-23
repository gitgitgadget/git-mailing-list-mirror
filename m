From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/WIP 1/2] Documentation: fix minor inconsistency
Date: Mon, 23 Mar 2009 15:28:52 +0100
Message-ID: <1237818533-31577-2-git-send-email-git@drmicha.warpmail.net>
References: <1237818533-31577-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 15:30:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LllAu-00064l-IU
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbZCWO3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 10:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754939AbZCWO3R
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:29:17 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39149 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754586AbZCWO3O (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 10:29:14 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 81B7B2FA571;
	Mon, 23 Mar 2009 10:29:12 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 23 Mar 2009 10:29:12 -0400
X-Sasl-enc: 11EFMj5li6DRbocpY6ZiSj45SpiJHA+GKOw2ZcLy8QYJ 1237818551
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id CF9C52B567;
	Mon, 23 Mar 2009 10:29:11 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.149.g6462
In-Reply-To: <1237818533-31577-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114313>

While we don't always write out commands in full (`git command`) we
should do it consistently in adjacent paragraphs.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/config.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 089569a..e093ff3 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1254,7 +1254,7 @@ receive.denyDeletes::
 	the ref. Use this to prevent such a ref deletion via a push.
 
 receive.denyCurrentBranch::
-	If set to true or "refuse", receive-pack will deny a ref update
+	If set to true or "refuse", git-receive-pack will deny a ref update
 	to the currently checked out branch of a non-bare repository.
 	Such a push is potentially dangerous because it brings the HEAD
 	out of sync with the index and working tree. If set to "warn",
-- 
1.6.2.149.g6462

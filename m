From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Documentation: fix minor inconsistency
Date: Thu, 13 May 2010 14:51:38 +0200
Message-ID: <1e73838cb1057f4cdb051c230f522df5a81fccd5.1273754999.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 14:51:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCXt7-00031O-K3
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 14:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758192Ab0EMMvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 08:51:37 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52595 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757486Ab0EMMvg (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 08:51:36 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3B97EF5C13;
	Thu, 13 May 2010 08:51:36 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 13 May 2010 08:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=H0I6D3Uj8b22Ceah60QA0LicdW4=; b=Es9b+zHAS/12fbMN3JWaE+XJFDEWpkUytKUeiL7N1ysX78u0GST5ndtwZ16/4FZt7GzevM3wTv308jmaF846X5vs3oAdF8AgJ8scW+ct7/y8+q3WGq3YEeRh30KeHeRFVNHAk+PJQrLFgW2xNv/4SrdxUX3+xsQTEoMEFZmMWMU=
X-Sasl-enc: jYBHcsoDnV2P0qdDwJGGyZAlTHYkdpGcJ4FalHlsNDaN 1273755095
Received: from localhost (p54859DBB.dip0.t-ipconnect.de [84.133.157.187])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 47A941ADA;
	Thu, 13 May 2010 08:51:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.240.geeaa4d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147000>

While we don't always write out commands in full (`git command`) we
should do it consistently in adjacent paragraphs.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
And, git-receive-pack is written with a dash everywhere :)

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
1.7.1.240.geeaa4d

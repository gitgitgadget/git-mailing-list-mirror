From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Documentation/gitdiffcore: fix order in pickaxe description
Date: Tue, 18 May 2010 12:49:33 +0200
Message-ID: <7e20518abca5648ee22fb319dcf27e3246b5f842.1274179709.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 18 12:50:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEKNb-0005IK-FQ
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 12:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756814Ab0ERKuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 06:50:06 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52635 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756416Ab0ERKuD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 May 2010 06:50:03 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C434AF6BC9;
	Tue, 18 May 2010 06:49:26 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 18 May 2010 06:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=8D2CPzkklzcqkNwUrBCV6+J319Q=; b=U3l8rtCBbNPYgdzXRRKcxWtSwueNWs+Bp1oym/gocs6yv2emJRGXMn/fG6U1vNQgnPAmwe7FJ84S6lKxGuxU2I760q/zU4YLeFpOO7QLXHJs9lp8A4KVPsNNfTINqLvuUAiDoweumAvDHsUQscTomyuInCldYOHGZvrdJE2vhz4=
X-Sasl-enc: L7FLyDfmFKna6mUj3VMEK7PCjnwsIYsvZSLt7jSPLY7y 1274179765
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B97424BACB;
	Tue, 18 May 2010 06:49:25 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.252.g2fdbc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147279>

Reverse the order of "origin" and "result" so that the sentence
really describes an addition rather than a removal.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/gitdiffcore.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index 9de8caf..5d91a7e 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -227,8 +227,8 @@ changes that touch a specified string, and is controlled by the
 commands.
 
 When diffcore-pickaxe is in use, it checks if there are
-filepairs whose "original" side has the specified string and
-whose "result" side does not.  Such a filepair represents "the
+filepairs whose "result" side has the specified string and
+whose "origin" side does not.  Such a filepair represents "the
 string appeared in this changeset".  It also checks for the
 opposite case that loses the specified string.
 
-- 
1.7.1.252.g2fdbc

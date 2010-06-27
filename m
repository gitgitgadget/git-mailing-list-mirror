From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3] git-rev-parse.txt: Document ":path" specifier
Date: Sun, 27 Jun 2010 15:15:22 +0200
Message-ID: <6af64ac563a9a165bec7fddc779b31ae5bcb9997.1277644307.git.git@drmicha.warpmail.net>
References: <7vpqzfj8zi.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 27 15:15:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSrhm-0000cv-9N
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 15:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150Ab0F0NPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 09:15:13 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33562 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754826Ab0F0NPM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jun 2010 09:15:12 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0B6031090B5;
	Sun, 27 Jun 2010 09:15:11 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Sun, 27 Jun 2010 09:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=3gyZqxy9C8HBtlrhczn5XkyCRQ0=; b=nAfPbtDabeAAZBGohiB2DbfwiGHOhVwsPMQG4Ro8EwUjLvIsU/oCDrFJTdsjgWcFay+WkB+VHiWPwMlNc4AfPMNihwwKdnStaz4MsBM2DQcEVzNEeHMPvoIFR8auv5b5QoS+WHxdcUv8VPAuYCAezc1kgl8Ai6TEqCUKSbK7M9k=
X-Sasl-enc: Ltf8HG9hnPsaC8lyLpUyhecQi4Pc67O1xnKbsGai7x9f 1277644510
Received: from localhost (p54859121.dip0.t-ipconnect.de [84.133.145.33])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3D3C149B01;
	Sun, 27 Jun 2010 09:15:10 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.621.g01d76
In-Reply-To: <7vpqzfj8zi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149792>

The empty treeish in ":path" means "index". This is actually a special
case of the ":stage:path" syntax where it is documented, but mentioning
it also together with "treeish:path" is helpful, so do it.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
How about this? Short description at "rev:path" but still pointing
to ":stage:path".

 Documentation/git-rev-parse.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 8db600f..d525e57 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -291,7 +291,9 @@ the `$GIT_DIR/refs` directory or from the `$GIT_DIR/packed-refs` file.
 
 * A suffix ':' followed by a path; this names the blob or tree
   at the given path in the tree-ish object named by the part
-  before the colon.
+  before the colon. ":path" (with an empty part before the colon)
+  is a special case of the syntax described next: content
+  recorded in the index at the given path.
 
 * A colon, optionally followed by a stage number (0 to 3) and a
   colon, followed by a path; this names a blob object in the
-- 
1.7.1.621.g01d76

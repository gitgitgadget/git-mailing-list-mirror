From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Documentation: fix a few typos in git-notes.txt
Date: Thu,  4 Mar 2010 15:31:17 +0100
Message-ID: <4a44449489fa80dd3e7d04b7de6c69797f91f422.1267712760.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 04 15:33:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnC7i-0000zk-Do
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 15:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725Ab0CDOdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 09:33:53 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60743 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750819Ab0CDOdx (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Mar 2010 09:33:53 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0114BE2F0A;
	Thu,  4 Mar 2010 09:33:51 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 04 Mar 2010 09:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=05fr1rG7oiKTB2FdaaVBZAX5oWc=; b=ipEPov27Y1szjohqbsAUee59Z/+1X6zsG2EfdIQfK8AIW+Y6mO5BOp61t7ZHqk4k1jDEWmzUnamSLcIKASfVCicr2z2l1KF5RnOKLUXy5VZefVF2hGWFk3NikESi2DY7O2RmDb+Tc+iU0qewE6LusflnoGEirFy0dLn5qYrz9jw=
X-Sasl-enc: MopV9iq8KmDbMEks3OHfSmMMrHdbwW5X635KpZFGJXu/ 1267713230
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4C22F43E7A;
	Thu,  4 Mar 2010 09:33:50 -0500 (EST)
X-Mailer: git-send-email 1.7.0.1.300.gd855a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141526>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This is based on next and is orthogonal to tr/notes-display in pu.

 Documentation/git-notes.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 14f73b9..bef2f39 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -46,13 +46,13 @@ list::
 
 add::
 	Add notes for a given object (defaults to HEAD). Abort if the
-	object already has notes, abort. (use `-f` to overwrite an
+	object already has notes (use `-f` to overwrite an
 	existing note).
 
 copy::
 	Copy the notes for the first object onto the second object.
 	Abort if the second object already has notes, or if the first
-	objects has none. (use -f to overwrite existing notes to the
+	object has none (use -f to overwrite existing notes to the
 	second object). This subcommand is equivalent to:
 	`git notes add [-f] -C $(git notes list <from-object>) <to-object>`
 
-- 
1.7.0.1.300.gd855a

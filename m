From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/3] cvsimport.txt: document the mapping between config and options
Date: Thu, 25 Nov 2010 16:10:56 +0100
Message-ID: <d7bf21ade4924949266ac850930a1b208658d22b.1290697830.git.git@drmicha.warpmail.net>
References: <939dff25f5a58b6f37cf21bf490b2782f6e96f39.1290697830.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 25 16:13:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLdVY-0007id-My
	for gcvg-git-2@lo.gmane.org; Thu, 25 Nov 2010 16:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507Ab0KYPNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 10:13:09 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:38859 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753123Ab0KYPNG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 10:13:06 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0D418937;
	Thu, 25 Nov 2010 10:13:06 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 25 Nov 2010 10:13:06 -0500
X-Sasl-enc: KoJ4t2ZwGqjnWhvc70Bn7Dmr/Q4hnnbgpKb5eMz12+N3 1290697985
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8467A5E3D7D;
	Thu, 25 Nov 2010 10:13:05 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.614.g03864.dirty
In-Reply-To: <939dff25f5a58b6f37cf21bf490b2782f6e96f39.1290697830.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162137>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-cvsimport.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 608cd63..b5d5b27 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -176,6 +176,13 @@ messages, bug-tracking systems, email archives, and the like.
 -h::
 	Print a short usage message and exit.
 
+CONFIG
+------
+For any option '-x' you can set the config variable 'cvsimport.x' to the value
+you would specify for '-x', or to 'true' for a boolean option. For an
+uppercase option '-X' use the config variable 'cvsimport.xx' (or
+'cvsimport.XX').
+
 OUTPUT
 ------
 If '-v' is specified, the script reports what it is doing.
-- 
1.7.3.2.614.g03864.dirty

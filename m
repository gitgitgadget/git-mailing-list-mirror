From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 3/3] cvsimport.txt: document the mapping between config and options
Date: Sun, 28 Nov 2010 20:39:47 +0100
Message-ID: <317523448870044a68311f811b42bd9461b90d43.1290973138.git.git@drmicha.warpmail.net>
References: <4CF2ADC9.8020504@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 28 20:39:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMn61-0001ou-To
	for gcvg-git-2@lo.gmane.org; Sun, 28 Nov 2010 20:39:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab0K1Tj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Nov 2010 14:39:27 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36885 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753193Ab0K1TjV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Nov 2010 14:39:21 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 7DBCE729;
	Sun, 28 Nov 2010 14:39:21 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Sun, 28 Nov 2010 14:39:21 -0500
X-Sasl-enc: yV9mBBiM6DFbcBmps4ztX/loMU+5eA4XhKcl+RDiiary 1290973160
Received: from localhost (p5485894A.dip0.t-ipconnect.de [84.133.137.74])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C93CA406EFE;
	Sun, 28 Nov 2010 14:39:20 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.614.g03864.dirty
In-Reply-To: <4CF2ADC9.8020504@drmicha.warpmail.net>
In-Reply-To: <468f815beeede312f98daa66986ce8bf887724b3.1290973138.git.git@drmicha.warpmail.net>
References: <468f815beeede312f98daa66986ce8bf887724b3.1290973138.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162353>

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

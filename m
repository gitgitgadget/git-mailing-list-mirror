From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 3/3] cvsimport.txt: document the mapping between config and options
Date: Wed,  1 Dec 2010 13:53:22 +0100
Message-ID: <84f63e5082da0bf483175584399688385fb6002d.1291207768.git.git@drmicha.warpmail.net>
References: <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 13:56:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNmEG-0003d0-TD
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 13:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204Ab0LAMzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 07:55:49 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:36454 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755173Ab0LAMzo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 07:55:44 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 11C9B5FA;
	Wed,  1 Dec 2010 07:55:44 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 01 Dec 2010 07:55:44 -0500
X-Sasl-enc: /xG5+A7A2LLepj6rREEK27N1bouxIwYF1SJaiatMIjcE 1291208143
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 8B0675E0507;
	Wed,  1 Dec 2010 07:55:43 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.617.g84f63
In-Reply-To: <7vd3pmw9n5.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1291207768.git.git@drmicha.warpmail.net>
References: <cover.1291207768.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162509>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-cvsimport.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 608cd63..fc77a3b 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -176,6 +176,13 @@ messages, bug-tracking systems, email archives, and the like.
 -h::
 	Print a short usage message and exit.
 
+CONFIG
+------
+For any option '-x' you can set the config variable 'cvsimport.x' to the value
+you would specify for '-x', or to 'true' for a boolean option. For an
+uppercase option '-X' use the config variable 'cvsimport.capital-x' (or
+'cvsimport.capital-X').
+
 OUTPUT
 ------
 If '-v' is specified, the script reports what it is doing.
-- 
1.7.3.2.617.g84f63

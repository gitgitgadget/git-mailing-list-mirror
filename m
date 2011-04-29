From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/2] diff-options.txt: describe --stat-{width,name-width,lines}
Date: Fri, 29 Apr 2011 16:57:46 +0200
Message-ID: <554098870eea307ea8f16e217f05413b5fe8fb5a.1304089050.git.git@drmicha.warpmail.net>
References: <5f16db0f3730be70ff522e63fbd491dc910c34d0.1304089050.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 16:58:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFp8o-0003yU-V7
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 16:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab1D2O5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 10:57:52 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:53187 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751697Ab1D2O5v (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2011 10:57:51 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 83DFE20846
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 10:57:51 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 29 Apr 2011 10:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id:in-reply-to:references; s=smtpout; bh=ypBlgHzFm2PPFi/TVmJgHi85iY8=; b=SIHA6Y4F2fEPrteu3H3i+WDMkczTttIsonELHBZiYnECjIMPFfz9m90Y1f4sHsFB5s2hAnYFmSt3zzZcdpcBSymn59FTPHQywl9jeUur2P5jxSzsehAUexqoHP0yLnXQSobBEhmGlWwuSe2X2yMBLgfxWx6ciPFb7aoGC+JKmv8=
X-Sasl-enc: u9NGb7WW4OQH1mqtlzrrfE1zZ2PLuFjmnV/G0uk+C41s 1304089071
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 043BF442DBC;
	Fri, 29 Apr 2011 10:57:50 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.250.g4493b
In-Reply-To: <5f16db0f3730be70ff522e63fbd491dc910c34d0.1304089050.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172454>

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/diff-options.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index e0429b3..ed8dbef 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -56,6 +56,9 @@ endif::git-format-patch[]
 	By giving a third parameter `<lines>`, you can limit the
 	output to the first and last `<lines>` lines, separated by
 	`...`.
++
+These parameters can also be set individually with `--stat-width=<width>`,
+`--stat-name-width=<name-width>` and `--stat-lines=<lines>`.
 
 --numstat::
 	Similar to `\--stat`, but shows number of added and
-- 
1.7.5.250.g4493b

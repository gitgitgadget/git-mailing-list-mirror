From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git.txt: fix list continuation
Date: Thu, 14 Apr 2011 09:17:26 +0200
Message-ID: <534233ecaf1b1e364954926ddbf11d47cf9b444e.1302765412.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 09:17:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAGo2-0007A9-N6
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 09:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757877Ab1DNHR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 03:17:29 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:45793 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752445Ab1DNHR3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2011 03:17:29 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C5736210F8;
	Thu, 14 Apr 2011 03:17:28 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute5.internal (MEProxy); Thu, 14 Apr 2011 03:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=eN8g9zkgIlAFTJin+NqSKXU4WcM=; b=RXQK6qLsbhFYZXeQbqYOVRVe1WUmAcD9l8jDwUBBRK9aES1cBbqhK2L/ALVViqr9HyGvANXIc+vrcxq8oFNIQ3d0fS0qLPZ7RncOgQn7o5QXriGexfahvzymkDujkY3QQ9wpaR6FXPv+d0hzejnCFetOhjlGa7dtPPg5ekK+7wI=
X-Sasl-enc: lk47kTjGLgjIgyMB0C9iEDHBy29vgrhrRYOdo1Kndw4i 1302765448
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 5600E4490A5;
	Thu, 14 Apr 2011 03:17:28 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.rc1.312.g1936c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171507>

Remove a spurious empty line which prevented asciidoc from recognizing a
list continuation mark ('+'), so that it does not get output literally any
more.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Should be safe for 1.7.5 :)
---
 Documentation/git.txt |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7df49ea..b8fa77b 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -622,7 +622,6 @@ where:
                          contents of <old|new>,
 	<old|new>-hex:: are the 40-hexdigit SHA1 hashes,
 	<old|new>-mode:: are the octal representation of the file modes.
-
 +
 The file parameters can point at the user's working file
 (e.g. `new-file` in "git-diff-files"), `/dev/null` (e.g. `old-file`
-- 
1.7.5.rc1.312.g1936c

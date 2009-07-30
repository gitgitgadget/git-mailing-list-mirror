From: "Wesley J. Landaker" <wjl@icecavern.net>
Subject: [PATCH 1/2] Documentation: git-send-email: fix submission port number
Date: Thu, 30 Jul 2009 17:08:53 -0600
Message-ID: <1248995334-28545-1-git-send-email-wjl@icecavern.net>
Cc: "Wesley J. Landaker" <wjl@icecavern.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 01:20:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWeuw-0002u8-IU
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 01:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbZG3XTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 19:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753160AbZG3XTh
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 19:19:37 -0400
Received: from rinoa.icecavern.net ([92.243.7.152]:49245 "EHLO icecavern.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753101AbZG3XTh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 19:19:37 -0400
X-Greylist: delayed 634 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Jul 2009 19:19:36 EDT
Received: from jenova.icecavern.net (c-76-113-110-228.hsd1.nm.comcast.net [76.113.110.228])
	by icecavern.net (Postfix) with ESMTPSA id EC2AE35A66;
	Fri, 31 Jul 2009 01:08:58 +0200 (CEST)
Received: from tonberry.icecavern.net (tonberry.icecavern.net [10.0.0.9])
	by jenova.icecavern.net (Postfix) with ESMTP id 48C1774C002;
	Thu, 30 Jul 2009 17:08:57 -0600 (MDT)
Received: by tonberry.icecavern.net (Postfix, from userid 1000)
	id 29E002FD8C; Thu, 30 Jul 2009 17:08:57 -0600 (MDT)
X-Mailer: git-send-email 1.6.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124488>

The current documentation confuses non-standard SSL smtp port 465 with
submission port 587 (RFC 4406). This patch just changes the referenced
number.

Signed-off-by: Wesley J. Landaker <wjl@icecavern.net>
---
 Documentation/git-send-email.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index d6b192b..1c94351 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -143,7 +143,7 @@ user is prompted for a password while the input is masked for privacy.
 --smtp-server-port=<port>::
 	Specifies a port different from the default port (SMTP
 	servers typically listen to smtp port 25 and ssmtp port
-	465); symbolic port names (e.g. "submission" instead of 465)
+	465); symbolic port names (e.g. "submission" instead of 587)
 	are also accepted. The port can also be set with the
 	'sendemail.smtpserverport' configuration variable.
 
-- 
1.6.3.1

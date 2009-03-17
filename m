From: "Emil Sit" <sit@emilsit.net>
Subject: [PATCH] config.txt: Describe special 'none' handling in core.gitProxy.
Date: Tue, 17 Mar 2009 13:31:42 -0400
Message-ID: <1237311102.24607.1305895377@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 18:33:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjdAD-0001nN-2p
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 18:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbZCQRbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 13:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754427AbZCQRbp
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 13:31:45 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:51098 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753624AbZCQRbo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 13:31:44 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 4B8552F2547
	for <git@vger.kernel.org>; Tue, 17 Mar 2009 13:31:42 -0400 (EDT)
Received: from web7.messagingengine.com ([10.202.2.216])
  by compute1.internal (MEProxy); Tue, 17 Mar 2009 13:31:42 -0400
Received: by web7.messagingengine.com (Postfix, from userid 99)
	id 2A39FFB0E3; Tue, 17 Mar 2009 13:31:42 -0400 (EDT)
X-Sasl-Enc: QrHbuXrdix/AC+Ip0SUg6H63eD5KuR8EVuEoIDb6CKPn 1237311102
X-Mailer: MessagingEngine.com Webmail Interface
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113509>


Signed-off-by: Emil Sit <sit@emilsit.net>
---
I noticed none support in connect.c that was not documented in config.txt.
Here's a small patch to explain it.

 Documentation/config.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 56bd781..d5532d2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -221,6 +221,11 @@ core.gitProxy::
 Can be overridden by the 'GIT_PROXY_COMMAND' environment variable
 (which always applies universally, without the special "for"
 handling).
++
+The special string `none` can be used as the proxy command to
+specify that no proxy be used for a given domain pattern.
+This is useful for excluding servers inside a firewall from
+proxy use, while defaulting to a common proxy for external domains.
 
 core.ignoreStat::
 	If true, commands which modify both the working tree and the index
-- 
1.6.1
-- 
Emil Sit / http://www.emilsit.net/

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC 4/6] convert doc links for other pages
Date: Fri, 12 Sep 2008 12:55:24 +0200
Message-ID: <1221216926-20435-6-git-send-email-git@drmicha.warpmail.net>
References: <1221216926-20435-1-git-send-email-git@drmicha.warpmail.net>
 <1221216926-20435-2-git-send-email-git@drmicha.warpmail.net>
 <1221216926-20435-3-git-send-email-git@drmicha.warpmail.net>
 <1221216926-20435-4-git-send-email-git@drmicha.warpmail.net>
 <1221216926-20435-5-git-send-email-git@drmicha.warpmail.net>
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 12:57:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke6L5-0003pN-Lp
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 12:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753232AbYILK4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 06:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbYILK4R
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 06:56:17 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:41143 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753203AbYILK4P (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2008 06:56:15 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 90B5E15ED71
	for <git@vger.kernel.org>; Fri, 12 Sep 2008 06:56:14 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 12 Sep 2008 06:56:14 -0400
X-Sasl-enc: c+UJvIYNbQen2DGIqD5TFl0jg4qSEF9iSiIDxOuGyHQt 1221216973
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E0A6C27AB4;
	Fri, 12 Sep 2008 06:56:13 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.308.gede4c
In-Reply-To: <1221216926-20435-5-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95703>

This converts the doc links for pages which do not start with git:
"everyday" and "curl"
We use the "linkgitasis" macro which preserves their name.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/config.txt           |    2 +-
 Documentation/gitcore-tutorial.txt |    2 +-
 Documentation/gitglossary.txt      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fe71aba..102ee48 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -801,7 +801,7 @@ help.autocorrect::
 
 http.proxy::
 	Override the HTTP proxy, normally configured using the 'http_proxy'
-	environment variable (see linkgit:curl[1]).  This can be overridden
+	environment variable (see linkgitasis:curl[1]).  This can be overridden
 	on a per-remote basis; see remote.<name>.proxy
 
 http.sslVerify::
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 579e2b2..af44361 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1691,7 +1691,7 @@ to follow, not easier.
 SEE ALSO
 --------
 linkgitasis:gittutorial[7], linkgitasis:gittutorial-2[7],
-linkgit:everyday[7], linkgitasis:gitcvs-migration[7],
+linkgitasis:everyday[7], linkgitasis:gitcvs-migration[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
diff --git a/Documentation/gitglossary.txt b/Documentation/gitglossary.txt
index 14c13fa..73aee50 100644
--- a/Documentation/gitglossary.txt
+++ b/Documentation/gitglossary.txt
@@ -17,7 +17,7 @@ include::glossary-content.txt[]
 SEE ALSO
 --------
 linkgitasis:gittutorial[7], linkgitasis:gittutorial-2[7],
-linkgit:everyday[7], linkgitasis:gitcvs-migration[7],
+linkgitasis:everyday[7], linkgitasis:gitcvs-migration[7],
 link:user-manual.html[The Git User's Manual]
 
 GIT
-- 
1.6.0.1.308.gede4c

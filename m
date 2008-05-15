From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Documentation: mention how to define multiple strategies
Date: Fri, 16 May 2008 00:10:17 +0200
Message-ID: <1210889417-21370-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 16 00:11:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwlfK-0005al-9K
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 00:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbYEOWKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 18:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbYEOWKS
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 18:10:18 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:58090 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbYEOWKR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 18:10:17 -0400
Received: from vmobile.example.net (dsl5401C014.pool.t-online.hu [84.1.192.20])
	by yugo.frugalware.org (Postfix) with ESMTP id A2CBF1DDC5B;
	Fri, 16 May 2008 00:10:15 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 1FCC3185E19; Fri, 16 May 2008 00:10:18 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82234>

pull.twohead and pull.octopus supports multiple default strategies but
this was undocumented and it was not obvious how to do so.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 Documentation/config.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 217980f..8a4abb2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -924,10 +924,12 @@ pack.packSizeLimit::
 
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
-	at once.
+	at once. Multiple strategies can be defined using a space
+	separated list.
 
 pull.twohead::
 	The default merge strategy to use when pulling a single branch.
+	Multiple strategies can be defined using a space separated list.
 
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
-- 
1.5.5

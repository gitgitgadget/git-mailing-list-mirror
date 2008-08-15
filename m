From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [EGIT PATCH] Enable diff=java for all *.java source files
Date: Fri, 15 Aug 2008 08:40:22 -0700
Message-ID: <1218814822-23307-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 17:41:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU1Qs-0000gd-0e
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 17:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756740AbYHOPkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 11:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754041AbYHOPkZ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 11:40:25 -0400
Received: from george.spearce.org ([209.20.77.23]:58050 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756307AbYHOPkY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 11:40:24 -0400
Received: by george.spearce.org (Postfix, from userid 1000)
	id 9B19738376; Fri, 15 Aug 2008 15:40:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.4 (2008-01-01) on george.spearce.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=4.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.4
Received: from localhost.localdomain (localhost [127.0.0.1])
	by george.spearce.org (Postfix) with ESMTP id 3B4F138265;
	Fri, 15 Aug 2008 15:40:23 +0000 (UTC)
X-Mailer: git-send-email 1.6.0.rc3.250.g8dd0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92488>

This (usually) gets more reasonable function headers to
appear in the header line for a diff hunk.  Its slightly
better than the default C rules.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 .gitattributes |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 .gitattributes

diff --git a/.gitattributes b/.gitattributes
new file mode 100644
index 0000000..f57840b
--- /dev/null
+++ b/.gitattributes
@@ -0,0 +1 @@
+*.java diff=java
-- 
1.6.0.rc3.250.g8dd0

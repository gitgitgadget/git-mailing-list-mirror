From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] CodingGuidelines: style for multi-line comments
Date: Sat, 12 Oct 2013 00:45:46 +0000
Message-ID: <1381538746-835885-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 02:45:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUnLA-0004V6-9l
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 02:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502Ab3JLApw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 20:45:52 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:32979 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754220Ab3JLApw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Oct 2013 20:45:52 -0400
Received: from vauxhall.crustytoothpaste.net (vauxhall.local [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id B51952807A
	for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:45:50 +0000 (UTC)
X-Mailer: git-send-email 1.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235933>

The style for multi-line comments is often mentioned and should be documented
for clarity.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/CodingGuidelines | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index e5ca3b7..a584062 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -145,6 +145,14 @@ For C programs:
    they were describing changes.  Often splitting a function
    into two makes the intention of the code much clearer.
 
+ - Multi-line comments should include their delimiters on separate lines from
+   the text. E.g.
+
+	/*
+	 * A very long
+	 * multi-line comment.
+	 */
+
  - Double negation is often harder to understand than no negation
    at all.
 
-- 
1.8.4

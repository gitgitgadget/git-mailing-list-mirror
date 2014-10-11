From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 2/4] Documentation: fix mismatched delimiters in git-imap-send
Date: Sat, 11 Oct 2014 23:37:34 +0000
Message-ID: <1413070656-241955-3-git-send-email-sandals@crustytoothpaste.net>
References: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 12 01:38:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xd6EZ-0004Lp-HH
	for gcvg-git-2@plane.gmane.org; Sun, 12 Oct 2014 01:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbaJKXhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Oct 2014 19:37:46 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49222 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751631AbaJKXhq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Oct 2014 19:37:46 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A54E928092
	for <git@vger.kernel.org>; Sat, 11 Oct 2014 23:37:42 +0000 (UTC)
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413070656-241955-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The documentation for git-imap-send uses block delimiters with
mismatched lengths, which Asciidoctor doesn't support.  As a result, the
page is misrendered.  Adjust the delimiters so that they are of the same
length.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-imap-send.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 7d991d9..c7c0d21 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -97,7 +97,7 @@ Using direct mode:
     host = imap://imap.example.com
     user = bob
     pass = p4ssw0rd
-..........................
+.........................
 
 Using direct mode with SSL:
 
@@ -109,7 +109,7 @@ Using direct mode with SSL:
     pass = p4ssw0rd
     port = 123
     sslverify = false
-..........................
+.........................
 
 
 EXAMPLE
-- 
2.1.1

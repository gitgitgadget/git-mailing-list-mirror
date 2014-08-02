From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] Documentation: avoid dangling modifier for imap-send
Date: Sat,  2 Aug 2014 23:57:01 +0000
Message-ID: <1407023821-103681-1-git-send-email-sandals@crustytoothpaste.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 03 01:57:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDjAq-0004ys-5H
	for gcvg-git-2@plane.gmane.org; Sun, 03 Aug 2014 01:57:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbaHBX5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 19:57:12 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49281 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751425AbaHBX5L (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Aug 2014 19:57:11 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6FF5F2808F
	for <git@vger.kernel.org>; Sat,  2 Aug 2014 23:57:09 +0000 (UTC)
X-Mailer: git-send-email 2.0.1
X-Spam-Score: -2.5 () ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254715>

Avoid a nonsensical misreading by moving the modifier closer to the
verb.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-imap-send.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 875d283..23231e1 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -43,7 +43,7 @@ imap.folder::
 imap.tunnel::
 	Command used to setup a tunnel to the IMAP server through which
 	commands will be piped instead of using a direct network connection
-	to the server. Required when imap.host is not set to use imap-send.
+	to the server. Required to use imap-send when imap.host is not set.
 
 imap.host::
 	A URL identifying the server. Use a `imap://` prefix for non-secure
-- 
2.0.1

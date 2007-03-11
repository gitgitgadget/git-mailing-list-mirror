From: Avi Kivity <avi@qumranet.com>
Subject: [PATCH 1/2] git-send-email: Document configuration options
Date: Sun, 11 Mar 2007 19:19:43 +0200
Message-ID: <1173633584748-git-send-email-avi@qumranet.com>
References: <11736335842565-git-send-email-avi@qumranet.com>
Cc: Avi Kivity <avi@qumranet.com>
To: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 18:41:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQS2o-0000wJ-IV
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 18:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933875AbXCKRlN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 13:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933885AbXCKRlN
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 13:41:13 -0400
Received: from il.qumranet.com ([82.166.9.18]:41884 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933875AbXCKRlM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 13:41:12 -0400
X-Greylist: delayed 1287 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Mar 2007 13:41:12 EDT
Received: by il.qumranet.com (Postfix, from userid 500)
	id AFD34A00B8; Sun, 11 Mar 2007 19:19:44 +0200 (IST)
X-Mailer: git-send-email 1.5.0.2
In-Reply-To: <11736335842565-git-send-email-avi@qumranet.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41947>

Wishing to implement an email aliases file, I found that they were already
implmented.  Document them for the next user.

Signed-off-by: Avi Kivity <avi@qumranet.com>
---
 Documentation/git-send-email.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 35b0104..367646e 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -91,6 +91,19 @@ The --cc option must be repeated for each user you want on the cc list.
 The --to option must be repeated for each user you want on the to list.
 
 
+CONFIGURATION
+-------------
+sendemail.aliasesfile::
+	To avoid typing long email addresses, point this to one or more
+	email aliases files.  You must also supply 'sendemail.aliasfiletype'.
+
+sendemail.aliasfiletype::
+	Format of the file(s) specified in sendemail.aliasesfile. Must be
+	one of 'mutt', 'mailrc', 'pine', or 'gnus'.
+
+sendemail.smtpserver::
+	Default smtp server to use.
+
 Author
 ------
 Written by Ryan Anderson <ryan@michonline.com>
-- 
1.5.0.2

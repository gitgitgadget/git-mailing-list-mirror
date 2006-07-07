From: Stephan Feder <sf@b-i-t.de>
Subject: [PATCH 3/3] diff-options: Explain --text and -a
Date: Fri, 07 Jul 2006 15:57:09 +0200
Message-ID: <11522806292890-git-send-email-sf@b-i-t.de>
References: <44AE4B35.6060607@b-i-t.de>
Reply-To: Stephan Feder <sf@b-i-t.de>
X-From: git-owner@vger.kernel.org Fri Jul 07 15:58:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fyqpc-0000jj-SA
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 15:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWGGN5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 09:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbWGGN5S
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 09:57:18 -0400
Received: from mail.medianet-world.de ([213.157.0.167]:42976 "HELO
	mail.medianet-world.de") by vger.kernel.org with SMTP
	id S1751216AbWGGN5P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 09:57:15 -0400
Received: (qmail 14874 invoked by uid 1011); 7 Jul 2006 13:57:14 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(0.1/5.0):. 
 Processed in 0.252843 secs); 07 Jul 2006 13:57:14 -0000
X-Spam-Status: No, hits=0.1 required=5.0
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de) (213.157.15.184)
  by mail.medianet-world.de with SMTP; 7 Jul 2006 13:57:14 -0000
Received: from localhost.localdomain (groa.b-i-t.de [192.168.168.40])
	by mail.b-i-t.de (Postfix) with ESMTP id D6F9028203;
	Fri,  7 Jul 2006 15:57:09 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.gbc483
In-Reply-To: <44AE4B35.6060607@b-i-t.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23441>

Signed-off-by: Stephan Feder <sf@b-i-t.de>
---
 Documentation/diff-options.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index f523ec2..1a93629 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -94,5 +94,11 @@
 	Swap two inputs; that is, show differences from index or
 	on-disk file to tree contents.
 
+--text::
+	Treat all files as text.
+
+-a::
+	Shorthand for "--text".
+
 For more detailed explanation on these common options, see also
 link:diffcore.html[diffcore documentation].
-- 
1.4.1.gbc483

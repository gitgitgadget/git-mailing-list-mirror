From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] [TRIVIAL] imap-send: use correct configuration variable in
 documentation
Date: Sat, 18 Apr 2009 13:26:42 +0200
Message-ID: <1240054002.12170.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 13:45:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lv8zR-0007vF-8b
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 13:45:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbZDRLoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 07:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753362AbZDRLoL
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 07:44:11 -0400
Received: from smtp-out1.tiscali.nl ([195.241.79.176]:45176 "EHLO
	smtp-out1.tiscali.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037AbZDRLoK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 07:44:10 -0400
X-Greylist: delayed 1045 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Apr 2009 07:44:10 EDT
Received: from [212.123.169.34] (helo=[192.168.1.61])
	by smtp-out1.tiscali.nl with esmtp 
	id 1Lv8h1-0005QY-W1; Sat, 18 Apr 2009 13:26:44 +0200
X-Mailer: Evolution 2.26.1 (2.26.1-2.fc11) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116825>

It's imap.pass (not imap.password).

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 Documentation/git-imap-send.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 024084b..d016daf 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -51,7 +51,7 @@ imap.host::
 imap.user::
 	The username to use when logging in to the server.
 
-imap.password::
+imap.pass::
 	The password to use when logging in to the server.
 
 imap.port::
-- 
1.6.2.2

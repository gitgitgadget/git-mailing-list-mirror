From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH 2/2] Google has renamed the imap folder
Date: Tue, 17 Feb 2009 10:12:15 +0000
Message-ID: <200902171012.15755.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 17 11:41:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZNOF-0003ab-HT
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 11:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbZBQKjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 05:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbZBQKjn
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 05:39:43 -0500
Received: from static.88-198-22-168.clients.your-server.de ([88.198.22.168]:8678
	"EHLO basyskom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbZBQKjm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 05:39:42 -0500
Received: by basyskom.de (Postfix, from userid 1051)
	id 1F143398864; Tue, 17 Feb 2009 11:12:20 +0100 (CET)
X-Spam-Flag: NO
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on new.basyskom.de
X-Spam-Info: No, score=-1.6 required=6.3 tests=AWL,BAYES_00,RCVD_IN_PBL,
	RDNS_DYNAMIC autolearn=no version=3.2.5
Received: from johnflux-desktop.localnet (58-190-81-184.eonet.ne.jp [58.190.81.184])
	by basyskom.de (Postfix) with ESMTP id 4D4263981FF
	for <git@vger.kernel.org>; Tue, 17 Feb 2009 11:12:18 +0100 (CET)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110353>

Also add a comment that the web interface wraps the lines

Signed-off-by: John Tapsell <johnflux@gmail.com>
---
 Documentation/SubmittingPatches |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 9b559ad..aa41c9e 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -491,12 +491,18 @@ message, complete the addressing and subject fields, and press send.
 Gmail
 -----
 
+GMail does not appear to have any way to turn off line wrapping in the web
+interface, so this will mangle any emails that you send.  You can however
+use any IMAP email client to connect to the google imap server, and forward
+the emails through that.  Just make sure to disable line wrapping in that
+email client.
+
 Submitting properly formatted patches via Gmail is simple now that
 IMAP support is available. First, edit your ~/.gitconfig to specify your
 account settings:
 
 [imap]
-	folder = "[Gmail]/Drafts"
+	folder = "[Google Mail]/Drafts"
 	host = imaps://imap.gmail.com
 	user = user@gmail.com
 	pass = p4ssw0rd
@@ -513,3 +519,5 @@ command to send the patch emails to your Gmail Drafts folder.
 
 Go to your Gmail account, open the Drafts folder, find the patch email, fill
 in the To: and CC: fields and send away!
+If you get an error that the "Folder doesn't exist" try with folder = "[Gmail]/Drafts".
+
-- 
1.6.2.rc1

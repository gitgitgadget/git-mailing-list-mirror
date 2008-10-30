From: _vi@list.ru
Subject: [PATCH] Documented --no-checkout option in git-svn
Date: Thu, 30 Oct 2008 18:08:20 +0200
Message-ID: <1225382900-22482-1-git-send-email-_vi@list.ru>
Cc: gitster@pobox.com, "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 30 17:41:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvaZu-0006rO-9i
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 17:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189AbYJ3Qjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 12:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754001AbYJ3Qjn
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 12:39:43 -0400
Received: from fallback.mail.ru ([194.67.57.14]:10730 "EHLO mx4.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759AbYJ3Qjn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 12:39:43 -0400
X-Greylist: delayed 1823 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Oct 2008 12:39:42 EDT
Received: from mx30.mail.ru (mx30.mail.ru [194.67.23.238])
	by mx4.mail.ru (mPOP.Fallback_MX) with ESMTP id 32FB310A89DF
	for <git@vger.kernel.org>; Thu, 30 Oct 2008 19:09:17 +0300 (MSK)
Received: from [212.95.48.19] (port=46217 helo=localhost.localdomain)
	by mx30.mail.ru with asmtp 
	id 1Kva4h-000Bog-00; Thu, 30 Oct 2008 19:08:44 +0300
X-Mailer: git-send-email 1.6.0.1.141.g445ca
X-Spam: Not detected
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99496>

From: Vitaly "_Vi" Shukela <public_vi@tut.by>

Signed-off-by: Vitaly "_Vi" Shukela <public_vi@tut.by>
---
 Documentation/git-svn.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 84c8f3c..90784a5 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -91,6 +91,9 @@ COMMANDS
 	tracking.  The name of the [svn-remote "..."] section in the
 	.git/config file may be specified as an optional command-line
 	argument.
+	
+--no-checkout
+	Do not checkout latest revision after fetching.
 
 'clone'::
 	Runs 'init' and 'fetch'.  It will automatically create a
@@ -103,6 +106,9 @@ COMMANDS
 	the working tree; and the 'rebase' command will be able
 	to update the working tree with the latest changes.
 
+--no-checkout
+	Do not checkout latest revision after fetching.
+
 'rebase'::
 	This fetches revisions from the SVN parent of the current HEAD
 	and rebases the current (uncommitted to SVN) work against it.
-- 
1.5.6.5

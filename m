From: Tony Finch <dot@dotat.at>
Subject: [PATCH] imap-send: clarify CRAM-MD5 vs LOGIN documentation
Date: Mon, 28 Jul 2014 11:38:20 +0100
Message-ID: <alpine.LSU.2.00.1407281138100.13901@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 13:02:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBihk-0001nM-4o
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 13:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbaG1LCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 07:02:52 -0400
Received: from ppsw-40.csi.cam.ac.uk ([131.111.8.140]:45238 "EHLO
	ppsw-40.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbaG1LCw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 07:02:52 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:49086)
	by ppsw-40.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XBiJw-0005id-mD (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 28 Jul 2014 11:38:20 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XBiJw-0005Mt-T9 (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Mon, 28 Jul 2014 11:38:20 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254305>

Explicitly mention that leaving imap.authMethod unset makes
git imap-send use the basic IMAP plaintext LOGIN command.
---
 Documentation/git-imap-send.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 875d283..770cbe8 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -76,7 +76,8 @@ imap.preformattedHTML::

 imap.authMethod::
 	Specify authenticate method for authentication with IMAP server.
-	Current supported method is 'CRAM-MD5' only.
+	Current supported method is 'CRAM-MD5' only. If this is not set
+	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.

 Examples
 ~~~~~~~~
-- 
2.0.3.dirty

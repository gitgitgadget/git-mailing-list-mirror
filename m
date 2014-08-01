From: Tony Finch <dot@dotat.at>
Subject: [PATCH v3 1/2] imap-send: clarify CRAM-MD5 vs LOGIN documentation
Date: Fri, 1 Aug 2014 09:15:48 +0100
Message-ID: <alpine.LSU.2.00.1408010915470.23775@hermes-1.csi.cam.ac.uk>
References: <alpine.LSU.2.00.1407312034410.25674@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 10:16:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XD80L-0000SK-22
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 10:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754199AbaHAIPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 04:15:51 -0400
Received: from ppsw-40.csi.cam.ac.uk ([131.111.8.140]:37125 "EHLO
	ppsw-40.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873AbaHAIPu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 04:15:50 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:59857)
	by ppsw-40.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XD80C-0007ja-kt (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Fri, 01 Aug 2014 09:15:48 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XD80C-0007Et-Dq (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Fri, 01 Aug 2014 09:15:48 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <alpine.LSU.2.00.1407312034410.25674@hermes-1.csi.cam.ac.uk>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254620>

Explicitly mention that leaving imap.authMethod unset makes
git imap-send use the basic IMAP plaintext LOGIN command.

Signed-off-by: Tony Finch <dot@dotat.at>
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
2.1.0.rc0.60.gb5b18e5

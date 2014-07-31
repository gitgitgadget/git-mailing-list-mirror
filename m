From: Tony Finch <dot@dotat.at>
Subject: [PATCH 1/2] imap-send: clarify CRAM-MD5 vs LOGIN documentation
Date: Thu, 31 Jul 2014 09:14:30 +0100
Message-ID: <alpine.LSU.2.00.1407310914260.13901@hermes-1.csi.cam.ac.uk>
References: <alpine.LSU.2.00.1407310910230.10413@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 31 10:14:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XClVV-0005Dk-Pe
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 10:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021AbaGaIOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 04:14:33 -0400
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:46618 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755917AbaGaIOc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 04:14:32 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-1.csi.cam.ac.uk ([131.111.8.51]:33925)
	by ppsw-50.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.158]:25)
	with esmtpa (EXTERNAL:fanf2) id 1XClVO-0008SV-sC (Exim 4.82_3-c0e5623) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 09:14:30 +0100
Received: from fanf2 by hermes-1.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local id 1XClVO-000608-N3 (Exim 4.72) for git@vger.kernel.org
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 31 Jul 2014 09:14:30 +0100
X-X-Sender: fanf2@hermes-1.csi.cam.ac.uk
In-Reply-To: <alpine.LSU.2.00.1407310910230.10413@hermes-1.csi.cam.ac.uk>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254539>

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
2.1.0.rc0.229.gaee38de

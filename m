From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 1/3] cvsserver: small corrections to asciidoc documentation
Date: Sat,  7 Apr 2007 16:58:08 +0200
Message-ID: <11759578902278-git-send-email-frank@lichtenheld.de>
References: <11759575342765-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 17:01:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaCP8-0007ux-5v
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 17:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965941AbXDGPAK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 11:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965953AbXDGPAJ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 11:00:09 -0400
Received: from mail.lenk.info ([217.160.134.107]:65074 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965941AbXDGPAI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 11:00:08 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HaCOv-0003J1-Ta; Sat, 07 Apr 2007 17:00:25 +0200
Received: from p54b0f651.dip.t-dialin.net ([84.176.246.81] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HaCOb-0005Ty-S1; Sat, 07 Apr 2007 17:00:06 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HaCMk-0007AG-Mb; Sat, 07 Apr 2007 16:58:10 +0200
X-Mailer: git-send-email 1.5.1
In-Reply-To: <11759575342765-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43974>

Fix a typo: s/Not/Note/

Some formating fixes: Use ` ` syntax for all filenames and
' ' syntax for all commandline switches.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsserver.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 6904aad..2cf8153 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -122,12 +122,12 @@ To get a checkout with the Eclipse CVS client:
 Protocol notes: If you are using anonymous access via pserver, just select that.
 Those using SSH access should choose the 'ext' protocol, and configure 'ext'
 access on the Preferences->Team->CVS->ExtConnection pane. Set CVS_SERVER to
-'git-cvsserver'. Not that password support is not good when using 'ext',
+'git-cvsserver'. Note that password support is not good when using 'ext',
 you will definitely want to have SSH keys setup.
 
 Alternatively, you can just use the non-standard extssh protocol that Eclipse
 offer. In that case CVS_SERVER is ignored, and you will have to replace
-the cvs utility on the server with git-cvsserver or manipulate your .bashrc
+the cvs utility on the server with git-cvsserver or manipulate your `.bashrc`
 so that calling 'cvs' effectively calls git-cvsserver.
 
 Clients known to work
@@ -146,9 +146,9 @@ checkout, diff, status, update, log, add, remove, commit.
 Legacy monitoring operations are not supported (edit, watch and related).
 Exports and tagging (tags and branches) are not supported at this stage.
 
-The server should set the -k mode to binary when relevant, however,
+The server should set the '-k' mode to binary when relevant, however,
 this is not really implemented yet. For now, you can force the server
-to set `-kb` for all files by setting the `gitcvs.allbinary` config
+to set '-kb' for all files by setting the `gitcvs.allbinary` config
 variable. In proper GIT tradition, the contents of the files are
 always respected. No keyword expansion or newline munging is supported.
 
-- 
1.5.1

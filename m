From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] git-shortlog: Fix two formatting errors in asciidoc documentation
Date: Thu, 19 Apr 2007 00:10:22 +0200
Message-ID: <11769342222941-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 00:24:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeIZs-000748-BX
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 00:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992877AbXDRWYB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 18:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992891AbXDRWYB
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 18:24:01 -0400
Received: from mail.lenk.info ([217.160.134.107]:4966 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992877AbXDRWYA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 18:24:00 -0400
X-Greylist: delayed 793 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Apr 2007 18:24:00 EDT
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HeILy-0000rh-Ag; Thu, 19 Apr 2007 00:10:18 +0200
Received: from p54b0f1e4.dip.t-dialin.net ([84.176.241.228] helo=feynman.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HeIM0-000673-4E; Thu, 19 Apr 2007 00:10:20 +0200
Received: from djpig by feynman.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@feynman.djpig.de>)
	id 1HeIM2-0000Fh-NY; Thu, 19 Apr 2007 00:10:22 +0200
X-Mailer: git-send-email 1.5.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44956>

First use [verse] in the SYNOPSIS so that the line break actually
shows.

Secondly drop the quotes around '.mailmap' since this exposes
a bug in our toolchain (didn't bother enough yet to find out wether
it is asciidoc's fault or that of the XSL templates) that leads to
the dot not getting escaped correctly in the roff output and thereby
swallowing the line.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-shortlog.txt |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

 I sometimes wonder if anyone except me actually reads the
 git man pages?

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index b0df92e..1c8c55e 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -7,6 +7,7 @@ git-shortlog - Summarize 'git log' output
 
 SYNOPSIS
 --------
+[verse]
 git-log --pretty=short | 'git-shortlog' [-h] [-n] [-s]
 git-shortlog [-n|--number] [-s|--summary] [<committish>...]
 
@@ -33,7 +34,8 @@ OPTIONS
 
 FILES
 -----
-'.mailmap'::
+
+.mailmap::
 	If this file exists, it will be used for mapping author email
 	addresses to a real author name. One mapping per line, first
 	the author name followed by the email address enclosed by
-- 
1.5.1.1

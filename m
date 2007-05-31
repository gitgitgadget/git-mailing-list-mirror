From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] git-config: Various small fixes to asciidoc documentation
Date: Thu, 31 May 2007 02:35:36 +0200
Message-ID: <11805717372779-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 31 02:35:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtYdm-00058Q-IU
	for gcvg-git@gmane.org; Thu, 31 May 2007 02:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbXEaAfi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 20:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753165AbXEaAfi
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 20:35:38 -0400
Received: from v32413.1blu.de ([88.84.155.73]:50434 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752320AbXEaAfh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 20:35:37 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HtYdb-0006kk-Pd; Thu, 31 May 2007 02:35:36 +0200
Received: from p54b0d6da.dip.t-dialin.net ([84.176.214.218] helo=dirac.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HtYdY-0002mg-15; Thu, 31 May 2007 02:35:32 +0200
Received: from djpig by dirac.djpig.de with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HtYdd-0006IG-IX; Thu, 31 May 2007 02:35:37 +0200
X-Mailer: git-send-email 1.5.2-rc3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48795>

Add '' around the only mentioned commandline option that didn't
had it.

Make reference to section EXAMPLE a link and rename it to
EXAMPLES because it actually contains a lot of examples ;)

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-config.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 827a499..8f4149f 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -31,7 +31,7 @@ If you want to update or unset an option which can occur on multiple
 lines, a POSIX regexp `value_regex` needs to be given.  Only the
 existing values that match the regexp are updated or unset.  If
 you want to handle the lines that do *not* match the regex, just
-prepend a single exclamation mark in front (see EXAMPLES).
+prepend a single exclamation mark in front (see also <<EXAMPLES>>).
 
 The type specifier can be either '--int' or '--bool', which will make
 'git-config' ensure that the variable(s) are of the given type and
@@ -48,7 +48,7 @@ This command will fail if:
 . the section or key is invalid,
 . you try to unset an option which does not exist,
 . you try to unset/set an option for which multiple lines match, or
-. you use --global option without $HOME being properly set.
+. you use '--global' option without $HOME being properly set.
 
 
 OPTIONS
@@ -119,8 +119,10 @@ GIT_CONFIG_LOCAL::
 	from the global configuration file in addition to the given file.
 
 
-EXAMPLE
--------
+
+[[EXAMPLES]]
+EXAMPLES
+--------
 
 Given a .git/config like this:
 
-- 
1.5.2-rc3.GIT

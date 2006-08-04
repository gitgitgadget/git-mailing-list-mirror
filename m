From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/4] Copy description of new build configuration variables to configure.ac
Date: Fri,  4 Aug 2006 17:55:59 +0200
Message-ID: <11547069594092-git-send-email-jnareb@gmail.com>
References: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 04 17:56:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G922H-0007FZ-Mt
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 17:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161269AbWHDP4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 11:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161263AbWHDP4L
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 11:56:11 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:64420 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1161265AbWHDP4I (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 11:56:08 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k74Ft7QE029222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 4 Aug 2006 17:55:07 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k74Fu091018897;
	Fri, 4 Aug 2006 17:56:00 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k74FtxT4018896;
	Fri, 4 Aug 2006 17:55:59 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <7v7j1on71n.fsf@assigned-by-dhcp.cox.net>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24799>

Copy description of new build configuration variables from the
commentary in the top Makefile, namely NO_FINK and NO_DARWIN_PORTS
configuration variables, putting them in site configuration section.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 configure.ac |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index a88219a..76bfa9d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -79,6 +79,18 @@ #
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports.
 #
+# Define NO_FINK if you are building on Darwin/Mac OS X, have Fink
+# installed in /sw, but don't want GIT to link against any libraries
+# installed there.  If defined you may specify your own (or Fink's)
+# include directories and library directories by defining CFLAGS
+# and LDFLAGS appropriately.
+#
+# Define NO_DARWIN_PORTS if you are building on Darwin/Mac OS X,
+# have DarwinPorts installed in /opt/local, but don't want GIT to
+# link against any libraries installed there.  If defined you may
+# specify your own (or DarwinPort's) include directories and
+# library directories by defining CFLAGS and LDFLAGS appropriately.
+#
 # Define NO_MMAP if you want to avoid mmap.
 #
 # Define SHELL_PATH to provide path to shell.
-- 
1.4.1.1

From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 9] configure.ac vertical whitespace usage cleanup
Date: Sat,  8 Jul 2006 23:07:14 +0200
Message-ID: <11523928383518-git-send-email-jnareb@gmail.com>
References: <200607030156.50455.jnareb@gmail.com> <1152392835436-git-send-email-jnareb@gmail.com> <11523928361444-git-send-email-jnareb@gmail.com> <1152392836910-git-send-email-jnareb@gmail.com> <1152392837823-git-send-email-jnareb@gmail.com> <11523928373026-git-send-email-jnareb@gmail.com> <11523928373299-git-send-email-jnareb@gmail.com> <11523928372070-git-send-email-jnareb@gmail.com>
Reply-To: Jakub Narebski <jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 08 23:26:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzKK8-0006Lt-4R
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 23:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030400AbWGHV0p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 17:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWGHV0p
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 17:26:45 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:37783 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S1030400AbWGHV0o (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 17:26:44 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k68LQBlm023686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Jul 2006 23:26:11 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k68L7IVc015609;
	Sat, 8 Jul 2006 23:07:18 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k68L7IFc015608;
	Sat, 8 Jul 2006 23:07:18 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <11523928372070-git-send-email-jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23512>

 configure.ac |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/configure.ac b/configure.ac
index 56e765f..acea6ce 100644
--- a/configure.ac
+++ b/configure.ac
@@ -23,41 +23,41 @@ AC_DEFUN([GIT_CONF_APPEND_LINE],
 
 ## Checks for programs.
 AC_MSG_NOTICE([CHECKS for programs])
-
+#
 AC_PROG_CC
 #AC_PROG_INSTALL		# needs install-sh or install.sh in sources
 AC_CHECK_TOOL(AR, ar, :)
 AC_CHECK_PROGS(TAR, [gtar tar])
-
+#
 # Define NO_PYTHON if you want to loose all benefits of the recursive merge.
 
 
 ## Checks for libraries.
 AC_MSG_NOTICE([CHECKS for libraries])
-
+#
 # Define NO_OPENSSL environment variable if you do not have OpenSSL.
 # Define NEEDS_SSL_WITH_CRYPTO if you need -lcrypto with -lssl (Darwin).
 AC_CHECK_LIB([ssl], [SHA1_Init],[],
 [AC_CHECK_LIB([crypto], [SHA1_INIT],
  GIT_CONF_APPEND_LINE(NEEDS_SSL_WITH_CRYPTO=YesPlease),
  GIT_CONF_APPEND_LINE(NO_OPENSSL=YesPlease))])
-
+#
 # Define NO_CURL if you do not have curl installed.  git-http-pull and
 # git-http-push are not built, and you cannot use http:// and https://
 # transports.
 AC_CHECK_LIB([curl], [curl_global_init],[],
 GIT_CONF_APPEND_LINE(NO_CURL=YesPlease))
-
+#
 # Define NO_EXPAT if you do not have expat installed.  git-http-push is
 # not built, and you cannot push using http:// and https:// transports.
 AC_CHECK_LIB([expat], [XML_ParserCreate],[],
 GIT_CONF_APPEND_LINE(NO_EXPAT=YesPlease))
-
+#
 # Define NEEDS_LIBICONV if linking with libc is not enough (Darwin).
 AC_CHECK_LIB([c], [iconv],[],
 [AC_CHECK_LIB([iconv],[iconv],
  GIT_CONF_APPEND_LINE(NEEDS_LIBICONV=YesPlease),[])])
-
+#
 # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
 # Patrick Mauritz).
 AC_CHECK_LIB([c], [socket],[],
@@ -70,18 +70,18 @@ ## Checks for header files.
 
 ## Checks for typedefs, structures, and compiler characteristics.
 AC_MSG_NOTICE([CHECKS for typedefs, structures, and compiler characteristics])
-
+#
 # Define NO_D_INO_IN_DIRENT if you don't have d_ino in your struct dirent.
 AC_CHECK_MEMBER(struct dirent.d_ino,[],
 GIT_CONF_APPEND_LINE(NO_D_INO_IN_DIRENT=YesPlease),
 [#include <dirent.h>])
-
+#
 # Define NO_D_TYPE_IN_DIRENT if your platform defines DT_UNKNOWN but lacks
 # d_type in struct dirent (latest Cygwin -- will be fixed soonish).
 AC_CHECK_MEMBER(struct dirent.d_type,[],
 GIT_CONF_APPEND_LINE(NO_D_TYPE_IN_DIRENT=YesPlease),
 [#include <dirent.h>])
-
+#
 # Define NO_SOCKADDR_STORAGE if your platform does not have struct
 # sockaddr_storage.
 AC_CHECK_TYPE(struct sockaddr_storage,[],
@@ -92,19 +92,19 @@ GIT_CONF_APPEND_LINE(NO_SOCKADDR_STORAGE
 ## Checks for library functions.
 ## (in default C library and libraries checked by AC_CHECK_LIB)
 AC_MSG_NOTICE([CHECKS for library functions])
-
+#
 # Define NO_STRCASESTR if you don't have strcasestr.
 AC_CHECK_FUNC(strcasestr,[],
 GIT_CONF_APPEND_LINE(NO_STRCASESTR=YesPlease))
-
+#
 # Define NO_STRLCPY if you don't have strlcpy.
 AC_CHECK_FUNC(strlcpy,[],
 GIT_CONF_APPEND_LINE(NO_STRLCPY=YesPlease))
-
+#
 # Define NO_SETENV if you don't have setenv in the C library.
 AC_CHECK_FUNC(setenv,[],
 GIT_CONF_APPEND_LINE(NO_SETENV=YesPlease))
-
+#
 # Define NO_MMAP if you want to avoid mmap.
 #
 # Define NO_IPV6 if you lack IPv6 support and getaddrinfo().
@@ -178,5 +178,6 @@ ## Output files
 AC_CONFIG_FILES(["${config_file}":"${config_in}":"${config_append}"])
 AC_OUTPUT
 
+
 ## Cleanup
 rm -f "${config_append}"
-- 
1.4.0

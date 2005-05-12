From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] Remove heading and trailing empty lines from commit
	messages
Date: Thu, 12 May 2005 22:44:30 +0200
Message-ID: <1115930670.18499.64.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-judaxNf5L0QhK/mHttnJ"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 12 22:37:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWKQK-0000YX-55
	for gcvg-git@gmane.org; Thu, 12 May 2005 22:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVELUoV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 16:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVELUoV
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 16:44:21 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:8369 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262116AbVELUoI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 16:44:08 -0400
Received: from pegasus (p5487C16D.dip.t-dialin.net [84.135.193.109])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j4CKjVWX018831
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Thu, 12 May 2005 22:45:32 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.83/875/Tue May 10 13:27:59 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-judaxNf5L0QhK/mHttnJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

the attached patch removes heading and trailing empty lines from the
commit message before doing the commit.

Regards

Marcel


Signed-off-by: Marcel Holtmann <marcel@holtmann.org>


--=-judaxNf5L0QhK/mHttnJ
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: cg-commit
===================================================================
--- 00b94eea5b99d5dd1d1bbe9c9ca3502d11aec581/cg-commit  (mode:100755)
+++ uncommitted/cg-commit  (mode:100755)
@@ -134,7 +134,7 @@
 else
 	cat >>$LOGMSG2
 fi
-grep -v ^CG: $LOGMSG2 >$LOGMSG
+grep -v ^CG: $LOGMSG2 | sed '/./,${/./b;:a;$d;N;/\n$/ba;b;};d' >$LOGMSG
 rm $LOGMSG2
 
 

--=-judaxNf5L0QhK/mHttnJ--


From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] Remove heading and trailing empty lines from commit
	messages
Date: Mon, 09 May 2005 02:28:33 +0200
Message-ID: <1115598513.8949.86.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-sYA188Y3QmAW/pzzAoAX"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 02:21:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUw1E-0005L7-9N
	for gcvg-git@gmane.org; Mon, 09 May 2005 02:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbVEIA2O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 20:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbVEIA2O
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 20:28:14 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:7854 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S263017AbVEIA2J
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 8 May 2005 20:28:09 -0400
Received: from pegasus (p5487D02F.dip.t-dialin.net [84.135.208.47])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j490TSWX008244
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Mon, 9 May 2005 02:29:28 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV version 0.83, clamav-milter version 0.83 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-sYA188Y3QmAW/pzzAoAX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

the attached patch removes heading and trailing empty lines from the
commit message before doing the commit.

Regards

Marcel


--=-sYA188Y3QmAW/pzzAoAX
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

cg-commit: needs update
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
 
 

--=-sYA188Y3QmAW/pzzAoAX--


From: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH Cogito] More flexiable colorize for Acked-by statement
Date: Tue, 21 Jun 2005 00:19:08 +0200
Message-ID: <1119305948.26772.77.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-BtBB9deRgyq0yYaYU3kh"
Cc: GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 21 00:30:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkUmE-0005l9-Ng
	for gcvg-git@gmane.org; Tue, 21 Jun 2005 00:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262326AbVFTWUi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 18:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262319AbVFTWTr
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 18:19:47 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:2766 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S262310AbVFTWTL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2005 18:19:11 -0400
Received: from pegasus (p5487D28A.dip.t-dialin.net [84.135.210.138])
	by mail.holtmann.net (8.12.3/8.12.3/Debian-7.1) with ESMTP id j5KMLKSs013720
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO);
	Tue, 21 Jun 2005 00:21:21 +0200
To: Petr Baudis <pasky@ucw.cz>
X-Mailer: Evolution 2.2.2 
X-Virus-Scanned: ClamAV 0.85.1/947/Mon Jun 20 21:39:23 2005 on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-BtBB9deRgyq0yYaYU3kh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Petr,

the attached patch makes the colorize of the Acked-by statement a little
bit more flexible. It seems like people tend to use various combinations
of upper and lower case letters.

Regards

Marcel


Signed-off-by: Marcel Holtmann <marcel@holtmann.org>


--=-BtBB9deRgyq0yYaYU3kh
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -265,7 +265,7 @@ print_commit_log()
 	sed -e '
 		s/^    \(.*\)/% \1/
 		/^% *[Ss]igned-[Oo]ff-[Bb]y:.*/ s/^% \(.*\)/% '$colsignoff'\1'$coldefault'/
-		/^% *[Aa]cked-[Bb]y:.*/ s/^% \(.*\)/% '$colsignoff'\1'$coldefault'/
+		/^% *[Aa][Cc][Kk]ed-[Bb]y:.*/ s/^% \(.*\)/% '$colsignoff'\1'$coldefault'/
 	' | while read key rest; do
 		trap exit SIGPIPE
 		process_commit_line

--=-BtBB9deRgyq0yYaYU3kh--


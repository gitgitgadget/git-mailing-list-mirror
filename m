From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 2/4] config.txt: Document core.autocrlf
Date: Fri, 13 Apr 2007 18:02:31 +0200
Message-ID: <11764801532182-git-send-email-frank@lichtenheld.de>
References: <11764801533023-git-send-email-frank@lichtenheld.de>
Cc: Junio C Hamano <junkio@cox.net>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 13 18:04:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcOGF-0000T6-Sk
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 18:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbXDMQDt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 12:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbXDMQDt
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 12:03:49 -0400
Received: from mail.lenk.info ([217.160.134.107]:1045 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754070AbXDMQDs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 12:03:48 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HcOFM-0008R9-4j; Fri, 13 Apr 2007 18:03:36 +0200
Received: from p3ee3f548.dip.t-dialin.net ([62.227.245.72] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HcOFV-0000yN-Ql; Fri, 13 Apr 2007 18:03:46 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HcOEV-0001nR-Qy; Fri, 13 Apr 2007 18:02:43 +0200
X-Mailer: git-send-email 1.5.1.1
In-Reply-To: <11764801533023-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44414>

Text shamelessly stolen from the 1.5.1 release notes.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/config.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 061c585..09c355b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -117,6 +117,16 @@ core.fileMode::
 	the working copy are ignored; useful on broken filesystems like FAT.
 	See gitlink:git-update-index[1]. True by default.
 
+core.autocrlf::
+	If true, makes git convert `CRLF` at the end of lines in text files to
+	`LF` when reading from the filesystem, and convert in reverse when
+	writing to the filesystem.  The variable can be set to
+	'input', in which case the conversion happens only while
+    	reading from the filesystem but files are written out with
+    	`LF` at the end of lines.  Currently, which paths to consider
+	"text" (i.e. be subjected to the autocrlf mechanism) is
+	decided purely based on the contents.
+
 core.symlinks::
 	If false, symbolic links are checked out as small plain files that
 	contain the link text. gitlink:git-update-index[1] and
-- 
1.5.1.1

From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] Documentation: format-patch has no --mbox option
Date: Mon, 14 May 2007 16:44:52 +0200
Message-ID: <11791538941530-git-send-email-frank@lichtenheld.de>
References: <1179153893715-git-send-email-frank@lichtenheld.de>
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 16:45:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnbnQ-0005Np-Ab
	for gcvg-git@gmane.org; Mon, 14 May 2007 16:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670AbXENOpA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 10:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754696AbXENOpA
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 10:45:00 -0400
Received: from mail.lenk.info ([217.160.134.107]:4137 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670AbXENOo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 10:44:57 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hnblw-0001wx-4K; Mon, 14 May 2007 16:43:36 +0200
Received: from p54b0d0fd.dip.t-dialin.net ([84.176.208.253] helo=localhost)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HnbnB-0000hY-OQ; Mon, 14 May 2007 16:44:53 +0200
Received: from djpig by localhost with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HnbnC-0005k8-2L; Mon, 14 May 2007 16:44:54 +0200
X-Mailer: git-send-email 1.5.1.4
In-Reply-To: <1179153893715-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47247>

git-applymbox and git-mailinfo refer to a --mbox
option of git-format-patch. But there is no such
option AFAICT. mbox output can produced with
format-patch --stdout.

This patch only replaces --mbox with --stdout.
Some further explanation and/or format-patch
arguments (e.g. -k) might be needed.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-applymbox.txt |    2 +-
 Documentation/git-mailinfo.txt  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-applymbox.txt b/Documentation/git-applymbox.txt
index 3bc92d8..761ca3e 100644
--- a/Documentation/git-applymbox.txt
+++ b/Documentation/git-applymbox.txt
@@ -31,7 +31,7 @@ OPTIONS
 	whitespaces, (3) '[' up to ']', typically '[PATCH]', and
 	then prepends "[PATCH] ".  This flag forbids this
 	munging, and is most useful when used to read back 'git
-	format-patch --mbox' output.
+	format-patch --stdout' output.
 
 -m::
 	Patches are applied with `git-apply` command, and unless
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index ba18133..d49eee9 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -30,7 +30,7 @@ OPTIONS
 	whitespaces, (3) '[' up to ']', typically '[PATCH]', and
 	then prepends "[PATCH] ".  This flag forbids this
 	munging, and is most useful when used to read back 'git
-	format-patch --mbox' output.
+	format-patch --stdout' output.
 
 -u::
 	The commit log message, author name and author email are
-- 
1.5.1.4

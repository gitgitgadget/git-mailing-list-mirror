From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] builtin-log.c: Fix typo in comment
Date: Mon, 14 May 2007 16:44:51 +0200
Message-ID: <11791538933653-git-send-email-frank@lichtenheld.de>
References: <1179153893715-git-send-email-frank@lichtenheld.de>
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 16:45:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnbnP-0005Np-A4
	for gcvg-git@gmane.org; Mon, 14 May 2007 16:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbXENOo5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 10:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754689AbXENOo5
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 10:44:57 -0400
Received: from mail.lenk.info ([217.160.134.107]:1537 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbXENOo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 10:44:56 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hnblw-0001ww-4L; Mon, 14 May 2007 16:43:36 +0200
Received: from p54b0d0fd.dip.t-dialin.net ([84.176.208.253] helo=localhost)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HnbnB-0000hX-OF; Mon, 14 May 2007 16:44:53 +0200
Received: from djpig by localhost with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HnbnB-0005k6-SW; Mon, 14 May 2007 16:44:53 +0200
X-Mailer: git-send-email 1.5.1.4
In-Reply-To: <1179153893715-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47245>

s/fmt-patch/format-patch/

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 builtin-log.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 38bf52f..3744712 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -454,7 +454,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	/*
 	 * Parse the arguments before setup_revisions(), or something
-	 * like "git fmt-patch -o a123 HEAD^.." may fail; a123 is
+	 * like "git format-patch -o a123 HEAD^.." may fail; a123 is
 	 * possibly a valid SHA1.
 	 */
 	for (i = 1, j = 1; i < argc; i++) {
-- 
1.5.1.4

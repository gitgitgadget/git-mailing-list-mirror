From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/3] merge-one-file: fix late-night typo
Date: Wed, 24 Jan 2007 12:26:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241225420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Jan 24 12:26:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9gHH-0005R2-QH
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 12:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbXAXL0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 06:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbXAXL0n
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 06:26:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:57210 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751251AbXAXL0a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 06:26:30 -0500
Received: (qmail invoked by alias); 24 Jan 2007 11:26:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 24 Jan 2007 12:26:28 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37627>


While fixing up some debugging cruft, this slipped in.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	One day I will learn not to send off things when too tired.
	*sigh*

 builtin-merge-one-file.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-merge-one-file.c b/builtin-merge-one-file.c
index 5f74c6b..75774ce 100644
--- a/builtin-merge-one-file.c
+++ b/builtin-merge-one-file.c
@@ -25,7 +25,7 @@ int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < 3; i++) {
 		char *p;
 		hashes[i] = buffers[i];
-		if (!*argv[i + 1] || *argv[i + 1])
+		if (!argv[i + 1] || !*argv[i + 1])
 			hashes[i] = NULL;
 		else if (get_sha1_hex(argv[i + 1], buffers[i]))
 			return error("invalid hash: %s\n", argv[i + 1]);
-- 
1.5.0.rc2.gee75e-dirty

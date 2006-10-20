From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] Fix typo in show-index.c
Date: Fri, 20 Oct 2006 23:24:32 +0200
Message-ID: <11613794723762-git-send-email-hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 20 23:24:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb1r4-0002OD-CK
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 23:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992613AbWJTVYf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 17:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423236AbWJTVYf
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 17:24:35 -0400
Received: from mail48.e.nsc.no ([193.213.115.48]:16031 "EHLO mail48.e.nsc.no")
	by vger.kernel.org with ESMTP id S1423237AbWJTVYf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 17:24:35 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no [80.213.28.208])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id k9KLOWh1026747
	for <git@vger.kernel.org>; Fri, 20 Oct 2006 23:24:32 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.3.ge193
Date: Fri, 20 Oct 2006 22:55:37 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29542>

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 show-index.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/show-index.c b/show-index.c
index c21d660..a30a2de 100644
--- a/show-index.c
+++ b/show-index.c
@@ -8,7 +8,7 @@ int main(int argc, char **argv)
 	static unsigned int top_index[256];
 
 	if (fread(top_index, sizeof(top_index), 1, stdin) != 1)
-		die("unable to read idex");
+		die("unable to read index");
 	nr = 0;
 	for (i = 0; i < 256; i++) {
 		unsigned n = ntohl(top_index[i]);
-- 
1.4.3.rc2.g4035b

From: Stephan Feder <sf@b-i-t.de>
Subject: [PATCH 1/3] Teach diff -a as shorthand for --text
Date: Fri, 07 Jul 2006 15:57:07 +0200
Message-ID: <11522806291956-git-send-email-sf@b-i-t.de>
References: <44AE4B35.6060607@b-i-t.de>
Reply-To: Stephan Feder <sf@b-i-t.de>
X-From: git-owner@vger.kernel.org Fri Jul 07 15:57:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fyqpf-0000jj-Cd
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 15:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWGGN5Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 09:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWGGN5Q
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 09:57:16 -0400
Received: from mail.medianet-world.de ([213.157.0.167]:15812 "HELO
	mail.medianet-world.de") by vger.kernel.org with SMTP
	id S1751213AbWGGN5P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 09:57:15 -0400
Received: (qmail 14876 invoked by uid 1011); 7 Jul 2006 13:57:14 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(0.1/5.0):. 
 Processed in 0.355802 secs); 07 Jul 2006 13:57:14 -0000
X-Spam-Status: No, hits=0.1 required=5.0
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de) (213.157.15.184)
  by mail.medianet-world.de with SMTP; 7 Jul 2006 13:57:14 -0000
Received: from localhost.localdomain (groa.b-i-t.de [192.168.168.40])
	by mail.b-i-t.de (Postfix) with ESMTP id B177215444;
	Fri,  7 Jul 2006 15:57:09 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.gbc483
In-Reply-To: <44AE4B35.6060607@b-i-t.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23440>

Signed-off-by: Stephan Feder <sf@b-i-t.de>
---
 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 1f0219d..b423491 100644
--- a/diff.c
+++ b/diff.c
@@ -1561,7 +1561,7 @@ int diff_opt_parse(struct diff_options *
 		options->output_format |= DIFF_FORMAT_PATCH;
 		options->full_index = options->binary = 1;
 	}
-	else if (!strcmp(arg, "--text")) {
+	else if (!strcmp(arg, "-a") || !strcmp(arg, "--text")) {
 		options->text = 1;
 	}
 	else if (!strcmp(arg, "--name-only"))
-- 
1.4.1.gbc483

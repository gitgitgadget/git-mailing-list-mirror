From: Stephan Feder <sf@b-i-t.de>
Subject: [PATCH 2/3] Add -a and --text to common diff options help
Date: Fri, 07 Jul 2006 15:57:08 +0200
Message-ID: <11522806292871-git-send-email-sf@b-i-t.de>
References: <44AE4B35.6060607@b-i-t.de>
Reply-To: Stephan Feder <sf@b-i-t.de>
X-From: git-owner@vger.kernel.org Fri Jul 07 15:58:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fyqpd-0000jj-Dc
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 15:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWGGN5R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 09:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbWGGN5R
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 09:57:17 -0400
Received: from mail.medianet-world.de ([213.157.0.167]:44692 "HELO
	mail.medianet-world.de") by vger.kernel.org with SMTP
	id S1751215AbWGGN5P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 09:57:15 -0400
Received: (qmail 14872 invoked by uid 1011); 7 Jul 2006 13:57:14 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(0.1/5.0):. 
 Processed in 0.258224 secs); 07 Jul 2006 13:57:14 -0000
X-Spam-Status: No, hits=0.1 required=5.0
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de) (213.157.15.184)
  by mail.medianet-world.de with SMTP; 7 Jul 2006 13:57:14 -0000
Received: from localhost.localdomain (groa.b-i-t.de [192.168.168.40])
	by mail.b-i-t.de (Postfix) with ESMTP id C33E928202;
	Fri,  7 Jul 2006 15:57:09 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.1.gbc483
In-Reply-To: <44AE4B35.6060607@b-i-t.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23442>

Signed-off-by: Stephan Feder <sf@b-i-t.de>
---
 diff.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/diff.h b/diff.h
index f80f646..8ab0448 100644
--- a/diff.h
+++ b/diff.h
@@ -162,7 +162,8 @@ #define COMMON_DIFF_OPTIONS_HELP \
 "  -O<file>      reorder diffs according to the <file>.\n" \
 "  -S<string>    find filepair whose only one side contains the string.\n" \
 "  --pickaxe-all\n" \
-"                show all files diff when -S is used and hit is found.\n"
+"                show all files diff when -S is used and hit is found.\n" \
+"  -a  --text    treat all files as text.\n"
 
 extern int diff_queue_is_empty(void);
 extern void diff_flush(struct diff_options*);
-- 
1.4.1.gbc483

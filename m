From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] diff-raw: Use 'A' instead of 'N' for added files.
Date: Mon, 25 Jul 2005 17:21:05 -0700
Message-ID: <7vbr4qfmdq.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722204120.GD11916@pasky.ji.cz>
	<7vr7dqpmm4.fsf@assigned-by-dhcp.cox.net>
	<20050722212725.GJ11916@pasky.ji.cz>
	<7v8xzyh1ak.fsf@assigned-by-dhcp.cox.net>
	<7vpst6fmif.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 02:22:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxDDV-0007OU-Jn
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 02:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVGZAV4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jul 2005 20:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbVGZAV4
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jul 2005 20:21:56 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:37015 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261559AbVGZAVH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2005 20:21:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050726002102.UJMA12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 25 Jul 2005 20:21:02 -0400
To: Petr Baudis <pasky@suse.cz>,
	Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <7vpst6fmif.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Mon, 25 Jul 2005 17:18:16 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This actually changes the diff-raw status letter from N to A
for added files.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 diff.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

ca8c9156f8f980455f64e2cedcf0347328e46029
diff --git a/diff.h b/diff.h
--- a/diff.h
+++ b/diff.h
@@ -83,7 +83,7 @@ extern int diff_queue_is_empty(void);
 extern void diff_flush(int output_style, int line_terminator);
 
 /* diff-raw status letters */
-#define DIFF_STATUS_ADDED		'N'
+#define DIFF_STATUS_ADDED		'A'
 #define DIFF_STATUS_COPIED		'C'
 #define DIFF_STATUS_DELETED		'D'
 #define DIFF_STATUS_MODIFIED		'M'

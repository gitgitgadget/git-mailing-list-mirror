From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] merge-options.txt: Clarify merge --squash
Date: Mon, 25 May 2009 18:00:10 +0200
Message-ID: <1243267210-28997-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 25 18:00:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8cbN-0004mg-77
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 18:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbZEYQAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2009 12:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbZEYQAV
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 12:00:21 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43197 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752402AbZEYQAU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 12:00:20 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 32BF3346453;
	Mon, 25 May 2009 12:00:22 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 25 May 2009 12:00:22 -0400
X-Sasl-enc: eg5f+2NG3HKr3C3lpT6FLFlrrIxYT4lxoKwi1QdC/i8d 1243267221
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 91E2B75C7;
	Mon, 25 May 2009 12:00:21 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.1.241.g24356
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119940>

With the --squash option, merge sets up the index just like for a real
merge, but without the merge info (stages). Say so.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
I think this kind of fell under the rug back then when it was discussed
(http://permalink.gmane.org/gmane.comp.version-control.git/119185).
So I'm resending it.

Cheers,
Michael

 Documentation/merge-options.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 637b53f..adadf8e 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -39,7 +39,8 @@
 
 --squash::
 	Produce the working tree and index state as if a real
-	merge happened, but do not actually make a commit or
+	merge happened (except for the merge information),
+	but do not actually make a commit or
 	move the `HEAD`, nor record `$GIT_DIR/MERGE_HEAD` to
 	cause the next `git commit` command to create a merge
 	commit.  This allows you to create a single commit on
-- 
1.6.3.1.241.g24356

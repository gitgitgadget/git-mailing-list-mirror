From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-branch.txt: document -f correctly
Date: Tue, 17 Mar 2009 15:06:20 +0100
Message-ID: <1237298780-11304-1-git-send-email-git@drmicha.warpmail.net>
References: <7vtz5ssk0s.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 15:08:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjZxe-0000Zl-M8
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 15:08:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbZCQOGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 10:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbZCQOGh
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 10:06:37 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:53723 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751290AbZCQOGg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 10:06:36 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id B5E062F3552;
	Tue, 17 Mar 2009 10:06:34 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 17 Mar 2009 10:06:34 -0400
X-Sasl-enc: CBOpxjSDGXxXppKyocI2EjcnwX/G8HAKVickmj6fk024 1237298794
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1317F1CA4C;
	Tue, 17 Mar 2009 10:06:33 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.149.g6462
In-Reply-To: <7vtz5ssk0s.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113472>

'git branch -f a b' resets a to b when a exists, rather then deleting a.
Say so in the documentation.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Something like this?

BTW, I noticed that 'git-subcmd' is used everywhere in here which does
not feel right, but I followed the existing style, leaving a consistent
clean-up for a later patch. Also, typesetting is inconsistent:
We have <branch> as well as `<branch>` when the text talks about the
options. Do we have a style guide or such?

 Documentation/git-branch.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 6103d62..27b73bc 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -76,8 +76,8 @@ OPTIONS
 	based sha1 expressions such as "<branchname>@\{yesterday}".
 
 -f::
-	Force the creation of a new branch even if it means deleting
-	a branch that already exists with the same name.
+	Reset <branchname> to <startpoint> if <branchname> exists
+	already. Without `-f` 'git-branch' refuses to change an existing branch.
 
 -m::
 	Move/rename a branch and the corresponding reflog.
-- 
1.6.2.149.g6462

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 5/6] git-reset.txt: point to git-checkout
Date: Wed, 15 Sep 2010 22:47:43 +0200
Message-ID: <4503439028b2670c7abd090115fc83d266794611.1284582409.git.git@drmicha.warpmail.net>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 15 22:49:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovyup-0005JE-OP
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 22:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755172Ab0IOUry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 16:47:54 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:32820 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755158Ab0IOUrx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 16:47:53 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D0816609;
	Wed, 15 Sep 2010 16:47:52 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 15 Sep 2010 16:47:52 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=dprY0rMeIsUVHak/THxVTV15sq4=; b=c5ezgUXPXDuaH7svWEsrtMqMKIE/3Bqh2pV/WyJlDBn7pCaFEsSH2+HeKLn3gx1p4PmG2ffPE86PM11kKza/6UZntUz46gMxnzXUYlHLR4bexYxsKPuvXUJNW8afVxQq4Jgaj35+v8Wb116O9rdriiygJuuMsk/In0AHhmxSRpY=
X-Sasl-enc: rzAxytod4poJuOhowC3XULInQ3y5f+7GgGzNQVSwAF6+ 1284583672
Received: from localhost (p548580A7.dip0.t-ipconnect.de [84.133.128.167])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 30AED4023C4;
	Wed, 15 Sep 2010 16:47:52 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc1.215.g6997c
In-Reply-To: <cover.1284365021.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1284582409.git.git@drmicha.warpmail.net>
References: <cover.1284582409.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156250>

for the case of updating a file in index and worktree, or from the index
to the worktree.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/git-reset.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 6c94f83..78f3b74 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -26,6 +26,13 @@ in all forms.
 +
 This means that `git reset <paths>` is the opposite of `git add
 <paths>`.
++
+After running `git reset <paths>` to update the index entry, you can
+use linkgit:git-checkout[1] to check the contents out of the index to
+the working tree.
+Alternatively, using linkgit:git-checkout[1] and specifying a commit, you
+can copy the contents of a path out of a commit to the index and to the
+working tree in one go.
 
 'git reset' --patch|-p [<commit>] [--] [<paths>...]::
 	Interactively select hunks in the difference between the index
-- 
1.7.3.rc1.215.g6997c

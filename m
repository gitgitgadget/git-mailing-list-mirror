From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/3] read-tree cleanups
Date: Wed, 21 Sep 2011 09:48:35 +0200
Message-ID: <cover.1316590874.git.git@drmicha.warpmail.net>
References: <4E7996AA.4040909@drmicha.warpmail.net>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 09:48:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6HXy-0000BK-ES
	for gcvg-git-2@lo.gmane.org; Wed, 21 Sep 2011 09:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab1IUHsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 03:48:42 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46439 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752409Ab1IUHsl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2011 03:48:41 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway2.nyi.mail.srv.osa (Postfix) with ESMTP id 4533129302;
	Wed, 21 Sep 2011 03:48:41 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 21 Sep 2011 03:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=6cywAJtxC4MyBtKGfskwDleDF
	a4=; b=siTz+EcKQkc2w6b3oJpvZmYnbx9c+YH/rDUG0n69fILQfDkaCbxQ51DRb
	E1z0yegRuUjAqy2JfwIIP+nk888+QK1N9dRs6RxrBSVFiTuDGFj7AUHuop6RUqsW
	F4ox8lVXgdjVolZVIU96nxPwPdZkqS6bQT64R9skwtZWFuUIho=
X-Sasl-enc: Oxyh997BLYoDQ1HPcXODHr+SpFxaUswBnO4LmxWB6x+E 1316591320
Received: from localhost (p548594C9.dip0.t-ipconnect.de [84.133.148.201])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A35287C0650;
	Wed, 21 Sep 2011 03:48:40 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.469.g9eb94
In-Reply-To: <4E7996AA.4040909@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181821>

These are a few cleanups I noticed while checking Joshua's sparse checkout
problem when swithcing branches with a dirty sparse tree.
They are independent of a possible fix.

Michael J Gruber (3):
  unpack-trees: print "Aborting" to stderr
  git-read-tree.txt: language and typography fixes
  git-read-tree.txt: correct sparse-checkout and skip-worktree
    description

 Documentation/git-read-tree.txt |   48 +++++++++++++++++++-------------------
 unpack-trees.c                  |    2 +-
 2 files changed, 25 insertions(+), 25 deletions(-)

-- 
1.7.7.rc0.469.g9eb94

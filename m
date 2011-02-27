From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 0/3] add/commit -u/-a/-A
Date: Sun, 27 Feb 2011 16:50:09 +0100
Message-ID: <cover.1298821535.git.git@drmicha.warpmail.net>
References: <4D68D630.9000608@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 27 16:49:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptis5-0004aZ-DW
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 16:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185Ab1B0PtG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 10:49:06 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56588 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752162Ab1B0PtD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 10:49:03 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3CC8C20335;
	Sun, 27 Feb 2011 10:49:02 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 27 Feb 2011 10:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=8hF1h56hxA4jZVapDrPtf8LuHDs=; b=UQ24OhAaAyJWWMCLJEhgnar55VAQ3tVidV2K306Hh39e7/8eU3eNqPsF381boVYo/u/Kl8dFe12eo6mI4e9xBbLMoF8zizOnoG3mQmUw9gCHhgFEwaxwJR2ErF1lg+jVNmyKBV9OkKkf4+CgnT2gkD0xF2AJbO/JhttfdYprBa8=
X-Sasl-enc: HWtLbXvcyF1XV38zg+DNBCeRhE4yTljUmP8wMeGbSN8i 1298821741
Received: from localhost (p5485925B.dip0.t-ipconnect.de [84.133.146.91])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 851F3442B5E;
	Sun, 27 Feb 2011 10:49:01 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.224.gefc87
In-Reply-To: <4D68D630.9000608@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168039>

v2 takes "all-tracked" as the long form of "-a" for add and commit.

I would think that "changes from all tracked files" would include the special
change "deletion", but I'm open to making the description more verbous.
But as a general rule, "git cmd -h" output should serve as a reminder,
distinguishing the options from each other, not as complete description.

Michael J Gruber (3):
  git-add: make -A description clearer vs. -u
  git-commit: rename --all to --all-tracked
  git-add: rename -u to -a

 Documentation/git-add.txt         |    8 ++++----
 Documentation/git-commit.txt      |    2 +-
 Documentation/git-rm.txt          |    2 +-
 Documentation/gitattributes.txt   |    4 ++--
 builtin/add.c                     |    7 ++++---
 builtin/commit.c                  |   12 ++++++------
 t/t1511-rev-parse-caret.sh        |    2 +-
 t/t2200-add-update.sh             |   26 +++++++++++++-------------
 t/t2201-add-update-typechange.sh  |    6 +++---
 t/t2203-add-intent.sh             |    2 +-
 t/t3030-merge-recursive.sh        |    2 +-
 t/t3415-rebase-autosquash.sh      |   16 ++++++++--------
 t/t4037-diff-r-t-dirs.sh          |    2 +-
 t/t6022-merge-rename.sh           |    2 +-
 t/t6036-recursive-corner-cases.sh |    2 +-
 15 files changed, 48 insertions(+), 47 deletions(-)

-- 
1.7.4.1.224.gefc87

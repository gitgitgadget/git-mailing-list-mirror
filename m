From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/7] Cleaning up --help-all inconsistencies
Date: Mon, 14 Feb 2011 16:10:28 +0100
Message-ID: <cover.1297695910.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 16:13:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp07X-0002Pc-6l
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 16:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307Ab1BNPNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 10:13:42 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58040 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753867Ab1BNPNk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 10:13:40 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 34EF8208C5
	for <git@vger.kernel.org>; Mon, 14 Feb 2011 10:13:40 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 14 Feb 2011 10:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=YssoWVzN7F0IvqE3VzRqT0Pax/0=; b=YGuTLl0+JAp15yQPjmg4Xjq1IjNc6oZL5gm24Nitydh7nHtgDLBcDrm7nWUfQWdU/KJE8dPtOec9BB/UWL6sx7pqS0h+36awhXJ/IcpW9c7kirFZTiKnvjchrWU5F/0EzzvzLdgv7gvWGp1zZWtiCvZavxkJ/1tx92CWRVoXRAs=
X-Sasl-enc: V+K29SpFJLy6c+E0M1Y1bhC6SBfg76nIEzp4T+dX3tIg 1297696419
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B552540D19C;
	Mon, 14 Feb 2011 10:13:39 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1.74.gf39475
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166718>

While looking at our use of short options, I noticed that several
identical options are described differently in --help-all output of
different commands. This mini series fixes this up. I also smuggled in a
patch to git-tag.txt, whose description section is worded as if "create"
was the only mode (and thus makes incorrect statements about options).

Michael J Gruber (7):
  commit,tag: use same wording for -F
  push: describe --porcelain just like commit and status
  clone,init: describe --template using the same wording
  merge,tag: describe -m just like commit
  add: describe --patch like checkout, reset
  commit,status: describe -u likewise
  git-tag.txt: list all modes in the description

 Documentation/git-tag.txt |    8 +++++++-
 builtin/add.c             |    2 +-
 builtin/clone.c           |    4 ++--
 builtin/commit.c          |    4 ++--
 builtin/init-db.c         |    2 +-
 builtin/merge.c           |    4 ++--
 builtin/push.c            |    2 +-
 builtin/tag.c             |    6 +++---
 8 files changed, 19 insertions(+), 13 deletions(-)

-- 
1.7.4.1.74.gf39475

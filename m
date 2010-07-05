From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 0/3] Documentation: Improve revision documentation
Date: Mon,  5 Jul 2010 18:11:38 +0200
Message-ID: <cover.1278346173.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 05 18:12:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVoHe-0006Xf-AO
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 18:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab0GEQMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 12:12:33 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57947 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752580Ab0GEQMc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jul 2010 12:12:32 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4C3BD1183C4
	for <git@vger.kernel.org>; Mon,  5 Jul 2010 12:12:32 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 05 Jul 2010 12:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=zyifWY/nyJ6geYlmTUVuNZK4fuc=; b=KnQJMQUS9g2GmsQ2kwMogIJTq97M78pBusRzWwVgJ9iHuAi6ATX7NSNq+F6vllNSVK0sxDdyH/ao4lm74C6Py8Fnam1NExRh6jEXuvDInSo5U/BTfe5JxCAV1tFKyTEEPaiSSxvTEqDMLcjcLItD8GixwGjKY9u0vrqtrBfKIJw=
X-Sasl-enc: FFAtbb7+gXsN+1/jDSoMryhsQi6Da3bbxuzCCQ1QxfG+ 1278346351
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AF9731A3E9;
	Mon,  5 Jul 2010 12:12:31 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.621.g01d76
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150274>

This mini-series sets up a new gitrevisions(7) man page so that people
looking for revision syntax don't need to try to find it in
git-rev-parse(1) which is cluttered with a lot of unrelated stuff (it's
plumbing after all).

If that concepts is OK, I actually suggest changing the actual content a
bit. Also, I found a copule of typos around the areas which I touched
but saved this for an extension of this series.

Michael J Gruber (3):
  Documentation: split off rev doc into include file
  Documentation: gitrevisions
  Documentation: link to gitrevisions rather than git-rev-parse

 Documentation/Makefile                 |    2 +-
 Documentation/git-cat-file.txt         |    2 +-
 Documentation/git-check-ref-format.txt |    2 +-
 Documentation/git-cherry-pick.txt      |    4 +-
 Documentation/git-diff.txt             |    4 +-
 Documentation/git-fast-import.txt      |    2 +-
 Documentation/git-format-patch.txt     |    2 +-
 Documentation/git-log.txt              |    3 +-
 Documentation/git-push.txt             |    2 +-
 Documentation/git-reflog.txt           |    2 +-
 Documentation/git-rev-parse.txt        |  200 +-------------------------------
 Documentation/git-revert.txt           |    2 +-
 Documentation/git-show-branch.txt      |    2 +-
 Documentation/git-show.txt             |    2 +-
 Documentation/git.txt                  |    2 +-
 Documentation/gitcore-tutorial.txt     |    2 +-
 Documentation/gitk.txt                 |    2 +-
 Documentation/gitrevisions.txt         |   35 ++++++
 Documentation/revisions.txt            |  199 +++++++++++++++++++++++++++++++
 Documentation/user-manual.txt          |    8 +-
 20 files changed, 257 insertions(+), 222 deletions(-)
 create mode 100644 Documentation/gitrevisions.txt
 create mode 100644 Documentation/revisions.txt

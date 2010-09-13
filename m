From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/6] git-reset.txt improvements
Date: Mon, 13 Sep 2010 10:06:30 +0200
Message-ID: <cover.1284365021.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 10:17:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov4Dk-0004ll-EF
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 10:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663Ab0IMIQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 04:16:47 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57641 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753903Ab0IMIQW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 04:16:22 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3F33D1DC;
	Mon, 13 Sep 2010 04:06:34 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 13 Sep 2010 04:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=5MIzwjCyI7upoPbkDmLhzrIWCNA=; b=l7Mb8338KOh6nYOmgthMTSzSsZ+LYa4VeLjS8MltnKAzuxT4nrOr8OpovmBueWWc5a0ocmTFScookemar46SGJc0NQxh3rkPKCY4h6hvMOu2flDRiHyWgDBsJwFTx4wJoSUiaP9Cg3rpBAU3yFWmFiTtKAV/AQHXcTakJL6J4i0=
X-Sasl-enc: 7o1xLiCV2wSDNAZdTspmDyimYVpdS7gxiQ84yXjRO4XT 1284365193
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B4BCA40539D;
	Mon, 13 Sep 2010 04:06:33 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.rc1.215.g6997c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156079>

First of all: I've been out of the loop last week, so please forgive me if this
comes at the wrong phase of a cycle.

I portioned the changes to git-reset.txt and ordered them starting from the
least controversial, I hope. The descriptions of modes have grown organically
over time, and this series tries to make them consistent in structure and
wording, after cleaning up some minor issues. 6/6 is the "meat", so to say.

For the "--merge" description in 6/6: Please double check. I've tried to
understand the mode from the tables and from the inner works (git read-tre -u -m
plus carrying over unmerged entries) because I did not understand the original
description.


Michael J Gruber (6):
  git-reset.txt: clarify branch vs. branch head
  git-reset.txt: reset does not change files in target
  git-reset.txt: reset --soft is not a no-op
  git-reset.txt: use "working tree" consistently
  git-reset.txt: point to git-checkout
  git-reset.txt: make modes description more consistent

 Documentation/git-reset.txt |   63 ++++++++++++++++++++++++++-----------------
 1 files changed, 38 insertions(+), 25 deletions(-)

-- 
1.7.3.rc1.215.g6997c

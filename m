From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv4 0/5] mg/branch-list amendment
Date: Thu,  8 Sep 2011 16:25:56 +0200
Message-ID: <cover.1315491900.git.git@drmicha.warpmail.net>
References: <4E6889DF.7030404@drmicha.warpmail.net>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 16:26:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1fYQ-0001r0-Do
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 16:26:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844Ab1IHO0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 10:26:01 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:39928 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750744Ab1IHO0B (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Sep 2011 10:26:01 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 850592B1B9;
	Thu,  8 Sep 2011 10:26:00 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 08 Sep 2011 10:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=KpoNxVjZjsmhkJCdYRUKqgdcK
	sI=; b=tRNphutseygoFJ8NJQBnxEq/Rk0ddkPpWohsLpVOK7SgFl5QqNutoyc3F
	fmqfbTbOxuifzbdWfyYV0QWW4M/3Wgwec42v1u76VYn+eLTxuRZ2eA1O5IyR8Kkn
	+rOaauLeboRmEyFudzkVDsNCzatLdSalJIgZRzcup/8HOmu8dk=
X-Sasl-enc: pakjWvYdUkV+YPKTSXGaa0Grzm5/zkgwWOqo24fpoi66 1315491960
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 016D9AC0CA6;
	Thu,  8 Sep 2011 10:25:59 -0400 (EDT)
X-Mailer: git-send-email 1.7.7.rc0.469.g9eb94
In-Reply-To: <4E6889DF.7030404@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180972>

So, this is what the top 2 commits in mg/branch-list should be replaced
with if we don't let "-v" activate list mode, so that we can have a verbose
option for branch creation later on, i.e.:

git branch -v foo is the verbose version of git branch

Michael J Gruber (2):
  branch: introduce --list option
  branch: allow pattern arguments

 Documentation/git-branch.txt |   17 +++++++++++++----
 builtin/branch.c             |   35 +++++++++++++++++++++++++++++------
 t/t3200-branch.sh            |   32 ++++++++++++++++++++++++++++++++
 t/t3203-branch-output.sh     |   28 ++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 10 deletions(-)

-- 
1.7.7.rc0.469.g9eb94

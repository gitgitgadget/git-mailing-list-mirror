From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 0/5] patterns for branch list
Date: Sun, 28 Aug 2011 16:54:27 +0200
Message-ID: <cover.1314543252.git.git@drmicha.warpmail.net>
References: <cover.1314367414.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 16:54:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qxgl4-0008Rv-F2
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 16:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998Ab1H1Oyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 10:54:39 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48959 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751037Ab1H1Oyh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2011 10:54:37 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3E8D420ED8;
	Sun, 28 Aug 2011 10:54:35 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Sun, 28 Aug 2011 10:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=Z4dpxH4G9kfWU2EAnf/BbJBZd
	wE=; b=ELiSJOvOPdKjcALdOxLds2G5V4AwWCQV3fPnz9nAe7mt5y6jxQsCsf+N8
	Lt1Ew4I1N3p/b7Up4o849iDABpGeH7L9Kr5sMtgpKDs7BpiCs6Ii96xswWSiLEg9
	BoqGrAL2o5KU7YkEVxjQsyjaogbzZF614ve8RRXzxVoqD48dP4=
X-Sasl-enc: 5yDH0Q4kHL6+64m9n+vWdJDzpTvUlqlADY2aPNQSwLMQ 1314543274
Received: from localhost (p54859364.dip0.t-ipconnect.de [84.133.147.100])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9003CA00250;
	Sun, 28 Aug 2011 10:54:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <cover.1314367414.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180268>

v3 has reworded commit messages for 2,3,4 and tests for combinations
of branch options in 4, as suggested.

No code changes (besides the additional tests in 4).

Michael J Gruber (5):
  t6040: test branch -vv
  git-tag: introduce long forms for the options
  git-branch: introduce missing long forms for the options
  branch: introduce --list option
  branch: allow pattern arguments

 Documentation/git-branch.txt |   20 +++++++++++++++--
 Documentation/git-tag.txt    |    8 +++++++
 builtin/branch.c             |   46 +++++++++++++++++++++++++++++++----------
 builtin/tag.c                |   16 +++++++-------
 t/t3200-branch.sh            |   32 +++++++++++++++++++++++++++++
 t/t3203-branch-output.sh     |   24 +++++++++++++++++++++
 t/t6040-tracking-info.sh     |   16 ++++++++++++++
 7 files changed, 140 insertions(+), 22 deletions(-)

-- 
1.7.6.845.gc3c05

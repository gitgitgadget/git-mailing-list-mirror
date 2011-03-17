From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFD 0/2] revision.c: --merges, --no-merges and --merges-only
Date: Thu, 17 Mar 2011 12:33:56 +0100
Message-ID: <cover.1300359256.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 12:37:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0BWI-0007TZ-Se
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 12:37:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab1CQLha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 07:37:30 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:49240 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752910Ab1CQLh3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2011 07:37:29 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 89C8920A8B
	for <git@vger.kernel.org>; Thu, 17 Mar 2011 07:37:28 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Thu, 17 Mar 2011 07:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:subject:date:message-id; s=smtpout; bh=YIjK9kyY6bqxndKgSD9g6iO6kUE=; b=QCFk0kQ4gFo/GShbcjCWTtb+O18ioTRkKjOssMqWeZJIl9X53/f1dSIFEVeoyKZgM/mXzLBdjjn45l5ntCNWZYSdn9SX/uQBOu5pEQVeix+9AfvZb0M8J+zsj391pkhZc8fBEKdQhswB1dP+IySl60JmoL4CqvCMlj7k4U0uLhE=
X-Sasl-enc: Y9GCIJg/oWoCiK9e9XCk1yBsLjYa+sMtpbsEkR+2/ofQ 1300361848
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0E9CE44512A;
	Thu, 17 Mar 2011 07:37:27 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.464.gf81ff
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169237>

This mini series makes it so that --no-merges undoes --merges
and vice versa, as the user should be able to expect,
and that --merges-only is a separate option.

Michael J Gruber (2):
  revision.c: rename --merges to --merges-only
  revision.c: introduce --merges to undo --no-merges

 Documentation/git-rev-list.txt         |    1 +
 Documentation/git-stash.txt            |    2 +-
 Documentation/rev-list-options.txt     |    6 ++++--
 contrib/completion/git-completion.bash |    2 +-
 revision.c                             |    4 +++-
 submodule.c                            |    2 +-
 6 files changed, 11 insertions(+), 6 deletions(-)

-- 
1.7.4.1.464.gf81ff

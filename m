From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 0/3] git-merge-base -a vs. git-show-branch --merge-base
Date: Wed,  5 Aug 2009 09:59:17 +0200
Message-ID: <1249459160-3931-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 09:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYbPW-00031z-22
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 09:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933713AbZHEH7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 03:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933694AbZHEH7e
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 03:59:34 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44055 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933355AbZHEH7d (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 03:59:33 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 7F64B3BB4DC;
	Wed,  5 Aug 2009 03:59:34 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 05 Aug 2009 03:59:34 -0400
X-Sasl-enc: z38LBGQeQOfFqrXcDzfok5NGr57wdkwBAbXArG16AZk+ 1249459173
Received: from localhost (vpn-136-027.rz.uni-augsburg.de [137.250.136.27])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D8E202AD9;
	Wed,  5 Aug 2009 03:59:33 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.70.g9c084
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124872>

The two commands above behave differently when more than two commits are
given. The purpose of this patch series is to correct and improve the
documentation in this regard, and to document the difference in behavior
with a test.

1/3 only depicts the DAG of a test which is already present, to make it
easier for future test writers (such as that of 3/3).

2/3 cleans up the documentation so that man pages and usage strings for
those two commands coincide.

3/3 adds a test case and corrects the documentation with regards to
merge bases for more than two commits.

Michael J Gruber (3):
  t6010-merge-base.sh: Depict the octopus test graph
  git-merge-base/git-show-branch: Cleanup documentation and usage
  git-merge-base/git-show-branch --merge-base: Documentation and test

 Documentation/git-merge-base.txt  |    9 +++++++--
 Documentation/git-show-branch.txt |   13 ++++++++-----
 builtin-merge-base.c              |    2 +-
 builtin-show-branch.c             |    6 +++---
 t/t6010-merge-base.sh             |   18 ++++++++++++++++++
 5 files changed, 37 insertions(+), 11 deletions(-)

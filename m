From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] Documentation: cherry-pick: fix asciidoc problem with --
Date: Fri, 25 Jun 2010 04:16:23 +0200
Message-ID: <20100625021625.12918.16047.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 04:19:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORyVf-0006JM-CD
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 04:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754346Ab0FYCTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 22:19:09 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:50617 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839Ab0FYCTI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 22:19:08 -0400
Received: from style.boubyland (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A172F81802D;
	Fri, 25 Jun 2010 04:18:58 +0200 (CEST)
X-git-sha1: cc1f7f230d7f92fba7e617260121f4bae872ed38 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149662>

Asciidoc interprets two dashes separated by spaces as a single big
dash. So let's escape the first dash, so that "master \-- README"
will properly appear as "master -- README".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---

	This patch should be squashed into patch 2/3 in the
	cc/cherry-pick-stdin series.

 Documentation/git-cherry-pick.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index f047739..ca485db 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -113,7 +113,7 @@ git cherry-pick --ff ..next::
 	are in next but not HEAD to the current branch, creating a new
 	commit for each new change.
 
-git rev-list --reverse master -- README | git cherry-pick -n --stdin::
+git rev-list --reverse master \-- README | git cherry-pick -n --stdin::
 
 	Apply the changes introduced by all commits on the master
 	branch that touched README to the working tree and index,
-- 
1.7.1.642.gc3eb1

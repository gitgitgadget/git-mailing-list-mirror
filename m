From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC PATCH] user-manual: fix anchor name Finding-comments-With-given-Content
Date: Tue, 28 Sep 2010 13:16:07 +0200
Message-ID: <f2cc250ea5816f351074bd0efb482398acb7428d.1285672508.git.git@drmicha.warpmail.net>
Cc: "J. Bruce Fields" <bfields@citi.umich.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 13:16:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0YAF-0005dg-SK
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 13:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752115Ab0I1LP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 07:15:58 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:56769 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751992Ab0I1LP6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 07:15:58 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 67663570;
	Tue, 28 Sep 2010 07:15:57 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 28 Sep 2010 07:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=GWwrd+Zklt+8oFg91MG+PLwKVWM=; b=Z9Ldm0xaVrYzybfCku4w5k3lWOoLaNZUnFZ8TK6Z/YS5/71/GluGVqmw4q4k2j9A+6EAauon2hFGvdLKLiCfvQRV3iTHBO6AxqZUacimhVzwLTb+qNYz68aR0zJWbY+IpbpJUNmU0M3nFUdFua7OQ9uiIuvr6lIpDzltMhmpYMc=
X-Sasl-enc: nRw4+qnDW3euxwPWAZ1CMQ3t3Tyn0h4dHxsKiKcC0x6C 1285672557
Received: from localhost (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F3069402361;
	Tue, 28 Sep 2010 07:15:56 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.98.g5ad7d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157405>

Change the anchor name to

Finding-commits-With-given-Content

so that it corresponds to the actual content there.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
The downside is that existing links go stale, of course.
Also, CapiTalisation is a bit weird but goes with prior art here.

 Documentation/user-manual.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index fecc4eb..8d9a3c4 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -955,7 +955,7 @@ echo "git diff --stat --summary -M v$last v$new > ../diffstat-$new"
 and then he just cut-and-pastes the output commands after verifying that
 they look OK.
 
-[[Finding-comments-With-given-Content]]
+[[Finding-commits-With-given-Content]]
 Finding commits referencing a file with given content
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-- 
1.7.3.98.g5ad7d

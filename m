From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 3/3] Makefile: Make dependency directory creation less noisy
Date: Sun, 11 Sep 2011 20:40:18 +0100
Message-ID: <4E6D0EA2.5080406@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 11 21:45:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2pxs-0005KO-9R
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 21:45:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760342Ab1IKTpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Sep 2011 15:45:08 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:42537 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754413Ab1IKTpI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2011 15:45:08 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1R2pxi-0007An-cf; Sun, 11 Sep 2011 19:45:07 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181189>



Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 0ea1a2b..a0f0faf 100644
--- a/Makefile
+++ b/Makefile
@@ -1909,7 +1909,7 @@ dep_dirs := $(addsuffix .depend,$(sort $(dir $(OBJECTS))))
 
 ifdef COMPUTE_HEADER_DEPENDENCIES
 $(dep_dirs):
-	mkdir -p $@
+	@mkdir -p $@
 
 missing_dep_dirs := $(filter-out $(wildcard $(dep_dirs)),$(dep_dirs))
 dep_file = $(dir $@).depend/$(notdir $@).d
-- 
1.7.6

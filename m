From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 3/4] Run the perf test suite for profile feedback too
Date: Mon,  7 Jul 2014 23:35:10 -0700
Message-ID: <1404801311-15365-4-git-send-email-andi@firstfloor.org>
References: <1404801311-15365-1-git-send-email-andi@firstfloor.org>
Cc: Andi Kleen <ak@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 08:35:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4P0E-0005EQ-Og
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 08:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbaGHGfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 02:35:32 -0400
Received: from one.firstfloor.org ([193.170.194.197]:33415 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752057AbaGHGfa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 02:35:30 -0400
Received: from basil.firstfloor.org (184-100-237-164.ptld.qwest.net [184.100.237.164])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by one.firstfloor.org (Postfix) with ESMTPSA id 8D92686779;
	Tue,  8 Jul 2014 08:35:28 +0200 (CEST)
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id 550CFA169F; Mon,  7 Jul 2014 23:35:16 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1404801311-15365-1-git-send-email-andi@firstfloor.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253006>

From: Andi Kleen <ak@linux.intel.com>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index a9770ac..ba64be9 100644
--- a/Makefile
+++ b/Makefile
@@ -1647,6 +1647,7 @@ ifeq ($(filter all,$(MAKECMDGOALS)),all)
 all:: profile-clean
 	$(MAKE) PROFILE=GEN all
 	$(MAKE) PROFILE=GEN -j1 test
+	$(MAKE) PROFILE=GEN -j1 perf
 endif
 endif
 
-- 
2.0.1

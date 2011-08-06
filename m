From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 02/40] whitespace: remediate t1001-read-tree-m-2way.sh
Date: Sat,  6 Aug 2011 18:44:16 +1000
Message-ID: <1312620294-18616-2-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:45:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcVX-0004qa-2q
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358Ab1HFIpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:20 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab1HFIpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:09 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oCApFq/6WNbi71QFWsFgYUG2BJpp0Qf5DtcbLGQ/u7Q=;
        b=cXxMic2AVZJc/BFNle5Rs/pmqpCyo/4qy5ig5oNgPopgP1MhEbJAYtWLD7Yr9ZCcuD
         Sjjzb6wRNa48mlOi/ilLRLhrIF7iZ83q9zWRKGDGOU6thIj7SJa0IWE9WScimU32Ee2l
         0gPV9FIScuTSouYZHgCXPbfl0Pp1GV7+OpLMw=
Received: by 10.42.167.9 with SMTP id q9mr2705193icy.310.1312620308588;
        Sat, 06 Aug 2011 01:45:08 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178833>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t1001-read-tree-m-2way.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.sh
index acaab07..141a35a 100755
--- a/t/t1001-read-tree-m-2way.sh
+++ b/t/t1001-read-tree-m-2way.sh
@@ -14,11 +14,11 @@ all the combinations described in the two-tree merge "carry forward"
 rules, found in <Documentation/git read-tree.txt>.
 
 In the test, these paths are used:
-        bozbar  - in H, stays in M, modified from bozbar to gnusto
-        frotz   - not in H added in M
-        nitfol  - in H, stays in M unmodified
-        rezrov  - in H, deleted in M
-        yomin   - not in H nor M
+	bozbar  - in H, stays in M, modified from bozbar to gnusto
+	frotz   - not in H added in M
+	nitfol  - in H, stays in M unmodified
+	rezrov  - in H, deleted in M
+	yomin   - not in H nor M
 '
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
-- 
1.7.6.362.gf0e6

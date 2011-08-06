From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 04/40] whitespace: remediate t1300-repo-config.sh
Date: Sat,  6 Aug 2011 18:44:18 +1000
Message-ID: <1312620294-18616-4-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:45:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcVk-0004uu-ON
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573Ab1HFIpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:24 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab1HFIpN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:13 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=dqAFnMckPni6IpiULACHZeEGassUzWBqLxEnb5hB8Fw=;
        b=F4PNJy+uGWHhc89kVcLuLHEKZAHcFMRGJE7O4hGFJfqIai/SPZJiX0fIRkePrPMvbb
         4Usz0c5MpdR6hGGsx5YN7YY51mMB/63hekihn9k04l235TAiJntK7wqqkdFuHK+XtGtv
         3aPlVLoSWDRnMwvmMDGt0IV5h/2s5Uxij4scM=
Received: by 10.231.112.39 with SMTP id u39mr916042ibp.70.1312620313213;
        Sat, 06 Aug 2011 01:45:13 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178835>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t1300-repo-config.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3e140c1..b835552 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -588,7 +588,7 @@ test_expect_success bool '
 	do
 	    git config --bool --get bool.true$i >>result
 	    git config --bool --get bool.false$i >>result
-        done &&
+	done &&
 	cmp expect result'
 
 test_expect_success 'invalid bool (--get)' '
-- 
1.7.6.362.gf0e6

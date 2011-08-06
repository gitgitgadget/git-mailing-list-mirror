From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 23/40] whitespace: remediate t7004-tag.sh
Date: Sat,  6 Aug 2011 18:44:37 +1000
Message-ID: <1312620294-18616-23-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcWT-0005FS-Va
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315Ab1HFIqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:09 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:43546 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170Ab1HFIp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:59 -0400
Received: by iye16 with SMTP id 16so5183461iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=XSjOcAyDSc0xcsJ8RQn6iwydFtTXrxNB+Fb9BeLXtSQ=;
        b=A2Z3FKxoTmqjR1e7nVG5bE8zjL3SAZYJwpKAHF4kb6T+xuFGkCALpGTMXnrQMVY3Hm
         nMXOMPWfka/GuFhsLyw4PKWNdPMczfqL9Wy2Lw/fOvqpNx6T7Qph0FlQwPdwsnLtaXlt
         4Z5NFEALNAoJsmtposg3YPO8Fd/CRp/djTShI=
Received: by 10.43.49.133 with SMTP id va5mr2727718icb.306.1312620359222;
        Sat, 06 Aug 2011 01:45:59 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178847>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7004-tag.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 097ce2b..1ae978c 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1239,7 +1239,7 @@ test_expect_success 'checking that third commit has no tags' "
 
 test_expect_success 'creating simple branch' '
 	git branch stable v2.0 &&
-        git checkout stable &&
+	git checkout stable &&
 	echo foo-3.0 > foo &&
 	git commit foo -m fourth &&
 	git tag v3.0
@@ -1258,7 +1258,7 @@ test_expect_success 'checking that branch head only has one tag' "
 
 test_expect_success 'merging original branch into this branch' '
 	git merge --strategy=ours master &&
-        git tag v4.0
+	git tag v4.0
 '
 
 cat > expected <<EOF
-- 
1.7.6.362.gf0e6

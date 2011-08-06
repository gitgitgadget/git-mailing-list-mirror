From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 18/40] whitespace: remediate t5510-fetch.sh
Date: Sat,  6 Aug 2011 18:44:32 +1000
Message-ID: <1312620294-18616-18-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcWS-0005FS-CH
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046Ab1HFIpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:54 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:53446 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab1HFIpr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:47 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182831iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=T+LA0JGiZE4FyiUjsy/f5cEtHWnlZnrMNwdB7PGDuN8=;
        b=ILD+d80b6PqQWe89EyCUMFm1wntg2gKMiySAxvMIyl+o+VzSnQct1mYvcTYtM3E2ep
         T6A9y0aNjMPYzzIpoJIgF0x52gzFV6LEz9jUeYuQxxd61nIKOfej9n3HYrmoixFF1jIJ
         xD12pwRcFadwxpGDR4DNw544YwS/q579WGvNs=
Received: by 10.42.144.8 with SMTP id z8mr1343303icu.140.1312620347413;
        Sat, 06 Aug 2011 01:45:47 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178846>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t5510-fetch.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 7e433b1..dee5aeb 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -384,14 +384,14 @@ test_expect_success 'fetch --dry-run' '
 '
 
 test_expect_success "should be able to fetch with duplicate refspecs" '
-        mkdir dups &&
-        cd dups &&
-        git init &&
-        git config branch.master.remote three &&
-        git config remote.three.url ../three/.git &&
-        git config remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
-        git config --add remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
-        git fetch three
+	mkdir dups &&
+	cd dups &&
+	git init &&
+	git config branch.master.remote three &&
+	git config remote.three.url ../three/.git &&
+	git config remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
+	git config --add remote.three.fetch +refs/heads/*:refs/remotes/origin/* &&
+	git fetch three
 '
 
 test_done
-- 
1.7.6.362.gf0e6

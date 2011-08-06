From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 22/40] whitespace: remediate t7003-filter-branch.sh
Date: Sat,  6 Aug 2011 18:44:36 +1000
Message-ID: <1312620294-18616-22-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcWU-0005FS-GS
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319Ab1HFIqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:10 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:52375 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755106Ab1HFIp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:57 -0400
Received: by iye16 with SMTP id 16so5183416iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=GSn4tswuluI0e4f9o8u8zbpVlw3wswUZD0suHHubzDc=;
        b=AFbiaOlqdUxqWXFgn478c4BVOuN55KUjHzdCuFLrb8A1pFcaz9+h60GgqbxCem2sTK
         LSreZdwltdvhppH+2cDQUQzzBucDI8zE7iRejRQ6VvzPvnkcz8CgQgyDbfZt7wflVFmB
         yzw37gVf+Tt8akbbRoPKryOwZDlTotZubnHpw=
Received: by 10.231.30.130 with SMTP id u2mr915273ibc.69.1312620356919;
        Sat, 06 Aug 2011 01:45:56 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178850>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t7003-filter-branch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index e022773..96aca9e 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -147,7 +147,7 @@ test_expect_success 'use index-filter to move into a subdirectory' '
 	git branch directorymoved &&
 	git filter-branch -f --index-filter \
 		 "git ls-files -s | sed \"s-	-&newsubdir/-\" |
-	          GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
+		  GIT_INDEX_FILE=\$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
 		  mv \"\$GIT_INDEX_FILE.new\" \"\$GIT_INDEX_FILE\"" directorymoved &&
 	git diff --exit-code HEAD directorymoved:newsubdir
-- 
1.7.6.362.gf0e6

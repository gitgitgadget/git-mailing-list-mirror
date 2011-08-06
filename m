From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 09/40] whitespace: remediate t4002-diff-basic.sh
Date: Sat,  6 Aug 2011 18:44:23 +1000
Message-ID: <1312620294-18616-9-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:47:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcXQ-0005kJ-6K
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601Ab1HFIrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:47:12 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab1HFIpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:25 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FHnEtC9aJ9uUgi+5pM4Hv4fNpmgdDw1eF1KGbRYjniY=;
        b=wkSu0McAQJLT6sJAaowalDzIgMxML7KCXAXHl0mrUA6xhre24/JBnC0kEpv0HIcIjc
         I/a9bXbXpsdXJP6cMhhbmo1ODO3Hi3s1hmtmEU7wI1KvlQpjdxZ/3p2w/ZtJoPHf+PFe
         z6UPqk7Dprf6nFSOD9vBPK8dyqujwXb8P7Acw=
Received: by 10.231.130.105 with SMTP id r41mr935835ibs.14.1312620325316;
        Sat, 06 Aug 2011 01:45:25 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178869>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t4002-diff-basic.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index a5e8b83..b6730a5 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -258,9 +258,9 @@ test_expect_success \
 test_expect_success \
     'diff can read from stdin' \
     'test_must_fail git diff --no-index -- MN - < NN |
-        grep -v "^index" | sed "s#/-#/NN#" >.test-a &&
+	grep -v "^index" | sed "s#/-#/NN#" >.test-a &&
     test_must_fail git diff --no-index -- MN NN |
-        grep -v "^index" >.test-b &&
+	grep -v "^index" >.test-b &&
     test_cmp .test-a .test-b'
 
 test_done
-- 
1.7.6.362.gf0e6

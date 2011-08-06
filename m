From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 38/40] whitespace: remediate t9603-cvsimport-patchsets.sh
Date: Sat,  6 Aug 2011 18:44:52 +1000
Message-ID: <1312620294-18616-38-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcX0-0005WP-R7
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab1HFIqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:38 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:52375 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755855Ab1HFIqe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:34 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5183416iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4UMJkphe2Axr3gAQjFC74xOrHeHplwvSM5p7z2u/+tw=;
        b=Zu7c4lDKnc+SjIcbgTbugop0zraVIgRjvu+MkSAiTx6QZcTd+2RQfTLbpq/Q0K0fNx
         ktdfxnwt7/kajFbEidbirJX5et4g6EW41/hGRfEESRbPw1Y3mhWAELY64JACM1S4myNQ
         sreRYCKna9HQQIB7OguwcldaQh5GMGBTn9Tas=
Received: by 10.42.162.72 with SMTP id w8mr2798399icx.497.1312620394147;
        Sat, 06 Aug 2011 01:46:34 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178856>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t9603-cvsimport-patchsets.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9603-cvsimport-patchsets.sh b/t/t9603-cvsimport-patchsets.sh
index 52034c8..93c4108 100755
--- a/t/t9603-cvsimport-patchsets.sh
+++ b/t/t9603-cvsimport-patchsets.sh
@@ -20,9 +20,9 @@ test_expect_failure 'import with criss cross times on revisions' '
 
     git cvsimport -p"-x" -C module-git module &&
     (cd module-git &&
-        git log --pretty=format:%s > ../actual-master &&
-        git log A~2..A --pretty="format:%s %ad" -- > ../actual-A &&
-        echo "" >> ../actual-master &&
+	git log --pretty=format:%s > ../actual-master &&
+	git log A~2..A --pretty="format:%s %ad" -- > ../actual-A &&
+	echo "" >> ../actual-master &&
 	echo "" >> ../actual-A
     ) &&
     echo "Rev 4
-- 
1.7.6.362.gf0e6

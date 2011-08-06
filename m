From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 11/40] whitespace: remediate t5300-pack-object.sh
Date: Sat,  6 Aug 2011 18:44:25 +1000
Message-ID: <1312620294-18616-11-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:45:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcVw-000510-91
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab1HFIpg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:36 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab1HFIpa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:30 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=EItGsf5O22N6DIE/hz1m2+N/AYypBQCVyIAtLOBc+9o=;
        b=UZ/kIeuf2Ylxcdc+Ohs9j+Rk7/OflojAirR2cbe8dgKiTSnB9AdkLua1hPfNrwBHof
         dobuN5g0/EBmvVaGmeHcSuXqOli2xdyqyxlR1q72GIoI48m/QZ9heH5f4INpii3D1r9Y
         H9GZYwJxrcG7U93cvAAKWm+/H+M0M7BOmE7hU=
Received: by 10.42.133.69 with SMTP id g5mr3150069ict.112.1312620330135;
        Sat, 06 Aug 2011 01:45:30 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178838>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t5300-pack-object.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 602806d..0370994 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -57,7 +57,7 @@ test_expect_success \
     '(cd ../.git && find objects -type f -print) |
      while read path
      do
-         cmp $path ../.git/$path || {
+	 cmp $path ../.git/$path || {
 	     echo $path differs.
 	     return 1
 	 }
@@ -87,7 +87,7 @@ test_expect_success \
     '(cd ../.git && find objects -type f -print) |
      while read path
      do
-         cmp $path ../.git/$path || {
+	 cmp $path ../.git/$path || {
 	     echo $path differs.
 	     return 1
 	 }
@@ -117,7 +117,7 @@ test_expect_success \
     '(cd ../.git && find objects -type f -print) |
      while read path
      do
-         cmp $path ../.git/$path || {
+	 cmp $path ../.git/$path || {
 	     echo $path differs.
 	     return 1
 	 }
-- 
1.7.6.362.gf0e6

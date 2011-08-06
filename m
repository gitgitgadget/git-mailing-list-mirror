From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 05/40] whitespace: remediate t1503-rev-parse-verify.sh
Date: Sat,  6 Aug 2011 18:44:19 +1000
Message-ID: <1312620294-18616-5-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:47:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcXO-0005kJ-4y
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab1HFIp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:27 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab1HFIpP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:15 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LVXJUlF2DRYWd1EGEko7Yw2lA1aF7tFw7+h4YsA/1KM=;
        b=RTmBfxQgr4GUnmhQhfjN1YxnW/Bg0mmGaqiw9c+W35rhLSDYSwX33rcublqT7Ka6cN
         bMTwi+Dg7tjbCISNBMAy8s/II+DLdBiOymHufas/CFkkKdfEmV2WnaQMgFgKw0I/3+zp
         tqIcPUliYxlSo7N6i38IRIlFt+WyhMGFsZrHg=
Received: by 10.231.55.201 with SMTP id v9mr930696ibg.16.1312620315641;
        Sat, 06 Aug 2011 01:45:15 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178868>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t1503-rev-parse-verify.sh |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 813cc1b..5cc50e7 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -14,12 +14,12 @@ add_line_into_file()
     _file=$2
 
     if [ -f "$_file" ]; then
-        echo "$_line" >> $_file || return $?
-        MSG="Add <$_line> into <$_file>."
+	echo "$_line" >> $_file || return $?
+	MSG="Add <$_line> into <$_file>."
     else
-        echo "$_line" > $_file || return $?
-        git add $_file || return $?
-        MSG="Create file <$_file> with <$_line> inside."
+	echo "$_line" > $_file || return $?
+	git add $_file || return $?
+	MSG="Create file <$_file> with <$_line> inside."
     fi
 
     test_tick
-- 
1.7.6.362.gf0e6

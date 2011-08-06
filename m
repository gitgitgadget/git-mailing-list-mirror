From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 21/40] whitespace: remediate t6030-bisect-porcelain.sh
Date: Sat,  6 Aug 2011 18:44:35 +1000
Message-ID: <1312620294-18616-21-git-send-email-jon.seymour@gmail.com>
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
	id 1QpcWV-0005FS-1N
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755106Ab1HFIqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:12 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755018Ab1HFIpz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:55 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=nZaa1aG/soe+ZR2JmfZw6SQRuwqGv8bANLrgVGZXlvs=;
        b=I6gFlZoQ4d++EghwBN7xzEcsLN+IjoQak6ZKmdeovP7r2ayHxgiMHM3THdFTWVM0I0
         Z83MwLfm8hgFgBTorsQSplam0nf/D2lzkzSMSX3/wUF7kapQtkk0jH4L1ExeUG+phQki
         5YqwJAp0jQv16LNIpvtSW9cpO8Is80wP9KNzs=
Received: by 10.42.133.137 with SMTP id h9mr3309244ict.392.1312620354610;
        Sat, 06 Aug 2011 01:45:54 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178854>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t6030-bisect-porcelain.sh |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index b5063b6..479184f 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
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
@@ -559,10 +559,10 @@ test_expect_success 'skipping away from skipped commit' '
 	git bisect start $PARA_HASH7 $HASH1 &&
 	para4=$(git rev-parse --verify HEAD) &&
 	test "$para4" = "$PARA_HASH4" &&
-        git bisect skip &&
+	git bisect skip &&
 	hash7=$(git rev-parse --verify HEAD) &&
 	test "$hash7" = "$HASH7" &&
-        git bisect skip &&
+	git bisect skip &&
 	para3=$(git rev-parse --verify HEAD) &&
 	test "$para3" = "$PARA_HASH3"
 '
-- 
1.7.6.362.gf0e6

From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 35/40] whitespace: remediate t9400-git-cvsserver-server.sh
Date: Sat,  6 Aug 2011 18:44:49 +1000
Message-ID: <1312620294-18616-35-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:46:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcWz-0005WP-Oz
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755817Ab1HFIq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:46:29 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:43546 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463Ab1HFIq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:46:27 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5183461iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=z1P5gYMHE1L1kUqa2yl868q0QG+8Z6OFJlT98GCs8Pk=;
        b=dsjEumrCT1F9clS5xthsSxBOMH2WQpYYdYYAp2i6Nb5NAIwQ86KqP6zlTk1a968Vel
         F1H0XBqtpjFQloJ286SjHs6HFUx18gohQNpflptHuNUzKiE3iIpcM0VILnC7hsnrqrDx
         /+IUgeLMB4OZ1UV2VfFSS7XdXYah3lOxM/Etw=
Received: by 10.231.114.10 with SMTP id c10mr943826ibq.11.1312620386790;
        Sat, 06 Aug 2011 01:46:26 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.46.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:46:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178858>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t9400-git-cvsserver-server.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index 9199550..193d485 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -337,9 +337,9 @@ test_expect_success 'cvs update (subdirectories)' \
       filename="file_in_$(echo $dir|sed -e "s#/# #g")" &&
       if test "$(echo $(grep -v ^D $dir/CVS/Entries|cut -d/ -f2,3,5))" = "$filename/1.1/" &&
 	test_cmp "$dir/$filename" "../$dir/$filename"; then
-        :
+	:
       else
-        echo >failure
+	echo >failure
       fi
     done) &&
    test ! -f failure'
@@ -448,7 +448,7 @@ test_expect_success 'cvs update (-p)' '
     GIT_CONFIG="$git_config" cvs update &&
     rm -f failures &&
     for i in merge no-lf empty really-empty; do
-        GIT_CONFIG="$git_config" cvs update -p "$i" >$i.out
+	GIT_CONFIG="$git_config" cvs update -p "$i" >$i.out
 	test_cmp $i.out ../$i >>failures 2>&1
     done &&
     test -z "$(cat failures)"
-- 
1.7.6.362.gf0e6

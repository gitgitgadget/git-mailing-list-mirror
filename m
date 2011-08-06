From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 13/40] whitespace: remediate t5302-pack-index.sh
Date: Sat,  6 Aug 2011 18:44:27 +1000
Message-ID: <1312620294-18616-13-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:45:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcVy-000510-D7
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355Ab1HFIpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:40 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483Ab1HFIpf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:35 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kKcm+Xa+pAwfiL+agGneVnxJmfQ3YxNuDI6RD95Sh6U=;
        b=aiJLpLs+xLns/WAF9/KI9zZxw5umBtfO5gEsU1afn3apPbE5+NSkjYgccWEQJ7fu8f
         nsSE1VV2q+lohiKgDdNQJ2oBXZAKGLDSsEQulAmwA3Yw1MpSTw1ZpKva+Ucwn/X5deyf
         0BgUHz4J+VuCgLVM6zPs36UHmYK3Y9NpmluEE=
Received: by 10.42.150.68 with SMTP id z4mr2850242icv.23.1312620335260;
        Sat, 06 Aug 2011 01:45:35 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178842>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t5302-pack-index.sh |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index f8fa924..18dd695 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -14,16 +14,16 @@ test_expect_success \
      i=1 &&
      while test $i -le 100
      do
-         iii=`printf '%03i' $i`
-         test-genrandom "bar" 200 > wide_delta_$iii &&
-         test-genrandom "baz $iii" 50 >> wide_delta_$iii &&
-         test-genrandom "foo"$i 100 > deep_delta_$iii &&
-         test-genrandom "foo"`expr $i + 1` 100 >> deep_delta_$iii &&
-         test-genrandom "foo"`expr $i + 2` 100 >> deep_delta_$iii &&
-         echo $iii >file_$iii &&
-         test-genrandom "$iii" 8192 >>file_$iii &&
-         git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
-         i=`expr $i + 1` || return 1
+	 iii=`printf '%03i' $i`
+	 test-genrandom "bar" 200 > wide_delta_$iii &&
+	 test-genrandom "baz $iii" 50 >> wide_delta_$iii &&
+	 test-genrandom "foo"$i 100 > deep_delta_$iii &&
+	 test-genrandom "foo"`expr $i + 1` 100 >> deep_delta_$iii &&
+	 test-genrandom "foo"`expr $i + 2` 100 >> deep_delta_$iii &&
+	 echo $iii >file_$iii &&
+	 test-genrandom "$iii" 8192 >>file_$iii &&
+	 git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
+	 i=`expr $i + 1` || return 1
      done &&
      { echo 101 && test-genrandom 100 8192; } >file_101 &&
      git update-index --add file_101 &&
@@ -154,9 +154,9 @@ test_expect_success \
      nr_099=`index_obj_nr 1.idx $sha1_099` &&
      chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
      dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
-        if=".git/objects/pack/pack-${pack1}.idx" \
-        skip=$((4 + 256 * 4 + $nr_099 * 24)) \
-        bs=1 count=20 conv=notrunc &&
+	if=".git/objects/pack/pack-${pack1}.idx" \
+	skip=$((4 + 256 * 4 + $nr_099 * 24)) \
+	bs=1 count=20 conv=notrunc &&
      git cat-file blob $sha1_101 > file_101_foo1'
 
 test_expect_success \
@@ -195,9 +195,9 @@ test_expect_success \
      nr_099=`index_obj_nr 1.idx $sha1_099` &&
      chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
      dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
-        if=".git/objects/pack/pack-${pack1}.idx" \
-        skip=$((8 + 256 * 4 + $nr_099 * 20)) \
-        bs=1 count=20 conv=notrunc &&
+	if=".git/objects/pack/pack-${pack1}.idx" \
+	skip=$((8 + 256 * 4 + $nr_099 * 20)) \
+	bs=1 count=20 conv=notrunc &&
      git cat-file blob $sha1_101 > file_101_foo2'
 
 test_expect_success \
@@ -222,7 +222,7 @@ test_expect_success \
      nr=`index_obj_nr ".git/objects/pack/pack-${pack1}.idx" $obj` &&
      chmod +w ".git/objects/pack/pack-${pack1}.idx" &&
      printf xxxx | dd of=".git/objects/pack/pack-${pack1}.idx" conv=notrunc \
-        bs=1 count=4 seek=$((8 + 256 * 4 + `wc -l <obj-list` * 20 + $nr * 4)) &&
+	bs=1 count=4 seek=$((8 + 256 * 4 + `wc -l <obj-list` * 20 + $nr * 4)) &&
      ( while read obj
        do git cat-file -p $obj >/dev/null || exit 1
        done <obj-list ) &&
-- 
1.7.6.362.gf0e6

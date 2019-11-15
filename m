Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19B901F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 01:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfKOBBS (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 20:01:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40597 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfKOBBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 20:01:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id r4so5471199pfl.7
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 17:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z26qB6XvVls68+5OC4K/cbfgDyvCz1xPH2n0sob8W94=;
        b=KvrCpTfdRTLpRVnj3Zz8B5zfOUsMor4JiJHEBYVDFyDYaCLv1UgUhzSYLMKsnJZSMi
         v6d/D7fiFzR45NFK9Vy8CcqQr/ygBlFOSBSBooUMvkVc0YVc/sS8bWvKMMBsKCBTKJ61
         FAapszzbMHxmzt8adpwZSaBRWTwDrRRS9jKloC9p8cQHp0Nsg8yJ+H+HJRA7jcZfOe80
         cbYQpWCchAt6GL6NSRWSApo7tZmY3C4MBl0ZfZs8X2tFotNfeiJYwRBcYnvkm0on5QmB
         NJJk4oEWX549dz3CZXHiueXG6xcDbxOYIVPCP/QN+liCdllFwNe3oNWqtOIJdInPdZ1Z
         n+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z26qB6XvVls68+5OC4K/cbfgDyvCz1xPH2n0sob8W94=;
        b=aogUmzKOB81Y3AI3L/BJ9dGSc+1QAAOvUzHvMawrtFC4dbQEYJzeCYvPfWMM9AxrAb
         3PVQ/1pcQKUf8l7ndiEJqNIxlbBFQmHyw8a7M/Mhj1K70XhtD3QXROtc6JuIR1sLDZC4
         0ImVCUfPpadn9YdrQB8lxc1BES8+En/kgDTkj+zvaitmXJ4J2FNGhc4RfOO6H/GPvgHH
         O5RTtjleIhh+msLvZZygNFpkgQR9hs0hWA81fX1+Mke7jAFnr8AUZhW+/cPfVKIiMOn3
         WzLAby4dNnmNO6n56V71qZFK8SUef+TOIMO2aahI3fWRPpV7Ji4ya52y5SwGkqTInSOX
         cwSQ==
X-Gm-Message-State: APjAAAW4E3Sa287CY3Mqjgsjhd8ED3wapVikOKOlf7f8uNizqhZGCDze
        HIoRjco5GyxhZFoyf4sGKHKAy/gN
X-Google-Smtp-Source: APXvYqzsaBUBu3ThzIXZgN1gjNqjImBcX9kc0ol/9GkKOFGn81yR712+BYAlfuhF25R437GfjSK2Fw==
X-Received: by 2002:a17:90a:a58b:: with SMTP id b11mr16288831pjq.46.1573779674945;
        Thu, 14 Nov 2019 17:01:14 -0800 (PST)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id 206sm12463629pfu.45.2019.11.14.17.01.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 17:01:14 -0800 (PST)
Date:   Thu, 14 Nov 2019 17:01:13 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 18/27] t7700: move keywords onto their own line
Message-ID: <0d776372553d223ecf11d7dc773125bd0a549200.1573779465.git.liu.denton@gmail.com>
References: <cover.1573779465.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1573779465.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code style for tests is to have statements on their own line if
possible. Move keywords onto their own line so that they conform with
the test style.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 51 +++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 8936928387..a96e876c4e 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -29,10 +29,12 @@ test_expect_success 'objects in packs marked .keep are not repacked' '
 	mv pack-* .git/objects/pack/ &&
 	git repack -A -d -l &&
 	git prune-packed &&
-	for p in .git/objects/pack/*.idx; do
+	for p in .git/objects/pack/*.idx
+	do
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"; then
+		if git verify-pack -v $p | egrep "^$objsha1"
+		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
 			break
@@ -45,10 +47,12 @@ test_expect_success 'writing bitmaps via command-line can duplicate .keep object
 	# build on $objsha1, $packsha1, and .keep state from previous
 	git repack -Adbl &&
 	test_when_finished "found_duplicate_object=" &&
-	for p in .git/objects/pack/*.idx; do
+	for p in .git/objects/pack/*.idx
+	do
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"; then
+		if git verify-pack -v $p | egrep "^$objsha1"
+		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
 			break
@@ -61,10 +65,12 @@ test_expect_success 'writing bitmaps via config can duplicate .keep objects' '
 	# build on $objsha1, $packsha1, and .keep state from previous
 	git -c repack.writebitmaps=true repack -Adl &&
 	test_when_finished "found_duplicate_object=" &&
-	for p in .git/objects/pack/*.idx; do
+	for p in .git/objects/pack/*.idx
+	do
 		idx=$(basename $p)
 		test "pack-$packsha1.idx" = "$idx" && continue
-		if git verify-pack -v $p | egrep "^$objsha1"; then
+		if git verify-pack -v $p | egrep "^$objsha1"
+		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
 			break
@@ -83,8 +89,10 @@ test_expect_success 'loose objects in alternate ODB are not repacked' '
 	git commit -m commit_file3 &&
 	git repack -a -d -l &&
 	git prune-packed &&
-	for p in .git/objects/pack/*.idx; do
-		if git verify-pack -v $p | egrep "^$objsha1"; then
+	for p in .git/objects/pack/*.idx
+	do
+		if git verify-pack -v $p | egrep "^$objsha1"
+		then
 			found_duplicate_object=1
 			echo "DUPLICATE OBJECT FOUND"
 			break
@@ -99,10 +107,13 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 	git repack -a &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
 	test -f "$myidx" &&
-	for p in alt_objects/pack/*.idx; do
+	for p in alt_objects/pack/*.idx
+	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest; do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" ); then
+	done | while read sha1 rest
+	do
+		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
+		then
 			echo "Missing object in local pack: $sha1"
 			return 1
 		fi
@@ -119,10 +130,13 @@ test_expect_success 'packed obs in alt ODB are repacked when local repo has pack
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
 	test -f "$myidx" &&
-	for p in alt_objects/pack/*.idx; do
+	for p in alt_objects/pack/*.idx
+	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest; do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" ); then
+	done | while read sha1 rest
+	do
+		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
+		then
 			echo "Missing object in local pack: $sha1"
 			return 1
 		fi
@@ -144,10 +158,13 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
 	test -f "$myidx" &&
-	for p in alt_objects/pack/*.idx; do
+	for p in alt_objects/pack/*.idx
+	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-	done | while read sha1 rest; do
-		if ! ( git verify-pack -v $myidx | grep "^$sha1" ); then
+	done | while read sha1 rest
+	do
+		if ! ( git verify-pack -v $myidx | grep "^$sha1" )
+		then
 			echo "Missing object in local pack: $sha1"
 			return 1
 		fi
-- 
2.24.0.399.gf8350c9437


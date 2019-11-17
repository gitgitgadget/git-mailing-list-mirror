Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2D4E1F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 06:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbfKQG4Q (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 01:56:16 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36920 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfKQG4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 01:56:16 -0500
Received: by mail-wm1-f46.google.com with SMTP id b17so15234718wmj.2
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 22:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sbqQKPFLwqefjSeatY3TgmSApYsc1DIwXSJjnSoXqzg=;
        b=B3eMJCLGdOQz27vpX7MM4cefUeH0dyGD6dBfCuYB+nGnE+APuqTd2yIQ1TUM5NVdng
         p7vZCOzuKALZRl7BCYrPbE0BR3cQ6HzpKH5qIOZcvdwu2sbpDG4v7qJRDQ3vbtT1mCAa
         odYH0t6NwM9APhFATIlauuBpy4yrzKtK2AXfhVfrANuzLw4zPfYhDYa5+43oryP7it28
         62wpBlxhx8ddgrVoOBVGr3NN458DkQyNp20Yy0sNRukVX56NXFdrnnT8AgIIUBmGwwGe
         e8YhsretYo2R4Xj/ZK++cSHCp1gFymaNh4YYkdQ8beeH07X1AyyQeWsv9Ig83NgavWBh
         bzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sbqQKPFLwqefjSeatY3TgmSApYsc1DIwXSJjnSoXqzg=;
        b=VFHBm+Hf1yYC0nJ8LhxQqH0D3TDnT3CwY2gs7NUFGqbEqt+6fBG9s3tJdlgp+8zQO7
         wE0ValifoAhya7Dz0F/1h6MJLQfeX/7BIfp09MXPscJM59Mo+91SRhpmddjNxAuRUK2D
         OwM3rSeTTpyGM8ErpgZok8F31mnMcVrpmrYf+6ekXoL8HABVQNQlapTh5iyKSkSHpsRk
         SXF68/NLtNcEJUdV0jBsrNFCzYlelhJrA4eW1o2r8GfMW5kRF6WJ+LTWooVA0Xg1CKm2
         4uv91WvEZD5WdMpTy3BrJzi6FLA9wW081jpfC0wtT8T/ZmRw3cVgl+tee2P9YzFQCKZh
         +WQg==
X-Gm-Message-State: APjAAAVRStgyDOZF4FxgHVIPtMWzKEjCco+XlwiOs+heDbnH5rAbM2/E
        qQwjUjQFQJSW/GBpVA5Dc0l/adQZ
X-Google-Smtp-Source: APXvYqxJio4HYrT0sAGjMTPLi5aaOqaqjIkR/3wGyapAOr9aL0ObAJyChV+cEuh9i504aq5q7nmfIQ==
X-Received: by 2002:a05:600c:cb:: with SMTP id u11mr22973863wmm.5.1573973772915;
        Sat, 16 Nov 2019 22:56:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 83sm15730394wme.2.2019.11.16.22.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Nov 2019 22:56:12 -0800 (PST)
Message-Id: <da1704c56e0bd3f1ac53af96b702e3777bb3eb37.1573973770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
References: <pull.436.v3.git.1573638988.gitgitgadget@gmail.com>
        <pull.436.v4.git.1573973770.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 06:56:09 +0000
Subject: [PATCH v4 1/2] git-gui: consolidate naming conventions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Jonathan Gilbert <JonathanG@iQmetrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Gilbert <JonathanG@iQmetrix.com>

A few variables in this file use camelCase, while the overall standard
is snake_case. A consistent naming scheme will improve readability of
future changes. To avoid mixing naming changes with semantic changes,
this commit contains only naming changes.

Signed-off-by: Jonathan Gilbert <JonathanG@iQmetrix.com>
---
 lib/index.tcl | 92 +++++++++++++++++++++++++--------------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/lib/index.tcl b/lib/index.tcl
index e07b7a3762..28d4d2a54e 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -56,15 +56,15 @@ proc _close_updateindex {fd after} {
 	uplevel #0 $after
 }
 
-proc update_indexinfo {msg pathList after} {
+proc update_indexinfo {msg path_list after} {
 	global update_index_cp
 
 	if {![lock_index update]} return
 
 	set update_index_cp 0
-	set pathList [lsort $pathList]
-	set totalCnt [llength $pathList]
-	set batch [expr {int($totalCnt * .01) + 1}]
+	set path_list [lsort $path_list]
+	set total_cnt [llength $path_list]
+	set batch [expr {int($total_cnt * .01) + 1}]
 	if {$batch > 25} {set batch 25}
 
 	$::main_status start $msg [mc "files"]
@@ -78,26 +78,26 @@ proc update_indexinfo {msg pathList after} {
 	fileevent $fd writable [list \
 		write_update_indexinfo \
 		$fd \
-		$pathList \
-		$totalCnt \
+		$path_list \
+		$total_cnt \
 		$batch \
 		$after \
 		]
 }
 
-proc write_update_indexinfo {fd pathList totalCnt batch after} {
+proc write_update_indexinfo {fd path_list total_cnt batch after} {
 	global update_index_cp
 	global file_states current_diff_path
 
-	if {$update_index_cp >= $totalCnt} {
+	if {$update_index_cp >= $total_cnt} {
 		_close_updateindex $fd $after
 		return
 	}
 
 	for {set i $batch} \
-		{$update_index_cp < $totalCnt && $i > 0} \
+		{$update_index_cp < $total_cnt && $i > 0} \
 		{incr i -1} {
-		set path [lindex $pathList $update_index_cp]
+		set path [lindex $path_list $update_index_cp]
 		incr update_index_cp
 
 		set s $file_states($path)
@@ -119,18 +119,18 @@ proc write_update_indexinfo {fd pathList totalCnt batch after} {
 		display_file $path $new
 	}
 
-	$::main_status update $update_index_cp $totalCnt
+	$::main_status update $update_index_cp $total_cnt
 }
 
-proc update_index {msg pathList after} {
+proc update_index {msg path_list after} {
 	global update_index_cp
 
 	if {![lock_index update]} return
 
 	set update_index_cp 0
-	set pathList [lsort $pathList]
-	set totalCnt [llength $pathList]
-	set batch [expr {int($totalCnt * .01) + 1}]
+	set path_list [lsort $path_list]
+	set total_cnt [llength $path_list]
+	set batch [expr {int($total_cnt * .01) + 1}]
 	if {$batch > 25} {set batch 25}
 
 	$::main_status start $msg [mc "files"]
@@ -144,26 +144,26 @@ proc update_index {msg pathList after} {
 	fileevent $fd writable [list \
 		write_update_index \
 		$fd \
-		$pathList \
-		$totalCnt \
+		$path_list \
+		$total_cnt \
 		$batch \
 		$after \
 		]
 }
 
-proc write_update_index {fd pathList totalCnt batch after} {
+proc write_update_index {fd path_list total_cnt batch after} {
 	global update_index_cp
 	global file_states current_diff_path
 
-	if {$update_index_cp >= $totalCnt} {
+	if {$update_index_cp >= $total_cnt} {
 		_close_updateindex $fd $after
 		return
 	}
 
 	for {set i $batch} \
-		{$update_index_cp < $totalCnt && $i > 0} \
+		{$update_index_cp < $total_cnt && $i > 0} \
 		{incr i -1} {
-		set path [lindex $pathList $update_index_cp]
+		set path [lindex $path_list $update_index_cp]
 		incr update_index_cp
 
 		switch -glob -- [lindex $file_states($path) 0] {
@@ -190,18 +190,18 @@ proc write_update_index {fd pathList totalCnt batch after} {
 		display_file $path $new
 	}
 
-	$::main_status update $update_index_cp $totalCnt
+	$::main_status update $update_index_cp $total_cnt
 }
 
-proc checkout_index {msg pathList after} {
+proc checkout_index {msg path_list after} {
 	global update_index_cp
 
 	if {![lock_index update]} return
 
 	set update_index_cp 0
-	set pathList [lsort $pathList]
-	set totalCnt [llength $pathList]
-	set batch [expr {int($totalCnt * .01) + 1}]
+	set path_list [lsort $path_list]
+	set total_cnt [llength $path_list]
+	set batch [expr {int($total_cnt * .01) + 1}]
 	if {$batch > 25} {set batch 25}
 
 	$::main_status start $msg [mc "files"]
@@ -221,26 +221,26 @@ proc checkout_index {msg pathList after} {
 	fileevent $fd writable [list \
 		write_checkout_index \
 		$fd \
-		$pathList \
-		$totalCnt \
+		$path_list \
+		$total_cnt \
 		$batch \
 		$after \
 		]
 }
 
-proc write_checkout_index {fd pathList totalCnt batch after} {
+proc write_checkout_index {fd path_list total_cnt batch after} {
 	global update_index_cp
 	global file_states current_diff_path
 
-	if {$update_index_cp >= $totalCnt} {
+	if {$update_index_cp >= $total_cnt} {
 		_close_updateindex $fd $after
 		return
 	}
 
 	for {set i $batch} \
-		{$update_index_cp < $totalCnt && $i > 0} \
+		{$update_index_cp < $total_cnt && $i > 0} \
 		{incr i -1} {
-		set path [lindex $pathList $update_index_cp]
+		set path [lindex $path_list $update_index_cp]
 		incr update_index_cp
 		switch -glob -- [lindex $file_states($path) 0] {
 		U? {continue}
@@ -253,7 +253,7 @@ proc write_checkout_index {fd pathList totalCnt batch after} {
 		}
 	}
 
-	$::main_status update $update_index_cp $totalCnt
+	$::main_status update $update_index_cp $total_cnt
 }
 
 proc unstage_helper {txt paths} {
@@ -261,7 +261,7 @@ proc unstage_helper {txt paths} {
 
 	if {![lock_index begin-update]} return
 
-	set pathList [list]
+	set path_list [list]
 	set after {}
 	foreach path $paths {
 		switch -glob -- [lindex $file_states($path) 0] {
@@ -269,19 +269,19 @@ proc unstage_helper {txt paths} {
 		M? -
 		T? -
 		D? {
-			lappend pathList $path
+			lappend path_list $path
 			if {$path eq $current_diff_path} {
 				set after {reshow_diff;}
 			}
 		}
 		}
 	}
-	if {$pathList eq {}} {
+	if {$path_list eq {}} {
 		unlock_index
 	} else {
 		update_indexinfo \
 			$txt \
-			$pathList \
+			$path_list \
 			[concat $after [list ui_ready]]
 	}
 }
@@ -305,7 +305,7 @@ proc add_helper {txt paths} {
 
 	if {![lock_index begin-update]} return
 
-	set pathList [list]
+	set path_list [list]
 	set after {}
 	foreach path $paths {
 		switch -glob -- [lindex $file_states($path) 0] {
@@ -321,19 +321,19 @@ proc add_helper {txt paths} {
 		?M -
 		?D -
 		?T {
-			lappend pathList $path
+			lappend path_list $path
 			if {$path eq $current_diff_path} {
 				set after {reshow_diff;}
 			}
 		}
 		}
 	}
-	if {$pathList eq {}} {
+	if {$path_list eq {}} {
 		unlock_index
 	} else {
 		update_index \
 			$txt \
-			$pathList \
+			$path_list \
 			[concat $after {ui_status [mc "Ready to commit."]}]
 	}
 }
@@ -393,7 +393,7 @@ proc revert_helper {txt paths} {
 
 	if {![lock_index begin-update]} return
 
-	set pathList [list]
+	set path_list [list]
 	set after {}
 	foreach path $paths {
 		switch -glob -- [lindex $file_states($path) 0] {
@@ -401,7 +401,7 @@ proc revert_helper {txt paths} {
 		?M -
 		?T -
 		?D {
-			lappend pathList $path
+			lappend path_list $path
 			if {$path eq $current_diff_path} {
 				set after {reshow_diff;}
 			}
@@ -420,12 +420,12 @@ proc revert_helper {txt paths} {
 	# as they have quite complex plural-form rules. Unfortunately,
 	# msgcat doesn't seem to support that kind of string translation.
 	#
-	set n [llength $pathList]
+	set n [llength $path_list]
 	if {$n == 0} {
 		unlock_index
 		return
 	} elseif {$n == 1} {
-		set query [mc "Revert changes in file %s?" [short_path [lindex $pathList]]]
+		set query [mc "Revert changes in file %s?" [short_path [lindex $path_list]]]
 	} else {
 		set query [mc "Revert changes in these %i files?" $n]
 	}
@@ -444,7 +444,7 @@ proc revert_helper {txt paths} {
 	if {$reply == 1} {
 		checkout_index \
 			$txt \
-			$pathList \
+			$path_list \
 			[concat $after [list ui_ready]]
 	} else {
 		unlock_index
-- 
gitgitgadget


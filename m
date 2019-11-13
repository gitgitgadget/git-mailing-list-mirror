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
	by dcvr.yhbt.net (Postfix) with ESMTP id B126F1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 09:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfKMJ4f (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 04:56:35 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:34113 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbfKMJ4d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 04:56:33 -0500
Received: by mail-wm1-f51.google.com with SMTP id j18so4448584wmk.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 01:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sbqQKPFLwqefjSeatY3TgmSApYsc1DIwXSJjnSoXqzg=;
        b=Dvi1T352mdy49RNMu39Kp3tpnQgploSMRL47E/ib3zyHQfj06RmLTqOOrHAPylM1bz
         CxbUnM9znmRqSjYQLOnpIDwMbf8ZLu4Gx6Wt4Lm3LpsbCzvd2417kP2qKiogTrbRARcq
         brNbetPwYRp0mh2DZG7utTKXMCgSc27d7Fz/Xk80z6MeDb+5bF9RPutPJf2z1UQAi4Bl
         UMDq0TQSCLwz9km+BE4sxoGolch8+j9E5d5hVlaVPApMVIns8K0AqU+nvdH2Rf233VPR
         539Awe65gV7kH00tyVY33JDcaJSBwDKFFHHogtd/38g3AvdCGQc8Yqf5M5RVpFRoZ9Vh
         pZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sbqQKPFLwqefjSeatY3TgmSApYsc1DIwXSJjnSoXqzg=;
        b=a10WYvDSls22c/wPqZzRKUVEdjR50SrJHzY7GJj9LlgLbautaZ1GY3RZczVsvHMQ3E
         1sOPOtTtAiVN2HIKJ+gLsE/jpcRXGDFfLOqHZwtqYG5wUXVP2vIeq8PuBY63BUnxNxg5
         VROs6z96jypFn+3bMoOqrIyOGhI2eAs2qHUF3ZxGlonyLuBzkJeLiX063PWrIIun6/N6
         2S/Vss6SoD9K8FIh4SPvTxTAOLD4cQWvn4BZfkwF3gnvHJZH+GJ89U1OGRTLlIjKykDy
         eE691hWhBdK+VzKavheRr/Amyh1EVL01oa6ERghoMMBnDFYTGznUP55RP9MkVprbTtk+
         YBJQ==
X-Gm-Message-State: APjAAAURz8JSKF+wcAyXetJLBz2WK6ZWK3UhqUbZhVutyATQyi6n4xs1
        Q3rNeXHiaA615h9obj1ajpUkXxX4
X-Google-Smtp-Source: APXvYqy8mISrZs/ZifXKzFBUENdRo8tBvJgu3lbGgUun+pZsCVVNXMWOPx2Nf/c0QsgzFveaNYQN+g==
X-Received: by 2002:a1c:2e0f:: with SMTP id u15mr1922682wmu.47.1573638990385;
        Wed, 13 Nov 2019 01:56:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b3sm1600718wmj.44.2019.11.13.01.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 01:56:29 -0800 (PST)
Message-Id: <da1704c56e0bd3f1ac53af96b702e3777bb3eb37.1573638988.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.436.v3.git.1573638988.gitgitgadget@gmail.com>
References: <pull.436.v2.git.1573110335.gitgitgadget@gmail.com>
        <pull.436.v3.git.1573638988.gitgitgadget@gmail.com>
From:   "Jonathan Gilbert via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 09:56:26 +0000
Subject: [PATCH v3 1/2] git-gui: consolidate naming conventions
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


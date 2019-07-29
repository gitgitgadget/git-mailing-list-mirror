Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B241F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfG2UIO (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44282 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730176AbfG2UIK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so63184871wrf.11
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OUw7wM3WNOYiu6Xi2N0y7apcoGabVxzK3EzQKZinpnw=;
        b=pTj2tRGipYvQsiftkJhGnvvMdNvTP4ND5BhtEXC/dgWnOmiQw8J3dUNxmTH3Aqhxo4
         9YpQG+HKc5J/lmtiHb/OV7blRUw3xLOfTO6RxtvO0TfZFj0Q7q6I64y+Mdy4LbnqjcTE
         n83WGgZNOg12O3UOW/r7GrBnGXXVeemMdNAxBxZFA4Gi/LG6abBSAsA0BufoZ4qvT9nl
         GgVS7SfN53Wfhi8YSoDoMC2WPqnt2e6Hh4rAmQ3xsCkQZuOJdMFkffnyJWwenXKzeHDW
         Wd3QG4MG9VyFWZqUSNjwtkGynIAp9RdFGrQTdx/XG7NB0qNPFH0rcAblEIYGMfI8kLvZ
         emXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OUw7wM3WNOYiu6Xi2N0y7apcoGabVxzK3EzQKZinpnw=;
        b=C5LDNGtg1v36hqeTFsvrh8/R1/HCZXrlYiiBH644D9VZrpS/oAG62GE5l1fVcyYN+3
         RHeGStrtZ5hXPZg8uQZVMC1QJwYGS7L57AESJymbeW7Ljc1x+kXM1E8QHOP+0a9Nuld3
         7COogo87/MhNwuQJdKXWDrqiEp+69h2bNyLjnAEEGhLxgFYALAT1xPpHM9jqJRP14Vub
         0QxIfEqPMbc6EeAZmJ1AG5gQni7W+EwUItI6PUl8Tb8r1uE4hzzTzBgbXfK8TAGlZERh
         vFg+qax9GxIVlf9QKLaHL7SLvtiBr+kg27HA8bwb4/JN2IU53WXBQG56GFm2poO5Ts3O
         KjRQ==
X-Gm-Message-State: APjAAAU2dXJjGlxV+VR9R/sUFCTEUcMqHND/0dBPda4czPceeT2HxjLX
        k9rvFrJ4kQnc1s1Hz+HnY3+Udp0G
X-Google-Smtp-Source: APXvYqwHZSs8LrgYYBaarO9hFKCsuJIqAnhr9cqrOMXmGQAHXFvoS72Vip0YoxAifUCObBA1DAH0Fw==
X-Received: by 2002:a5d:4f01:: with SMTP id c1mr41251047wru.43.1564430888400;
        Mon, 29 Jul 2019 13:08:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15sm54422824wrx.84.2019.07.29.13.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:07 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:07 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:47 GMT
Message-Id: <eaf1dd449d541d7b8272c6f95af056a548b577ef.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 11/23] contrib/buildsystems: optionally capture the dry-run
 in a file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

Add an option for capturing the output of the make dry-run used in
determining the msvc-build structure for easy debugging.

You can use the output of `--make-out <path>` in subsequent runs via the
`--in <path>` option.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/engine.pl | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index de5c0b6b25..732239d817 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -32,6 +32,7 @@ sub showUsage
   -g <GENERATOR>  --gen <GENERATOR> Specify the buildsystem generator    (default: $gen)
                                     Available: $genlist
   -o <PATH>       --out <PATH>      Specify output directory generation  (default: .)
+                  --make-out <PATH> Write the output of GNU Make into a file
   -i <FILE>       --in <FILE>       Specify input file, instead of running GNU Make
   -h,-?           --help            This help
 EOM
@@ -39,6 +40,7 @@ sub showUsage
 }
 
 # Parse command-line options
+my $make_out;
 while (@ARGV) {
     my $arg = shift @ARGV;
     if ("$arg" eq "-h" || "$arg" eq "--help" || "$arg" eq "-?") {
@@ -46,6 +48,8 @@ sub showUsage
 	exit(0);
     } elsif("$arg" eq "--out" || "$arg" eq "-o") {
 	$out_dir = shift @ARGV;
+    } elsif("$arg" eq "--make-out") {
+	$make_out = shift @ARGV;
     } elsif("$arg" eq "--gen" || "$arg" eq "-g") {
 	$gen = shift @ARGV;
     } elsif("$arg" eq "--in" || "$arg" eq "-i") {
@@ -80,6 +84,12 @@ sub showUsage
 # test for an empty Errors file and remove it
 unlink $ErrsFile if -f -z $ErrsFile;
 
+if (defined $make_out) {
+    open OUT, ">" . $make_out;
+    print OUT @makedry;
+    close OUT;
+}
+
 # Parse the make output into usable info
 parseMakeOutput();
 
-- 
gitgitgadget


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
	by dcvr.yhbt.net (Postfix) with ESMTP id EAF711F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390501AbfGRNTO (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35582 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390452AbfGRNTK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id y4so28695067wrm.2
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OUw7wM3WNOYiu6Xi2N0y7apcoGabVxzK3EzQKZinpnw=;
        b=EDnKNX/4nMDERo47Lhk7ciNpBLHd0X/iy0rJH1OThhqiOycIV1hqsyJtBjhmLOYzmW
         KtOlCcH3eoylJ+qZYUt2506Y7S58JorEbQ2wOYFTMkvveFece0aOYoozxxv4WlH83BYe
         oj9ZKo7m8fBrNWdcG7x2IYD7MH1diSLA0m+SZgOtm0KneP3HDlwNIG6SoOC2a0aAeoA5
         I3eKcz2wM9xl8qZD/YzShn83B3QRroTe4PV6elyAWQrcGQoYcl8agxeiB5dIodmPbTbO
         4tKRMyR14fXb7BlTxMPkSIZL6ftBlypDicb+ZCjwdIu+jhf2LkpVJGHecR9srVBQ+yQg
         km/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OUw7wM3WNOYiu6Xi2N0y7apcoGabVxzK3EzQKZinpnw=;
        b=XdVGRQjSDxjJ06XwGLVk2tqPSLW+3p64HNickdmEbf955MpBQP4mbTvUBXQpGtYIp/
         ZBOSlbmreP68bdf1Eqqpz6WBsM/qf3FRgEOknMW1ZSiwEdgwp+ofrQqIx/e4nNIF7qL0
         gHhzN5v/cN3ED9NvalnpJLQvrflN3wbHQVPwguJGzhTfF7+3CAuEZ6GUSnbmn5B1qNA7
         VkcvS3ezrE2aXT93T3j2CNUkTiHrkv3zVOcCpy1SF7hooUNxVjQ7V4KZAzQBvi2PMl5a
         SQdwqtWdfOC76PYky7c0Fh9iCyc9RU6M6Cct90iU0horXoehY7FEayg9mLjYdV7/KMGV
         8RxA==
X-Gm-Message-State: APjAAAWDo8pZV7uidzidSSJ2fZ+0KqTsU9ba7kLk3mGe3MjVId5IUR1g
        sQ50Pa4lohxSu72CZ78mixEAEYUO
X-Google-Smtp-Source: APXvYqxXYye+Z5Ev6NZ2VkYeJuErYzDfwaFVLUtiIajJIxtVlgeXDFMEhA0RB/8OsqFi5rsIY2RxJA==
X-Received: by 2002:adf:90e7:: with SMTP id i94mr21185244wri.224.1563455948616;
        Thu, 18 Jul 2019 06:19:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10sm21053311wrt.49.2019.07.18.06.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:08 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:08 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:46 GMT
Message-Id: <eaf1dd449d541d7b8272c6f95af056a548b577ef.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 11/24] contrib/buildsystems: optionally capture the dry-run in
 a file
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


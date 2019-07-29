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
	by dcvr.yhbt.net (Postfix) with ESMTP id C594F1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 20:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfG2UIJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 16:08:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56194 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730177AbfG2UIF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 16:08:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so54980219wmj.5
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 13:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WbI3jo5hS0woR7wltjg1GZrZ7cNQ7AjPnEAyvlrHHUY=;
        b=mkdRdxko7qrX6+LhbqxkbEACtRpOaqk4eqgzOsrxHYmoexE2tDOKgGS3HuqT70TKtz
         EKapp3WrPte6QcsKNX8xqRKcQUA/f+x3nSz7eGhDCGWcu4qY4+pbJ90b9kpWciEjwce5
         oujYKowOzJD/4ea8anWHt7QKZz/g/h+ED1qhxIpdPQtAP7MZVqczQB0jQF4pHAICK989
         QyBwMxQRmKvVrD1sMb7JHksXdxSp90J71tXa4RL246N1kdd1ATvmun5H1xK98MIxzZIm
         ppjKgRKgDJkTGctyW1xpzPzjnQtxIGz6pP+pejytSmCVThTZEN5Lga0f1B9owCYX/qor
         se7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WbI3jo5hS0woR7wltjg1GZrZ7cNQ7AjPnEAyvlrHHUY=;
        b=E3Ar6NGcrUeanqIvkdLvHpOMR+TMm6wRmx8eFA3OpyjPf4ptDUcFzJ5hg8+0XhHX4N
         rDFs2JZMuXW0NOsjq/q2zEbfavsh6LZ0DSXtToIEPVxvZZrxmw8HAwGjZ8+Os5uxGZjP
         /0MDxc2FPmyyOEPCcsnrszFud5/TipgyOS1Oqvx1jv/DdlBGMG7JWM0drjP1kgHumAtf
         4sXiVuQW3f49BDQ2T9WgA82QfEA5vCg+GfdXvsf/m00BnHOf68J6I7S1SwhWXkrKC9WA
         OGfu41f3Dim1ChvwLm7yoktUXy/awlxG2eMm/ihApFXAK9Yt4xKc6791aUKCrbBxFX16
         SCiA==
X-Gm-Message-State: APjAAAUnAOn4I1HjQ/stcDAArboGwpeqnJjKziG0b1/QfRHxA8Q7R0af
        f4T6QkGlSqVIy581/TrLoq0xyLtZ
X-Google-Smtp-Source: APXvYqzvuT3+IACm13j4Xvnkf+UqzdNqh69/C51iuxLftf4JuayedaybS55ai8BcVNCHbU/ANoLJ1g==
X-Received: by 2002:a1c:b146:: with SMTP id a67mr98532482wmf.124.1564430883674;
        Mon, 29 Jul 2019 13:08:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u1sm57570787wml.14.2019.07.29.13.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:08:03 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:08:03 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Jul 2019 20:07:40 GMT
Message-Id: <f4d41c65e92b2aab43986c2f3763f33e82f3120c.1564430879.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.v2.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
        <pull.287.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 04/23] Vcproj.pm: urlencode '<' and '>' when generating VC
 projects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/Generators/Vcproj.pm | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/contrib/buildsystems/Generators/Vcproj.pm b/contrib/buildsystems/Generators/Vcproj.pm
index b17800184c..737647e76a 100644
--- a/contrib/buildsystems/Generators/Vcproj.pm
+++ b/contrib/buildsystems/Generators/Vcproj.pm
@@ -59,6 +59,8 @@ sub createLibProject {
     my $includes= join(";", sort(map("&quot;$rel_dir\\$_&quot;", @{$$build_structure{"LIBS_${libname}_INCLUDES"}})));
     my $cflags  = join(" ", sort(@{$$build_structure{"LIBS_${libname}_CFLAGS"}}));
     $cflags =~ s/\"/&quot;/g;
+    $cflags =~ s/</&lt;/g;
+    $cflags =~ s/>/&gt;/g;
 
     my $cflags_debug = $cflags;
     $cflags_debug =~ s/-MT/-MTd/;
@@ -80,6 +82,8 @@ sub createLibProject {
 
     $defines =~ s/-D//g;
     $defines =~ s/\"/\\&quot;/g;
+    $defines =~ s/</&lt;/g;
+    $defines =~ s/>/&gt;/g;
     $defines =~ s/\'//g;
     $includes =~ s/-I//g;
     mkdir "$target" || die "Could not create the directory $target for lib project!\n";
@@ -271,6 +275,8 @@ sub createAppProject {
     my $includes= join(";", sort(map("&quot;$rel_dir\\$_&quot;", @{$$build_structure{"APPS_${appname}_INCLUDES"}})));
     my $cflags  = join(" ", sort(@{$$build_structure{"APPS_${appname}_CFLAGS"}}));
     $cflags =~ s/\"/&quot;/g;
+    $cflags =~ s/</&lt;/g;
+    $cflags =~ s/>/&gt;/g;
 
     my $cflags_debug = $cflags;
     $cflags_debug =~ s/-MT/-MTd/;
@@ -297,6 +303,8 @@ sub createAppProject {
 
     $defines =~ s/-D//g;
     $defines =~ s/\"/\\&quot;/g;
+    $defines =~ s/</&lt;/g;
+    $defines =~ s/>/&gt;/g;
     $defines =~ s/\'//g;
     $defines =~ s/\\\\/\\/g;
     $includes =~ s/-I//g;
-- 
gitgitgadget


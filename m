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
	by dcvr.yhbt.net (Postfix) with ESMTP id D48F61F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390454AbfGRNTJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:09 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52107 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfGRNTG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:06 -0400
Received: by mail-wm1-f52.google.com with SMTP id 207so25582070wma.1
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WbI3jo5hS0woR7wltjg1GZrZ7cNQ7AjPnEAyvlrHHUY=;
        b=gf/kqTjyYibYGXwfKc+dFHBzDokMFlQ/BRzFXhOFOC5+Z+EHZR8bCwExHRay2NlLY6
         Z3t6iOolVQn9Km5ZhBZ8Vrj5eqQYzGmBEx60OJsWRWuBpUdjJIdc1Y9hlsuXh/40Rr9D
         LtqT4u4l6hmu2goYpHUXjZ4BgmKvopnlA2q+hcuLWptEDB1+2MZ8nOrfhWNOtu/FD4Si
         ++Gzjku1pM6GIFBfQ7O6iNHCUTAT1E0VcDbeIMj0eWUYBjGKco3RsiX0Kial55IWN9ZG
         XPBO9FM64uCErQBureB53be0I/tcJxWesMRLwUe52wodrHsVQaliF6a/pkN3XL4OyXk+
         SVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WbI3jo5hS0woR7wltjg1GZrZ7cNQ7AjPnEAyvlrHHUY=;
        b=p3d7KdmNNcGO5hZhWLA4Bs7PmLCyS1qxd1NnEfzgQ3JB82s7GO1aDlNbF5Ab1xTE6m
         XTkOcqQZOUDukgkbAomYIZhsnaxROL4h4Y+Rkw7KV8h8i4X06dAYsf+1UY1+60qu5wzS
         ftiVnH/i58Ium+T9Xqn93bN16ZJLm2w6iiTrtSkuBPoQSIoDq43ohbSviUQq4ZEfQwCc
         p2QzgAr01uAv/6FeatWi/WpAxsRKnVPdIq+7PxmwnmZs4mckJ8Lry2bCOzb605CAzTRW
         +GDGAjSfOHLouzdwKVRSHT6y5vhnHy3MaKmC9q7jTP+WpVQ+CtXQoBi6J4YreyQy6PkF
         QWiw==
X-Gm-Message-State: APjAAAXGisWEnMC9bnak9BxohBH+cxXr+7JoLRkWEFgcjDYincA9eiXN
        5S5346HzrCqpLOwcrzwkOiKbDouK
X-Google-Smtp-Source: APXvYqyiSGgJMCMfBPVSuOfBk7i59XqAcZLUfcJfQ74uv+ZWzp878+3J2orx0aPRd49gvjHnaVA5ew==
X-Received: by 2002:a05:600c:1150:: with SMTP id z16mr41307815wmz.168.1563455943878;
        Thu, 18 Jul 2019 06:19:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm22361271wmq.25.2019.07.18.06.19.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:03 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:03 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:39 GMT
Message-Id: <f4d41c65e92b2aab43986c2f3763f33e82f3120c.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 04/24] Vcproj.pm: urlencode '<' and '>' when generating VC
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


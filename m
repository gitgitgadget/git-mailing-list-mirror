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
	by dcvr.yhbt.net (Postfix) with ESMTP id A8A181F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390480AbfGRNTL (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41669 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390444AbfGRNTH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so25468760wrm.8
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZsMTYhK2ok2pSdGHeJ351sDFGcg+R6HsHq5y8VmRNuU=;
        b=ckQuryfu7HYvLbbDRYkUUmLd4jPcItl9zMMXubNF5gjYm6NwaMXDvtoK3whuIKlhjf
         Pz6eR5BUpMKD1XQl5hZEIn6LwXGDU5xLXsj12QyRbYdHnMo5AbPlj9+3mRGHGumEX22p
         Ek5hPm26HFXy65Ai//UkLu5gtPX0EYCFbm8Zl4j1ZiNPj1IVeAebzt/pN4MoJ1pNU1jX
         8cJQvP6cP1yAXtfS9jS1Eo0a1ZGrFoXRCN9lA8zt1KpbeyyzLoVxnZT45O/bL7SYYqGa
         x7zQfUeOz5WQSJFuxKyEraYUXPT9dldEF55rkGxR4kAOg+S2JwNJafKZkIsVXMrLsKcn
         l+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZsMTYhK2ok2pSdGHeJ351sDFGcg+R6HsHq5y8VmRNuU=;
        b=XzFVdOrcU9QHRJJJQnvc//0jZSQ6tCw7Oq557TZXn9xTdnZYu70xq3MksN1ij8It5w
         IKECy/XE91YUoEO+OzeMc3FJWePrEoXHrJesDyYYjde7sycwtaYsHrBiaoLQ0jAxf4GM
         GvJaeBxrHsa+qh7rRN4/Z65lrv/pa9L+KV7HBDv3aieqdT1f6N7d+LUakj2jri1MF5mg
         jjxyyi1RtxVY9YV76YnuIwajLDQAwMbFsP8WpBKcKGgYqO2wCZ6PM4OTMfJpjAALn9a3
         iijiF39Gt048ryFRFf7J4fjfMTH6z+z8oZWvwiT2KeOahMIOagvuMa0la6V4qP/8C6Ot
         xPAA==
X-Gm-Message-State: APjAAAXgFwlu9ltmv0cWnPE6UQUUbOBbwcJ8s3lpz8b3SM+ATB+/z9qe
        4XjD65EJbWK6HqgbjOvNnh8ejc6V
X-Google-Smtp-Source: APXvYqxALZxv7S90u3zuc0DP6ioLhJRaL/iqr9XYxSUTnjK4miPsOMBgr6Fg5VshykScVPIUrJ47YQ==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr49133569wru.280.1563455946013;
        Thu, 18 Jul 2019 06:19:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o11sm26574488wmh.37.2019.07.18.06.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:05 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:05 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:42 GMT
Message-Id: <b8eb868316990ae180323d04efe08ed7d48c61ef.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 07/24] contrib/buildsystems: fix misleading error message
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

The error message talked about a "lib option", but it clearly referred
to a link option.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/engine.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 53e65d4db7..11f0e16dda 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -333,7 +333,7 @@ sub handleLinkLine
         } elsif ($part =~ /\.obj$/) {
             # do nothing, 'make' should not be producing .obj, only .o files
         } else {
-            die "Unhandled lib option @ line $lineno: $part";
+            die "Unhandled link option @ line $lineno: $part";
         }
     }
 #    print "AppOut: '$appout'\nLFlags: @lflags\nLibs  : @libs\nOfiles: @objfiles\n";
-- 
gitgitgadget


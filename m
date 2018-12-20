Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7831F405
	for <e@80x24.org>; Thu, 20 Dec 2018 13:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733300AbeLTNss (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 08:48:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36430 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733197AbeLTNsq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 08:48:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id p6so2265193wmc.1
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 05:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b7HRv9tY97SmsUnX3NVekx5KGQMdvWY0dIlgxXsfVfo=;
        b=mYKARFnFDb0M1WPA3Y5SwNyZvmSSG012T0HJ0VRHF/YPoXyiur+00gVOxYOAiRqYpL
         L9o2w9jofSfI8qemxwRuapnbRlDmFdVyq75aPn9nZsH+KIDYDOkng7jYBN8nqXv/bZhJ
         gsYG1O7uacQwMbbE+LSp4oEkg8BAWd4f9ziWv7KxqqihRt6EdjW0SQgKVYc9+aYuMY2s
         leRpF9yN6EGalmBwZrRn99yzdQ8Iij032HGAbtchJRYf2jEwZ6S+bCEtPVZSExHi9gaN
         rsnHi+x6B1x675BxXgw14uf93pfFFGN9Uu9PVYRWV4YrOeyIsRvGz3k6LTj7tqhclBL2
         mrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b7HRv9tY97SmsUnX3NVekx5KGQMdvWY0dIlgxXsfVfo=;
        b=Wdbsi/Nx88sWMEQpJdpVGll1VixM651OV5PRmcPzKZASxMFXZyIkq2Aku150piccSI
         6eKkjDoF8xJ5NWa6Y+RtpvMbYkz4di5uXooD5gtrLQOSzKIsH9QRSuVLCvY+PPCzYaP+
         QMGrv1FVj1AXWEe7QDQkmmjd5ckyQFRPWH/8R3f7yLz6u7fQqQkaeQoiQVfEssxCwm4G
         46Ga2mFWBGD5wIH8Q7pKvlN6LkjGscugUn6ro1G2lMCx26L6KEuf0RsoDnurHopd/npD
         4B2gYmGzugmTcGKfpv419nV06l/mD7EsJ5/GgX6kfTu42xpJ08aVyheAlKhO6KdCtmJz
         3/yw==
X-Gm-Message-State: AA+aEWbFWbZjYCA4vxCTDbEeJ5EoPBbcYk51VDl/EXErdXXqSUyHpXT9
        F+a4qeLeRvsm3UJ5zrUfuH3ZfDUjbaw=
X-Google-Smtp-Source: AFSGD/WSXcZLW6SRBDlrP/vdeWmiZETLmNZU0+f1skgRQ3nZh2znTyoK85t9eEcAgfXvzq8EZ+ktsg==
X-Received: by 2002:a1c:bdc5:: with SMTP id n188mr1060537wmf.69.1545313724129;
        Thu, 20 Dec 2018 05:48:44 -0800 (PST)
Received: from localhost (host174-110-dynamic.249-95-r.retail.telecomitalia.it. [95.249.110.174])
        by smtp.gmail.com with ESMTPSA id p6sm9035433wrx.50.2018.12.20.05.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 05:48:43 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 5/8] checkout: clarify comment
Date:   Thu, 20 Dec 2018 13:48:17 +0000
Message-Id: <20181220134820.21810-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.20.1.415.g653613c723
In-Reply-To: <20181220134820.21810-1-t.gummerer@gmail.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181220134820.21810-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The key point for the if statement is that read_tree_some did not
update the entry, because either it doesn't exist in tree-ish or
doesn't match the pathspec.  Clarify that.

Suggested-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/checkout.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..cb166b2e07 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -304,10 +304,10 @@ static int checkout_paths(const struct checkout_opts *opts,
 			continue;
 		if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
 			/*
-			 * "git checkout tree-ish -- path", but this entry
-			 * is in the original index; it will not be checked
-			 * out to the working tree and it does not matter
-			 * if pathspec matched this entry.  We will not do
+			 * "git checkout tree-ish -- path" and this entry
+			 * is in the original index, but is not in tree-ish
+			 * or does not match the pathspec; it will not be
+			 * checked out to the working tree.  We will not do
 			 * anything to this entry at all.
 			 */
 			continue;
-- 
2.20.1.415.g653613c723


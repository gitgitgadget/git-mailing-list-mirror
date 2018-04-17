Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C354A1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 19:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeDQTQN (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 15:16:13 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41164 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeDQTQM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 15:16:12 -0400
Received: by mail-wr0-f193.google.com with SMTP id v24so21421487wra.8
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 12:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mlug5SLIpjGZanA2/xoOcoXiL9J+PynOOyrm0iTA8W4=;
        b=n5rUvb5EVwa7P/o9nFN6fT/bRNhLmSwo+euGOL5NYoqLdl+BPU+WIboB52BrVTL7jh
         21SvLVN1iU1q5ULOjA788P6s7qecqXRGlKI6h8l+Z3snMo2v7m1J2DlQU8ttfDueizdh
         Qhbs8dZ1OYCWYNvWSzDjScaBaZcxFxxQkX7d2AdWkJbMd1tvg7uM/PtTGq1yMPagXgxX
         bBuX86OG3fnHG23OEpB8uZMpoXbSxd6uXS5TZ1neFYvx26I8D2/lJlPa5L81jyQZUjKA
         A0LnvWYJAlROi2R3dwd0B63aGzp4JzeJvadixEN4+9yft4Pt3L0k5hwyM9Xje3Qr3rgd
         BN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mlug5SLIpjGZanA2/xoOcoXiL9J+PynOOyrm0iTA8W4=;
        b=bguMfMxYmppmppb8VP1bDE1yTNepf8VnQQOrTcwxAnlr7+8ihP9O9980sGC63Jravz
         pxZyFHCfV7gTvCcs3wNa6KFYB5fh/mpxYvubt9oYQg0o2LSct20AmXppckvD+r0YJgr3
         bvwowTrQ2BCS7B3YeBSBCs8XJofCtTnsb8+yNUn0gZAcfchYz2kvLJq1g+G2D/7aLVul
         4A1+vlzo4m3q3sLnksjdnTLqnkFXH+SBetH+1Tncvzu5rogM0cw2FNKTAc8x38W4OxQx
         KQgKVoahEkwAGOgiUN4akYwVf7hoS4O/vRVrrFzCoMZgIdXiOnxkLcMN/nzbpAH+KWa3
         sNoQ==
X-Gm-Message-State: ALQs6tAmdBRzCXtQW5akXR57qSXdEi8haDEqIcMk5h/qKmClCoLJUTCu
        olHaAY0FQRlFVtxXIEpOSMsY0vZL
X-Google-Smtp-Source: AIpwx496/aNCjHl6/5Ij7hXIEKgpWN/2dO6VCU4PRvFcRsVtoTmXX/fYrULAR83ZSPDnFHm46n8GUA==
X-Received: by 10.28.5.10 with SMTP id 10mr1882693wmf.47.1523992570345;
        Tue, 17 Apr 2018 12:16:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id m62sm2745398wmc.41.2018.04.17.12.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Apr 2018 12:16:09 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 4/4] git-submodule.txt: quote usage in monospace, drop backslash
Date:   Tue, 17 Apr 2018 21:15:29 +0200
Message-Id: <c22515c89a336040f5af81bf4114e437c0eca1e7.1523991648.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.252.gfe0a9eaf31
In-Reply-To: <cover.1523991648.git.martin.agren@gmail.com>
References: <CAN0heSru4-VoCTxZ6OHU_jdTs0__xvRmd45Dd0H3L8apMKkW6w@mail.gmail.com> <cover.1523991648.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We tend to quote command line examples using `` to set them in a
monospace font. The immediate motivation for this patch is to get rid of
another instance of \--. As noted in the previous commits, \-- has a
tendency of rendering badly. Here, it renders ok (at least with
AsciiDoc 8.6.9 and Asciidoctor 1.5.4), but by getting rid of this
instance, we reduce the chances of \-- cropping up in places where it
matters more.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-submodule.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 71c5618e82..630999f41a 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -213,8 +213,8 @@ sync [--recursive] [--] [<path>...]::
 	submodule URLs change upstream and you need to update your local
 	repositories accordingly.
 +
-"git submodule sync" synchronizes all submodules while
-"git submodule sync \-- A" synchronizes submodule "A" only.
+`git submodule sync` synchronizes all submodules while
+`git submodule sync -- A` synchronizes submodule "A" only.
 +
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and sync any nested submodules within.
-- 
2.17.0.252.gfe0a9eaf31


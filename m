Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87C7D1F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753103AbeGCL1A (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:27:00 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46129 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753215AbeGCL02 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:28 -0400
Received: by mail-pg0-f65.google.com with SMTP id q14-v6so836315pgt.13
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=IrP/ZppE9OZ1XOhoVmFPS9m5BSwvYKE/ZDTYRWCGdj4=;
        b=J1T40qEvwFR6ou7hMATTWWThCodRf+X6KJUsYp0HNAW1ddgD7EqbU1M6VJ5tI8YLZS
         YtgRHipexTYNsZ6xboOQAYn09KMSGnfN/oYuD6sApwirV7kKyRUkTsXFserXOZqSrPq8
         /dnpfM0hbOt5rg1XG5fED5QdFg2ZBFxxyQq6A3C1BH6wHJPyHg8RpeHfaP3Ks9i7RjjD
         XE0+3K4yHJyEvkzBTCmjiYPdbMQWF5V4TRiS18JX28Y8FU9iwmPCxSNAuV/AzfzK6r71
         lssFnWA+BIW3mI1dsqFaVmd2blMi/knzlOLF+gkACfxhCt7AXemU3QAHvQleOX3+u7Cn
         OAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=IrP/ZppE9OZ1XOhoVmFPS9m5BSwvYKE/ZDTYRWCGdj4=;
        b=hRWOukZkrTYW4R+3/8ETck4E5bIWQhqj0wdRea4WmIFU9IR8046gjxilj3o6CjUMjX
         mp2TpfBRtBWZEtKMa/dpM62U7/sjWQgAYpGbD9qHrbz/NMAlQb6n4FfH9SbqYIa1g4Fq
         75iFVY63B7ZMoHqRf8GfasnVZQWEpC7U8UwqlKZPfoHGuACpDGEyLRUhBktEEhdrlpas
         moQLDjYgOL4bKcvCDvUnTB7VBmAJLWhUjLyffJFzUHK1GPmcRAhIYC/NisfwQo3HnqM2
         v76Ak77+WRcN001t/1L5H5ecwsQ7i4etl+80aYHU7RyHzwKQ5c9QqVi91sj6HIzcjxmE
         htgg==
X-Gm-Message-State: APt69E23GnPkDqtjNRLFrWgS2XOW5+sojatx5MjjngoBvpeRF57pq3u3
        kF9TkD5kMTtBqadyt5ADFzVrSw==
X-Google-Smtp-Source: AAOMgpd9Bedb0eqNEGifuE5FHNjzN8J+F8uTLKuA0QTQAK/sqzKmgfLAH3wigJBw1g2oAcVrNwjB0g==
X-Received: by 2002:a62:675b:: with SMTP id b88-v6mr25260233pfc.24.1530617188238;
        Tue, 03 Jul 2018 04:26:28 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id s12-v6sm2064736pfm.41.2018.07.03.04.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:27 -0700 (PDT)
Message-Id: <96a3073fb3499fa3f87606a678f5d3e6c9710ccc.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 3 May 2018 02:14:31 +0200
Subject: [PATCH v3 13/20] color: add the meta color GIT_COLOR_REVERSE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This "color" simply reverts background and foreground. It will be used
in the upcoming "dual color" mode of `git range-diff`, where we will
reverse colors for the -/+ markers and the fragment headers of the
"outer" diff.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 color.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/color.h b/color.h
index 5b744e1bc..33e786342 100644
--- a/color.h
+++ b/color.h
@@ -44,6 +44,7 @@ struct strbuf;
 #define GIT_COLOR_BG_CYAN	"\033[46m"
 #define GIT_COLOR_FAINT		"\033[2m"
 #define GIT_COLOR_FAINT_ITALIC	"\033[2;3m"
+#define GIT_COLOR_REVERSE	"\033[7m"
 
 /* A special value meaning "no color selected" */
 #define GIT_COLOR_NIL "NIL"
-- 
gitgitgadget


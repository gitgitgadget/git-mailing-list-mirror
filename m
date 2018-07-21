Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02981F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeGUW7U (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:20 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44245 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbeGUW7T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:19 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so6621823pls.11
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IrP/ZppE9OZ1XOhoVmFPS9m5BSwvYKE/ZDTYRWCGdj4=;
        b=rHJXhyQq/tVFWr/M18J/fSMk7A0RZ1b5nA6WCxieEcIfF/xwdPeHl8CS6esQFl3pjG
         FlM0ZRk4wTRQ+OfiQKCQ486H43lISXhsaEBzKfI1HVO/du8BHHPlpSG+oW9ABmrPLk3u
         rUb8BQOJSlbERQ8LSAZs88CrxNAMkc9bNGFDEqMdJZpmrzuu41oKVuyL/bDyo9mAXz9W
         99QTUWyQLnPdH1ryu/kMMbS0yymkcnKUynVZ6MC6DIDgywyTBYUEVQ8fb0qCHM5KG9uT
         rUxAMnTmJoPqPGK15Mz6I/sGG8NLyGV0wJds+qT2GpDMQx0PuQyAtUNkMPt/BVU/AhAR
         X+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IrP/ZppE9OZ1XOhoVmFPS9m5BSwvYKE/ZDTYRWCGdj4=;
        b=bxnpwT65DU1M7JHmiajGGTlOMcdzL6MvYByFfXrgLx42o5fSpZmBm4aYuA4xvooRVw
         y+WrSWEeDyEF3YBMYOrrHTNsS1M4tvO1OQIi/0ewOCPLUyP5a0gXoGZkIt0YUe+W6h7A
         TCLFHswpqKStVRKbAGfStOUZ6BoElumcwskMvs/f4mAzqW3ofAMK3742Yfaz0Q9sDhOb
         rfXg0CnRwOlX3chSnTKYWRsiya5GbpKMoqv6iAQnXmuk2GqRhI+mdT6NrXR+YRJEzPPg
         tUT0+HJYaLW8s0sJDtE//CRI6a7ZVel8GYl+AVkbL287R8nEdfhC118osEemOj57gjLQ
         OOQw==
X-Gm-Message-State: AOUpUlGFLHCoegqkY2JkjR/cfBlepbICVozJWZ2z02d+IeXlqY5xP+4i
        hlVRftTv2IthxNi6G52tfmHRTCE2
X-Google-Smtp-Source: AAOMgpdoVlm3fkuj8EdTnFG4XSSEGwOIrgquYlmb8B2hos349U5UVXpsK6AbZ3gVRj9pkZSM2mXbGw==
X-Received: by 2002:a17:902:b08a:: with SMTP id p10-v6mr7032433plr.217.1532210703691;
        Sat, 21 Jul 2018 15:05:03 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id q140-v6sm7487758pgq.11.2018.07.21.15.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:05:02 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:05:02 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:34 GMT
Message-Id: <9ccb9516ae1fcded3e9000b795a780b8b189cb33.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 13/21] color: add the meta color GIT_COLOR_REVERSE
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


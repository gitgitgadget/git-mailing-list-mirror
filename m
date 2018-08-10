Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9B11F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeHKAqb (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:31 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33103 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbeHKAqb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:31 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so5139474pfn.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IrP/ZppE9OZ1XOhoVmFPS9m5BSwvYKE/ZDTYRWCGdj4=;
        b=nHv3ogCQYH6Q8MtCeh5LGmV0RnqC1SdXLt5ppdK1pzvLDgYDAazxroErFYuos7/yD5
         DIi19tlRPnaqB22vKIHlTiHBz4lUkeJklMCSfHZBlEp4Z8QGh1kRiNEiUf8DST0PmSCk
         xSdtR2pwUthNqyMDG1902Rb5drmx/jpA8ByMYZDNHHO7oeQi94e21nHkBDbSlWr0DdPt
         oZK2Bxnm6S82w83FGK9X6gBEkbN/+JR5he7AAZsdqcArOS8nejR8NqZ7LIxkMpoutVbJ
         qujpXJQOeMhP3myhQrmkLSd8EyXNukxQVGEtlgaR5g/BSZCY3ipx0oWTjsjzS/g0D5mw
         7Tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IrP/ZppE9OZ1XOhoVmFPS9m5BSwvYKE/ZDTYRWCGdj4=;
        b=eP7+3q2uSsXppAZFYVvQyYsrxXXD4X642sL5Bkd2hsjs9IhO6z1PSEODrF/mTE6N4j
         P/Wpco/UT1yO2VZ1nyR/YHMr9nf3YmRn25BqN1H1H4pBz2khAFH7btUB4pK+UUKirXN5
         EzPG7pl/MFt90/cc5MiQbzwUTZHpotnTsDiznBM6DSl7J0hAEN80SjFJbNVB19j+BeDW
         b+I+l5u4U/XIfYUX2dEII96ALeYgU7YkGHvopZ4JvNMxbLaTrmEbbRETRv5xonmbAC0H
         NVKVeRAemQMdg9M2OCXlvgzGZHoVmp68JRMhTc075eihw8QoWVAaewKyJ609ypFRI+H/
         4hNg==
X-Gm-Message-State: AOUpUlH1sm95mbEcoVv2Jv//Gh2+ewYvYHpjRy5bHGMi/f0Aja9mPHnx
        KgTFTHEgzM2syp0e/kh+Ll54p4XH
X-Google-Smtp-Source: AA+uWPzAMS5v5JcExuo00+PoB+PdGoBfkFzOiW1pHkp6rA+lCQROf5Bh6iDvcQPfu7mu18Bjx12lJA==
X-Received: by 2002:a63:2dc1:: with SMTP id t184-v6mr8081285pgt.62.1533939285344;
        Fri, 10 Aug 2018 15:14:45 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id r81-v6sm16245468pfa.18.2018.08.10.15.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:44 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:44 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:15 GMT
Message-Id: <1ad74f9396b216d853a3e96206692f9a137aef6a.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 13/21] color: add the meta color GIT_COLOR_REVERSE
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


Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1075BC433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242437AbiCJNgj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242419AbiCJNgh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:36:37 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B1F14E960
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:35:36 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id x15so7948236wru.13
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=71UqTVjIiUbJ1ahHInAEsbpiPVWgfl9HccksDeM7pM8=;
        b=NgV8w/JxTOh+OqKyjft86Mgj34/rLP2kbJnsEFsudwsu9VhCrx35tj7EivvDNVUhrG
         s3+GdYXRkdJdh7yLXdHTWyd4WQSwmZ2w7Cc4q8Kta+zHsXn5XYe3pOz3XIWlt4Jfm/8S
         Y/BBkn0rFN55P3owLxUh79hphei7oLIJax7e7wOxjSxN0GlXWfvgC7S8v8tynhlTwu7n
         ykf8kpusDSKi4/tiD+Y/ORxzn/EtcCyX6LoRTsxbpTNFTiUC8C2Z4eX6iwSsnc0YLghX
         3HOT7PseKn388cGFo9GsZedBuiTYJ12iEb1MTo9oJCl9iaL4G0QQVp7ObKSluSDqxS5l
         rXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=71UqTVjIiUbJ1ahHInAEsbpiPVWgfl9HccksDeM7pM8=;
        b=4HKm1b4JcOUAcTyz5whkkkRZiAofCSdtynNHcZOzgTwWjNoXOe5iuYi0IfWbk/CGTg
         NFo4kt3y0xHHl9L3IpDdRaIGswIr1aoYpyteEedImPNBWECCWqHzw1cZNWweVjrQenO9
         /yj6yGTsb8yZDIG3RCibYKLUqXPjrHhnpFAwH63WSHDNsSntnBlLs+ykjcZZen281JwV
         90EDkROAwzLtaUNiI2dHqHSXnHohjDrGIlPJjFknwXBLH2u04zBQ3gYUW9QVtZnROIsx
         8wC3AGn2aFK20tuRNzx/+K7UUwXfoEAxCBRaRraPOkbsF3WD8FVBZtMQMFNSAZovrFO1
         iALA==
X-Gm-Message-State: AOAM533A3s/OMAJwIpUTGvlhCN0LzYX8PuEDXq3aIRiJUbkzAx1tub+k
        xoG6s7vuLOLCqyE5YUsrUcG0AOzd3zM=
X-Google-Smtp-Source: ABdhPJwUZOOgiEQ6FKngl7vqpezbKrMjQGDhdWg7IHsucczhPOP5z0MUKFDF8HvbCjZpgaw2Jz0YXA==
X-Received: by 2002:a5d:4487:0:b0:1f1:232b:794f with SMTP id j7-20020a5d4487000000b001f1232b794fmr3719429wrq.715.1646919334714;
        Thu, 10 Mar 2022 05:35:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r187-20020a1c44c4000000b0038377fb18f8sm6735396wma.5.2022.03.10.05.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 05:35:34 -0800 (PST)
Message-Id: <284c6a3df84bed669790fe2f44905328269d1f4f.1646919331.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Mar 2022 13:35:29 +0000
Subject: [PATCH 2/4] trace2 docs: surround more terms in backticks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-trace2.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 77216eff622..8ef921a4e4d 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -70,7 +70,7 @@ $ cat ~/log.normal
 
 The performance format target (PERF) is a column-based format to
 replace GIT_TRACE_PERFORMANCE and is suitable for development and
-testing, possibly to complement tools like gprof.  This format is
+testing, possibly to complement tools like `gprof`.  This format is
 enabled with the `GIT_TRACE2_PERF` environment variable or the
 `trace2.perfTarget` system or global config setting.
 
@@ -172,7 +172,7 @@ take a `va_list` argument.
 Some functions have a `_printf_fl()` suffix to indicate that they also
 take a varargs argument.
 
-There are CPP wrapper macros and ifdefs to hide most of these details.
+There are CPP wrapper macros and `#ifdef`s to hide most of these details.
 See `trace2.h` for more details.  The following discussion will only
 describe the simplified forms.
 
-- 
gitgitgadget


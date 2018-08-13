Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC0B11F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbeHMOPT (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38078 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbeHMOPS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:18 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3-v6so7380519pgq.5
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mNPuVOLfAv83qJ58LyUwgbNxGqHRWthH+tV7Ychlzyk=;
        b=avYTdDZnlNBe3RCQwST180qECiyqPwmdJNV0GlqwXMc5thUSmOKnonqGOBJf9bLvw0
         5NrGRE+el4pEDbhlUnzA+U3deWjurEZmmG0lyCWzIqv2I43tQPmkaai6xJKMVt9FnXGq
         pvbma3dlvKw26nOvGe653rP4fsnzz6ZjDQ/p0bHcXN+COKZ1j4wH0Olvm9TZ7Z3LMwZN
         R64RnaEeIE3fY2sFddt2nsgrbcEQmdzkQ4RYO3WwAJbW85W/rCrmop9hrgrClLbgUqm5
         Jqtgp3r5XMxO4/KfCaXQy++yc8lhntsb96dTJy+CV5HvQqu6Lf2Fgyo4l8GQCFdpjTD0
         2IlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mNPuVOLfAv83qJ58LyUwgbNxGqHRWthH+tV7Ychlzyk=;
        b=q/bdqVoLK07poLLnmPCH1JVacFlt+uFCoM47dZs8QhFJkY3cJIjuU0EbIgbkbzVkak
         DAVb0HfZ/X3GogGQZ7KzPd/Q3hNeA0jLS5if/c58k33ii0Aq3lP95VCZkZzMsujkPcNd
         p6WDq8LUkh3524p+oFZAWXcoFsQp0LK2ffOcFUf8XKj1gzLAjdpK12PkXU4OOblhGIfa
         vB2EG00nWqrDOKETOP8aMSBw6RqW4dyBBGGItWC2Vro7unr61w0etAt8N7BEkzyKRXvU
         f9/uPg6ZgyUS+Jg15DXT41AWIY421n00SpS676wXlAMwZGAPO5KXX0CxHJCeXqmtd/+B
         btVA==
X-Gm-Message-State: AOUpUlHz3MH2STXDOlMycy9msrIrh0Rf9a7VIsadYeRDE0BDqvNIeowg
        oiBsmmm0RlscabXVOXQxY8vx5Wzk
X-Google-Smtp-Source: AA+uWPx4ZBwVnAzYOvxP2UIJD+hVoZH0syOLhljEPB0b4SREB/6pFPUt0ducciOAHN10+PSPJniRFg==
X-Received: by 2002:a63:cf10:: with SMTP id j16-v6mr16695967pgg.238.1534160005279;
        Mon, 13 Aug 2018 04:33:25 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id j22-v6sm20377069pfh.45.2018.08.13.04.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:24 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:24 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:51 GMT
Message-Id: <c56c51c8bb470ec9a498e984854f5154acf86ef2.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 16/21] range-diff --dual-color: skip white-space warnings
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

When displaying a diff of diffs, it is possible that there is an outer
`+` before a context line. That happens when the context changed between
old and new commit. When that context line starts with a tab (after the
space that marks it as context line), our diff machinery spits out a
white-space error (space before tab), but in this case, that is
incorrect.

Rather than adding a specific whitespace flag that specifically ignores
the first space in the output (and might miss other problems with the
white-space warnings), let's just skip handling white-space errors in
dual color mode to begin with.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/diff.c b/diff.c
index e6c857abf..ea8ecae04 100644
--- a/diff.c
+++ b/diff.c
@@ -1299,6 +1299,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_FRAGINFO);
 			else if (c != '+')
 				set = diff_get_color_opt(o, DIFF_CONTEXT);
+			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
 		}
 		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
-- 
gitgitgadget


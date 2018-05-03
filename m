Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5271F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932111AbeGCL0g (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:36 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45585 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753203AbeGCL0d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:33 -0400
Received: by mail-pf0-f194.google.com with SMTP id y24-v6so869678pfe.12
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=GviUoXF351zBtenzEI4BQ/OQiJdr8AGNbyxD5OHY4nw=;
        b=inpxyVeQGVh5plX0RKV/qThX2S30Vs1OMAGfbYRyH/WCLc63X4MvY7Od3OZXbCifd9
         7ZQTjkWxMJQ/avsnzCToiCCpQEl0SUlcwI+cvDNIrb1O9BdidjUD4mAXOKhhWOWX6r+Q
         mQUfmiLMngVBpBIA8Pn9x+rqU6hnDanvz69NKYwdtJJgye4mALKIhCv120lClsyNr8tG
         7YfGntNvEU7xxVog1pg4z8mvz2jRLbqXGJTkPAJYeVogFqAK3R4aN51H0mhgprFaWfDM
         eJsSvkqaYKJu0TfvBlSyuOam/kOZ6xb6+wb+Elk/B10YFH1vAmSVEgzYngMbI7F+PAub
         G5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=GviUoXF351zBtenzEI4BQ/OQiJdr8AGNbyxD5OHY4nw=;
        b=rILQV3GwxyslUcwAY5yh/3mEWqD6X1eteO7MuM+mZlm7ZhMetciAS05wh36Au3s9As
         S2deZ+XHFvnzEx+Br74KRHXSWnjfl66EZeiZ259QJlVwQmxUaZXC0gm2wLcgXUsWI9yW
         NzMwI9/7i3ghNqEhTqMygBabNDVl3B4wjpQw/hKgQAhkE1/uvaa5RxpGrsUi1SlIrzdI
         D5C9zeD9u+hyXd3HUXkAj7cH7ZPvj+HEr+4Cr2OnvIXk6tENsGreGaewbtlUCi+HyvSP
         OnXRjE5rkKc0f/enKHXwAY6YSpM4IebpxIlQvestOYhL8DAJLgfOdAkTyHdBk+BXrotW
         w4og==
X-Gm-Message-State: APt69E1p+VWGUq03I6h+Y2LLQJlaxz9te3OlgjZZueDNm9yOpfcNAyWR
        Kq4j3oyKFOXba3msjypITR4iBA==
X-Google-Smtp-Source: ADUXVKL1sJaviXXMtoLoHcD6tydsc/fXJcIp3cqYFEDzuluwVoLlkMShNIQacUkrb/oyWCgOd1e+AQ==
X-Received: by 2002:a63:6ecb:: with SMTP id j194-v6mr25465461pgc.158.1530617192453;
        Tue, 03 Jul 2018 04:26:32 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id c1-v6sm2021333pgf.21.2018.07.03.04.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:31 -0700 (PDT)
Message-Id: <dfa7b1e71f7a39dfa608e1e205579d3b95d8a34f.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 3 May 2018 03:11:58 +0200
Subject: [PATCH v3 16/20] range-diff --dual-color: work around bogus
 white-space warning
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

When displaying a diff of diffs, it is possible that there is an outer
`+` before a context line. That happens when the context changed between
old and new commit. When that context line starts with a tab (after the
space that marks it as context line), our diff machinery spits out a
white-space error (space before tab), but in this case, that is
incorrect.

Work around this by detecting that situation and simply *not* printing
the space in that case.

This is slightly improper a fix because it is conceivable that an
output_prefix might be configured with *just* the right length to let
that tab jump to a different tab stop depending whether we emit that
space or not.

However, the proper fix would be relatively ugly and intrusive because
it would have to *weaken* the WS_SPACE_BEFORE_TAB option in ws.c.
Besides, we do not expose the --dual-color option in cases other than
the `git range-diff` command, which only uses a hard-coded
output_prefix of four spaces (which misses the problem by one
column... ;-)).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/diff.c b/diff.c
index 26445ffa1..325007167 100644
--- a/diff.c
+++ b/diff.c
@@ -1093,6 +1093,12 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				set = diff_get_color_opt(o, DIFF_FRAGINFO);
 			else if (c != '+')
 				set = diff_get_color_opt(o, DIFF_CONTEXT);
+			/* Avoid space-before-tab warning */
+			if (c == ' ' && (len < 2 || line[1] == '\t' ||
+					 line[1] == '\r' || line[1] == '\n')) {
+				line++;
+				len--;
+			}
 		}
 		emit_line_ws_markup(o, set, reset, line, len, set_sign, '+',
 				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
-- 
gitgitgadget


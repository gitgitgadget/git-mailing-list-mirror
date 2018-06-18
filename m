Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A975F1F403
	for <e@80x24.org>; Mon, 18 Jun 2018 23:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935341AbeFRXRG (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 19:17:06 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:39860 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934807AbeFRXRF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 19:17:05 -0400
Received: by mail-yb0-f169.google.com with SMTP id i2-v6so191545ybg.6
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 16:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oREpYy6u/US0RV2UZtHM2OyCN67SNucwIENlcXarSpc=;
        b=Xdm8TmCOaLxFjhA2CMWmIJyRX4dCBr46TNwsQLW5JYV500Dq/R46ZJbkzrIZO1M10C
         6TNZ1ODra1RJWESooS2H8kKSmEWTINqANls7iol8JJUvkfTyhoiNL7At9DyYSRDqCKi3
         ncC+R4uywXEJ/s7rsH77Pam6k2wZgOcZg6DdjpoCmXNZ+oA6NFet68eoqlT4IdwixqM9
         cij4wwKEbuMRCG6buP9ohG80kWYbKER4RDphnJ5QTVO9GsXQOS/CwAPw1ZdpM/m3dRn2
         Hy+duB0396q4Ot/VHKzAmSi4sD+moPXccpOBZGhY/MIs4Jo+ZphnFg60d+EmCCUwD0Xg
         7Vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oREpYy6u/US0RV2UZtHM2OyCN67SNucwIENlcXarSpc=;
        b=am6kBKUueCSzH1ea2KDE1mymHQIdGZmLqgCJk1gdMpvGdrzWr5ncFPWewa8AYyfFx0
         Ce95dXr5seaduup/mY/fnA9/RcwsF8lUjUj18IrS4mIRxMZl0wEGZ8i89/zRZplaRcZM
         8zFyaaPH/IrQz5niOcUFEbtnVmnHpupCfKO9GGIQ1TlNB9MnmnRo84yD4ewPmrS9kAL7
         ZLxLDyvlK13wAYH2ohwgVC8XnSDkwr1Oy2UZNNQzgMA03rvBzD7ttFlyBl/OOA0oqv+P
         Nb6n8zQujQaBtt35PsUh5ShmdP0HrNJYFHsw7IdUPRmtXuiLcS6qJAm7ysgBdyLRyEqQ
         cbkw==
X-Gm-Message-State: APt69E3qoSQoLHWKVaTaTSx3skOM6DDPyec0BWOf1XQO+YVqrE0ZLJsA
        eZO1gPPzOUO9z9af37jLM45Vz8ZNIeRxzL3tTHwitQ==
X-Google-Smtp-Source: ADUXVKKwhQldhFsApD7wJN5MECKQkPn2nGer0Oiq2yYjP4khrFGdp3qDTkmUCSFAQxNGCSi9TpW8kRP+n93rNV9x6mg=
X-Received: by 2002:a25:dcc4:: with SMTP id y187-v6mr4629231ybe.515.1529363824231;
 Mon, 18 Jun 2018 16:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqsh5jwzp3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsh5jwzp3.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Jun 2018 16:16:52 -0700
Message-ID: <CAGZ79kYjHUGfgSx+Whih1sWF5U8NLUzXUzimLQfFzqFoc20eUA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2018, #05; Mon, 18)
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob,

> * sb/diff-color-move-more (2018-05-21) 8 commits
>   (merged to 'next' on 2018-05-24 at 45f3fb7975)
>  + diff: color-moved white space handling options imply color-moved
>  + diff.c: add --color-moved-ignore-space-delta option
>  + diff.c: decouple white space treatment from move detection algorithm
>  + diff.c: add a blocks mode for moved code detection
>  + diff.c: adjust hash function signature to match hashmap expectation
>  + diff.c: do not pass diff options as keydata to hashmap
>  + xdiff/xdiffi.c: remove unneeded function declarations
>  + xdiff/xdiff.h: remove unused flags
>
>  "git diff --color-moved" feature has further been tweaked.
>
>  Will kick back to 'pu'.
>  cf. <CAGZ79kag9m02xtJKg05aPE4Grq2wBWSmUr3JdwfyHsMawR7m5Q@mail.gmail.com>

FYI: I have this series still cooking internally, but it is not ready again
for prime time, as I still need to debug a corner case.

The code found at [1] is improved over this series here
as the options for detecting moved code and its coloring
are decoupled; having more tests.

I just had not enough time to resend this one.

[1] https://github.com/stefanbeller/git/tree/color-moved-only

Thanks,
Stefan

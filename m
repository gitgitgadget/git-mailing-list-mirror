Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 417321F453
	for <e@80x24.org>; Fri, 28 Sep 2018 19:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeI2CMx (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 22:12:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38707 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeI2CMx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 22:12:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id x17-v6so4989264pfh.5
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 12:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JfLGdliVPJyA+gHHdIgD6IQfRVlB4gex8y6JzToMeQw=;
        b=nr95KQzBjzGNPs9tHKLVYyAjog78wj6aycMiiVLmdg/EyXo75/PU4OEyaFVPFUDvSO
         bumjgdYJDk/cey+KkLYqPeLse9e8ai2KOGjXyBPtAgTafJFjLCgQn1oT7bMsS/sK6tsY
         /JQcHI66wSM7WUhqTPiaiVjPbB1LaFKHuX16ydZ60ZFpcwjEmaAbZucNe3X5gy18L8va
         yoq+h8Ke6S6n38anZxTR+c9rcPolas2/Mua6Z+7qLsOOxHlvfjEzE6Nnw4CPyxbcGNf+
         YEDxuc4Nzf6lY8IZ5dHxTtjtjySPYwjqYwSOB7wmVQj8X3FkT0wONvHvWOsPxCaNNIx8
         HLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JfLGdliVPJyA+gHHdIgD6IQfRVlB4gex8y6JzToMeQw=;
        b=KUqDRgEEEKjg68imawKEYXdUzXdSdGbG2UBQPu/vtOAe3zpe4PEUWlN4/gYPITsk6S
         F27D0VwSOgA/7ZwGnTD1EpbyYS7Uw9d78iBNGZUsK5Gfkv+7hw3/zKpV3+/3azttFdbL
         kVNFTUan1ZjirfyXruc8fYzgzwIbYGnWhVwSc4LnXNXuXhQIQb6iBdNAfUVcXc576Mmd
         3fb2BHFY5A+vISaaJUhoL2eLe2KQ1ktjd5m0YvD9UXcXqAZ4yNIHDDQK3XacLJ7PZdPK
         aYXG0RuE9Calakvkji0/GygvvDirt3/YUWenk5SZCiqDujNwlMMO6wSpakvLK28+cF88
         xZEg==
X-Gm-Message-State: ABuFfohCzCRkF/JIkn2BEskZQBJY+VxZ61/Pu7LWLld97LvPQ4B0nrmb
        PvFk3P0botVZ8b12KhnCGggLOPj4HK6b6nSyk+AD1w==
X-Google-Smtp-Source: ACcGV60GtdwmlX9+ATZzXCkmJ9qkq4mAmZ76GApoQY38H0hP28xc9WVGiW93lnu2skQewV/5uY2KPcJytfasxKrKnm0=
X-Received: by 2002:a63:6507:: with SMTP id z7-v6mr122780pgb.200.1538164055359;
 Fri, 28 Sep 2018 12:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwor6hmgk.fsf@gitster-ct.c.googlers.com> <20180927212727.128214-1-sbeller@google.com>
 <20180927232732.GA216193@aiede.svl.corp.google.com> <20180928011129.GD11281@sigill.intra.peff.net>
 <xmqq5zypefcp.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zypefcp.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 28 Sep 2018 21:47:23 +0200
Message-ID: <CAN0heSq4-CXo5dzWdeBiR8nFdRzc-+YXE6h4w7WuB8qEiSBf6g@mail.gmail.com>
Subject: Re: [PATCH] Documentation/CodingGuidelines: How to document new APIs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 28 Sep 2018 at 18:51, Junio C Hamano <gitster@pobox.com> wrote:
> We recommend documenting in the header over documenting near the
> implementation to encourage people to write the docs that are
> readable without peeking at the implemention.

s/implemention/implementation/

> - - When you come up with an API, document it.
> + - When you come up with an API, document it the functions and the

s/it the/the/

> +   structures in the header file that exposes the API to its callers.
> +   Use what is in "strbuf.h" as a model to decide the appropriate tone
> +   in which the description is given, and the level of details to put
> +   in the description.

Martin

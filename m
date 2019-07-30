Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16C071F462
	for <e@80x24.org>; Tue, 30 Jul 2019 09:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbfG3JaL (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 05:30:11 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41955 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfG3JaK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 05:30:10 -0400
Received: by mail-io1-f67.google.com with SMTP id j5so122413188ioj.8
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 02:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KBgmc1nXosexGoxpjLTUVSyVj7PQAVIWPRIEJtNVWtg=;
        b=eI29mzyoBHorjYZriw36yR1jAQBlEqHHBBsyI31/KdcfhS4yiZTkfTjQ0i0zxWSOa2
         wqmtt+AmIvcFFB+ZORD7FC9NgMSEDdYuIqblQVewWImg6yEKulzoGlAcY7ZvRjVmKrWz
         MhPtuxwKHtUYfEg03nZrJShLU7BzDkVuY1cIneAWZRR5ECMSLpJdJWdJD6nYsmAY44s7
         QAwUL4dbKFgAOj8LaPRzuSKjR2+bJtp8tgG/OESwnpITaAcAumvV8xUHx0FfhmYO2d0m
         9YFhsUpB16cXrRqX2iDLDoWcAknZA9ocD+JuceZaBkJ0OKjGQq7/5EmtdJd1YYvuaCfT
         mxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBgmc1nXosexGoxpjLTUVSyVj7PQAVIWPRIEJtNVWtg=;
        b=Fbsei5DeDdwQnAzKGzFzBewcr4DONZrtXiiBYVXWjrmT5ZtTr00TwoFdQ9+v58X6Qi
         OsZiHwNJHgPjw3f9Zb5ZAfmLzOeAYi3jrbDGZfHByz2PNE4+bFka083zex1RXWX+AJoQ
         jiMWyV+UN8yc8d1rRFG+ibOUme8DCxl5TP8lua5Ecf8Mf9perFkLPUg7UeRCV89Fc/KR
         6EB1YnM47ylfpflvwrWcbkRAbl57WmIX4e93NQWOB1w+etf1iAC16WIPCj8gsCTtyoPR
         MpnYvbrxs9oTZOfwUVhdhvp6o1YiypPs+sQFXZKUCt/99FR8TbqtD7HD2sDGxksIq8zz
         YbSA==
X-Gm-Message-State: APjAAAVGhmKp82Ljb68kscSHOhl3tfQc4l3+q7KJKfRxIb6V184q6LVc
        ErTYIJs2+BnNlDSZQA4d29HdVUcXR5wiz5V1Oto=
X-Google-Smtp-Source: APXvYqzqRtwKVYxI9hMCrweKheNgaoR06xp3d0Jmgbc0D1j89WYvMyYuv43LSYa8EgjrKgFTBkYRB7PMTCNaF6GQ6gU=
X-Received: by 2002:a6b:f80b:: with SMTP id o11mr97209669ioh.40.1564479009887;
 Tue, 30 Jul 2019 02:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqo91ctst6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo91ctst6.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 30 Jul 2019 16:29:43 +0700
Message-ID: <CACsJy8A8fJZq6k2i_e0EpkxN8SZ4+8h1FA0eV6e9xFLaMDcsPg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #07; Mon, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 4:49 AM Junio C Hamano <gitster@pobox.com> wrote:
> * nd/index-dump-in-json (2019-06-26) 11 commits
>  - SQUASH???
>  - t3008: use the new SINGLE_CPU prereq
>  - read-cache.c: dump "IEOT" extension as json
>  - read-cache.c: dump "EOIE" extension as json
>  - resolve-undo.c: dump "REUC" extension as json
>  - fsmonitor.c: dump "FSMN" extension as json
>  - split-index.c: dump "link" extension as json
>  - dir.c: dump "UNTR" extension as json
>  - cache-tree.c: dump "TREE" extension as json
>  - read-cache.c: dump common extension info in json
>  - ls-files: add --json to dump the index
>
>  "ls-files" learned "--debug-json" option to dump the contents and
>  the extensions of the index file.
>
>  At least the fixup at the tip needs to be squashed into the right
>  commit.  Also the new test seems flaky.

I'm pretty busy with other stuff (and considering stopping doing git)
so it's probably safest to just drop this one.
-- 
Duy

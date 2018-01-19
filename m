Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E031F424
	for <e@80x24.org>; Fri, 19 Jan 2018 18:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756037AbeASS7a (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 13:59:30 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42514 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755899AbeASS72 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 13:59:28 -0500
Received: by mail-wm0-f66.google.com with SMTP id b141so5347371wme.1
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 10:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9Jm2sIh4LZ7p9w/e014aSLmXmfQlbnU0eMJZpLhJl9A=;
        b=mByRYdD0eL+05ICqHXL6Viq/TnP+YWylk/O8Ts6KSroQpzEJ5pjg+Kr7JdOSAR4VX8
         tlygvaReejC2sFl8BPRJjwXCHono77Lp0BnyW1bdF6FuuL4YQ5slbz5DwrDSdfCWNbvM
         rhePDH3Jut0RIRQVzzD+lOORCJ74/+YB0v1h+JtMLTVrTNy4GpIpaX3KF6JRBNNgqmHR
         pTifao8RFike0hS5elwRCBw8/PKF/A+GvgH7ZLfmAY2md7t6fHxb5nCKGRLtAp8O7TEY
         VNmqAg9KcRdNtn83hgUn2RHyt+mRnDsihIw/l4OZgsrMRZ3ZAoeNbIxY35/lCuIZDmoh
         1Zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9Jm2sIh4LZ7p9w/e014aSLmXmfQlbnU0eMJZpLhJl9A=;
        b=iWlquX75p6XKFmhctoagyoC7DqggYGet6X/xqv4UOS20geGzwHR+nF7k5yMwh5OW3p
         GRDM4FTeUsOT+mKOMJpGvVaa7llJBrYHyx9cRiITZMqcM4cNqTEyjNuZ5thgR3xQI8Hu
         oHLA/W6u5nEOUr7gmsgkquti42/SoJXqoih7qHJb/mK6/uC1PthMCGNsvJLiKEwGnWcp
         Cqs+RcmoWf5uwUKVGIN5oWsPNuA36zR06dYWbTOUsqbUEHJyes+IvYh5gv5ANrdFM7XK
         hpIeb5PQ9CtePDeDiMYE8wciErFOWwm8K2AaJIME1+DV7cxQftyuWELpggCE3fJtF3et
         KwiA==
X-Gm-Message-State: AKwxytdnb5gPfLdcrfEtOyv7Uvc5TxPcdmY7H/f5nFgaw23+plvPk5VG
        RptCR6mL7+OsTPNzEJ5qTg4beUOa/bFb5YtDGHnDhg==
X-Google-Smtp-Source: ACJfBotREjMeooaciBJlSHaw/znsZy4zr+DOAFirRxqzeLcecle5CVV/RjAhZwSQ/m5kQHp10h0XwolAAhjaYlwYqug=
X-Received: by 10.80.165.21 with SMTP id y21mr14834845edb.148.1516388367548;
 Fri, 19 Jan 2018 10:59:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.177.180 with HTTP; Fri, 19 Jan 2018 10:59:07 -0800 (PST)
In-Reply-To: <229b332d-56b8-0183-f57b-b0db0c62f781@talktalk.net>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de>
 <d069a3c7-198e-81d2-0f35-f934e110c991@philandanna.no-ip.org> <229b332d-56b8-0183-f57b-b0db0c62f781@talktalk.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 19 Jan 2018 10:59:07 -0800
Message-ID: <CA+P7+xpj503VKEf4jzYdbk33aAvaMQ8+T1bQ3EB0T+AWEU3pKA@mail.gmail.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to resettherevision
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 10:55 AM, Phillip Wood
<phillip.wood@talktalk.net> wrote:
> On 19/01/18 12:24, Phillip Wood wrote:
>>
>> On 18/01/18 15:35, Johannes Schindelin wrote:
>>>
>>> Internally, the `label <name>` command creates the ref
>>> `refs/rewritten/<name>`. This makes it possible to work with the labeled
>>> revisions interactively, or in a scripted fashion (e.g. via the todo
>>> list command `exec`).
>>
>> If a user has two work trees and runs a rebase in each with the same
>> label name, they'll clobber each other. I'd suggest storing them under
>> refs/rewritten/<branch-name or detached HEAD SHA> instead. If the user
>> tries to rebase a second worktree with the same detached HEAD as an
>> existing rebase then refuse to start.
>>
>
> Ah this isn't a concern after all as patch 5 makes refs/rewritten local
> to the worktree. Perhaps you could move that part of patch 5 here or add
> a note to the commit message that it will become worktree local later in
> the series
>
> Best Wishes
>
> Phillip

I'd rather it be included here as well.

Thanks,
Jake

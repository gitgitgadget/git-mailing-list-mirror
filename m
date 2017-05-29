Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E939420D0A
	for <e@80x24.org>; Mon, 29 May 2017 18:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbdE2S0n (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 14:26:43 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:32776 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbdE2S0m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 14:26:42 -0400
Received: by mail-io0-f180.google.com with SMTP id p24so44973501ioi.0
        for <git@vger.kernel.org>; Mon, 29 May 2017 11:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a4m0tY8nAA9oppGEHEUWmlI1KNje5RfWTfwN4QaaLMk=;
        b=IKVW9IbdNzBL/BwVa7n5n2CE9qsdGdJhPHjqxZ8Hlc3foX4OkukBRrQVUrc9h1UjtO
         x2irygATloQ7NPnpYfg3FaqlErEx14fRgaVYO3Iske7b0IRjH9tgDIzfTm8aedNjqe8c
         NcuhEwhFycEz5F0npKcEy+sSOPloeqPTt6q5WqVjKCQEBAtxn7CTElLZ02S7uyYgc963
         5CM1VCUKzobhN1qQ2z67EoO3y1vz9rn1P/CP3zOxPA733poyZe3YDX7a2lnljUeqMS7C
         wATb1vfmywW1Hx6INUS+RzeR/AiNYjH5hrw0iXMFmW0bZj0YGrv35zhedVeIvu9WR0WY
         Zz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a4m0tY8nAA9oppGEHEUWmlI1KNje5RfWTfwN4QaaLMk=;
        b=keqmpMMbi61aoRZ6TF0RkQ3ripbS1kn4Is0lN5SZz/u58Ox+fG37baguLRFKcTPHU2
         xf5woBjc8lHGMGDEwZJQZVlRcJZPk3JwAjQtLKgmtjsOWviu+X07ZJH2jItCxkFwze/y
         PRxDUvKEifrzpG+4ekN6PvXURZ0zg2fxQE72LEshLHyumT46pwtMCiLkmkiNSEEDZAdC
         CtiFLc77k8ELMcW+rg8wy3e04r0dasErt3tPutdGlVRMnUbryrwAU/RTnVWNEv8WR6XV
         dn75oJLiupzsYnN1wqs89HCqr+ecIR9F9htq1c0lmwHYdZKq4O3XSyQW2TIIebNEmzHL
         ECCw==
X-Gm-Message-State: AODbwcCYA01zZI575BI43UuMUlO5xJ7cQbjG1KtDb4zpdTIXOVaKniAQ
        QSiFt6sRhxT0EwzZOjFFIqYc+YSNDA==
X-Received: by 10.107.138.21 with SMTP id m21mr14064548iod.80.1496082401767;
 Mon, 29 May 2017 11:26:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 29 May 2017 11:26:20 -0700 (PDT)
In-Reply-To: <CA+CzEk8NoGhDB6nX6RRL7J-KenoJBE7rVfskJfCQn_iCSnA4nA@mail.gmail.com>
References: <20170528165642.14699-1-joel@teichroeb.net> <20170528165642.14699-5-joel@teichroeb.net>
 <CACBZZX6uXnE+BTfsiLNF2OT3Dsr-J99uUFEwcu-qK45OrU+1hQ@mail.gmail.com>
 <20170528192149.dgzibu334n5ja57e@sigill.intra.peff.net> <CA+CzEk8NoGhDB6nX6RRL7J-KenoJBE7rVfskJfCQn_iCSnA4nA@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 29 May 2017 20:26:20 +0200
Message-ID: <CACBZZX4VP2GZSxw5MqBY=w1EhN64=75MFnjd0CYvPTvoVdFWQw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] stash: implement builtin stash
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 29, 2017 at 8:18 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> Once I have all those leaks fixed, is there a way to make sure I'm not
> missing any? I tried using valgrind with leak-check enabled, but there
> are too many leaks from other git commands.

I just used:

    valgrind --leak-check=full ./git-stash list

And then skimmed things that mentioned stash.c in the pager. There
might be some better way to do this (e.g. instrument the test suite to
run valgrind for all commands and summarize that somehow), but I don't
know how to do that offhand...

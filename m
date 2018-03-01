Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825041F404
	for <e@80x24.org>; Thu,  1 Mar 2018 15:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032430AbeCAP64 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 10:58:56 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36216 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032488AbeCAP6y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 10:58:54 -0500
Received: by mail-wr0-f194.google.com with SMTP id v111so7082755wrb.3
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 07:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6FaBh0cpB1tGQnF5L+YwojUdF3qkfDpfJvPTKHtnMJk=;
        b=Cbdplwi8ZTK61bHSYpMtS6y/QCz4eI2PhNc7AKBbj34Ova5Pa3wQXu9JOpgT/iHmRr
         UMqRILhGMdoVpJFn1BJkHb94YsXaiemSIHNo98dJ3PiAA6HA9la1NuTnokbasrToYLuq
         nik7BhnBb6bt3/Zgzw/D/OjG9l1R5LF+bEmBt+1NKdae7BbE5ooAy37XNPLUKVrNCU+7
         KLjf08bNNaPcjZK03bYq/OlKIu7r2UwtrT9kWFKvgVp5+kYyQ5wQRePsw30NmQ3jKjtR
         29EvmCF0hFIvGE6SIt3yDvZRXq9mZIN0UkktzoFNf3m3NC9qWqp9IpCmv/1agEb1B2Fl
         +O3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6FaBh0cpB1tGQnF5L+YwojUdF3qkfDpfJvPTKHtnMJk=;
        b=WaPZUnW4PGstnHrXr2rM4M1LXhUhI2NG+xkajMQ/dNEn3FF/3ggo5ma8E2Aau6Idaj
         Bd0AHKebFvhV1Ga9iHceThJSkS+PUdC4K1dhfr7hY3ipVW7Jg88N9j9KMDFrYG93TtVO
         /pMRgyk5huYhwoTN3IjGEt4oeHWBVSoU31FrQaYZ3n9Kwb744RMogqur2yXS/QTFrTTL
         VKTQPl+bBRjYiYb1ArNxbrn/nEdFuLds6L2h3qn8sMjJpczzVqXf4AVTusmNA0q7dpUL
         TaR4IpAKwrxk29Ea5SxMCdrZb5I1jYfrOhEMp6Hs9NORnh0Gc5gVS5uT6G2UxCWWvlj1
         2w5A==
X-Gm-Message-State: APf1xPCU+JWewQLJLSY6zddp8WG8IJQ07/VSgLe4KUS+S95+ODhp+erV
        VRm3mzoNGPI1wzXn7yAIWls=
X-Google-Smtp-Source: AG47ELsCMHQHd9lXVQA1Om1aei+i/I3FPfXYup1ORpsF6ymoYGXADazBhEN66RFfz7B4662MzjtAXQ==
X-Received: by 10.223.174.247 with SMTP id y110mr2249122wrc.68.1519919932502;
        Thu, 01 Mar 2018 07:58:52 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u136sm4074662wmf.5.2018.03.01.07.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 07:58:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 2/9] t3701: indent here documents
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180227110404.16816-1-phillip.wood@talktalk.net>
        <20180227110404.16816-3-phillip.wood@talktalk.net>
        <xmqqo9kanjrk.fsf@gitster-ct.c.googlers.com>
        <12a03e03-640e-90c8-0ac8-14807a1834c9@talktalk.net>
        <xmqqsh9lm8fl.fsf@gitster-ct.c.googlers.com>
        <30ff8d98-e86f-2eca-c7fb-25f537f9e3e5@talktalk.net>
Date:   Thu, 01 Mar 2018 07:58:51 -0800
In-Reply-To: <30ff8d98-e86f-2eca-c7fb-25f537f9e3e5@talktalk.net> (Phillip
        Wood's message of "Thu, 1 Mar 2018 10:57:39 +0000")
Message-ID: <xmqqinafiy84.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> Thanks for the tips, tbdiff looks useful (I just need to learn to read
> diffs of diffs!). I also find rebasing them on a common ancestor useful
> but its a bit tedious.

Yes, comparing two versions of a series is somewhat unusual and
needs getting used to before one can do so efficiently.  You do
not have to always rebase (tbdiff is fairly good at what it does
even when two ranges are far apart), but it helps not to begin
developing on a codebase that is newer than needed (e.g. a bugfix
on 'next' is unneeded unless you are fixing a bug introduced by a
topic that is still on 'next'---in which case the best fix is one
that is on that topic, without depending on the rest of 'next').

In any case, thank _you_ for contributing.


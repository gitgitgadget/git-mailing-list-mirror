Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 428AB1F954
	for <e@80x24.org>; Mon, 20 Aug 2018 09:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeHTMZ7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 08:25:59 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:38951 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbeHTMZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 08:25:59 -0400
Received: by mail-it0-f41.google.com with SMTP id g141-v6so19567322ita.4
        for <git@vger.kernel.org>; Mon, 20 Aug 2018 02:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l5x+dqAfvDHhLgBTvMzm4POw6Qx/Y6GIXIM0sXFacjU=;
        b=GKEwA2WNJSiL62fKlpO+6ZzRVmMrmHI5innY9wAK30hLqcfuRAEG3vQbD3F+Uou+wV
         /BVMrBtxei8MAXPfsrAG4/dR6Rron4uV4K/bWNraXqIEg0Fozqz39gei7J5qXXx6JqJ+
         cU45T6MkFs3UKdgL22qN6Esrxb/Ym4zB1EQN3eP7XRn8OtqS42QzRUG8Emu3PlZDirha
         WW9RkfYFpqYgJT4mU2UYr9cE/6DrgFJtNBjTyDKeIEtUC4Dnt9/TdfStSxeGX+LxtT10
         96391xj0PDbruLXa+lp6EjY3qRp7bgB2PaZm/0sbVJZg6Ce2KV+XXWUuywbhVwWXAFjC
         Li8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l5x+dqAfvDHhLgBTvMzm4POw6Qx/Y6GIXIM0sXFacjU=;
        b=Yqf9Yayergilb1XbB7rLfessFxlJwUrONeBFxRvckgYNR7XxuH8XypiL/rsLafrWSI
         RG2GkOMckJLoKjKfpw8+BAe78ZUR/Wmc1oZFMo/MTXqplz5RQ5TLy19DZzetjqVV7Q68
         uOL7KapB97xvbw1YFRIFlM8MXzBmriUQzOID9u3MgmDzEZe5kduzvVqM3CD8eemyY1yf
         ycvF9oMK/YJRFoYUeUTsRc5R4h64nuChbIeL/ohduMcwy3rs2HIHWvkHQxqDX9FTJ/3s
         7fs4rBxTQp5quZ1GKJMsfUDYVXy2Aw5dqWAccVAZbT/2TWeMze+roKx/eNkFQ9ex7Wqa
         qLXg==
X-Gm-Message-State: AOUpUlHlwwOi9aH+9eZiQcjihMLwvtsKgNtLDe3XjP2EulNRrxC0TjBp
        G990ntNYnVG9n4koMnP58YpJXhoOznERx9lF2O8=
X-Google-Smtp-Source: AA+uWPxoFqj8Zc0ZhUUYjufXg+Wg4ZfiMJLjkovEmETj3SAthBRrOQlZ6uU41cQgwUlgunXL4Y+oTK8R9+ZfwuQxkig=
X-Received: by 2002:a24:fac2:: with SMTP id v185-v6mr33757056ith.145.1534756269782;
 Mon, 20 Aug 2018 02:11:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 02:11:09
 -0700 (PDT)
In-Reply-To: <87y3d1pgin.fsf@evledraar.gmail.com>
References: <CAP8UFD2V8NQxGAhWvGK1q7uozcE+dpwHcgRw8SVsT4T=7zJXXA@mail.gmail.com>
 <87y3d1pgin.fsf@evledraar.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 20 Aug 2018 11:11:09 +0200
Message-ID: <CAP8UFD2vMW56Jh3FO+6Pt=idebCRzVZ37bBt8dQxsA2HQRE5hg@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 42
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Pawe=C5=82_Paruzel?= <pawelparuzel95@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Simon Ruderich <simon@ruderich.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 20, 2018 at 10:51 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Mon, Aug 20 2018, Christian Couder wrote:

>> Jakub, Markus, Gabriel and me plan to publish this edition on
>> Wednesday August 22nd.
>
> Let's mention that we've picked SHA-256 as NewHash, as a follow-up to
> last month's edition which covered the discussion around the NewHash
> selection. I've submitted a PR for that here:
> https://github.com/git/git.github.io/pull/307/files

Great, merged! Thanks!

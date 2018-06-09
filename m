Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5639F1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 14:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbeFIOb7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 10:31:59 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:39691 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbeFIOb6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 10:31:58 -0400
Received: by mail-pl0-f65.google.com with SMTP id f1-v6so9856560plt.6
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jUEuLP3KABd0vP41GUMsug7bsxOAJPaHvblSBcCb1/s=;
        b=BLZJiB7JhawlOMGMTs9YpAF8StRue9oQ0lB4NMz9fYoWQhOO0ZLNNaRk58xvm7w6+7
         tJvfdIWtvuJHBU9jiUknnO7KDEepZm9zAeV/efzw5BcbA/GM/NGBw767ADYf/q4MJ3M7
         HC9Ct3+uvxoU9F4wtQANIKK9DhmGE9JN0KYY63LAs5c+ZRnbfcgxTUeA7lkopFPJUaGY
         Gm3S6uMaXGelT7NYCau28xR/1KDa+mwaKjT2VWg79w32nydUqUbZ3VuQyffUQlTeLylL
         W7kgB1nwsUf6cUzGwSBumTHY86K75FRSjr73gf8g0tkonXOtdpK8HYVJCs/0kVgub6Zb
         760w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jUEuLP3KABd0vP41GUMsug7bsxOAJPaHvblSBcCb1/s=;
        b=eCoG78Hq/PcTOPXF0PYmIbDNLZmAJTDJ4OryYXvLPp3gJbPuVKAU5AH//tFAHvdehm
         RJ8TBaZ50BxiH9jTMrjIJouJthEVWlmK0zt1rl/vG4ADsWo9WgBTFKFY4+srUd8ugyjo
         7X9YvtjPg4zGHgOKA3ufwBxHLSf+V93T9LQsaNOspawpCJ9qEi5Djplkw0f5X5ODeCfU
         4FOURjHsxkxF0/k2xngYTUhw3XNTmPnoL/2zdsvOOxYMVR+2RmPCctNuliR5qZeURHm8
         gfj2YRdgji0M3Howk12Vj1djUIaZgZ7MsZEna3ZHn5QuiP9/iEJxbY0Do5BfhR5vIOAC
         MZ/A==
X-Gm-Message-State: APt69E1E2zm1S28u3zjBYHlv2d/l4aPR7EF5eX4gVlzIJOZyFpG7IqeL
        1LsjMKsUZOnLF8bn3xwS+E9UfvwYC/5epSzCbl4=
X-Google-Smtp-Source: ADUXVKJNL3AZ867lcbXtDOym2emr1WT+kR8QXmNQxAUWI+MXH/FjS0HPX5Izx0wHrNIP9iQJYxUS1Kc/muaNf1FF82Q=
X-Received: by 2002:a17:902:543:: with SMTP id 61-v6mr11127101plf.47.1528554718330;
 Sat, 09 Jun 2018 07:31:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:760e:0:0:0:0 with HTTP; Sat, 9 Jun 2018 07:31:57
 -0700 (PDT)
In-Reply-To: <CAN0heSqrgUw1u8Ykk-9eGosWwFS0NFM7sLBe5Loo4cN=tkrXaA@mail.gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com> <20180608224136.20220-18-avarab@gmail.com>
 <CAN0heSqrgUw1u8Ykk-9eGosWwFS0NFM7sLBe5Loo4cN=tkrXaA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 9 Jun 2018 16:31:57 +0200
Message-ID: <CAN0heSpMSmn=34ze4GmuETzR=VZ2TO4ooNC=PS+OM5yAawB3og@mail.gmail.com>
Subject: Re: [PATCH 17/20] abbrev: unify the handling of empty values
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 June 2018 at 16:24, Martin =C3=85gren <martin.agren@gmail.com> wrote:
> On 9 June 2018 at 00:41, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@g=
mail.com> wrote:
>> For no good reason the --abbrev=3D command-line option was less strict
>> than the core.abbrev config option, which came down to the latter
>> using git_config_int() which rejects an empty string, but the rest of
>> the parsing using strtoul() which will convert it to 0.
>
> It will still be less strict in that it accepts trailing garbage, e.g.,
> `--abbrev=3D7a`. Probably ok to leave it at that in this series, but
> possibly useful to mention here that this only makes these options "less
> differently strict".

Hmpf, please ignore. That's what I get for looking at a few patches,
taking a break, picking it up again and completely forgetting what's
going on...

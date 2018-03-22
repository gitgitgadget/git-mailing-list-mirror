Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 262431F42D
	for <e@80x24.org>; Thu, 22 Mar 2018 08:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeCVIY0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 04:24:26 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:39499 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbeCVIYN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 04:24:13 -0400
Received: by mail-oi0-f50.google.com with SMTP id q71-v6so6626372oic.6
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xc4aRjUJgwlMlcvXYVkC11SOb5DeizvL5KSbpjkIcxs=;
        b=VJWeimvA0u6GlB6eEOJ3V7W134v0sL/fe5IbASvalyWnKIvqZSk5NIjEVTobD0tHCT
         I7jHtakUTkSDCbE0DxySa3V67b22tbvNDcFSxfppQRmF7vG+q3rvw74pgFssTXhxu72h
         EZYo3kIJLZXMzVEkx180V8YM305kGN7+gkyTgn0wfiIcp7EDDpLT+8iNzQvxH4eJI7Xy
         RruDibPEQ7tsHNpKu5QZbHFwq+q197gcJek121eHkLSahQGKRZJSUwidOdFN0pTF2N2B
         ewhnzkCIfFvs4noPp0wzYXfd7cMwaMNe1QiS1r36PaF5DLp6ZpvXCpC7rCIvsB3NoiBv
         CmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xc4aRjUJgwlMlcvXYVkC11SOb5DeizvL5KSbpjkIcxs=;
        b=ZF+2JAhz9nTh6GiDCm8j5hJrpjXxND+6rOb+I17GXCMwLNJ7cWjviL5pkC4ZMSnipW
         gWZfoO52Z5Zwj6zmEOuESWLVTIu4kKekzwesnwDFjytAAJNLfEuJ2SC4F4nk3B2HHMNv
         NK+N6dB5OY0E4wmq86bYp48RefsvB6WXZouXj2dbwulcpwCG24g0+eOW03+WhbVikI5/
         h+o7+9xLSQHgzMHE8kv+tCNIqJwKsC1rYVqL4ChSKhIwt3Fmy1rS6YvgACuf+BRwsN0+
         NpzULK4D8ARGr/uzg+N8WCwavUEL5iWH5X0UHHZKDJRLpBbgcbSSJK1yXAk3YjTj7Vck
         ratA==
X-Gm-Message-State: AElRT7Fq4gtd1skaBg8G6WCLkk35YN2g15vz4ALZh57OR1OpvySMCNsX
        ke0qznztSutL5U8DjmFK+wUCxfrrVdBiaKG2h5E=
X-Google-Smtp-Source: AG47ELtDT4A3ADRRxT4gxN7isuf0qf3Cic/E/jLVZdcvFvoSjO5ux+KLfZB5Aj2gw1RdSkZkpSu8RcHMNGTFQduLBvo=
X-Received: by 10.202.81.200 with SMTP id f191mr13745192oib.32.1521707053134;
 Thu, 22 Mar 2018 01:24:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Thu, 22 Mar 2018 01:23:42 -0700 (PDT)
In-Reply-To: <20180322080740.GA28907@sigill.intra.peff.net>
References: <20180317141033.21545-1-pclouds@gmail.com> <20180318142526.9378-1-pclouds@gmail.com>
 <20180321082441.GB25537@sigill.intra.peff.net> <87tvt9xuel.fsf@evledraar.gmail.com>
 <20180322080740.GA28907@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 22 Mar 2018 09:23:42 +0100
Message-ID: <CACsJy8AF0FYysw48Y1CKdAHs_zWN8raYaGXrKQ9OmeKS-XujLQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 22, 2018 at 9:07 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 21, 2018 at 05:31:14PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> > [...]Yes, having that many packs is insane, but that's going to be
>> > small consolation to somebody whose automated maintenance program now
>> > craps out at 16k packs, when it previously would have just worked to
>> > fix the situation[...]
>>
>> That's going to be super rare (and probably nonexisting) edge case, but
>> (untested) I wonder if something like this on top would alleviate your
>> concerns, i.e. instead of dying we just take the first N packs up to our
>> limit:
>
> I wish you were right about the rarity, but it's unfortunately something
> I have seen multiple times in the wild (and why I spent time optimizing
> the many-packs case for pack-objects). Unfortunately I don't know how
> often it actually comes up, because in theory running "git repack"
> cleans it up without further ado. But after these patches, not so much.

It's good to know this case is real and I can start to fix it
(assuming that the other concern about readability will not stop this
series).

I think I'll try to fix this without involving repack. pack-objects
can produce multiple packs, so if we have more than 16k pack files, we
produce  one new pack per 16k old ones.
--=20
Duy

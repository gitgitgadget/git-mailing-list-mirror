Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E44E1FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 10:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754583AbdDKKxB (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 06:53:01 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:33324 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752712AbdDKKva (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 06:51:30 -0400
Received: by mail-io0-f175.google.com with SMTP id t68so98864424iof.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 03:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/dB+oYlmejha0TrshNTgwohGIb4bOPZd38QXN4K+n8I=;
        b=H5IjM8p0x6VdXyjEafqZcEmiFdn8bPXu/hQPv0Wd5fKVcFxW+nFK9swi0+XFWEJ7+U
         A61VGrSAZzqm8fkpnO2tlRqvfbhU9vTJa6m1CSrrJ+vIYQKMEAcqFzau8Xx815/kr94A
         SCCQnlxmBhS+ADdnS38WG5Mmizh/T0Zoetprqm/YZ6WwutPn3t8RsurqOBO+TyR8Uma7
         uqY/uOgo3M41RM7Yc+TatIHCS2AnwOx63zYH67enKAQ9Oa2rbEmVmxxFl/hUzMIVBeGX
         7uSg2u+WC2H8jHrPTAS8NGzqerN7c1w1aLfmsp/ENs6ydr7OIem5+P1yOdXt7RNpVOBo
         hRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/dB+oYlmejha0TrshNTgwohGIb4bOPZd38QXN4K+n8I=;
        b=kn6FzEdxTKx9guKx/o4sQuKiAPwAx5FWuLTTZ7MN5Qq0OxPRQ8xWQQl8eJuTkSGZzE
         9hjcjz3XlSwyZc5+ELvSDC9z0aGJ3Mb12ECjIhKqEGTsCjmJdp1wjnJ3dY+VHlYrQR4c
         ASzgRVXkZc8ZM0KlZGVa29IzWlt+tY1sfP/XQ9VqKWViHjptpxJoPNjoUh2jid+85AbS
         FOki+87RG9JIc76sShBRNVQdHY5NteMv1Ri75m7TUHPagUoBVyPy2T5BuHOBRLg4LIUj
         NrK3XzLLSyypH1/HYehV02DxTudyx/kCG+ZaQQEuz92RhkAIjWNCqr5+tcwNBb+6IJgl
         sBIQ==
X-Gm-Message-State: AN3rC/7VEwcAVUpEmYq0FVc0UxoarnuVuOppbRa6tGEB3pL0HX3bD4n77O5MSgXWBY2t4XZOVBWXmMoU2RyIlA==
X-Received: by 10.36.43.77 with SMTP id h74mr16488846ita.60.1491907889899;
 Tue, 11 Apr 2017 03:51:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 11 Apr 2017 03:51:09 -0700 (PDT)
In-Reply-To: <20170411103523.tlub4v65er32ikix@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com> <20170408132506.5415-11-avarab@gmail.com>
 <20170411103523.tlub4v65er32ikix@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Apr 2017 12:51:09 +0200
Message-ID: <CACBZZX7gmmTm6qU-6sviRQ3znwkOXG6999C6SDD_oJe6pqdTWw@mail.gmail.com>
Subject: Re: [PATCH 10/12] grep: change the internal PCRE macro names to be PCRE1
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 12:35 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Apr 08, 2017 at 01:25:04PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Change the internal USE_LIBPCRE define, & build options flag to use a
>> naming convention ending in PCRE1, without changing the long-standing
>> USE_LIBPCRE Makefile flag which enables this code.
>>
>> This is for preparation for libpcre2 support where having things like
>> USE_LIBPCRE and USE_LIBPCRE2 in any more places than we absolutely
>> need to for backwards compatibility with old Makefile arguments would
>> be confusing.
>>
>> In some ways it would be better to change everything that now uses
>> USE_LIBPCRE to use USE_LIBPCRE1, and to make specifying
>> USE_LIBPCRE (or --with-pcre) an error. This would impose a one-time
>> burden on packagers of git to s/USE_LIBPCRE/USE_LIBPCRE1/ in their
>> build scripts.
>>
>> However I'd like to leave the door open to making
>> USE_LIBPCRE=3DYesPlease eventually mean USE_LIBPCRE2=3DYesPlease,
>> i.e. once PCRE v2 is ubiquitous enough that it makes sense to make it
>> the default.
>
> Yeah, I think it's nice to keep the build-time knobs compatible. In the
> long run I assume we'll want to add a USE_LIBPCRE1 flag and USE_LIBPCRE
> just becomes a synonym for it (in fact, we could do that in this
> commit).

I could just add that. Hints for how to do that without entirely
copy/pasting the "ifdef USE_LIBPCRE" in the Makefile welcome. The
Makefile syntax doesn't support some form of "ifdef X || ifdef Y"
AFAICT, so it looks like I'll need to copy those lines...

> I suspect we won't ever want to make it a synonym for USE_LIBPCRE2.
> Unlike the run-time synonyms, where the expressions themselves are
> backwards compatible, builders need to care which one they're using.

Maybe, that's a problem for another day,  at some point we might want
to turn PCRE on by default, and then maybe v2 will be prolific enough
to make that the default...

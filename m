Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3F01F424
	for <e@80x24.org>; Wed,  9 May 2018 17:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935293AbeEIR1B (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 13:27:01 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37127 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935202AbeEIR06 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 13:26:58 -0400
Received: by mail-pl0-f68.google.com with SMTP id f7-v6so4702763plr.4
        for <git@vger.kernel.org>; Wed, 09 May 2018 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yXMme4LNYuPtEdz4KIeBRmEcNcUqj4KceM4d9VUh4c0=;
        b=k7YbrdtUAj6O9PyRsxH+OVBOuia70GyiGsslRUMF5nf0wM/i3HBA7hkFUnDz+zYic6
         Om3ZrhSJCA8SrZAHHZErOJ7uF/E71yx0i3k06sI9dP63g66AEuR15JZbp2C9QgdYc9+Z
         /RN90FK5UGKuqKp0TB8rMZGQgkSSg+mwoywDSEuvvsnfyp4N9Iv+Ybxu2hHEqLrlMMmS
         3WD/3dkclQbvIQpZZG0h6PFoguc+5MybB/KqY5uhuvalbntic5vWCvgugdmceeJ6sh4D
         u6Y00xgUg9+K4UWp5pCl6wBQ+8pg3ePn6eTWXnMbSY+lNXVcZdPb4HnfnSWgbFLX9Pnr
         QY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yXMme4LNYuPtEdz4KIeBRmEcNcUqj4KceM4d9VUh4c0=;
        b=KfqFODuTa4dNix2IS+kCHiJgevQWlWKgEdEVGqgq/XMuQDzjz32HfSL3w2uJNVIDpB
         R8QW1ij/7HwHNdtSaaaV1MTsdC6oCJhxHhrOabzY4TOdc0B4wDrt/Zyj+JTqwfbLJ++j
         1sE17mczSBVrXXXhOiIJiiDHnes4/XP2WZhoYjOeGz5r4Va80xa77oTJNQVXUCRf2At9
         DHVwdB93UuNtXbPeclSA05jnMV/2M3+OuDb8Out7jXYqLS78wD1FL/6Du2ynJ17/oCX2
         12uuoD73ApG2DWm6dO6nZOn23w6JpuBFsLhRxr/2TIRCKdpvljruaiCxfHOeytVSOD/h
         XZ6Q==
X-Gm-Message-State: ALQs6tD3nrc9I4d6sysD2/7G5/xVQ1NCqe/zp0E4uHfX7hv8UIuMapS9
        4RjJSkSDR+dK6Aa5zN0zxgU0kl/QvbJDBAcDj7E=
X-Google-Smtp-Source: AB8JxZrW3UADmOjVXzkdzbZrHLBCwpEL+dlrTVMsZZ3U14ycsiI65szqU8UnRVW5cRwMcv8UWrL+kWMhZqt9BWQppmE=
X-Received: by 2002:a17:902:b94a:: with SMTP id h10-v6mr47470980pls.321.1525886818152;
 Wed, 09 May 2018 10:26:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Wed, 9 May 2018 10:26:57 -0700 (PDT)
In-Reply-To: <882bdfe8-6caa-dd9c-7752-ee4884f135f9@talktalk.net>
References: <20180421034530.GB24606@syl.local> <cover.1525831201.git.me@ttaylorr.com>
 <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com> <882bdfe8-6caa-dd9c-7752-ee4884f135f9@talktalk.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 9 May 2018 19:26:57 +0200
Message-ID: <CAN0heSpXCajyDKwOrXuQHWRODsVnFewUWTMitOoRQueFV4eSiw@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] builtin/grep.c: add '--column' option to 'git-grep(1)'
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 May 2018 at 12:41, Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 09/05/18 03:13, Taylor Blau wrote:
>>
>>   +--column::
>> +       Prefix the 1-indexed byte-offset of the first match on non-context
>> lines. This
>> +       option is incompatible with '--invert-match', and extended
>> expressions.
>> +
>
>
> Sorry to be fussy, but while this is clearer I think to could be improved to
> make it clear that it is the offset from the start of the matching line.
> Also the mention of 'extended expressions' made me think of 'grep -E' but I
> think (correct me if I'm wrong) you mean the boolean options '--and',
> '--not' and '--or'. The man page only uses the word extended when talking
> about extended regexes. I think something like
>
> Print the 1-indexed byte-offset of the first match from the start of the
> matching line. This option is incompatible with '--invert-match', '--and',
> '--not' and '--or'.
>
> would be clearer

>> +       if (opt->columnnum && opt->extended)
>> +               die(_("--column and extended expressions cannot be combined"));
>> +

Just so it doesn't get missed: Phillip's comment (which I agree with)
about "extended" would apply here as well. This would work fine, no?

One thing to notice is that dying for `--column --not` in combination
with patch 7/7 makes git-jump unable to handle `--not` (and friends).
That would be a regression? I suppose git-jump could use a special
`--maybe-column` which would be "please use --column, unless I give you
something that won't play well with it". Or --column could do that kind
of falling back on its own. Or, git-jump could scan the arguments to
decide whether to use `--column` or not. Hmm... Tricky. :-/

Martin

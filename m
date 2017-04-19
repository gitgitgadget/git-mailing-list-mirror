Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11AF21FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 13:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763556AbdDSNUF (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 09:20:05 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33496 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762829AbdDSNUD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 09:20:03 -0400
Received: by mail-it0-f68.google.com with SMTP id z67so2782971itb.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=T/oFrs3KRutmMBVW8d2f7tvLGQmeWtD6x3OkYxfKSRI=;
        b=rxe1Wam+3KzDf39EF7WevpQNsIZEK7OsFdftH5QzyG6WbokAlmmRNWC/4x17Fdw6k5
         asVKxNlgw9YQ2Thsvf7CHm2385aXWWGn75rF3n/9KboSEv01TdfSy1SfkZ5HsowWlxiY
         l0KPFSjJ0GePEeDewhNhwNPbd9aS/vmiJfnEJiZROXlf/RganLyxdx9kTmgoqbAxbpWd
         jjOTwN3hx4EtCvaTgLIwplmLzolHGX/o58ugT4UKfkocjezg3zb0cEiWS6nMf8XfBOiM
         EUZN6icjVahD9t50K/+IpnpcChZTQhx52F97k/JHMvZYsnzeQUmxOXPGAdEUonL5aWy7
         aiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=T/oFrs3KRutmMBVW8d2f7tvLGQmeWtD6x3OkYxfKSRI=;
        b=kKJF3PnA8CJvFojbU+iwwvXtEoNODi7MONiaxpeOAnGLxJGapyS7DfgiMq9IS0KzIJ
         1pfAYdIW+fw2oytIPIi3s7xSP1FoxBcAh+bpHp5+A126pLkIKty+eYyw/rS2BsUo6ylk
         y0TfPhcGOGxUJPj8LvY9djiH0UJhUs1ldepScd0tFK6s9zZXMi1v8yvI38xmygmygIHD
         wv4RFNNAKr3v+q2mZlLdygFqorlZAp7H5iV74wYjIKJPosZxPuCyImX2yRnwBVMLiHki
         +nU+SLkCybBtFWcEhAEIi1wO3T2eLjwvX6c+w57ICZYg7NtAVtWX9VwVEKv4rVao5nCN
         5Wfg==
X-Gm-Message-State: AN3rC/7gyw2CRZkfnE4Lv+MPCpzTkZ8QrHww19gjdoDn4JxpEL7j2S0C
        XSe6rpO26vYVX/rAr/qSEUIBSJLFpYO0
X-Received: by 10.36.115.12 with SMTP id y12mr3241287itb.24.1492608002773;
 Wed, 19 Apr 2017 06:20:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Wed, 19 Apr 2017 06:19:42 -0700 (PDT)
In-Reply-To: <b4eef4c1-cd5a-aa71-fc79-8af89dbe365d@web.de>
References: <20170418170914.9701-1-avarab@gmail.com> <de79d366-3609-8efe-b23a-7e793036b3ef@web.de>
 <CACBZZX6XWXjvDKeR+a1Ymb4csXgOKLiF==VkKLp5S9TRVQhgoA@mail.gmail.com> <b4eef4c1-cd5a-aa71-fc79-8af89dbe365d@web.de>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 19 Apr 2017 15:19:42 +0200
Message-ID: <CACBZZX7Y2cqabLMkx35ZU88Y3+8zffP5hxa8haThMaErbfhcfA@mail.gmail.com>
Subject: Re: [PATCH] various: disallow --no-no-OPT for --no-opt options
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 19, 2017 at 3:11 PM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 19.04.2017 um 09:00 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Wed, Apr 19, 2017 at 12:29 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wrote=
:
>>>
>>> Setting PARSE_OPT_NONEG takes away the ability to toggle the affected
>>> option.  E.g. git clone would reject --checkout.  Currently users can
>>> specify --no- options as defaults in aliases and override them on the
>>> command line if needed, with the patch that won't be possible anymore.
>>>
>>> PARSE_OPT_NONEG should only be used for options where a negation doesn'=
t
>>> make sense, e.g. for the --stage option of checkout-index.
>>
>>
>> That's a bad bug, I don't know whether to be surprised or not that we
>> had no tests for this :)
>>
>> I thought I was just disabling --no-no-checkout for --no-checkout, not
>> --checkout, but didn't notice the subtleties of the special case
>> handling for --no-* in parse-options.c, thanks.
>
>
> I'm confused.  What's the bug here?
>
> --no-no-checkout is undocumented; Jacob's patch addresses it. --no-checko=
ut
> is the documented form.  Negation allows --checkout to be used as well, w=
ith
> the opposite meaning to --no-checkout.  Turning off negation with
> PARSE_OPT_NONEG forbids --checkout to be used.
>
> Perhaps the issue is that a single line of documentation is not enough
> ("PARSE_OPT_NONEG: says that this option cannot be negated")?

I mean a bug in my patch, i.e. I meant to remove --no-no-OPT in cases
of --no-OPT but also removed --OPT unintentionally, but anyway, let's
drop this one, Jacob's patch is better.

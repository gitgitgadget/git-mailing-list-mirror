Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 188EC1F576
	for <e@80x24.org>; Mon,  5 Feb 2018 11:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeBELXT (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 06:23:19 -0500
Received: from mail-oi0-f50.google.com ([209.85.218.50]:41914 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeBELXR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 06:23:17 -0500
Received: by mail-oi0-f50.google.com with SMTP id m83so20913993oik.8
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 03:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8rPKbv6spKJo1/MmDN4Xnc77g+yWZrBUojE/EHIaK/g=;
        b=NeOqLfC8RxtTvmatrAtNO5k25GcQ3f9hNeAKj+nrIFfTDH7ZbsC/444YKkDfjy/+kb
         2mtjtgzh534gYOFKHzqIwGsvB0M9N+CWN0w//WOH6nXFFZ94tMEpax0RF2TRTTBeSHZu
         xv+ZOvhTsX0B+R3GedS72TAVNFEqZpIqmC3PIEslTcdwH84UlWq7G2uNEu5iIHCqh8vv
         0lEOlAd4uBkhVBUw97cVAkC1PveakDPB1ywbpeKeG/KaxgWq0T+cNGRvrrv1VVUYvGQ0
         BRPsrbmWMVXc1ov2u8dRwuoMrd8mJ1Fxv1vRGjfiCydoi/j9kS58RjabMaWVo9eIOyIm
         dctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8rPKbv6spKJo1/MmDN4Xnc77g+yWZrBUojE/EHIaK/g=;
        b=SxS3hOMF35ySqsSlj4pfPR80K67V9Pbuc6yTgbj25Edu1hrllmv1puZ+3vQJym9Yx2
         Z+KQZ4JHwixDs6fPiS6X3myo7YknmDBNFqmTvpqg2xrHSnZ4hzwPMvFPkIIGPE09yg65
         UCfQ757jzQYHn1L01d9AxPi/4jWkbmV9wx65lghQNGO86m7LgJDVr2nqRaVUdjuqKXAi
         ERSdXk8o5PiH0N+H3DzGeYwI3Llzry9n13VRcgl213heFoPrk7NphS9XWUvpu+fPRd4z
         SZW1Gq1lHbGCxME60KOcDg/wGYuq3bpdT5i6Wo9dPjfiNfcU7OalMgAVjWcQkDe7JpO8
         pstQ==
X-Gm-Message-State: AKwxytdAPBjEWuqfdCBhhVT20hhThwBbqG4ZCEqeIzKyZ0oX2m3e5K0O
        ZT/oP6jmFAg/0UzSlNSrbp3900fEi4xhQYorAWs=
X-Google-Smtp-Source: AH8x225P9iY/ZbCnW+n8JA3NVjXHMwokh3/LJ5huFO65Ojq/bmUHsBM7J1uKRWzGVGvxktUrl3yHMWS0TrfEzPI4Z8w=
X-Received: by 10.202.177.136 with SMTP id a130mr31150640oif.252.1517829797361;
 Mon, 05 Feb 2018 03:23:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Mon, 5 Feb 2018 03:22:46 -0800 (PST)
In-Reply-To: <87y3k7lnnn.fsf@evledraar.gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180131110547.20577-2-pclouds@gmail.com>
 <CAPig+cT5GkhFJ9XFDSirGjfoji4qUCM8LA6abdRsaT=g3prznQ@mail.gmail.com> <87y3k7lnnn.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Feb 2018 18:22:46 +0700
Message-ID: <CACsJy8AzKAGyAL_Pxpex3zF6G48=q8KCKvgJxOA_peqyM1cJug@mail.gmail.com>
Subject: Re: [PATCH v2 01/41] parse-options: support --git-completion-helper
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 5:46 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Jan 31 2018, Eric Sunshine jotted:
>
>> On Wed, Jan 31, 2018 at 6:05 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
>>> This option is designed to be used by git-completion.bash. For many
>>> simple cases, what we do in there is usually
>>>
>>>     __gitcomp "lots of completion options"
>>>
>>> which has to be manually updated when a new user-visible option is
>>> added. With support from parse-options, we can write
>>>
>>>     __gitcomp "$(git command --git-completion-helper)"
>>>
>>> and get that list directly from the parser for free. Dangerous/Unpopula=
r
>>> options could be hidden with the new "NOCOMPLETE" flag.
>>
>> I wonder if this option should be named DANGEROUS rather than
>> NOCOMPLETE to better reflect its intention. The reason I ask is that
>> it is easy to imagine git-completion.bash some day growing a new
>> configuration option to allow people to complete these "dangerous"
>> options, as well, rather than us imposing, with no escape hatch, our
>> idea of what should and should not complete.
>>
>> It's not uncommon for "bug reports" to be sent to the list stating
>> that such-and-such option (say, --force) does not autocomplete. Our
>> stock answer is "oh, that's a dangerous option, so you'll have to type
>> it manually". If git-completion.bash gains new configuration to allow
>> dangerous options, then our answer can become "oh, that's a dangerous
>> option, if you really want it to complete, then enable
>> GIT_COMPLETION_DANGEROUS" (or whatever).
>
> I think we should just drop this idea of dangerous and complete things
> like --force. On the same systems people use this on this will complete
> --force:
>
>     rm / --recurse --for<TAB>
>
> So it's odd UI to be inconsistent with that. But if others disagree and
> want to keep the current behavior I'd definitely turn the "complete
> 'dangerous'" option.

Personally I like completing all options too (and will be happier if
plumbing commands are completable; it seems much less work to do that
now). But I don't know git-completion.bash history and don't want to
revisit why some options are filtered out or the inconsistency.
--=20
Duy

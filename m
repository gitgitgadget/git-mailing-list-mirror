Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57F131F404
	for <e@80x24.org>; Thu, 15 Mar 2018 16:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752435AbeCOQsx (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 12:48:53 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:33451 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbeCOQsk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 12:48:40 -0400
Received: by mail-ot0-f174.google.com with SMTP id y11-v6so7550446otg.0
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 09:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P8AwSFmr4QaNx5SBY4Q4ZOMxhD9rzXt7OCWhjQZiwM8=;
        b=Atg7d7fSqnrc3B7Xd+c5wF2R7eJkCatB6JuEn589abTPI+oaOtuBlAwaRkR303sdM7
         J20CF+Zrkcj+k51ioFMCo+IsTien5vowMIxiMRcIl48ePvQOTVSR1sGjWoZcU3C6/sKv
         HpDHPmvpPhXPcAeRJG6kzNCyxlErRqDzq/IiDl5Y4fw3F7YRbn+WJexVe2x7WIHk21ie
         0eMgmEt+9tvJKjU2UFAy+1olfVo58Gu9TC+tWbE4FUcfWbU2FClV9QSaHxKhCyBR4zn4
         VQKjT7PgueO58N0KufXmnP3rj7VD+wdxzvcB8qN58JhiFwNPw5ryreH21YOswB/N0fXM
         pgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P8AwSFmr4QaNx5SBY4Q4ZOMxhD9rzXt7OCWhjQZiwM8=;
        b=rTs2TO4QQoKokbEOHXJIlKy/WWGM9T65CbkEuKNIiwqbAFXDf0L2GeKHM2r5IQ5b2m
         p1gcEf2g58XcolpNWRCqK0D5TouWRYPk2DGTlfsYlxkOzxTuipBmRo9aroLd1QaftII8
         kmIFCQ2RlQ+j5bH7iH76/VslLVRSzKZc26SkEkW+LUPLGJSvWmu/CDrRggxFkDufLVRq
         OHsHgGNH2OYTN6PH1vmzPGegnE7baj0ibkqdx4gfRG1Q2YnyQ2gXglNBu17QYZSqYDa8
         bAfrWX1mfj1bH2ogaYZCrNMJ6M88CwmJeW59C1DauOaaip33VjtHfhzI3eogNpKu/Riy
         0rRw==
X-Gm-Message-State: AElRT7HycEWa4syj/OjGDdsb57CcZ89D8WhjYdnbhER0y919KhHpjmzP
        Q+xl0G7884+VjR2FwgLi83AG0+OSmQpMshICcQo=
X-Google-Smtp-Source: AG47ELvKWWoHN8JUMc9igc4OsRNBH5l1NPi/TjHyHWyClwZ4urwSm8vBcFYSvn4AD2HJwZWTHcQqv531rlDTyqqcMqY=
X-Received: by 10.157.24.42 with SMTP id b39mr6458882ote.356.1521132520124;
 Thu, 15 Mar 2018 09:48:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Thu, 15 Mar 2018 09:48:09 -0700 (PDT)
In-Reply-To: <87bmftqg1n.fsf@evledraar.gmail.com>
References: <20180301092046.2769-1-pclouds@gmail.com> <20180306104158.6541-1-pclouds@gmail.com>
 <20180306104158.6541-4-pclouds@gmail.com> <xmqqfu5d3tbn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8C2j2dLozhHf4zE--KYPZ2VjOW2tobmczh3rf6L==Q1vw@mail.gmail.com>
 <xmqqd10f20k6.fsf@gitster-ct.c.googlers.com> <87bmftqg1n.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 15 Mar 2018 17:48:09 +0100
Message-ID: <CACsJy8AqQbX5Mkz=Gz=G79sp0mjV5rsyeo2X=pSO9HCuDbh1sw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] gc --auto: exclude base pack if not enough mem to
 "repack -ad"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 12, 2018 at 7:56 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Wed, Mar 07 2018, Junio C. Hamano jotted:
>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>>> But to those who say "packs larger than this value is too big" via
>>>> configuration, keeping only the largest of these above-threshold
>>>> packs would look counter-intuitive, wouldn't it, I wonder?
>>>
>>> I think I'll just clarify this in the document. There may be a use
>>> case for keeping multiple large packs, but I don't see it (*). We can
>>> deal with it when it comes.
>>
>> When the project's history grows too much, a large pack that holds
>> its first 10 years of stuff, together with another one that holds
>> its second 20 years of stuff, may both be larger than the threshold
>> and want to be kept.  If we pick only the largest one, we would
>> explode the other one and repack together with loose objects.
>>
>> But realistically, those who would want to control the way in which
>> their repository is packed to such a degree are very likely to add
>> ".keep" files to these two packfiles themselves, so the above would
>> probably not a concern.  Perhaps we shouldn't do the "automatically
>> pick the largest one and exclude from repacking" when there is a
>> packfile that is marked with ".keep"?
>
> As someone who expects to use this (although hopefully in slightly
> modified form), it's very useful if we can keep the useful semantics in
> gc.* config values without needing some external job finding repos andis =
is
> creating *.keep files to get custom behavior.
>
> E.g. I have the use-case of wanting to set this on servers that I know
> are going to be used for cloning some big repos in user's ~ directory
> manually, so if I can set something sensible in /etc/gitconfig that's
> great, but it sucks a lot more to need to write some cronjob that goes
> hunting for repos in those ~ directories and tweaks *.keep files.

If this is about .gc.bigBasePackThreshold keeping all packs larger
than the threshold, then yes it will be so in the reroll.
--=20
Duy

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E46A20323
	for <e@80x24.org>; Wed, 15 Mar 2017 09:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752202AbdCOJCN (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 05:02:13 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:35885 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbdCOJCI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 05:02:08 -0400
Received: by mail-it0-f42.google.com with SMTP id w124so45615574itb.1
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 02:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Io/C+CpBPzwFpr5mBHgUgm+GizlecQFI5WCWMzd0GMQ=;
        b=tF48kCO/9CP/HUFwv0PyYemKGUqOlHKuSg5dZTgEVWpex4A5lwuP1hDvpjieRPbJt2
         ciCjKbH8m6JZWWTYzbRrP1JYXewf1a0fYUnNLyCknvDqy1vGgTAAp86rwsjWxKdM6XaS
         gnCoaomceG2OzrEURe4kYttmGsyc0qUShNCG+/+DqJPhNLVpU34EPDqweqKUMJ01uq4c
         o95LXstoUmloURyUO11Gv+ZgwJhU8sijxwqD+XrGtAK95Pw8xgWcp/IAkyhiyjOQjnLX
         zcZOYODppY6kLpqkt+k7BCurrz51FJNkm2TPzqb3L78MUULbc8yNBA9+4V1FmXNG4EHh
         bBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Io/C+CpBPzwFpr5mBHgUgm+GizlecQFI5WCWMzd0GMQ=;
        b=LQXrsQbKOOD1UEVASb3hKoNvzM3qeNT4JkiQip1ka//kFupihqEsNLSWaem0MGj24k
         RkBE1payaTDvJMWly5+dcXejNwn9LDaKMaxK0+aagO0iwUWdy/j1Kr+jfHT0/IvZJUeQ
         uooOW1XfLZP0IQhQISk4utUfhRizGtU42clWtX8HPDiQZ+htd3rD5pGAvEWlEUnC8Jz4
         dyjyryI3Auugj4Vj+TnzY7Ij/ili458jngfY+yohR+3Lo2YYvRVAC2UV/lk5lFGB31k7
         IDixbv2ufU7tpvAjkOZfiyNl+VlfLFg9e7hSutD2it0f0It3wChbyc52hUIqFegjMVt5
         OELQ==
X-Gm-Message-State: AFeK/H01IyXC7VHuIG/byyIFSBTvUApjBtqh3WXFmCMXy76j29wFMG1wyWUJMPVX6/kH4u4BKB3OrWFQ4ZKmLQ==
X-Received: by 10.36.224.195 with SMTP id c186mr181283ith.24.1489568527440;
 Wed, 15 Mar 2017 02:02:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Wed, 15 Mar 2017 02:01:46 -0700 (PDT)
In-Reply-To: <103dec84-b274-0a81-fa9b-bf29afd988d9@free.fr>
References: <20170312200248.3610-1-jn.avila@free.fr> <20170312200248.3610-2-jn.avila@free.fr>
 <xmqq1su2ujsf.fsf@gitster.mtv.corp.google.com> <CACBZZX4EGfBAu0M0y4xboVAtWf5N07XY8s40npQ1hN3rbgqmSw@mail.gmail.com>
 <103dec84-b274-0a81-fa9b-bf29afd988d9@free.fr>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Wed, 15 Mar 2017 10:01:46 +0100
Message-ID: <CACBZZX7CoEn0d01hU=A5RbDiNwQi0wUJM9mU25pPnqTPu05r+w@mail.gmail.com>
Subject: Re: [PATCH] l10n: add framework for localizing the manpages
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 9:11 AM, Jean-No=C3=ABl Avila <jn.avila@free.fr> wr=
ote:
> Le 14/03/2017 =C3=A0 22:00, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason a =C3=
=A9crit :
>> On Mon, Mar 13, 2017 at 1:01 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
>>> Jean-Noel Avila <jn.avila@free.fr> writes:
>> Jean: Comments on the patch:
>>
>> - Firstly thanks for working on this. When I hacked up the initial po
>> support in v1.7.8-rc2-1-g5e9637c629 I always meant to try out po4a,
>> but never got around to it. It's much easier than I thought.
>
> Well, that's only the simplest setup I could come up with :-). I'm
> discovering the tool and it seems that can go quite hairy, depending on
> where we want to go.
>
>> - Consider submitting a more minimal patch that doesn't have the giant
>> fr.po (or just some minor cut version) as the tip of the series, to
>> make this easier to review
>
> OK. Will split in po4a.conf + Makefile changes, then pot and po files.
> The point is that as long as the po files are not translated at a
> minimum level, po4a does not generate the target files. Right now, the
> threshold is 80% of translated strings (no fuzzy).

Right, I don't mean don't include it, just add the *.pot and *.po file
in a subsequent patch, so reviewers focusing just on the translation
infra changes have a ~100-200 line patch to look at instead of 10x
that.

>> - The git-add.txt file is hardcoded in po4a.conf, won't this file need
>> to be generated in some final version of this series?
>
> If all the translation string are harvested automatically from the
> source files, the resulting po file will be huge. For the moment, I
> prefered to manually select the files and check that po4a behaves correct=
ly.

Yeah, makes sense, we can just start with git-add.txt and add more files la=
ter.

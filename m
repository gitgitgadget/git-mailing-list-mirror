Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1C61F576
	for <e@80x24.org>; Thu, 15 Feb 2018 10:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755325AbeBOKTm (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 05:19:42 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:46258 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeBOKTl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 05:19:41 -0500
Received: by mail-wr0-f179.google.com with SMTP id 34so2754781wre.13
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 02:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b4rE7FTyGQ2N0yRvuL+MHIKze9sv1IUYUqr2wmVD20Q=;
        b=c/ap/cMhrBFBFxx+LBt/KVKrvQxi4cbUNjuMQaHiBd3t4kKr8ctBH4k4Hz8w74sR+9
         PiZiQTsiwk9amO3MVLCCyp7FzOdOK8sdjSGzTWAKT7h2odKCGb3NG6nYsw+94el4wPW5
         Yotws5jjgeV+va2Vls+bp7yEoqY3EXw6WuHiymyw0KvZo784MoNV3CV1QL6zzjQJ14+F
         aqgcUXxso2vfZBNCTGlf8yWCMiUMlwsCOamJsrvfum46AX62rMFajnpU5q87PvsdKVaa
         Db95lOO3u2GrNPIdG7NJprhaiWbI3VtgUOmyecvSAi9YyS9+wvQM78lM8vsWNjjnWWBM
         23Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b4rE7FTyGQ2N0yRvuL+MHIKze9sv1IUYUqr2wmVD20Q=;
        b=CBN/MnUvdcs5+Dr3HE6k9guiqX+/82Fzc5lem+Rdb7LxMj+QFz6LZjp8D/LDIM8u1I
         VcVSghW+F7m3XTtCb1ObZwo98CjRuH2fPWfQazSNikLOj9XijXlc49HGOTkptU5NDrKE
         CbU4/FnHCwUGzyVJgAyWbfX9G0dFQfjoURFDhIfr0hYG6g8c1vJj2wAyFVNxCn0u8xjT
         kDxJ0Er0JXMlVQ7dr05OFMVOW8Au6/CREil3Ipm8WadHS/Ul7UYRb1uM2QjkF3OJkD5a
         uhOii2pOam8HPR+3oeSB/tn17Ce619xx9pfDVmwqaoIiP/lNVrwPTBe0DOTKnMlZwapl
         gWmw==
X-Gm-Message-State: APf1xPBLO42kl4EH5DOvuGISE+fv7TQJPhfM0zU1Hp9AVHvo91iFqAFf
        fwp/757cDvMWpNZcDMStRc1A1zZ+Dv6WXBS5QUc=
X-Google-Smtp-Source: AH8x224BbaKw144yz//lEWSYGgLngqPWFbwYMA7H3f0BvLedOiiaiK69CbQhjHqfKe7XKnB80EwHp8Ez/Lpk8CZahf8=
X-Received: by 10.223.176.201 with SMTP id j9mr2155472wra.210.1518689979926;
 Thu, 15 Feb 2018 02:19:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.155.17 with HTTP; Thu, 15 Feb 2018 02:19:39 -0800 (PST)
In-Reply-To: <20180215054542.GK18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f4353-44cc5f60-0e42-492a-9d7f-0f6f1c7b3501-000000@eu-west-1.amazonses.com>
 <20180215054542.GK18780@sigill.intra.peff.net>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 15 Feb 2018 13:19:39 +0300
Message-ID: <CAL21BmmeFW08vqx7EA7MsGzAbZjMt-uraz1kqUWWt5aXpziqJQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/23] ref-filter: get rid of mark_atom_in_object_info()
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-02-15 8:45 GMT+03:00 Jeff King <peff@peff.net>:
> On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:
>
>> Remove mark_atom_in_object_info() and create same logic
>> in terms of ref-filter style.
>
> This one is definitely a step in the right direction. In fact, this is
> what I would have expected to see in the beginning. It seems like this
> first half of the series really would benefit from being squashed into a
> few commits. I.e., I'd have expected to see the whole series looking
> something like:
>
>   - preparatory cleanup of ref-filter
>
>   - teach ref-filter any new atoms (or atom options) that cat-file knows
>     about but it doesn't
>
>   - convert cat-file to use ref-filter
>
> Most of what I've seen so far is basically that second step, but strung
> out along a bunch of commits. Can we compact it into a few commits that
> all make clear forward progress (by using "rebase -i" with "squash")?

I am afraid that I don't really see any 100% improvements by squashing
some of the commits. I tried to do that several times and I squashed
some of them, but now for me it looks like nothing else could be
squashed so that commits still look close to making atomic changes (I
am sure that it's super important).

>
> -Peff

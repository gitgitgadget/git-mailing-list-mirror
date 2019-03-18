Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA40220248
	for <e@80x24.org>; Mon, 18 Mar 2019 20:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfCRUEg (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 16:04:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45172 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbfCRUEg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 16:04:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so3161645wra.12
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 13:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yo85pidbuKlnf0/hH49Um1aIMe7DBsLITR7gY/XkfAU=;
        b=i7M3YpIX97rVqO9b7urAv0iTDjP2e+kdbpsyTIVlyKpzzWRz8SkheOzmA+NfG7gD80
         vPJLKTYg3zedBLsTEEgtjI6FQ1biriFUtE8Q8pfPJgWGMzmlMRZ2DipIe3CjULaLoMIZ
         lXtAi7fOzudLediGrFeS/PkkhoQ2rSR/6zrrtynb0O8USidzv1QUZjoI3FcMXDx/OZIX
         ZYuOHHlABc1cUgOo8EpB3U/7P5JkNCtOW8Yb097akQLNtS5FUYTedGtG+hjpzqeFOnfc
         CTb0tymkpnWt+UtqpnEFjGLgkodeTZUq3FcplPa13fpRIQW1uGs3TtFhLonCVSnBCPY6
         eEkA==
X-Gm-Message-State: APjAAAVpB6qJMiLABsY6DzLc4hsLQvleGRpr3f0uG2gpKhH6Vht8hf+r
        hc7LnP5G6Dz4uIVxelzTF2s/MVTeIMabFJoy6+U=
X-Google-Smtp-Source: APXvYqxutKdxQsBbRHDEHdaBF5eNOYcKX3OxEvcuWV0SyNozKN/R5l+uHfjXo1M5WoStPdVI6M7PtxuHC3VNxEthFiI=
X-Received: by 2002:adf:9f54:: with SMTP id f20mr14003737wrg.88.1552939474766;
 Mon, 18 Mar 2019 13:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1552275703.git.liu.denton@gmail.com> <cover.1552817044.git.liu.denton@gmail.com>
 <4edca9db0b2a32621a7622b5b709db23b2512d1e.1552817044.git.liu.denton@gmail.com>
In-Reply-To: <4edca9db0b2a32621a7622b5b709db23b2512d1e.1552817044.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 18 Mar 2019 16:04:22 -0400
Message-ID: <CAPig+cRmz2C7mAzc7Z=ZStAxd3qDSmbC4sbwyLGKqvkf2yzVPA@mail.gmail.com>
Subject: Re: [PATCH v8 10/11] sequencer.c: define describe_cleanup_mode
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 17, 2019 at 6:16 AM Denton Liu <liu.denton@gmail.com> wrote:
> Define a function which allows us to get the string configuration value
> of a enum commit_msg_cleanup_mode. This is done by refactoring
> get_cleanup_mode such that it uses a lookup table to find the mappings
> between string and enum and then using the same LUT in reverse to define
> describe_cleanup_mode.
>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>

These two Reviewed-by: lines should be dropped for a couple reasons.

First, neither Junio nor I reviewed _this_ version of the patch.

Second, a Reviewed-by: is given explicitly (not taken). When a
reviewer has thoroughly read and understood a patch and considers it
problem-free, he or she may say explicitly "Reviewed-by: <me>",
stating satisfaction that the patch seems worthy of inclusion in the
project. If he sees fit, Junio may then pick up that Reviewed-by: at
the time he queues the patch in his tree.

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>

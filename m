Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A3751F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbeGRSLC (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:11:02 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42776 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731431AbeGRSLC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:11:02 -0400
Received: by mail-io0-f193.google.com with SMTP id g11-v6so4754875ioq.9
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VT/5SSgeRC//F6PH2YOqch25nreYa3M1LXhquehM81w=;
        b=KmyHDWMxPx0lqApjGFtbUBIkPxXnV+LFlUWzc82ldX0FXe7IAIk0HyGM3gcsBBx4t/
         QXvEl2qhZGX75lCZccwRlDnRa3A5e5Dmp/ujDRX5Ewpjp3uICAfKY+L3xtGtt6+vUq16
         VHBtUSGKNqUQTECaxrc4j/qGA2ik3+eae72rX7y8uANX1xUIuRmIu2acbjbwXPc4mQQx
         0p/dgvEQ1LfEaDWHkD3S6aEbObCyVMtuhGxaYB9HO88QB+md9ls//ZPhCGProiJ57VPq
         bFrWco0RQYXnyFaxQCnP567242O1hLAln//bkw3GTtNvOOmqfyvM4pqunabC48UAZKvD
         kAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VT/5SSgeRC//F6PH2YOqch25nreYa3M1LXhquehM81w=;
        b=G7UZ+/6d/flcY7qwndR+LRW1+njLbT5Z2iHQwfuIWoR/WP9sRF5UZkH65BvStf4JC+
         FC/xcM1rkDd/Ocuepi9goN4pQnzZijgMfdv1gXnpe8Ol8CfnZnKccbv9lfjebDQbr1xT
         lm6sS1QTYXLT4aJRjTYAd2Zx9L9inOpZFmSmx39K1uw4vESIfId4/4euposILcQk8d1M
         LtUTt13Sl/OyMX7K2esiYj8B3IbE4Dq0gH+t0S7xLpDhC6qpTEGKN111tio77oVWns+D
         vP8O8SqzEFAxHUhcocQeE6FbYLLTTgDEEX9fFuoq/5MudDSY+thmkpqMfcx4HcKLJl5o
         u6+Q==
X-Gm-Message-State: AOUpUlGRCyNpG68dJ6709j1fQsmFti2R1TzKqZQJuEgznvAD+AI8NU2D
        2ZjeOrRT1vWzWK1FTIbw+vOqrin+akqnP43WpLA=
X-Google-Smtp-Source: AA+uWPxkz7mBkimeK/0S+F0Ca4YJTSbe5/1u0hTBsOkPUmaZ6nBBH5OVw08/6wmV7SWJI3B8ofYp9dIemu6yPNqizbE=
X-Received: by 2002:a6b:1f0e:: with SMTP id f14-v6mr5363114iof.236.1531935126725;
 Wed, 18 Jul 2018 10:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.9.git.gitgitgadget@gmail.com> <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
 <20180713203140.GB17670@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1807142351100.75@tvgsbejvaqbjf.bet>
 <20180716173636.GA18636@sigill.intra.peff.net> <CACsJy8BV3ii3MkYf6UObsX_JdDbT9ovY_K9dCCeYvQ3FWqnRUQ@mail.gmail.com>
 <20180717194148.GC30594@sigill.intra.peff.net>
In-Reply-To: <20180717194148.GC30594@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 18 Jul 2018 19:31:40 +0200
Message-ID: <CACsJy8DW8=FoRyEwAy48S76q0gxQbrS3emHou7QDhHqzwJRu+g@mail.gmail.com>
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 9:41 PM Jeff King <peff@peff.net> wrote:
> I slept on this to see if I could brainstorm any other ways.
>
> ..
>
> Sort of an aside to the patch under discussion, but I think it may make
> sense for prune_shallow() to take a callback function for determining
> whether a commit is reachable.
>
> I have an old patch that teaches git-prune to lazily do the reachability
> check, since in many cases "git repack" will have just packed all of the
> loose objects. But it just occurred to me that this patch is totally
> broken with respect to prune_shallow(), because it would not set the
> SEEN flag (I've literally been running with it for years, which goes to
> show how often I use the shallow feature).
>
> And if we were to have repack do a prune_shallow(), it may want to use a
> different method than traversing and marking each object SEEN.

All of this sounds good. The only thing I'd like to do a bit
differently is to pass the reachable commits in prune_shallow() as a
commit-slab instead of taking a callback function. I'll refactor this
code, move prune_shallow() to a separate command prune-shallow and do
the locking thing.

Johannes I could take over this bug too (since I introduced the
shallow pruning and missed this part) if you are busy, but if you want
it to be done fast, I can't help. I still have a list of things to go
through.
-- 
Duy

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0481F1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 15:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbeIYVYC (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 17:24:02 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43770 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729315AbeIYVYC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 17:24:02 -0400
Received: by mail-io1-f66.google.com with SMTP id y10-v6so20715506ioa.10
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3lTC9kJq0YyE7v36J/2W0pdTsCFSkoDusf6P488NHVk=;
        b=dWFTXkvEOdPO5ghlJxukjAvmi9NzZNfDTq6m7Psqc3Dqx4ZXQMgjHjth0BOJL/zdJ6
         cypF9cJgDGoPzGkO4ZtsNnxcsgHHsFlpdN/IcgI/lDB/AdzBqE9b3JXEQwEYB1qhIRIA
         r4CF1PpA8ajiHaNmv4QuB2r6jMO94g+cDLZYKXJvJZ8F6hGY/hGF8Q4hTwxj8ZQ45RD6
         dKaeFuDsf0+6ryCcqLuUM1hZIP5yk2A6sKxEx0YElKk0FxRX3A0K4s/aojaU/HJAv/MH
         fjkTf4ocewV22L4b7vtFszMsQ99LFsGr1NEn8dF6rLnB5NLTBIbXPPOZzKEV5kbhTV2W
         rswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lTC9kJq0YyE7v36J/2W0pdTsCFSkoDusf6P488NHVk=;
        b=HGi7ioTc12/eP0m/L0AMVj5KEg1DCbN+CoSWgywXNG0PVUQip/0MRY/mED+zesGHxm
         K07q+gh1cZ8yfou5/MxBVaANeVBhkAUKxxiLYr6mTQ8klxWVOcfl+WbwCY+YDfQmtRXa
         oFgM9eI3ext3StMtjrt3X2OpfoXqWQlokpwInG2YCkr/ZHHoVep+Ez/FIWW87KNwgpbl
         e9bKHx+j/G5ywPg2JEOnSpNUvxsODFkcK1SxfhWp9tpeyhSdXhhp0roqMRxyNMeNF6pr
         OqmCGhWsRcL06VWiIzCHngvLoJFxa6evBBqHzdtf5ZVeFxYkxLGFpwmSDM/VDbz54SO+
         OT7g==
X-Gm-Message-State: ABuFfoj/+BtXJniy3EWoJYt4kCyeRprJJLwftPPmSb6y/f4awLbnpiLH
        n/RKP1XoUNeXG8z7HwXYr27Fb+/dpewEiYyzPX0=
X-Google-Smtp-Source: ACcGV63KKrthBjepskctrlC4Zp5MOwI1uSXXHM3NZhLmLDkpxuTI/ErxV0J3boCDYBtW12LELWNp4mRsTk15g5zF9DM=
X-Received: by 2002:a6b:8f93:: with SMTP id r141-v6mr927892iod.118.1537888564859;
 Tue, 25 Sep 2018 08:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180922174707.16498-1-pclouds@gmail.com> <20180924181927.GB25341@sigill.intra.peff.net>
 <xmqq4leesjdc.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4leesjdc.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Sep 2018 17:15:38 +0200
Message-ID: <CACsJy8D1EMCqvBdxbta4oocMF33jwDf1=opXwZ0aRN7LYu=JXg@mail.gmail.com>
Subject: Re: [PATCH] git help: promote 'git help -av'
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 10:58 PM Junio C Hamano <gitster@pobox.com> wrote:
> I personally find "help -av" a bit too loud to my taste than plain
> "-a", and more importantly, I look at "help -a" primarily to check
> the last section "avaialble from elsewhere on your $PATH" to find
> things like "clang-format", which I do not think is available
> anywhere in "help -av", so I do not think "-av" can be promoted as
> an upward-compatible replacement in its current form.

Yep. I also thought "help -a" was denser but wasn't sure if it
actually helps or not. Whenever I look at that block of commands, I
end up searching anyway. For my use case, "help -a" could be better
served with something like "git apropos".

I think adding another section about external commands in "help -av"
would address the "clang-format" stuff. With that, it's probably good
enough to completely replace "help -a". It may also be good to list
aliases there too in a separate section so you have "all you can type"
in one (big) list.
--
Duy

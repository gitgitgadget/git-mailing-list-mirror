Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F07301F404
	for <e@80x24.org>; Sun, 15 Apr 2018 22:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752636AbeDOWLs (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 18:11:48 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:53446 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752609AbeDOWLr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 18:11:47 -0400
Received: by mail-it0-f46.google.com with SMTP id m134-v6so9156946itb.3
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 15:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=fCztKrDkL8N+Rfhh5KqyZWE7/vI3y8P+yiTSVm65QhI=;
        b=BnILgl2zn9OUdjSyHsBL9MS9M3T9nxo4sh15IfrwrSpeQGoqcSoslCfqPxsS7W4f48
         taHM06gx8iO316cXnRsqn4AzT3uTiGxFWwHymcoBv3g0zfgvzNhDJhI+GsVvgiDvz/KZ
         /ZBdTIvrJ7XiKubKY8iY0ANIWAAvwabxb73vW6sEujfr8NJ41W9T9YFuqXROwFGey6eL
         sLHAX5L4oUSKLXcH4ujvrF1bqCrifrNez/TwM6tmMDOMRaSKLoR6h5Yc+kj8OvXp/Qz6
         UHrgVMzwYYfK5HimkTSpa1tBMO3aCtBLA+/BECMQTjndmLfgVGB5V0u+k0/+FFwQ4CFw
         WelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=fCztKrDkL8N+Rfhh5KqyZWE7/vI3y8P+yiTSVm65QhI=;
        b=blKUCN9YpD7Lrc9FspqdMfuZ8fVheKQpwlyg5JhL38h7usFBk+p6VWOq6pGD8z6f6+
         YJ/rPtF2C4TJWYNC/0Mz2J2TSxdUQ6dfDSXy6r9jB4l8nuPCLhDFT4edpz5zK3V8Mkrc
         lSh1cVM/hRvF/xr5sKi/dRi1EtdHO3n7qQ2G9ShJeizK/fKFjWJ6SfChBHFdq19ImzWa
         zOUN3Ik57xhTKCohfgfNlKT3svrDUg7w+pAAQRQW4zc304Dpdr6anruChsPFJIDmW8A0
         6XgyGUOmS2tQuYmZTHOV3u0u+F1O3m0Sv5DQjmBpIWjbjOkIAX1/MfN9LTYRnK5n04M5
         Meqw==
X-Gm-Message-State: ALQs6tBs7qONG6A2J3gjTaMM7oC4OwyvCkG7eS9l166Po6rZwjAFSpJy
        42RHYUnSC5L9hCgie+ODErqm0HQ606evWYs85Ig8anee
X-Google-Smtp-Source: AIpwx4+jsAK5alaLPbU2JhhYU/XMG5QXkJdppopWPI8pIPWc1jkflQRK2uTceFfrBogzdL0MkxevlLHNbwM5DdaiCbM=
X-Received: by 2002:a24:6747:: with SMTP id u68-v6mr12598034itc.21.1523830306692;
 Sun, 15 Apr 2018 15:11:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.219 with HTTP; Sun, 15 Apr 2018 15:11:46 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 16 Apr 2018 00:11:46 +0200
Message-ID: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
Subject: Draft of Git Rev News edition 38
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-38.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/285

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday April 18th.

Thanks,
Christian.

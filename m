Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40D31F403
	for <e@80x24.org>; Tue, 19 Jun 2018 22:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753762AbeFSW3o (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 18:29:44 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34664 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753622AbeFSW3k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 18:29:40 -0400
Received: by mail-lf0-f44.google.com with SMTP id e13-v6so1621006lfc.1
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 15:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cOO2KPi3qBQ9iJ+P8qSp2/bc3+kUqpf7p4jYZ5dnzFg=;
        b=LrkToHClqqE8w4ME4RRk1IHLjPZMxhtl8hdJyA3XnHfRVv5w0X4EiNQIqXCunufmWC
         mQbrPQj43fAUOi7YMSr6hBmk2jFg4WJAWFDklrNk9AWugXcw7fIA/bYSmPxrfV+ZU2rU
         SSY/6tDi3hwo1RyX4WtIsqvy/J0Fq3suxITBVQYnZpiyj6gAPTN3n88WDc+vx4GkjQVb
         LNOgTBYS4oBD1gYoao1GUgFznS9MEJtfkaDxaNUYTIHMny10W7gBPhLLlGtUbe/8Tj3Z
         r516Atr7oDH36yW+c5qTvnDoiXaTfvD/XX/8/uc+PusG5sQaycUHtN6PjNtvncY+tNlE
         o0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cOO2KPi3qBQ9iJ+P8qSp2/bc3+kUqpf7p4jYZ5dnzFg=;
        b=C4ZWEtgkKZdQ6/tMBF22TQwzXZNFa4vhfxnyJwjYiCWxTpm73AO1JDdNayiuKc4DHp
         S79YnRjQb0U0zIac8lP73KbsXM+Ga4IiF3MmVtLe0+HPHQ3+NjS2bd1hpd0IdEgQC4I5
         yRwkqmqqB3u9A52WqrIs1H5GD3boqnpmrYVUbYIQWNCbe92Tg2lNNJpQmmJrMuoTsHWv
         h1wuQq4e8D0tZKJtJVN8InUNPdOPkYRXSl9yRuNXaPjP3bvij1BmFBrL9psFOtpLs92d
         DRun0EYFmjPU0Eshuno+sJ/yMa3kXVG1CNUo7nvy2rpW0IaX4YOFvOgT2THQ5RF8bIMl
         dyRA==
X-Gm-Message-State: APt69E27NNtcYqxb2R/h0YEStd6xkizMPWfbhVDjzQNIRmnbNcOCLsLU
        eso/prvXyn6cTgFxULGQPcYDVb3/syss5WcJ0C4=
X-Google-Smtp-Source: ADUXVKKMpbcjc8EQOCT2KODupkptYKGqxW5106E2u5TLyD1EP/yY16YiXQqly8v1GeTswD+Q/oBKVMaWcTRFo8k1hbw=
X-Received: by 2002:a19:a68a:: with SMTP id p132-v6mr10897586lfe.89.1529447379247;
 Tue, 19 Jun 2018 15:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180618111919.GA10085@book.hvoigt.net> <20180618155544.GB6958@alpha>
 <20180619102717.GB10085@book.hvoigt.net>
In-Reply-To: <20180619102717.GB10085@book.hvoigt.net>
From:   =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>
Date:   Tue, 19 Jun 2018 23:29:02 +0100
Message-ID: <CACUQV5884fs2wp+R5a-99BbJGdEbujzu2iBny+PjPeL9JeOm8Q@mail.gmail.com>
Subject: Re: Adding nested repository with slash adds files instead of gitlink
To:     hvoigt@hvoigt.net
Cc:     Kevin Daudt <me@ikke.info>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 11:28 AM Heiko Voigt <hvoigt@hvoigt.net> wrote:
>
> Interesting and nobody complained to the mailinglist?
>

For reference this was sometimes called "Fake Submodules" online.

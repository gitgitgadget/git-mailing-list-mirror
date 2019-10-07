Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87A9B1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 19:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfJGTQy (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 15:16:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37062 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGTQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 15:16:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so647917wmc.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 12:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oJmHXdxTDxLT4weG4gD7txJBorNP0RD2aaHToM/rYTs=;
        b=TuvziAcDsKvssC+sdHdO5KdPjsOScvIlj0BTX9NU4o/yFQv7egmW91gmegFoBnlq6b
         SUjbcCiSg5/K40nata9ji56itdvfZrzkpJg3bRLhDYiqsymInK0NPstwDFs23AXKf/+x
         yLwcJ+vuZ2XTrjGEj/Iu+AbdLUwzJcB5fh7X7r+i3/hvJYykj3zjencDhnp7w4QbcREq
         OaJku3bOi0Bq4FC+9tMQ8RxqLsLPAxUFcjJKE681FM8hiV/PoyxWxIj0wEQqHKco6hyU
         CMpv6XEAgapFb7N06bRwuQNhC+ORIrEGfeMl9rxL90nlUk2JzsGD6CS5bMSIQy2j8wnE
         JOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oJmHXdxTDxLT4weG4gD7txJBorNP0RD2aaHToM/rYTs=;
        b=SGmMTkY8j2eKqGS3USHmrdZOgFeHw3NVUGIkWYjk5QxCMoPoXxNLErV0B9iaPkaSDD
         99SjbysZ+MXceAsewx/AxaV/Fc0J4YQd1UNJWomXEzas8UrIF2uMEpw5vsRlh/uttdjA
         5t87plOrPoP/a4FRWzpkY069YKL6U7cgOyd1bMaj7APRMKOBRZqxWXOKZiyQxOYTvT7Q
         JjlatiTkGeGcXren7Q3gjpjcgmGspu49nqdXXZvAPFJllc+pLPnKSPJ/XNk+tizst+yw
         jZZMoko+AnueBuAb3f/j9GsRLrgnFPu/oBBNWp+jzOJ6+D7UXWOJsS7h7Sriejv3MnL9
         xUCg==
X-Gm-Message-State: APjAAAVmqS+XVeelCxCnMpUK17iCWpxycnCsccV42aFlJTaIEDWb5ZCf
        upFajIMJN26NqwMfr6L+QW5goWoD
X-Google-Smtp-Source: APXvYqynesWMSO/s8uR2kfKaa2U+BG11ZJJ5kHLzJz8h7ezjwj3SHKdZfr/Dvc+oZapTiuea8YSWDQ==
X-Received: by 2002:a1c:f602:: with SMTP id w2mr558577wmc.145.1570475812113;
        Mon, 07 Oct 2019 12:16:52 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-47-220.w86-221.abo.wanadoo.fr. [86.221.54.220])
        by smtp.gmail.com with ESMTPSA id k5sm8606592wrv.29.2019.10.07.12.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 12:16:51 -0700 (PDT)
Subject: Re: GitGUIGadget, was Re: [PATCH] Feature: custom guitool commands
 can now have custom keyboard shortcuts
To:     Birger Skogeng Pedersen <birgersp@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Harish Karumuthil <harish2704@gmail.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>
References: <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
 <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
 <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
 <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>
 <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>
 <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet>
 <20191006183948.5n23sdy2l4uwl6kb@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910062208460.46@tvgsbejvaqbjf.bet>
 <20191006210647.wfjr7lhw5fxs4bin@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910071101590.46@tvgsbejvaqbjf.bet>
 <CAGr--=JpC88+Bnc233aJRe1XDgPzZxThxHQShoDobBA6hcYChQ@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <86599b38-fe3c-903e-2f52-22cacea06e8d@gmail.com>
Date:   Mon, 7 Oct 2019 21:16:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAGr--=JpC88+Bnc233aJRe1XDgPzZxThxHQShoDobBA6hcYChQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Birger,

Le 07/10/2019 à 12:43, Birger Skogeng Pedersen a écrit :
> It seems this topic has kindof derailed(?). But I feel like voicing my
> opinion nonetheless.
> 
> -%<-
> 
> My biggest gripe with not using Github is how to keep track of replies
> (comments) to a topic. I have to navigate through multiple emails to
> get and overview of what everyone has been saying, when it should just
> be a single collection of replies from everyone (like in a Github
> issue). Where each issue has their own thread, and they can be linked
> to each other or to PRs.
> 

I don’t know which email client you use, but they usually have an option
to sort messages by thread -- this is how I handle my git folder with
Thunderbird; it takes one click to switch from plain view to threaded
view, and two to isolate a specific thread.  public-inbox.org also does
this.  Some don’t though, and gmail specifically has weird opinions on
which message is part of which thread.

On the other hand, I don’t really like non-threaded means of
communication, and I am very confused as to why modern services neglect
this feature -- there may be a good reason, I’m not an expert in
human-computer interaction :).  But personally, I find it very hard to
follow issues on github (or even IRC logs, for that matter) when there
is more than 2 people involved.

> 
> Just felt like chiming in,
> Birger
> 
Cheers,
Alban


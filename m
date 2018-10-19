Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98E9A1F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeJSWRG (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:17:06 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39593 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbeJSWRG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:17:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id e21-v6so2196614qtp.6
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGRWtXCjBv4Qy+PZNdC1qpF2PmD16UOZEaGfBly+Sps=;
        b=iUJQsVfEK9VhpDyn+A4gGbIC3AKtahiTGOqyNbRWSWAgXOCl8Agt94CLMwfQbLTw3K
         MY66XI57xSyj8PalW3skVTXOmtsT172BO9vtu8gowGjUPInyT2t1GJ4jGU3n9n0dQEXy
         nbo2wCNEEf3iQqycy7aDgkzhCgosh/EZaJGU1hQi8s20ZbM7Fbv+bloNbdMbA/9b0AzP
         bubGB+dtR8diz+8xoxejIvCIuo5rwF3i8bfMnIyrXYAl7734o5Rq+IP2WR/4HQefFFLT
         9aC0QTSC+ZpD6/bunS2Sr1DfIVgf+EcnJo2POZ4f9ulrDmwyefIIfemxmDWRqUAsUoTT
         xGsg==
X-Gm-Message-State: ABuFfog9I5HyqbLYEeNVVXICPdUHNpmWwstVGjMU5jA5L3ProlmontTB
        YLewBhZj3vWA8jKlYn0rfPJi8aq2NRM9n6UgWKQ1GA==
X-Google-Smtp-Source: ACcGV63FT/I3QMBRdLobAdbKA09IUJ+0X/V7OZKRM28nSnikKMEXWx6Af3/ueZdeyKRnsD42da9vaIwF2A5m+TBa7to=
X-Received: by 2002:ac8:73c5:: with SMTP id v5-v6mr28053186qtp.352.1539958247761;
 Fri, 19 Oct 2018 07:10:47 -0700 (PDT)
MIME-Version: 1.0
References: <20181018211527.25597-1-JPEWhacker@gmail.com> <CAPig+cR27mPmH+0oeT+2T878K-cBNqBnxPUumETnVK1cvz2qnA@mail.gmail.com>
 <9dc2995ff84158450255478c7411339a81f63aba.camel@gmail.com>
In-Reply-To: <9dc2995ff84158450255478c7411339a81f63aba.camel@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Oct 2018 10:10:36 -0400
Message-ID: <CAPig+cRFZ3kvbrUJpQheSFTvdah0Pds8boF0vf-p94SeWoUE+g@mail.gmail.com>
Subject: Re: [PATCH] send-email: explicitly disable authentication
To:     jpewhacker@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 18, 2018 at 6:02 PM Joshua Watt <jpewhacker@gmail.com> wrote:
> On Thu, 2018-10-18 at 17:53 -0400, Eric Sunshine wrote:
> > On Thu, Oct 18, 2018 at 5:16 PM Joshua Watt <jpewhacker@gmail.com>
> > wrote:
> > Implementation complexity aside, spelling the option --no-smtp-auth
> > might be more intuitive and consistent than --smtp-auth=none.
>
> One advantage of --smtp-auth=none is that it can also be done with a
> config variable sendemail.smtpauth="none". Would be also add a config
> variable like sendemail.nosmtpauth (the negative seems strange to me)?

I would not expect to see a "negating" config variable like that. I
was just suggesting that a "--no-*" command-line option might be more
intuitive.

> Or maybe --no-smtp-auth is just a shorthand alias for --smtp-auth=none?

That's one possibility.

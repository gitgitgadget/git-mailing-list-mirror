Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9328C1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 16:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439977AbfIWQ6h (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 12:58:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54838 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390958AbfIWQ6h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 12:58:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so10828017wmp.4
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 09:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=e81K+HJXghdNgyTd7btEpiIMOanDuU9C4SApvihBnHE=;
        b=T7wSIl138fTZH6x5kmZJy+crQKs/uZeY9GZtA/l6/BTYddLdvqVOZrtRkefyFpZR68
         r5TmlxTqHBchMJueWMI/g8s5QCbx5uQaeixNVjiDLTfNi8ijzpNcYUdaHHD7M2zjg5yX
         iA9affuXEaJ1PjfmDbeHtCh3g1BLTwo/g4lpZuws9+F8B9O4wVJ5TK7ZJCx/ZSW7UJi5
         C5JTU+o3jilZljAcX7qACqQHLeGDsJTbUDiWaS2dD/CU8rNU9N2m3a4dHQH0KBWbPBcX
         bEW/TLN7L5XiwQB9sX5l/RHjf11X/gyoUV5wq2wGHkenTgvBlDyzxuuN10XDkCovD27p
         my8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=e81K+HJXghdNgyTd7btEpiIMOanDuU9C4SApvihBnHE=;
        b=pS9x0wTQCMo5NLYW6xhpvWZ8nr7LYtuIvuAmuokZhN+x4u7EanTHTs4X6ZllMuJV7+
         255UndSMW7/pE0x4ClcHOs1rKAR0wryHkdV69Z6V2k2+DWfi+NSp9b5OlvOMtM5qTdXG
         BWC1vNtLpB0XVHD7nplZja6pIt6dLvQjP+OjO8t/9YOYUZ4u9M6S/GuE57Qjpi7sther
         W+PfSEzaTSTBe02wqpv9S+FYU1N0ldtulS66CSKc7mKkTojom6hcS4atv6CYf47UsooY
         4pjCjFZTWOnkMm+63e5oSCreIMe1ha69cSveqJyHu5VgSYgDOhN9swYcyFwPkgMFAhKM
         SqVw==
X-Gm-Message-State: APjAAAVOHdGKvqITgKxF3fgRAPOCeIfzqhB/RJ9qoRKMMMjcbHkfdy6r
        khHrytI/MHxY4GtCaX0UK4Y=
X-Google-Smtp-Source: APXvYqzq3vZtwRXTqt0zJffoL+Ba2CiXLx7e1hcrke6nbSppgACMo+J3myjAZmKPPRopbAhJvCbkCg==
X-Received: by 2002:a1c:150:: with SMTP id 77mr514454wmb.116.1569257914548;
        Mon, 23 Sep 2019 09:58:34 -0700 (PDT)
Received: from szeder.dev (x4db53381.dyn.telefonica.de. [77.181.51.129])
        by smtp.gmail.com with ESMTPSA id y12sm12405575wrn.74.2019.09.23.09.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 09:58:33 -0700 (PDT)
Date:   Mon, 23 Sep 2019 18:58:28 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Emily Shaffer <emilyshaffer@google.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190923165828.GA27068@szeder.dev>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
 <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190917120230.GA27531@szeder.dev>
 <nycvar.QRO.7.76.6.1909231444590.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.1909231444590.15067@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 02:47:23PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 17 Sep 2019, SZEDER Gábor wrote:
> 
> > On Tue, Sep 17, 2019 at 01:23:18PM +0200, Johannes Schindelin wrote:
> > > Also, things like the code tracing via `-x` (which relies on Bash
> > > functionality in order to work properly,
> >
> > Not really.
> 
> To work properly. What I meant was the trick we need to play with
> `BASH_XTRACEFD`.

I'm still unsure what BASH_XTRACEFD trick you mean.  AFAICT we don't
play any tricks with it to make '-x' work properly, and indeed '-x'
tracing works properly even without BASH_XTRACEFD (and to achive that
we did have to play some tricks, but not any with BASH_XTRACEFD;
perhaps these tricks are what you meant?).

> > > and which _still_ does not work as intended if your test case
> > > evaluates a lazy prereq that has not been evaluated before
> >
> > I don't see any striking differences between the trace output of a test
> > involving a lazy prereq from Bash or dash:
> >
> > [...]
> 
> The evaluation of the lazy prereq is indeed not different between Bash
> or dash. It is nevertheless quite disruptive in the trace of a test
> script, especially when it is evaluated for a test case that is skipped
> explicitly via the `--run` option.

But then the actual issue is the unnecessary evaluation of the prereq
even when the test framework could know in advance that the test case
should be skipped anyway, and the trace from it is a mere side effect,
no?


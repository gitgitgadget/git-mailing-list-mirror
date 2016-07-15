Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43F8320195
	for <e@80x24.org>; Fri, 15 Jul 2016 12:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbcGOMqu (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 08:46:50 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:34143 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbcGOMqt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 08:46:49 -0400
Received: by mail-qk0-f173.google.com with SMTP id o67so99998144qke.1
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 05:46:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zBbV+RjkUwlOYxIS6TtaaKr5GBwo8/PN/dYgTfpTJos=;
        b=rJfbnjWaDHQVjpwEY2pTcnhvjT/vpK5ayjiTxXXvzCX1ftwqt+v+lI5uD5+PLzwppk
         oDj2ad0c2MKU0Zb8f4plF5lOR3uu5a1HtQy2vuNJf6sp1lJCLAQy1w6M/qPDwopRMiXU
         xKf7L1oiZ6zEMryxAFpaw7JBGvYAejEPDRtX7LcKhnJPgAm8jkfHi0ySw5S6xryennuy
         +BeNEMZNeoq2SZew+nXozmMm7/1Ir1rbUZTgZJcAXKHYWLDvxcK/L73Cs4L10zNJ/mZs
         biSChgEF2RNIvu712Na+y+9FjO/tI83k0eqBVnu/FW23xioviA9pOcyYKN8qHWVQetDA
         35gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zBbV+RjkUwlOYxIS6TtaaKr5GBwo8/PN/dYgTfpTJos=;
        b=ccXgLH0TsFPWhWx9rLA3hH1C06ZEY4m/Q4ZbcS1H4LGIOyfbyHc8cd3cyuZDqKAX7B
         2xWPOIDOumA+zutxPthexghcRTNVX+3Pep+9xAHzAb1z81ChTTxOOmkvzs8v7J08+sGj
         lkP53RS5vQf4QyQQ8KmIpCEvYk2A4zILRWDnJseVK8GZC5dWRzPKSB3dlPXaMyqXxmME
         IYKq5LsmD/TZIXwjSKz72jQlKYqsYDi8w5mKrVp0jBELE6piQ4CIX1Po++wPcPd5Oj6U
         MOWdEPS8WjYvaEqPq/KrPpdA7gNX6e36DzGaGQ70zeBG4+hWFwj2Bx245RU0Mxn3NIgL
         9KJw==
X-Gm-Message-State: ALyK8tJaNmxirScijLK+1kVHGt/WX/UZW02wswqeiCT5pQoSltJGDr+Stcvg4FXoC4o6Jyb0NPyQ+T4bbuMB8A==
X-Received: by 10.55.4.133 with SMTP id 127mr25208030qke.207.1468586808254;
 Fri, 15 Jul 2016 05:46:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.36.77 with HTTP; Fri, 15 Jul 2016 05:46:28 -0700 (PDT)
In-Reply-To: <20160715121838.GA21968@sigill.intra.peff.net>
References: <CAP8UFD1BnnRqsv8zrcDDby=KqQ3UCDVdHWTycfDNTeyfLArn5g@mail.gmail.com>
 <20160715121838.GA21968@sigill.intra.peff.net>
From:	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:	Fri, 15 Jul 2016 14:46:28 +0200
Message-ID: <CACBZZX4TA0Ljf2aNZtZ5Sj8fFj-vhoLKq5RP5YbKSS9o9Ljg+A@mail.gmail.com>
Subject: Re: Plugin mechanism(s) for Git?
To:	Jeff King <peff@peff.net>
Cc:	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Turner <novalis@novalis.org>,
	Ben Peart <peartben@gmail.com>, Joey Hess <joey@kitenet.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Ronnie Sahlberg <rsahlberg@google.com>,
	David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 2:18 PM, Jeff King <peff@peff.net> wrote:
> Some features, like the index-helper, aren't quite so easy. One reason
> is that its data needs to persist as a cache between multiple git
> invocations. In general, I think it would be nice to solve that by
> communicating via on-disk files, rather than a running daemon (just
> because it has fewer moving parts). But that's only half of it for
> index-helper. It needs to monitor inotify while git isn't running at
> all; so it really _does_ need some kind of long-running daemon.

This *may* have changed in the recent versions of the series, but I'm
fairly sure and for what it's worth to this discussion, that's not
what the index-helper does. It's there to keep the index file in
memory instead of reading it from disk.

It can *also* if you "git update-index --watchman" spawn a watchman
daemon in the background, which is the thing that'll be doing the
inotify calls and needs to stay persistent, the index-helper then
communicates with the watchman daemon "what changed since X?" to
compute a new index when requested.

I.e. if you:

    $ git config indexhelper.autorun true
    $ git update-index --watchman

You'll end up with both:

    $ ps ax|grep -e index-helper -e watchman|grep -v grep
    61958 ?        Ss     0:00 git-index-helper --detach --autorun
    62813 ?        Sl     0:04 watchman get-sockname

So for the purposes of your example the index-helper is one of those
things that doesn't "need" to persist as a demon, only the third party
watchman daemon does, but the index-helper speeds up reading the index
since it keeps it alive in memory.

All or some of the above may be wrong, Nguyen/David, any comments?

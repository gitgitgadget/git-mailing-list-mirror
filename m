Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFAB1202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 00:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbdKUAii (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 19:38:38 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:41426 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdKUAih (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 19:38:37 -0500
Received: by mail-wm0-f67.google.com with SMTP id b189so22129947wmd.0
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 16:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sd9MPOy2XgjidlWPHgbYWh1p8MXI2JEj5Bb3noRpPH4=;
        b=LJGmtr2vhtsO8nxQBPfLJ5/vYgraXaT7jW1iaVuvPivAmaPmvgOw9MaMlgBry7GvxU
         DEF0tQ8r1iMYr/fRxIwqVNZzYFWZAZjjDN/pP1rjV4ssaVKRiU3kpiZRKlX2uFpS4NUi
         9H1WWnSPPpYrvk2aKkSHknqfoI9eJSGpUgwiPVojY4XhoRdTGAqy67KFiI3tNfMFFwfC
         P3Ftr92jNTzAPpqOqRM+FcHjX1MwNKGmkfQH1KTCDJOPBBZtH/OJwKttNjdLX4CxAmh9
         ofOr681X1vhjxSgTezCogk8D4+F2a+37PwixpGx9DneXJXZwiB1asE/V4uErkXylZ5hl
         BAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sd9MPOy2XgjidlWPHgbYWh1p8MXI2JEj5Bb3noRpPH4=;
        b=OoBWrX37MCBTF4cLNFua4pplvRcYMKAGswUa/hIS4sYbZlhtWGpaQU2SjtRGn6xp+3
         7jXZXGWhfDuD+86ffD3XvwIsmf5hWs6KlG8vnpbn6bTMsNtPVxOuwJCNWhHFUd4Xz/9U
         RTlF0y3QCaJHZIgWXjL/KSI+QH2v09v3XttHo2NKHRpmyuOEqYyHLY1ZRO5RKU0hhzxQ
         NinXtmyOKfeft9wuivLu3AWx1xdKnY8AumY5eQA0KN8Q+cwyCnlMeYdB+pBNKXnVFFCq
         Nu/Q+K+oqHEfFKY/2Evgp64R69Tp+VMgLtx+DYeIbbQ9WtVmNOJtsnjF7h95eDMi93G7
         Z4RQ==
X-Gm-Message-State: AJaThX6LVhdMMz+Xwsob+fyiUVIg3hBuns1RpYz8jySfQ7MmCutBJ8l3
        wl6OxuJB0a9t2Tkh6AVao0Qu1YjkFRg6YnJ/gg==
X-Google-Smtp-Source: AGs4zMaTa4R2a7EK4bcItpfn8wspUeTFYRYkfGL0w2VNjOmjwMMW2BzCAW53fybC+z8/mbzSCCxBLaDvZ+B5H9kTphI=
X-Received: by 10.80.241.143 with SMTP id x15mr22093065edl.119.1511224716849;
 Mon, 20 Nov 2017 16:38:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.135.140 with HTTP; Mon, 20 Nov 2017 16:38:36 -0800 (PST)
In-Reply-To: <CAP8UFD0ggpUGGoOEjAt3sB9=ek+Av+6GemiyqZ4kTCHLC9dWoA@mail.gmail.com>
References: <CAP8UFD0ggpUGGoOEjAt3sB9=ek+Av+6GemiyqZ4kTCHLC9dWoA@mail.gmail.com>
From:   Yubin Ruan <ablacktshirt@gmail.com>
Date:   Tue, 21 Nov 2017 08:38:36 +0800
Message-ID: <CAJYFCiOj1DwgMMrFRxV315CB7xuvXMFRbRAkbx6s14oPm3ui1Q@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 33
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Ross Kabus <rkabus@aerotech.com>,
        Henry Kleynhans <hkleynhans@bloomberg.net>,
        Charles Bailey <charles@hashpling.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-11-20 16:33 GMT+08:00 Christian Couder <christian.couder@gmail.com>:
> Hi,
>
> A draft of a new Git Rev News edition is available here:
>
>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-33.md
>
> Everyone is welcome to contribute in any section either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
>
>   https://github.com/git/git.github.io/issues/262
>
> You can also reply to this email.
>
> In general all kinds of contribution, for example proofreading,
> suggestions for articles or links, help on the issues in GitHub, and
> so on, are very much appreciated.
>
> I tried to cc everyone who appears in this edition, but maybe I missed
> some people, sorry about that.
>
> Thomas, Jakub, Markus and myself plan to publish this edition on
> Wednesday November 22nd.

Nice post.

For the CRLF issue: I am not really that concerned with this issue
because I mostly develop all my project on Linux. But can't git treat
CRLF and LF just as the same thing? That will solves the problem
gracefully.

Yubin

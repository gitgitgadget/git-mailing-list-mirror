Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DD61F404
	for <e@80x24.org>; Tue,  3 Apr 2018 21:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753305AbeDCVgx (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 17:36:53 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:40940 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbeDCVgw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 17:36:52 -0400
Received: by mail-qt0-f169.google.com with SMTP id g5so20964235qth.7
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zZR1Bw8kJ/iKYKIAWnRn959rfLB/EyOFoPx39ck1gWs=;
        b=Ok/LwpSlewB4hyCIJBchef0OHeuucxKzKuAWsAM2fvcFcI7T/kdv6uZdMRIZeWqSLr
         AUElznMJXMx+3V3rj7TgJ9LYna8Mp5xHUezeC/27Igsv06NkxRo+HT1hs8KdZFGlR1fQ
         DQCtNPo9c3gifzSC0CbubTuzQEd5sZ3IzEaWn6vOJa6mOSY0++9H/ofJXB3qtmtY0+TN
         yKmwHt2egqg3eg17/Lyy1NTsBkVr9PC2LnGKLWVC9KD/ERgIdOALXxjW0pgJrilytpvQ
         Fx5cUJ7hS9KzPq2rHyIZX94HDPhYVn6/2/rdw350303O+sGIaWx+BUKgr4YpkptT4SNa
         VWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zZR1Bw8kJ/iKYKIAWnRn959rfLB/EyOFoPx39ck1gWs=;
        b=RcLMZiexE/HWLKpOppJlo/XDNshNMlG79jkd4Ha3G+zO2mzq6KgNqGNYiqzwKteiiB
         IMcMVW5DPKyXt0hqm2x8jIF/BIP+a1x9EV8E9HBuRVps1FHtRoI+GDh8/qt1JugVls01
         XfSYFex3c8lIhSW43SW70xr6WDzSje99zpWhmi8lNUr2wsjTSMZDhSKPzZMtKOIA7j9B
         LnCZJtfbBhUOI3qM4NvV4cGJpwDAbP/t/tu2+p6Ipr5wAaLqr/I/eS+WA9JK2cWnhas6
         5hDLsD4OJ7LHn3noCA2hEPJGVPFm6q0izoNTfKjKJUzgJoG0pnPwVG5lBQ1sgkW243EZ
         Ndmg==
X-Gm-Message-State: ALQs6tAXMX4NKgWLzT3ONkTN16ZYkPH832hqHoJGjF8+73UD+XjtrTsZ
        VHqyiPwH1zUNmbpFCmfOYSnh28c8VQnAToAB9S8=
X-Google-Smtp-Source: AIpwx4/YCo6pAa8wn6o2ZzecskhUf0mkxNEZS/8u7FrRmZY2CyJZcn6Q1ByYb3uwKeqoe6LFoHUCoqHeAPhsNpYBxms=
X-Received: by 10.237.57.166 with SMTP id m35mr21682449qte.220.1522791411376;
 Tue, 03 Apr 2018 14:36:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Tue, 3 Apr 2018 14:36:50 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804031133270.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
 <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
 <20180329194159.GB2939@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
 <87fu4hwgfa.fsf@evledraar.gmail.com> <20180330191620.GA32338@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1804031133270.5026@qfpub.tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 3 Apr 2018 17:36:50 -0400
X-Google-Sender-Auth: tJwj7r6q37IRnA6zsdo50l7GNRo
Message-ID: <CAPig+cSEmHnmfhE1_1j0aVr0cfh4um=MxDr_n3jQq0skHesXGw@mail.gmail.com>
Subject: Re: A potential approach to making tests faster on Windows
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 3, 2018 at 5:49 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> My main evidence that shell scripts on macOS are slower than on Linux was
> the difference of the improvement incurred by moving more things from
> git-rebase--interactive.sh into sequencer.c: Linux saw an improvement only
> of about 3x, while macOS saw an improvement of 4x, IIRC. If I don't
> remember the absolute numbers correctly, at least I vividly remember the
> qualitative difference: It was noticeable.

MacOS is _slow_, much, much slower than, say, Linux.

Several years ago, when I had this machine configured for multi-boot,
I ran MacOS and Linux on bare metal. Back then, using ram disk for the
"trash" directories, and disabling Spotlight indexing on MacOS to
avoid it eating CPU and causing I/O contention, the Git test suite
would run to completion on Linux in slightly over 1 minute. On MacOS,
it would take over 10 minutes; 10 times slower.

These days, the Git test suite takes 15 minutes to run on the same
hardware (with same conditions: ram disk and Spotlight disabled),
which is painfully slow, thus I rarely do it. Unfortunately, I don't
have Linux installed on bare metal anymore, so I can't make a proper
comparison, but I do run Linux in a virtual machine under MacOS and,
even though its running within a virtualized environment, Linux is
still much faster than MacOS, taking 4:25 (slow, but not to the point
of outright pain).

That the test suite runs so much faster on Linux (bare metal or
virtualized) than MacOS on this machine, I have attributed (or
understood as being due) to poor HFS+ filesystem performance. It's
even worse when Spotlight interferes. Presumably, the new, recently
released, Mac filesystem has improved performance, but it's restricted
to SSD's, whereas this machine has a physical drive, thus I can't test
it.

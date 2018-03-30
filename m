Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC2E21F404
	for <e@80x24.org>; Fri, 30 Mar 2018 19:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeC3TQe (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 15:16:34 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35298 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752106AbeC3TQd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 15:16:33 -0400
Received: by mail-oi0-f44.google.com with SMTP id z8-v6so8488997oix.2
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 12:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w/DzpbucqZTMXiBhMm9zTJAxNRFlzHoLIxNMYdo04O8=;
        b=Q4oP9afrKmIyyf0xbAvBCZTxtJLCwiX31KVd6F18zQPIFtTw8a7bzf8aBlvno/UQcD
         W0GBFmcLWWV+WFcFd5S+T+lbG9r3fbrbl7+FUseRRu50UCNVfpjIS3kKuHxSu0askswe
         P6u1ytanMWwETXizgzbnbOeTquN7nqLyjIZmefNr/t0yRyFlZ5+Hvhstp+XfYblZD6OQ
         KmCk9u+LRUFzMNswLU7nww2jsXn3OX+6uQMlBW9OLLpmibwRSA7W566Suzh3f1pTgkO7
         FCjgmv0SYjjB743ooqf6iOg2OGwYyVrvF3ZyGa7cRpc8zOEQ/Hxrsi+KvzZouxmzi2wE
         2yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w/DzpbucqZTMXiBhMm9zTJAxNRFlzHoLIxNMYdo04O8=;
        b=M1qNiPUrBWt0eGQHwOHH1rsrt0c8rh6/FY05UvdUi6b16AT8ruoj81Buy45Wa/wA8T
         r+EglKiDw3eywzBNWu/cJso78kRV9hoGoOhZnXOXFrmjKld8JUL9as5Pk8/qTQRMNwqn
         MeKGaFpBkuoyPxNazb1og8FMsv42Ub8NdrX2KDlw7EF/5GBqwXm4nBVMpTeFocMvVdPI
         l0sAN0O36APIm+ENzkCzeIESB4ST1rOX06y+qsx5OEuMqpiwoocSiTZuRlxLZR9PNybt
         6VHiZGO3OV0omrQfMIPet1/LJf0hiaCW5e4dfSQfZrZjAJBRy2Q22CbaP4+MA8cMAeEw
         hh/w==
X-Gm-Message-State: ALQs6tC7cZuBg4pd37QPNklElEg3m8qOy3Nnw3tUmzNvsbPub+jsb3Ls
        WKakyCGVBDLJKhkZ9jTdzGfYc5xJnweIcR8zzVE=
X-Google-Smtp-Source: AIpwx4/MRpW6UTCAninYUfpF9Yj4QpmPt2q9OcyBkjYxCY8A8PcxhxTO1LX9cT5qjr5VcwO9tRF9ubawVoiyjM0wpko=
X-Received: by 2002:aca:5b06:: with SMTP id p6-v6mr142318oib.216.1522437392881;
 Fri, 30 Mar 2018 12:16:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Fri, 30 Mar 2018 12:16:02 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1803302046550.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de>
 <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de>
 <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com>
 <20180329194159.GB2939@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet>
 <CACsJy8DPof1jFe_cOS5+5dRHehU+_Y9y86P+5f3s_C0u85BXBw@mail.gmail.com> <nycvar.QRO.7.76.6.1803302046550.5026@qfpub.tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 30 Mar 2018 21:16:02 +0200
Message-ID: <CACsJy8DFva4y_Am-ZBei=VWXi4OdA0Y9Hc4xx7BnOHzVZP5gTQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] git_config_set: fix off-by-two
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 30, 2018 at 8:53 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I think the best course of action would be to incrementally do away with
> the shell scripted test framework, in the way you outlined earlier this
> year. This would *also* buy us a wealth of other benefits, such as better
> control over the parallelization, resource usage, etc.

If you have not noticed, I'm a bit busy with all sorts of stuff and
probably won't continue that work. And since it affects you the most,
you probably have the best motive to tackle it ;-) I don't think
complaining about slow test suite helps. And avoiding adding more
tests because of that definitely does not help.

> It would also finally make it easier to introduce something like "smart
> testing" where code coverage could be computed (this works only for C
> code, of course, not for the many scripted parts of core Git), and a diff
> could be inspected to discover which tests *really* need to be run,
> skipping the tests that would only touch unchanged code.
-- 
Duy

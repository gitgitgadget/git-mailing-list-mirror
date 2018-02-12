Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD911F404
	for <e@80x24.org>; Mon, 12 Feb 2018 15:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934644AbeBLPDw (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 10:03:52 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:33851 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932293AbeBLPDu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 10:03:50 -0500
Received: by mail-qt0-f182.google.com with SMTP id d14so19207523qtg.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 07:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DaKYvsTwIqS/qSYLtdnkK+aVsGVXgrAihhOFpEffR0U=;
        b=lSsKBR5tlRJekYRubrRBje439bHdkjNEq8zy83EL7Xf6RFxocuNoLWklrZA3SgVYvQ
         2iGkQmbJLz/vWtG3qMVhTM/kYBv8dNIqfxJtQDebxmPIqbgrIxQIzNSF7n9+TkUd9QEJ
         CIshPORWOHrsmzBF7W7RXVCc5TI/EQM67pS1N+D+i+MVvuTAjEY7NcSpsASybHevlyP2
         LqknBh+cuS5MZGmG8b75p6+NFPgmvnoCZnsJqzh7dOJy9ZApxWs5mU4fyXaK9+4BvHxq
         fx8xVd4kRjUyTHdCF+BBKgxqWrdZBxqKk9ZsFyzOiL3QQ9fa8qwOTPDVMQ6Hu3+gFMbS
         foIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DaKYvsTwIqS/qSYLtdnkK+aVsGVXgrAihhOFpEffR0U=;
        b=O19i2TuZKbH7kuHZ0zXwCjAayFXDVb9yNjT13Xg9Psa1DIsthfn3a4yssQxVnnmnFY
         mBgKSoFKm2sXpr1Y6tITJjAev68oyXN6E0etQLGY45h89NQa+k2DmisS5kvKWFq9FmKu
         2A0J3i5pv+lqFnIrFS5COlgfgZeT8eQKqqayt5mqlzySg+CVzvjUjyHapVpxdJFalwoS
         mkEoHw203UEQV1cA4zImhTAjfXmwOu6+aN4jBusheOI8b5oWM/6bEFGgWuTQ9w6yy96B
         uAtP3mgpUe68oHJND1zyjjh4RgW4A7ol8atzgOuJvMT98CVFvdCe0uCwOKIIqNc0wmL8
         PnOQ==
X-Gm-Message-State: APf1xPBp37vXVysHb5WHbGbbFukp1/pemYg89eBjEZnKBWw14cAeYGsV
        YomkMChvEVEOuscPlqQdKahpKkiIprYb2RWuL1zcLg==
X-Google-Smtp-Source: AH8x226MaRYWZbZwuKCvebq+HW806HKXlH9sqCvsZbZRZxE5yDbHwijhjQ/YMjzrnV02MTLHDP0+Xsv2wiFe2ePaYDg=
X-Received: by 10.237.62.163 with SMTP id n32mr13772224qtf.148.1518447829688;
 Mon, 12 Feb 2018 07:03:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.18.138 with HTTP; Mon, 12 Feb 2018 07:03:49 -0800 (PST)
In-Reply-To: <20180209193039.GA15554@sigill.intra.peff.net>
References: <20180209074404.2902-1-ash@kambanaria.org> <20180206073812.GA14133@sigill.intra.peff.net>
 <20180209074404.2902-2-ash@kambanaria.org> <xmqqlgg2xbx0.fsf@gitster-ct.c.googlers.com>
 <xmqqwozmvuth.fsf@gitster-ct.c.googlers.com> <20180209193039.GA15554@sigill.intra.peff.net>
From:   Alexander Shopov <ash@kambanaria.org>
Date:   Mon, 12 Feb 2018 16:03:49 +0100
Message-ID: <CAP6f5MnjhyP+Ty4zqS3sP2mgYfK3RiKm3=YpFE3LABxx7nUBkw@mail.gmail.com>
Subject: Re: [PATCH 1/1] Mark messages for translations
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, martin.agren@gmail.com,
        bmwill@google.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Xin Jiang <worldhello.net@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let me repeat what you said so I know how to improve the patch:
@Junio:
> Perhaps end each sentence with a full-stop?
I should end each sentence in the *log* message with "." (rather than
the translatable strings in the patch)

> Shouldn't this rather be like so instead?
> if test_i18ngrep ! "invalid gitfile format" .err
...
> These two ones want to be written
The standard negation form is:
   test_i18ngrep !
but I should leave the `!` in front of `test_i18ngrep` in this particular case

@Jeff:
> we may want to avoid this anti-pattern
Current state of these tests is wrong and I should rework them.

Here is what I intend to do:
1. Fix the commit message
2. Check whether I can get the tests in t0002-gitfile.sh to the
standard `test_i18ngrep !` negative (i.e. without using `if`)
3. Post and ask for feedback again

Kind regards:
al_shopov

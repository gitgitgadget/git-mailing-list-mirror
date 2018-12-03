Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BE57211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 20:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbeLCUnJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 15:43:09 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:39979 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLCUmi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 15:42:38 -0500
Received: by mail-pl1-f180.google.com with SMTP id u18so7057771plq.7
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 12:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcUaZ85afXnL6cCTihX3DtcZhQ24uVQbo7y5ftGq5Rc=;
        b=fLJnkuWKBMe9jcxnm7W3CqTA2hsYSWyo8bRBWYLMiUQFF+sWyUYG/q9qmFV9c/Gm+K
         R4yns4EZ4FwYCBl8dx3eK5Db7T3ZXdauTqvqxS0FjK9XE9LuSLU4SqKjUEJ+Qt2tjB8L
         XCZFegkAQX1QZ/mSXz/xd8DO25KvFmY+jlQSN1og/3GNlaLcOpcie3uA6DactWfhzDGJ
         FLZyPWpBcF36y+Fvbai/Et2SB5AkGpzZ9DvfWhQvf0JItKXKMHa5zFVQ1uUKibV2gO7B
         52sC2hsxRoHSo1mh5lsrXADlN3S/Lm/aqJFMN3jBvcuu/gY2qP9ugZeLoLkIQfLaqeEG
         81xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcUaZ85afXnL6cCTihX3DtcZhQ24uVQbo7y5ftGq5Rc=;
        b=hiaifAy8QwGrdZJOOtI3nSzOtaEJYdfLIQ5Y6ku++qCyiSPjevb+367QKbOl0+0kOH
         e9jxVzRhpHjZ9mYWSN4PKmKHCJzToRTHhi52TKtADvawvVtQLMxc0hTCV23dqyDAtwvc
         b+tyFtTASIbgqB2kAgsjvrF2ex49VVq9SKO0cnT9NJM7PiBVEngKjVsZftXY/V4UNXIF
         y4Gbi+SWyjjV6kS7jriXjHf5tT5IEExeJOnCQO1xihnQ9s2Y6+tLnGWg7aNg+O6lIT8Z
         khqmda7Qkc2E/QoRkdTDNTGJ6Odo9lY6pSkcmsrK+2DZsqlnByTOS6eDxoQF91cYP6L4
         ccvQ==
X-Gm-Message-State: AA+aEWYqLCPmnTk4EFk/4dikp5jI0rewtzaMOt1c2IO9zWVggXMIQgyz
        x1rrEjh5SUUbaT8dna5m7qxedT6paIi2TRWPVIL4AQ==
X-Google-Smtp-Source: AFSGD/UNc2PfBbPodq3eGRJkHiwwvTie9nBO0o4SlbYSFUdejARXZwU1fsFln3ApT7kGXPMjUVDyyvySsspz3O+euo8=
X-Received: by 2002:a17:902:728c:: with SMTP id d12mr17113853pll.284.1543869756646;
 Mon, 03 Dec 2018 12:42:36 -0800 (PST)
MIME-Version: 1.0
References: <f26b53e3-e7d1-f0fe-cdd3-dd734beb1628@kdbg.org>
In-Reply-To: <f26b53e3-e7d1-f0fe-cdd3-dd734beb1628@kdbg.org>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 3 Dec 2018 21:42:25 +0100
Message-ID: <CAN0heSqfgu2A7Hg5b1Td-m_5gXtmd-8_ZBC5Fq9BDMaJD0yMqA@mail.gmail.com>
Subject: Re: [PATCH] rebase docs: fix incorrect format of the section
 Behavioral Differences
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 3 Dec 2018 at 18:35, Johannes Sixt <j6t@kdbg.org> wrote:
> I actually did not test the result, because I don't have the
> infrastructure.

I've tested with asciidoc and Asciidoctor, html and man-page. Looks
good.

Martin

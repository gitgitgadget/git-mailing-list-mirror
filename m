Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DF0520248
	for <e@80x24.org>; Fri, 22 Feb 2019 15:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfBVPtw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 22 Feb 2019 10:49:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46304 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfBVPtw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 10:49:52 -0500
Received: by mail-qk1-f193.google.com with SMTP id i5so1357839qkd.13
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 07:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=veMfZjTRmbeP9yF6H4A8xQpbXVofvjfKjqXU9atB8xI=;
        b=CgkfW7qE4bVJiisdss7r88qoQ1aarhh6ctKhtNnLIJ3Yu9QUeHYh9huOjI2KmOwZsH
         WpvKqEHQt5gk0VNHGrA8GolaM8EO+xWapzI79J3LyVfq6Qf6ZjMeXORis7kwV48aS0NC
         4I0HwdTy32tEE9UKdkIhkTL+bWSnMQBZsjfYCKtu65+P3ho62t0By/ejQ2RULuaLoTwc
         E3UnlJlOjxAJS9sG8fHbzPlUOKHI4cDdW9CxYyYDhjHCFkcnikhPQ/iVTbG82arxLIMh
         uxB/m+tHqAfYhBSUU+XS+aDLblaAlnzkYepo/r0kMg7Rm6/o5ZYcGcsVieaQ743wGxgu
         OROw==
X-Gm-Message-State: AHQUAuZEaKOqv8WqSFFtb1yDzGsTOX+ccILvR5ko/YmXXJy9IOIC8lYr
        WN4V2LFL+WEFqLKvVAIG/pqOEmcAMaF74PZ9ISI=
X-Google-Smtp-Source: AHgI3IaN6bY6nJ41qBV3MFX0NRLWwS/IBEbzRjGF1EzupZrc8cSuka3uiVwErf+qImBShzP8in9OKHywITgjLb9RuN4=
X-Received: by 2002:a37:9584:: with SMTP id x126mr3451170qkd.36.1550850591592;
 Fri, 22 Feb 2019 07:49:51 -0800 (PST)
MIME-Version: 1.0
References: <20190222105658.26831-1-avarab@gmail.com> <20190222144127.32248-5-avarab@gmail.com>
In-Reply-To: <20190222144127.32248-5-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Feb 2019 10:49:41 -0500
Message-ID: <CAPig+cTwVYPLWnAJscOuNNRoBpuheQoQgQX-K8ia4gJ-5zAyiw@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] Makefile: Move *_LIBS assignment into its own section
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Lars Schneider <larsxschneider@gmail.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 9:41 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Now the only other non-program assignment in the previous list is
> PTHREAD_CFLAGS, which'll be moved elsewhere in a follow-up chang.

s/chang/change/

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

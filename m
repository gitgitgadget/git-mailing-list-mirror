Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA95C433FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 20:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673E86108B
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 20:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347921AbhIMUHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 16:07:42 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:45773 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348126AbhIMUHP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 16:07:15 -0400
Received: by mail-ed1-f51.google.com with SMTP id c22so14745764edn.12
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 13:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sb9XJa0rH5nFDyD8j9917zop1t3DvSjqgrnWQ/zzQdk=;
        b=HoogsWSvITnDrlGz40KT9FoXwpwoJp+ruP1rz/1S2zwuJNPoDzrbSiu8PlPIFKkF9J
         gvySLdxQO2IxPzJ9C7HQMGqF36yrfp+1eonmFY/O/1e+y4u9OHUu/vaDbwKUrD8Kh5He
         AG6vvCXW5Lge3jKe6hKeD2xFBUTgWFqhzja5upqNC5p2kLDRkEAMzW5scJm8wfCv+eQT
         1an2RllWd/Djn+bw3E3KWs77hJP1DW5wGsXEC4Q+0VE1wkkEVnCj2hmTHStTQNTLDEX8
         l2qStLU3NKQ1TOBOxchKzCcTk9jqhi6LFZNhG1ePueLdwJP4Auy8YNNS5Dw9icyBt7Gk
         eIsg==
X-Gm-Message-State: AOAM530DHp55ThXAdIJxS7QR6Z00xA9EYpgIjDyEdcZ3Pw7C1I4GhNlj
        VPovE1NBQ0s7pcsK84R2ppclkiX049hEJIiUCKHK+qOCHPE=
X-Google-Smtp-Source: ABdhPJzpRMCOZxnfB+n07iN9srNmdtdV0IaQlSnFHUrpqT7LsQ/QI8FFDieDlTqQeggKo75/po7GNxdj/b3smhDP+dg=
X-Received: by 2002:a05:6402:40cf:: with SMTP id z15mr14785242edb.70.1631563558364;
 Mon, 13 Sep 2021 13:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210913194816.51182-1-chooglen@google.com> <CAPig+cRZaonjCKt-rKcU0y-xNX1OQyftuEkuB4Rzhc5jCwVgMQ@mail.gmail.com>
In-Reply-To: <CAPig+cRZaonjCKt-rKcU0y-xNX1OQyftuEkuB4Rzhc5jCwVgMQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 13 Sep 2021 16:05:47 -0400
Message-ID: <CAPig+cQmRRRn+39+mTRfop4joR8kJECn6mD8BRrAa67qy7yz=Q@mail.gmail.com>
Subject: Re: [PATCH] MyFirstContribution: Document --range-diff option when
 writing v2
To:     Glen Choo <chooglen@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 13, 2021 at 4:00 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> I think we usually spell it as "range-diff", not "range diff". Also,
> it might be a good idea to give some hint as to what a range-diff is,
> even if that hint is just a link to the `git range-diff` manual page.
> Maybe:
>
>     ...to include a range-diff (see linkgit:range-diff[1]) between...

Of course, I meant:

    ...to include a range-diff (see linkgit:git-range-diff[1]) between...

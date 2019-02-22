Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEDF620248
	for <e@80x24.org>; Fri, 22 Feb 2019 16:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfBVQJp (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 11:09:45 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33749 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBVQJp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 11:09:45 -0500
Received: by mail-qt1-f193.google.com with SMTP id z39so3099111qtz.0
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 08:09:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66rUgvltZLEftrm8PgPomu6Efq5KG161sdHuTY/BSOk=;
        b=mNQVXh7BCrV3Z6UZc3sELin9oHSgu8nVYttQxW6P+Wyaxr9bWoy8K17ZndrV1ozbDu
         yL7MF2pBD6o0TE7rSJuUJLF6J7+s5Z/V/j/MonmwXJ1DOPQ8LdAZy8S3VEOX/hEhIoF9
         bW0ttL2v+YshjA1WBqEpukBdC/YSsVI4Hu9+ifOGYx3UJ0irB5F7CmucQEBBn2zRycYm
         3MKGWr32OzrXiKWGtv2b4q+FZnf6cVW3l7kvObMmR0O2dbQP8i6qDXS4a2MvdoEYQUFB
         Q1t7sMofheQGHv6BQXR5a8UQoy8wnQUdvUdF3/WUTSJW7QEeZfcYDXiXe3E8DYHfsM2R
         QhmQ==
X-Gm-Message-State: AHQUAubFHett1rVht0TVFJLNOmnMWAGzWV0vDB1TB9r3ZfSfQgLbSlJT
        mX2xBcgxb0aCkPKo0kGdUL0cGgQPIdcgkV28oUe5WFRw
X-Google-Smtp-Source: AHgI3IYM2pe0uiVsva4EoTlKxMjnZTCId2EkKv5kZ0BOIKgTtFGkAqD6OPXStAY3l5Tp/FFI4Ari1Mf42zpCxaqklUU=
X-Received: by 2002:aed:3fd9:: with SMTP id w25mr3659006qth.352.1550851784799;
 Fri, 22 Feb 2019 08:09:44 -0800 (PST)
MIME-Version: 1.0
References: <CAL21BmnVkKtYWa1cRL1EJAwtchGcVUzhu0136AuV8uXAi5Kuew@mail.gmail.com>
In-Reply-To: <CAL21BmnVkKtYWa1cRL1EJAwtchGcVUzhu0136AuV8uXAi5Kuew@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 22 Feb 2019 11:09:34 -0500
Message-ID: <CAPig+cSDtU1pbuzCvNPf+nmwS5LLKPm5RSY7wYxWg=s1e53enw@mail.gmail.com>
Subject: Re: [PATCH RFC 0/20] cat-file: start using formatting logic from ref-filter
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 22, 2019 at 10:58 AM Olga Telezhnaya
<olyatelezhnaya@gmail.com> wrote:
> I also have a question about site https://git-scm.com/docs/
> I thought it is updated automatically based on Documentation folder in
> the project, but it is not true. I edited docs for for-each-ref in
> December, I still see my patch in master, but for-each-ref docs in
> git-csm is outdated. Is it OK?

If you look at https://git-scm.com/docs/git-for-each-ref, you'll find
a pop-up control at the top of the page which allows you to select
documentation for a particular release of Git (say, 2.19.1). Your
change to git-for-each-ref.txt may be in "master" but is not yet in
any official final release. It will be in 2.21.0, but that release is
still in the RC stage, thus doesn't appear at
https://git-scm.com/docs/git-for-each-ref.

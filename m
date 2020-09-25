Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E673C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A2DE2086A
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgIYRd2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:33:28 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40087 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYRd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:33:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id t16so3299777edw.7
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 10:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lt3WCrhP3RYN6DiPR/ngTU0ItzK2HVVSmS1+0lT0MAQ=;
        b=bKKv8+H/hyUTlJW8xvwUIsBdtYeDuiRF09sy+Q9i9euPfq0MXp1kjbLPmCLArjS/0Q
         1d+35AA5owmsdlNrUVhcB4ZLzX7V13HL2Z6cqfnTJ8ukcJHbZm16uMuaWFwKuIOAUmSQ
         6RNyf5xrzstBotqcU/Z0Uee8bdNyBJm4Rbyldl1AEMFu4HaHwy7I1qeTqOgDnaaSBdyC
         vnoC5N9eVlEVVg2fe/MhxBog+PiUMWUdRnXqsaYdtrSzGjqDz/1Je9oo0VlPvwyBy92h
         zwBHVtC/FL7NANkilNZ+Mk8HRYrS4Bxa7XRJUFKa+yXO4e42XFLC8Md6f54kUYN5sDaV
         hjgA==
X-Gm-Message-State: AOAM532WkPVDQ379v47H7ZAG2JjyJ3CCWAYtYD1pz5HllwniKdND03pf
        9yU5FKIuFpTJKrqNzHis136RM4osn7OsERBBCdg=
X-Google-Smtp-Source: ABdhPJyIcrTIBr0+bjinkZbpoWEEOkZl5kG4XclR1ZitIwSoB4XZKacb8f4Jqb9Rtol2+NfN30JACm8QCb6KNCol9Mg=
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr2566193edj.94.1601055206700;
 Fri, 25 Sep 2020 10:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200925170256.11490-1-shubhunic@gmail.com>
In-Reply-To: <20200925170256.11490-1-shubhunic@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 Sep 2020 13:33:15 -0400
Message-ID: <CAPig+cTwHuTA=puzPfpOiMcMUkYPsbOca1GQK=dS1hJJeZZBGg@mail.gmail.com>
Subject: Re: [PATCH 00/11] Modernizing the t7001 test script
To:     shubham verma <shubhunic@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 1:03 PM shubham verma <shubhunic@gmail.com> wrote:
> In this patch series modernize the t7001 test script by changing the
> style of its tests from an old one to the modern one and by cleaning
> up the test script.

Thanks for tackling this task. I presume it was prompted by [1] or
[2], as this series covers many of the items mentioned in [1].
Overall, the series looks good. I'll leave comments in a few of the
individual patches.

[1]: https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/
[2]: https://git.github.io/rev_news/2020/08/27/edition-66/

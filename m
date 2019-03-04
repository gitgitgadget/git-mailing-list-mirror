Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62E9A20248
	for <e@80x24.org>; Mon,  4 Mar 2019 03:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfCDDzX (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 22:55:23 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40231 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfCDDzX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 22:55:23 -0500
Received: by mail-wr1-f67.google.com with SMTP id q1so3896529wrp.7
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 19:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W80DqYSt3i+/86Kq1yEp68OpZh4YVCw/c/+lgn8OBbg=;
        b=P74mBZGWpIGdZ6TIt0qCqIYXH7kG+o84ZtHrSVM2jpMVvQ1eYzWnXoBY0MTN07WFm7
         pYQobPTVhWv42889JFXe/onuRylx5COcz4uvPHpvIsy/CWzbIH/rlaxQjZOrkCzfTQXb
         3Mk9PUpsl+OEx4/VxO89cBXOxaA8UrREgmjZEYfAQTyTP4bJw6LZvYB+/UAyEJ3r93Vo
         VJuQX1pFwxQlXpZALQAmJp8aDp9N8jtCfilB3efOSAgV70er5FDrQvDEZviQ/CnAIMJF
         gHOW3/lXK2ISyjH8i8htvOCvb+EgbvyfKZMnc5X8mFGoNSyYIxWQQ6cGBT3g7aINDfF5
         mwzg==
X-Gm-Message-State: APjAAAV26uqsnfmRLlgwZdGZRNgpC9Mlqc7Ye2WdeNLEfah4jq2Nj56H
        +IgIoISScE+cg9mxm5lzSvslag7yALdHPJUmogs=
X-Google-Smtp-Source: APXvYqx08dDeDDPsL7m+aONoaRW1wH2SpeNlTS/Kyi8JpX61iBmUjzy8XWDyUXnZCsly3NLOjYmnLRoH4hc57Hi4uHY=
X-Received: by 2002:a5d:4149:: with SMTP id c9mr11532180wrq.58.1551671721332;
 Sun, 03 Mar 2019 19:55:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.155.git.gitgitgadget@gmail.com> <pull.155.v2.git.gitgitgadget@gmail.com>
 <074628c22b2df82280b06db604196f25300e8f87.1551624293.git.gitgitgadget@gmail.com>
 <CAPig+cS1URdnRb0RM0HYQhtmXWn5knx6Ee1Y96Gc9dt_9LmRKA@mail.gmail.com> <xmqqfts3z5kw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqfts3z5kw.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Mar 2019 22:55:09 -0500
Message-ID: <CAPig+cR8ukjA+mYR2zJBt-Q23SS2HJeBF0v_iEYY8-7JGRRh=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tests: introduce --stress-jobs=<N>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 3, 2019 at 10:22 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Sun, Mar 3, 2019 at 9:45 AM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> ---stress=<N>::
> >
> > Shouldn't the "--stress=<N>" line be removed?
>
> Eyes can easily be tricked by the patch format, but the above hunk
> does remove that line ;-)  I had the same reaction when I saw your
> message for the first time (before seeing the patch itself).

Yep, my eyes were tricked. Thanks for pointing it out, and sorry for the noise.

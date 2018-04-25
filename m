Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C38F1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 15:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755153AbeDYPMm (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 11:12:42 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36869 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754863AbeDYPMi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 11:12:38 -0400
Received: by mail-wr0-f196.google.com with SMTP id c14-v6so13573051wrd.4
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 08:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=835d0HE1R+Miz1mnoIyhzL5ljUHXpF+/D51NSxWl/cw=;
        b=ktSpBFLXcDtisJiGrvb13i8DhJ3M338gxBT1/lM4OFg45YRAPYtpQtvEqWpav+Ps1i
         UPzRtJJa209gRSQrgCClQIfP8py/z89jXjCE8CzZrWxk0LBbYtevuyB7xlIC8vV6Xgfp
         BG9wdvoDf4f1WBjFc6mJqlKzYmmX+QNu1wxfMFRPFROjG9WziIXT46Y1agHXXYjHE75q
         rmGCZgMtrw0K+Is/XgMvktaxVw2w3Ct86kETjSnJIxmUIPhpan1/noCR+nO594unU18S
         ftUohrB50fndivVoAIrf/EUJv7bT56Lru1H43ufsucKW8OuWwVC68RqLjv4g59f/eqg7
         jhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=835d0HE1R+Miz1mnoIyhzL5ljUHXpF+/D51NSxWl/cw=;
        b=EuHVC/KleF5w8zdCh4D7Nc+B7LgOsoDNvIHcE707wS4dPxWA7Gy3qUWcSG52Gc/vHn
         3asQPtEJwVnALtxOBX+KeILtTFH3DKGfk1+ruxJfId/hsGE9tg0jJM6VrmshrWPOYXq5
         2USq03Yr8jgcbIgfAg9wIH7ClgflNBSYUa7W4Dw9hkggC6kKFEfgLcr8YtEsTw86UxiE
         VWivxiruPUBSkHIvV1iuwYF1HlHbxy8pfBavs8mfSWwfJz+jX31W7h4q0g2IqikD2mOc
         X8A9nKswfUQCWNz2GSQtXPFgKZSmpi03zulj4Xiebugov4fuLblKVJ4xBhsgCulboXGn
         L+Ig==
X-Gm-Message-State: ALQs6tALmBzdhHnrVKx+fvauuQp05yLaS0u7USUcT/tQ3lLsQifAbdv9
        Y7FqlPLjQsi9IT/k6KTipq54PTo8XsV4Fg6BKRY=
X-Google-Smtp-Source: AIpwx4/aFOI319LQ9QPFIgTPNlI1q77kjRD3ntbkYysAoPnbj1GTsCt9liDYoNKWFWbXhmZxhoUI98YwKSTkH5z9qY4=
X-Received: by 2002:adf:b88f:: with SMTP id i15-v6mr22423471wrf.163.1524669157631;
 Wed, 25 Apr 2018 08:12:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.142.82 with HTTP; Wed, 25 Apr 2018 08:12:37 -0700 (PDT)
In-Reply-To: <CAGZ79kbzFGn2-xcrWFi1+ZUgSGGHdUPEQOexu8Lan796LCsvBg@mail.gmail.com>
References: <CAGZ79kbzFGn2-xcrWFi1+ZUgSGGHdUPEQOexu8Lan796LCsvBg@mail.gmail.com>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Wed, 25 Apr 2018 20:57:37 +0545
Message-ID: <CAOZc8M85e6V3XP++yay=DU0i1X613ACRFPfwgSes5PFV7dss6A@mail.gmail.com>
Subject: Re: GSoC students and mentors in 2018
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 2:46 AM, Stefan Beller <sbeller@google.com> wrote:
> Hi Git community,
>
> This year we'll participate once again in Google Summer or Code!
> We'll have 3 students and 3 mentors, which is more than in recent years.
>
> Paul-Sebastian Ungureanu mentored by DScho, wants to convert git-stash
> into a builtin.
>
> Alban Gruin and Pratik Karki want to convert parts of git-rebase into
> a builtin. Both are mentored by Christian and myself.
>
> The slots were just announced today, please join me in welcoming them
> to the Git mailing list! (Although you may remember them from the
> micro projects[1,2,3])
>
> [1] https://public-inbox.org/git/20180319155929.7000-1-ungureanupaulsebastian@gmail.com/
> [2] https://public-inbox.org/git/20180301111907.17607-1-alban.gruin@gmail.com/
> [3] https://public-inbox.org/git/20180327173137.5970-1-predatoramigo@gmail.com/
>
> Thanks,
> Stefan

Hi Git community, I will be working to convert parts of git-rebase into builtin.
I hope my contribution will improve Git.

Best of luck to Alban and Paul. Hope we get our patches merged this summer.

Cheers,
Pratik

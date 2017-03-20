Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B36920958
	for <e@80x24.org>; Mon, 20 Mar 2017 17:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755337AbdCTRlv (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 13:41:51 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34218 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754443AbdCTRlu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 13:41:50 -0400
Received: by mail-pf0-f177.google.com with SMTP id p189so45690025pfp.1
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d3IHFzu04iEqBaYtjDf6TQ226WEGQsPFT8TKZliALuI=;
        b=quUwgz2Mc+ofCLfp6jk4Un8N2lzwXn6U3SqUgrioBf2BJ3TcCd5UEyIHuk5xF205FV
         cOf703QSXNyuvD/BQWehkmPghCPkB0bFX706/bhpY3GNVkuBGou/lHoYPlHlcNf6+nME
         n8wbF56iLGR0UafjHA4+1pzz4/kfdx4QGmJ8QUOBjPojP29d6oQ9pP0drPzQi7Gd1RnX
         TzgwFiKgM+6rPIAzOqIo0NsXDqgu1vZgIssxJbCbp1m0nVcUEa4Wbpqo+Y7hygCZRN0L
         HQEsgW7J+7pK6ur3bG1i1CrWaEWsvTkmDpcOqBc4DfdJ0t7t6PSikfGueF2ICbrvkeSN
         Xo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d3IHFzu04iEqBaYtjDf6TQ226WEGQsPFT8TKZliALuI=;
        b=nNGMrqtTpobzgmywbjJos0f6LazTW3spGCJ2RMRWLjUQyhAG9Um/ioWY+HRMpmDX9J
         ZoLMSGwIxHuuiAx3z7tj4VWfKyNagAaJHbk7q8z/mXVElzCICMKRUigwrAWK/5mYoclg
         JQIT/ul/5JddsvoTcx7MBMYIXtx6lZJQJw2hMRj8NGTigqX/8VAg3n4JQpJTThKdvT4v
         ox21w/FXLwdC2pH540kdVT0nPl+mWX1kXEoVnO7yHdOMuDQvRJLVieculAvR7Y65s8Hu
         Ejti7cZ7tnC7s8MY6U8jWrWPkSUgQdMZ9LivvgTj5oFoLQlDR0WotmCpaEmt2CAuwLuw
         m8+w==
X-Gm-Message-State: AFeK/H0IDaY0ZEZSKK1bQIEAcW9yy8nd3I+6VTNBtSFn4flWMUSSGSxbb/IFqrqF/gl7Z0Lf7JgKQxBcl9eTpSpZ
X-Received: by 10.98.101.7 with SMTP id z7mr5820677pfb.81.1490031708669; Mon,
 20 Mar 2017 10:41:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.161 with HTTP; Mon, 20 Mar 2017 10:41:48 -0700 (PDT)
In-Reply-To: <20170320164154.xBcU6rG0C%pickfire@riseup.net>
References: <20170320164154.xBcU6rG0C%pickfire@riseup.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 20 Mar 2017 10:41:48 -0700
Message-ID: <CAGZ79kbF+O6tgn-4ivmOza3QGA4oFyJS=9eGHYZ1HQgw6+rEtQ@mail.gmail.com>
Subject: Re: GSoC Project | Convert interactive rebase to C
To:     Ivan Tham <pickfire@riseup.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 9:41 AM, Ivan Tham <pickfire@riseup.net> wrote:
> Hi everyone,
>
> I am Ivan Tham. Currently studying in Computer Science in APIIT Malaysia. I am
> interested particapate in Google Summer of Code 2017 under git organization. I
> would like to attempt "Add more builtin patterns for userdiff" particularly for
> shell for my microproject.

I'd love to see proper shell support!
Although there is already some support for shell (by looking at diffs
on our test
suite) ? So I am not sure what there is left to do? Can you clarify what you're
trying there?

> I am interested to work on "Convert interactive rebase to C"

+cc Johannes, who recently worked on rebase and the sequencer.

>  aiming to port
> most builtins stuff to C in which we can reduce the size of git. Additionally,
> I would also like to convert scripts to builtins as an additional milestone.
>
> What do you think of these projects? Would it collide with
> [Valery Tolstov's Shell to Builtins proposal][0]?

Curious why all people ask about colliding with Valerys proposal here?
I do not think it would collide, as submodules and rebase are very different
areas of the code base.

Thanks,
Stefan

>
> [0]: https://public-inbox.org/git/1489145258.10535.0@smtp.yandex.ru/
>

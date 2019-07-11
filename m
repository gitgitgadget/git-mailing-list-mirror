Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A875B1F461
	for <e@80x24.org>; Thu, 11 Jul 2019 00:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfGKACU (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jul 2019 20:02:20 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:45476 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfGKACU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jul 2019 20:02:20 -0400
Received: by mail-io1-f53.google.com with SMTP id g20so8578760ioc.12
        for <git@vger.kernel.org>; Wed, 10 Jul 2019 17:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OwT3Lf3NItDjTaqGPJDupUQTP+Om7Z7sHwzDg6SDKkQ=;
        b=z7TRV0yiJUFG43Gi5GjG/cy1jmmPc5sbDacRqAUZZZpg8C2cxvOl9HQvVBpadeoRxK
         uPX6gihi5hpiS0xkSL1mOUoLQnPrfxN0cNYp5P+svcjjxEO5k+xiSu0KMF7IbLJhD0au
         bcSjYBgwTJE/AhGmFyaCXVXE+uMRMqzYuiZC/UYyY8cOeg0TBUg5gOIPkl/IGgAIS5Ct
         2kUsBs15qrM/m+c/YmLZ8B3ZFGxbv78mxDIsET2mLx5VsNOdY2zyDkuBF0JcvyKaMVnB
         E03UMxzWkqsgThc7AhOnBEBApcj8jdaOVgBzjFDqntXxGCFtIJGBG+orQqs6GGn6qFUW
         MICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwT3Lf3NItDjTaqGPJDupUQTP+Om7Z7sHwzDg6SDKkQ=;
        b=kauY5hx+XBSpFQGhWNXjNM76ifkGCsfl9U2wrQSUHo0vTRBeFZ5br4BFNfPkVpFesy
         627pDwwnG6mvrn9wCOMaDoRZYeotMklcq/vNWWhoJQJ9HVT7NBOPotgxBy5z1Qz0yStS
         9bEM511mXUwAxS39QDpJ0JeUhal9204SyVW1IUDpIm7tInvJRmvXyXibpH8mCmvnhy2K
         yCMXuAHt4iKvOjIAeklPd5FFlBg8vxV5bkMIBVQycZEcXMe21BOjhf/omsr2+fhQ1ka5
         5Ure+iDHtlI6MDB8p68S856bOnRRzj0JjIf9Zq4qJ1CNCTapSo+hyxtGe/pgHSXgkavi
         NTdg==
X-Gm-Message-State: APjAAAU+OAfdwYxwhUAVPSShxwqfMAskwtWxQTDkEdt8faeU3IRjIPI7
        3fKx8e++ZOH1EpM0cnCJwZii7jezzJ4QnWr0Xf0oaQ==
X-Google-Smtp-Source: APXvYqxlFn0PdimNq79GJq+JMKjzDD6rlZH5l9bnmWUnRr2/mnkKl8jYNsjMz/De9iZM6fI+279VmJWhBR7rTtoOZXU=
X-Received: by 2002:a02:c646:: with SMTP id k6mr1016978jan.134.1562803339525;
 Wed, 10 Jul 2019 17:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq36jeva9e.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907102050100.46@tvgsbejvaqbjf.bet>
 <xmqq5zo9u36m.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq5zo9u36m.fsf@gitster-ct.c.googlers.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 10 Jul 2019 21:02:08 -0300
Message-ID: <CAHd-oW4-+XE_etXbDCvOX2Cdx1PcW-0oQWeq+jr=VPsf=EpgTg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2019, #02; Tue, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 10, 2019 at 3:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Hi Junio,
> >
> > On Tue, 9 Jul 2019, Junio C Hamano wrote:
> >
> >> * mt/dir-iterator-updates (2019-06-25) 10 commits
> >>  - clone: replace strcmp by fspathcmp
> >>  - clone: use dir-iterator to avoid explicit dir traversal
> >>  - clone: extract function from copy_or_link_directory
> >>  - clone: copy hidden paths at local clone
> >>  - dir-iterator: add flags parameter to dir_iterator_begin
> >>  - dir-iterator: refactor state machine model
> >>  - dir-iterator: use warning_errno when possible
> >>  - dir-iterator: add tests for dir-iterator API
> >>  - clone: better handle symlinked files at .git/objects/
> >>  - clone: test for our behavior on odd objects/* content
> >>
> >>  Adjust the dir-iterator API and apply it to the local clone
> >>  optimization codepath.
> >>
> >>  Is this ready for 'next'?
> >
> > I am afraid that still, just like I said in response to the previous
> > "What's cooking" mail, this is not ready (which is unsurprising, given
> > that it has not changed): it breaks 1,384 test cases.
>
> Let's kick it out of 'pu' for now to help ci runs on Windows, which
> would be swamped with failures from this.  Thanks for reminding me.

Sorry for the delay. I just sent v8[1] with Dscho's suggestions, which
should fix all those test failures on Windows.

Thanks,
Matheus

[1]: https://public-inbox.org/git/cover.1562801254.git.matheus.bernardino@usp.br/

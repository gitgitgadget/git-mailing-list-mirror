Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FC341F453
	for <e@80x24.org>; Wed,  6 Feb 2019 13:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbfBFNRh (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 08:17:37 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:39671 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfBFNRg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 08:17:36 -0500
Received: by mail-ed1-f45.google.com with SMTP id b14so5821528edt.6
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 05:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W4QIX1o+WRbDB8BGd1600afjdqozqqQacAMGgv/hBDo=;
        b=Yr05PVCa0417TJ5/EE3FMl8rWwr2DKL2iOwSHD0HhkaePgWMTkliQCXpVLW2YFQrZw
         nqWS5q+phIHx+itCuQWaHEGusfYW1141POslXeB4vzuNQAiz1oDgurF3h8CxunUA1/N4
         tJBsh0RD1MhLZOvzfxSoYs2iVfjiil7mkAcHUOVHYShQ0rke+jNhVnSWRuEkcb1g6/Wc
         ABk0RKQMye9vDxen5uEcCO/MYQnwpGLn9GJpCa31c2X36b0XgV5nyvnWHoZKejmo6br2
         oBgnGWmIay3or9RkhVt5Ggr+c3XYxf81XrF4Dt76FcG3JyKwkhd1gIk32gPFtnFgW2qh
         VHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4QIX1o+WRbDB8BGd1600afjdqozqqQacAMGgv/hBDo=;
        b=eS/CHK8PoHAqKZO5v8cTxNMuYel5NX+kh+n0vd5Hf0dfusrF1SDgg5vL1k9HLGgXLg
         zlrFwOGOghr2yeawqdu4khxaQTw9oOLh/laiNqkav2kwy47HW3ypwWba+VLGrviptj8W
         4RHL6Ibe4aESYQrSuxwSu74fHlnT+j1sPEwDHS1jyEfhJwc1d6xmoiPWRXZsckUCegq/
         aCZ/a6ak6XAzSudZzeL5qZov8g67H2ySfEzyrQoAyQkMFnxI1QIEfMkZFLuu+F3e1B1H
         rFxmxPWhF0yrIyttjOqBikwxcGUUzi0jrKtpcinPjpB5LD30wCSFJHYWQlbRDJIjdxOg
         RRWw==
X-Gm-Message-State: AHQUAuarSkPpsOI/IzRtO0Rx2hptcvVhU5QbmkFwTrhE9S+g5UzyuicP
        87jT0xf8LLaod6mnxPgJW+gOvTTQdYr0J8YiDmGC3TqtUOo=
X-Google-Smtp-Source: AHgI3IauDPK0MwxECb/LgWua51YAEmuZTO0Yu6DLNfxGZngARZJpBIGxLZiDEFljI9p5BTIjUisb0NaqJ2GnAQ3mfI4=
X-Received: by 2002:a50:94f4:: with SMTP id t49mr8318611eda.24.1549459054828;
 Wed, 06 Feb 2019 05:17:34 -0800 (PST)
MIME-Version: 1.0
References: <CAE5ih79DuU5Wrk4p+wpQX3j6bgyA2_ZgXYJX-tGvZpYhWazWqA@mail.gmail.com>
In-Reply-To: <CAE5ih79DuU5Wrk4p+wpQX3j6bgyA2_ZgXYJX-tGvZpYhWazWqA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 6 Feb 2019 14:17:23 +0100
Message-ID: <CAP8UFD3K47mfp_7gt2J19TZCXH4u4kf5D8McXd9ioguWb6umZQ@mail.gmail.com>
Subject: Re: could not freshen shared index ..../sharedindex.0000000000000000000000000000000000000000'
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 6, 2019 at 11:25 AM Luke Diamand <luke@diamand.org> wrote:
>
> I've recently started seeing a lot of this message when doing a rebase:
>
>    warning: could not freshen shared index
> '/home/ldiamand/git/dev_full/.git/worktrees/gcc8-take-2/sharedindex.0000000000000000000000000000000000000000'

Thanks for the report!

Have you tried to run the test suite with GIT_TEST_SPLIT_INDEX set to
"true" on your machine/environment?
Also does the rebase fail or otherwise misbehave?

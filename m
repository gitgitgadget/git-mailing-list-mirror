Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 793431F667
	for <e@80x24.org>; Sat, 19 Aug 2017 21:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbdHSVA6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 17:00:58 -0400
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34578 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbdHSVA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 17:00:57 -0400
Received: by mail-yw0-f179.google.com with SMTP id s143so75066996ywg.1
        for <git@vger.kernel.org>; Sat, 19 Aug 2017 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rB/msLrkHwV5g1ysNeXOsCju1+1yaaVOWWzY+AIWu40=;
        b=KzxHHpymadFlKUP0cE3K9vpf/8bVxXbJrD1QO6MXI8rz2cifJSM+GOm4h7+RX1yOBz
         P7w1fPo0cU6lfv1abEN1iUfTn6y8bxuLtmB9y/JHwR9VCUBMmQtHS116padWdgMZhEgU
         7VetzCc2MAhDPRB7n684i8K+4rRDc3xdmeHk3hAVyxV6p5nqq/ho6tLg24DjDR7pekND
         kP/csc8W9Pv5lCLyPQphPYy4ARDcapX/6Qg2fSfgxedTc2by1h0CwECadIeEPaY8qYju
         JA3pGjclP5xonlQUmrY37/qiWPnuat3guJgExuZfrzcGxyuyt+V/K/8cKi4/hxGsifNH
         WkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rB/msLrkHwV5g1ysNeXOsCju1+1yaaVOWWzY+AIWu40=;
        b=GjrlQILDzPoIbA1nXSigEWZY4TEM8Nzg8NrjYstD5qFFfhScUlgJzFJfOFkWzgfHC0
         kBwz+GfyA9HKZtraKaCxjeKCLx4Sx1NcBOB/gQLV7HbKrFRAZgpZCrjotvH8qRMIOUxx
         lrzRnW9Zavc+kldZkVQphzDjtpZPJof5xMB7gLLOt7IEUS/NiT7KwOzG7AfqqAQi1N8S
         Reo0tX5nEgTBRZeTCObG9HxGk9Ez2fYnktRoxNzNzMtecmoNLd6tjQl+4pOQZdQmKV7p
         YCi7CHILtD40y9VAO4orpT4VtLTtXcPlA1O6cFA6OYupiVHfAnIqyAtBwSBleNIkZaOE
         Dz9Q==
X-Gm-Message-State: AHYfb5gW6ar3U73RHEh/GmcSmfCRIS4C4WXwncQTEZWviFzms0p5Ghux
        //RJLi5SdOQtPAdMa5V0VuJ4LS4Yqg==
X-Received: by 10.37.183.208 with SMTP id u16mr11093415ybj.71.1503176457080;
 Sat, 19 Aug 2017 14:00:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.183.203 with HTTP; Sat, 19 Aug 2017 14:00:36 -0700 (PDT)
In-Reply-To: <xmqqpobr8ego.fsf@gitster.mtv.corp.google.com>
References: <20170819201326.6872-1-joel@teichroeb.net> <xmqqpobr8ego.fsf@gitster.mtv.corp.google.com>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Sat, 19 Aug 2017 14:00:36 -0700
X-Google-Sender-Auth: iQNjXLsgI0O_D7zetIkCn5qzbvA
Message-ID: <CA+CzEk98Tg_jyteZp7SGTchDNjP8FZFvHNXfvisg1XGgsT0vvg@mail.gmail.com>
Subject: Re: [PATCH 1/3] stash: add test for stash create with no files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

I was just too lazy to write a cover letter, and thought these would
make sense on their own. I'll make sure to include a cover letter next
time.

I just ripped them out of my patch series on implementing stash as a
builtin[1]. Since I haven't had time, I figured I could at least get
the additional tests I wrote into the codebase.

The tests mainly expand coverage of git stash, covering a few critical
error cases that didn't have tests.

[1] https://public-inbox.org/git/20170608005535.13080-1-joel@teichroeb.net/

On Sat, Aug 19, 2017 at 1:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I see three patches that add tests, but it is hard to judge them
> without any explanation on what the point of them are.
>
> Are you documenting an existing breakage?  Are you extending test
> coverage for some breakage we recently fixed without adding tests to
> ensure that the fix will stay unbroken?  Are you planning to touch
> the implementation (perhaps to add yet another feature that uses
> some existing code) and adding new tests in advance to avoid breaking
> the existing code?  Some other motivation?
>
> These would have made fine material to write in the cover letter for
> this series.
>
> Thanks.

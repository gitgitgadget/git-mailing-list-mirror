Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B925A201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 16:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbdF3QEw (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 12:04:52 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35362 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdF3QEv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 12:04:51 -0400
Received: by mail-pg0-f47.google.com with SMTP id j186so65690325pge.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8I35M6iTxjXhDTsLhKt209R0sHHPDtQ5RK3FzALA+Ac=;
        b=thL0UA/fPggNbOgbqzR6CnJev42B24iFGHGCaBd/XDocCnquZCRTQF1/ZUo2bH9ji5
         eucLQFUKTyZXTKEbRDh/Tcbcu4uFFFHMWBd9GpaACvcW/PB/4CI0tCUmAD9Q/VJ8B+03
         LS6lSvET/vDlziASUdessfaSAztQqijHbK81SZ8yuHi33ze7yM75C3a/Cj9UVi1AWomh
         jZymKOAHmYwDFLN1jNZG4FbYASkWwkwyvoPzENW7GyiEoeSlKXz2HLbkOuB3fDDeepbl
         +x4OoPGpDVvXZnmzNftEhxcP6pFwC0nK//sjn4dz3LuwHFWEVRyrjIBR53CMeerqMBfD
         G8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8I35M6iTxjXhDTsLhKt209R0sHHPDtQ5RK3FzALA+Ac=;
        b=Ds9wIvjEZscjHwKM8CfW9NBqhtqa5puTIKzMyU1zMbBgz0a7u2TkjZBG2MHsa+eXaR
         I1eBhPF9oOHDV8ujAcR5LGyZBB+rDIydPlF53xcbLKmBc7UwSwy2nClkV3/PaeqnZylw
         TeYfeeHmnENZB5aFK9gh0TGOkc2tDiCT91KJpDpNGl5+DgKu2NPgojv1qvKGuYSxffFN
         CH44+tHKgWnJ5ND/ZxPQ3hJBrFy1MWzu0WYS1zrPd6aR4WK1c7oijG64CmkkBGN2W8qh
         Nrt/Ri06SjTQza5opwaXVbL2y5Uazkak75qtFVZtTVd7nGfXvIVDsbxvRnuni+4RUFNS
         Ozgg==
X-Gm-Message-State: AKS2vOzWUKYODCAtU9FZQ4brKWxUP7UdRwb+RjoAz0JLpbv1+nOPSuTw
        Y8tmVuueBj1r5Yv/LaChm8TCFZSxjg5x
X-Received: by 10.84.217.138 with SMTP id p10mr24975194pli.66.1498838691133;
 Fri, 30 Jun 2017 09:04:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Fri, 30 Jun 2017 09:04:50 -0700 (PDT)
In-Reply-To: <20170630072611.q733inuxdvjmhjgw@ruderich.org>
References: <20170630000710.10601-1-sbeller@google.com> <20170630000710.10601-26-sbeller@google.com>
 <20170630072611.q733inuxdvjmhjgw@ruderich.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 30 Jun 2017 09:04:50 -0700
Message-ID: <CAGZ79kYONNMrB7L65WjwZjSuKOf3rAOWPwjb1bH26MU0owTJ4w@mail.gmail.com>
Subject: Re: [PATCH 25/25] diff: document the new --color-moved setting
To:     Simon Ruderich <simon@ruderich.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 12:26 AM, Simon Ruderich <simon@ruderich.org> wrote:
> On Thu, Jun 29, 2017 at 05:07:10PM -0700, Stefan Beller wrote:
>> +     Small blocks of 3 moved lines or fewer are skipped.
>
> If I read the commit messages correctly, this "skipping" process
> applies to the move detection in general for those smaller blocks
> and therefore doesn't mean a malicious move can hide smaller
> changes, correct? If so, I find this sentence misleading. Maybe
> something like:
>
>     Small blocks of 3 moved lines or fewer are excluded from move
>     detection and colored as regular diff.

Well, this reads as if "blocks of 3 lines" are excluded, but what I
mean is "if all adjacent blocks combined are 3 lines or fewer"

Example of how I understand the code:

    context
  + moved line, block A
  + moved line, block A
  + moved line, block B
  + moved line, block A
  + moved line, block A
    context

These five lines are colored, because 5>3, but each
individual block is smaller than 3 lines. However we
already want to tell the reviewer that the middle line is not part of
a contiguous 5 line block, so we have to use alternative color
in the middle.

However

    context
  + moved line, block A or B
  + moved line, block A or B
    context

is omitted, because the number of lines
here is fewer than 3 ignoring the block
type.

Maybe

  If there are fewer than 3 adjacent lines of
  moved code, they are skipped.

Thanks,
Stefan

>
> Regards
> Simon
> --
> + privacy is necessary
> + using gnupg http://gnupg.org
> + public key id: 0x92FEFDB7E44C32F9

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5A801F667
	for <e@80x24.org>; Tue, 22 Aug 2017 21:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbdHVV5e (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 17:57:34 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33771 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbdHVV5c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 17:57:32 -0400
Received: by mail-yw0-f175.google.com with SMTP id h127so180368ywf.0
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 14:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kxXFBZjkt3GPLPwB4IJUXbGFfU00d5ia78IFH4LXa6M=;
        b=rxdtcGiyVj/I6CYQvFjtoqNzlcSwVNtgEpGBV7QqDEA6Vw0W9u/GbT7zwZtFQYkatf
         Rt0/t7f4kO1FpVdTI8kPddn8lGKjk45y51qpKP2DzLs/mYSMUQQ2WSkxxdcfEvg/GNwV
         0KkGXZAoLLrI+CpwnrK80hxcfHPZtoWdjY0YyOqAk07MMRxDLT3imn/Xwixz9zzrFszq
         BrwkId3ZnyklsrBMjMhtShvCzeSeZ0yli0semipxsUIcYTxocQ2LJ2mxEddG+EVOq/05
         ODY7Gfk/I9m4ied8uIcZFxX6AIWaymvQEcnDlkKsBhxsRBX4pmVUgm6eyYWIfDZZieJt
         5n1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kxXFBZjkt3GPLPwB4IJUXbGFfU00d5ia78IFH4LXa6M=;
        b=NpeZHQNYwQna+v5hmjDkHD0yi8xjADJsUqePodZj5Mpi13y2VooLzmsQA18Wb4XWJb
         VW6qdzYXbO/qrFZXgST7qAXEW3nRxFQpUD5cphi8Lg8mU/HliQheU8DyzATUQa3TMpqX
         Mj8sc4WNvLLD8YidsKbuiZaMjar9VcMrb78crI/MEkBUshWVGtBindI13/6WbPYNRlqd
         HlTPqc4VvXbRaXxd7XhYXcVtZ4eNyIZmWdEievSXVvX5uHbonsYjHC10HDr+MEtX4RNF
         s4S4fLHjLRepx1Qx+ym5Gbhfixatjdd5Wrz5vgTZKyhWSEiNo5lyPH/AT3DmYCRTNn9v
         BMCA==
X-Gm-Message-State: AHYfb5i6fC/i1nETA6LPqYgvpe+zx1iGHfKRgUgwpPYJoZXPew6SPJeJ
        XxAUQZFexPPz/K7cWLC4xXywXokMY7oC
X-Received: by 10.37.7.6 with SMTP id 6mr483718ybh.215.1503439052150; Tue, 22
 Aug 2017 14:57:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.170.41 with HTTP; Tue, 22 Aug 2017 14:57:31 -0700 (PDT)
In-Reply-To: <CAH8yC8=A0-geqduTNNJw0yb1BREqsB75_bKSp+06Rb5fY6oiuQ@mail.gmail.com>
References: <CAH8yC8=A0-geqduTNNJw0yb1BREqsB75_bKSp+06Rb5fY6oiuQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 Aug 2017 14:57:31 -0700
Message-ID: <CAGZ79kYyO4zvmTvMpxpFyBEs4f=xoy_-UeSbmi9W-OCFz0kCwQ@mail.gmail.com>
Subject: Re: How to force a push to succeed?
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 2:55 PM, Jeffrey Walton <noloader@gmail.com> wrote:
> I tested some changes that lead to a dead end. The changes need to be
> removed. The changes were added in 7 commits.
>
> I went back in time to the point before the changes:
>
>     $ git reset --hard HEAD~7
>     HEAD is now at 559fc3b Fix benchmark selection code (GH #464)
>
> When I attempted to push:
>
>     $ git push
>     Username for 'https://github.com': noloader
>     To https://github.com/noloader/cryptopp.git
>      ! [rejected]        master -> master (non-fast-forward)
>
> I tried to commit, but Git claims there's nothing to add:
>
>     $ git commit
>     On branch master
>     Your branch is behind 'origin/master' by 7 commits, and can be
> fast-forwarded.
>
> Commit seems to be the wrong command as Git appears to be trying to do
> something I don't want.
>
> How do I force the push to succeed?
>
> Thanks in advance.

Checkout the --force[-with-lease] argument.

https://git-scm.com/docs/git-push

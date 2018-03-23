Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45D151F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeCWVeo (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:34:44 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42300 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752066AbeCWVen (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:34:43 -0400
Received: by mail-lf0-f65.google.com with SMTP id a22-v6so20273968lfg.9
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mDUZDJX0Ny6DVWUj7YAi6XLn+TqEQgo/LZ65Vg8plNA=;
        b=MZdtVESzEUS387BL1JnT3GzG2hHrNmUZkLrJFeEmvHpZ+S6tozZ0BTLhFgzOHcFV1A
         RsXdDX9NGbcie5RoZZwQxa4mr7bSgagnMxOSZjMI8Ppl/Awru4Op+3KLu6EBZ9LnL+z5
         9xftqJ+kbzgatdV5qkG+cakLV63dy4S16hcPj1YsO3G4hSpmJMtc1AVaKZoDPl/EMi/d
         ANLJ8EdCHFsq2hpUQ47DljZneHppboO/7ZrAEDjcOe0W0onT+qTonhrum4ScxqkuL0a3
         21YFsUW6rO0bk+LyhY/C68JfyP0ifvYuEAAM8mG6Ipj4gCkOB/ZiR7/al2gAtYtD0V7z
         pFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mDUZDJX0Ny6DVWUj7YAi6XLn+TqEQgo/LZ65Vg8plNA=;
        b=N6Dgnmcclq3hTJHzOFj+udlwrEeb69fLULQrSLhZAMk5aFM/lUyoOlyU4nu2UaDGG1
         I7ZxkDyYclD538JaJGBeqLVcE7iP08P+iv3scvPcQOf23SbsKQsYKMejU7kSItKXBBLn
         FvBkJUAHBMSnUKGKWB2BYywHEClSiE1oD5FRCi/VEz/cUZdyUy9rO0oe2OEgVLLhaXTU
         wbshF4EkzTs61Rkr1HQJFu2TL66swy5hdoQiIYbh3mSzIsvNwmNxOdHpNsHQHo4a4Wn5
         Qdji6Fod9nRZj2sno8LG5Wu+zZWwbJYVF+D083AzN15yE2Q0/84KVpgYpNrjuQ81A89R
         +OSA==
X-Gm-Message-State: AElRT7GndPvfmiFcTIZxHdDGNIOquz+sRU2Xj3JLHDhIWkC4l1H6AA2R
        64ZGHIPhiykQJDxKRDTqvYYPXw6RqstY/RcbRzKITvrp
X-Google-Smtp-Source: AG47ELuuwaz7bl21kimBVuhFSK6nJNP7vCojN3wa1ReKqMNJ9KjQmL/VLgcqL5lesL4pU9aykQw/tMupqPtTQ22+Qb0=
X-Received: by 10.46.127.30 with SMTP id a30mr5845114ljd.93.1521840881393;
 Fri, 23 Mar 2018 14:34:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Fri, 23 Mar 2018 14:34:20
 -0700 (PDT)
In-Reply-To: <cover.1521839546.git.wink@saville.com>
References: <cover.1521779249.git.wink@saville.com> <cover.1521839546.git.wink@saville.com>
From:   Wink Saville <wink@saville.com>
Date:   Fri, 23 Mar 2018 14:34:20 -0700
Message-ID: <CAKk8isqj3OusAE8OJtcys0a-Yj9fgQNn=DtLe-ZGYNzcKp=-3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/8] rebase-interactive
To:     Git List <git@vger.kernel.org>
Cc:     Wink Saville <wink@saville.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 23, 2018 at 2:25 PM, Wink Saville <wink@saville.com> wrote:
> Reworked patch 1 so that all of the backend scriptlets
> used by git-rebase use a normal function style invocation.
>
> Merged the previous patch 2 and 3 have been squashed which
> provides reviewers a little easier time to detect any changes
> during extraction of the functions.
>
> Wink Saville (8):
>   rebase-interactive: simplify pick_on_preserving_merges
>   rebase: update invocation of rebase dot-sourced scripts
>   Indent function git_rebase__interactive
>   Extract functions out of git_rebase__interactive
>   Add and use git_rebase__interactive__preserve_merges
>   Remove unused code paths from git_rebase__interactive
>   Remove unused code paths from git_rebase__interactive__preserve_merges
>   Remove merges_option and a blank line
>
>  git-rebase--am.sh          |  11 --
>  git-rebase--interactive.sh | 407 ++++++++++++++++++++++++---------------------
>  git-rebase--merge.sh       |  11 --
>  git-rebase.sh              |   1 +
>  4 files changed, 216 insertions(+), 214 deletions(-)
>
> --
> 2.16.2
>

Argh, I misspelled Junio's email address, so when you reply-all try
to remember to remove "gister@pobox.com" from the cc: list.

Sorry,
Wink

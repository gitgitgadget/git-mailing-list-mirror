Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFDF8209B8
	for <e@80x24.org>; Mon, 11 Sep 2017 18:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751026AbdIKS71 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 14:59:27 -0400
Received: from mail-qk0-f174.google.com ([209.85.220.174]:38794 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdIKS70 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 14:59:26 -0400
Received: by mail-qk0-f174.google.com with SMTP id a128so20601504qkc.5
        for <git@vger.kernel.org>; Mon, 11 Sep 2017 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=koCeoCKGrlxyaek+1XVk6kH6KiLrHNLU6i/+YNdcZ/w=;
        b=DzDklDBcNfbGtSLrBuMCI27HuEmgocett1FeKFXq5SSFYMQQjXh/KtYT5UVsUCaii8
         IzqbZvh4uto4RxrJ9A2wRAU2h3vsRZPRczHdas7cUqrv503rVZZ9A/v/ON06hA8X3HDg
         5zKQg6rnwEN0Qt+hNDA9SkxvlhH70r1G/YGphH5c8u8au92gMYFmFsAcWR05shljHPnv
         xqYPaUgKL/K39QM3W6MfdQzOZOhtIhFXiw294i9YKAZqaNM1qhskwQiTmHB4UYwHfz3j
         j2zgR7cVBpY93h/L95nD5yheyFJJ2QgyL/vzLE2oMwurjMFysPdNkmTr+jYHIaqDu3Nv
         uDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=koCeoCKGrlxyaek+1XVk6kH6KiLrHNLU6i/+YNdcZ/w=;
        b=VVfmcQ4icASw1kad5OUk/seyHjRLEm2EZqzLKhJHe3Kb0J7tLnLCw+TYWi70mQ7GiU
         oLiYnr6OJrvIDHbQP1hcg+0s+A78US5CcQiu4gMQVvJlYLEWlsblayB2ngmPS7xDxboU
         cIlHWhWtnxjMK9BsHlrk617KPX+yVzqVIzW5XP/rKIu8G360TpPwbyFAkYTVXQmuyShr
         U4SJBmmoWTCv49qP+GymwroprPIw/bYwU1TLqoa82M2zakC7Jypqb6yfDdBLsFuKjwc2
         bvOn6sRwnk0PKepp9y4lD+2SEkpgMXQ43Rq7puQLTWEavnZtvyU8ZdvFZp74vghma+f5
         Ml5g==
X-Gm-Message-State: AHPjjUgt9eRBy0PJMD+edtsn6vO21JiErEApJ4JGennPb2cwvQ72HoiL
        JV6JQH6R7HW4XyFnjFmS5mT0fOQhPIehMIY=
X-Google-Smtp-Source: AOwi7QBOdN5+U2AEX0YrtxUHI2OFSAXt4iQT5g7t/oCLoAjcu5jX6BYRzLlw21ds9jO9S3Z8xMuTxGGJWbiJpAlRU6s=
X-Received: by 10.55.66.22 with SMTP id p22mr6277277qka.78.1505156365331; Mon,
 11 Sep 2017 11:59:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.49.212 with HTTP; Mon, 11 Sep 2017 11:59:24 -0700 (PDT)
In-Reply-To: <CAJr1M6eS0jY22=0nvV41uDybcHUdjBv8CgRhHmBNFM=Z0J9YCA@mail.gmail.com>
References: <CAJr1M6eS0jY22=0nvV41uDybcHUdjBv8CgRhHmBNFM=Z0J9YCA@mail.gmail.com>
From:   Allen Li <vianchielfaura@gmail.com>
Date:   Mon, 11 Sep 2017 11:59:24 -0700
Message-ID: <CAJr1M6eXDiAEmaen+w5PCBLpSL1+=6RmyA=zgHuKV=aYbrRcdg@mail.gmail.com>
Subject: Re: --work-tree does not work for git-stash
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 11, 2017 at 11:32 AM, Allen Li <vianchielfaura@gmail.com> wrote:
> $ git --version
> git version 2.14.1.581
>
> This does not work:
>
> $ git --git-dir ~/foo/.git --work-tree ~/foo stash create
> fatal: /usr/lib/git-core/git-stash cannot be used without a working tree.
>
> This does:
>
> $ git --git-dir ~/foo/.git --work-tree ~/foo -C ~/foo stash create
>
> I found a description of the bug here:
>
> https://stackoverflow.com/a/5863555

I think that this bug may be quite serious.

If you were to run:

$ git --git-dir ~/tmp/.git stash

This will actually stash using your current directory as the worktree,
which could potentially screw up things quite seriously.  In my case,
I had an unstaged file at ~/tmp/tmp, so Git decided to remove the
entire ~/tmp directory as my current directory was ~ and I have a git
repo in ~ for my dotfiles.

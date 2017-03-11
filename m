Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15FEA201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 19:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754391AbdCKTaY (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 14:30:24 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:36946 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbdCKTaW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 14:30:22 -0500
Received: by mail-it0-f44.google.com with SMTP id g138so13242086itb.0
        for <git@vger.kernel.org>; Sat, 11 Mar 2017 11:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EjqLT56jax9bZXhevyA17H6DtSSGV9zMaE/qTCEhmVE=;
        b=pDwL7IPOmpz9NZKSa9vRMH+31I7wVQBnjcFgQukigpqfe5+tIszGy/7aOt0nupTdOr
         GqsP2BqvhEMkJe4jrSUhcssKN1BYRgnEkTu0RtZ4tV5UZ4atnxH0gyOMahxbIqXkBGHR
         dINKD8k3c5AxD1OBRQjGhtdsnpXRmD/fuTvojytcd1L+jbQcLgmQ4kO6j1QdDMjM34mO
         FgB7qDD62kHOwm/I4EZMy5EQxJcHFlzva13ISOLV3pSxyVY5d87esBFqYmP8OXHUvTyd
         xr32ZC0vw6A4sqHlmW+gxBYcLytMgHTtVk3PTxEW3ranXlWQKWlTCdezV5ZVVUYiKJ4g
         0jGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EjqLT56jax9bZXhevyA17H6DtSSGV9zMaE/qTCEhmVE=;
        b=sHGAhk1xC1awo8TnU19pQo6U/vZd+pLiZrLhoNks8iatjLCNVaSfa119+FRcQoGjKJ
         9A5ISdjlyz3hEjmJahrlfguh5/M7xGYjoOYmZlHSlYOefIKaOrQUKe2qUtCo1SmwQsik
         BlnDGU6SYRbG9pSXcoDD9b1/G5zZ2dpjabYk3RnkOlWBG4FYcXSuay51rkW/R+OELxul
         VLcOyddSn+9mlmHjgP6malywh6Oi/JTh5ZQNQ3MGnfrY3ph8+zWfC9RVD7GWT4YTEG8h
         LyF689DImlrGZrzTOopsOSFawY8PlHfCoSirCrCk/F5ahwCGNHbyHNM/HT+6B8ga7a0g
         SveQ==
X-Gm-Message-State: AFeK/H38bKoxpvZEKagqP2mNK9eFbS3eQjKTVM2iu7b3ShVvvxWuXP80e4h9fSzpfYCAcF1AIPFuXnoeSt+9VQ==
X-Received: by 10.36.37.145 with SMTP id g139mr4764321itg.24.1489260621159;
 Sat, 11 Mar 2017 11:30:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 11 Mar 2017 11:30:00 -0800 (PST)
In-Reply-To: <6962041489243945@web20g.yandex.ru>
References: <6962041489243945@web20g.yandex.ru>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 11 Mar 2017 20:30:00 +0100
Message-ID: <CACBZZX5g95nTtA5--g8K29FjQ=dU3JLEfVXZjUs8J2Y-QCzYHg@mail.gmail.com>
Subject: Re: How to view diff when doing `git push --force`
To:     KES <kes-kes@yandex.ru>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 11, 2017 at 3:52 PM, KES <kes-kes@yandex.ru> wrote:
> Hi. I have done `git push --force` but I forget to `pull`,
>
> Counting objects: 7, done.
> Delta compression using up to 4 threads.
> Compressing objects: 100% (7/7), done.
> Writing objects: 100% (7/7), 765 bytes | 0 bytes/s, done.
> Total 7 (delta 6), reused 0 (delta 0)
> To xxxgit:cry/cry.git
>  + 48e9058...117ee39 staging -> staging (forced update)
>
> But I can not view diff:
>
> git show 48e9058...117ee39
> fatal: ambiguous argument '48e9058...117ee39': unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions, like this:
> 'git <command> [<revision>...] -- [<file>...]'
>
> May I pull info about changes that was deleted?

At this point, no, but in the future instead of --force use
--force-with-lease=<refname>:<expect> where <expect> is e.g. $(git
rev-parse HEAD).

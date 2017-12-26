Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C6331F424
	for <e@80x24.org>; Tue, 26 Dec 2017 10:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750928AbdLZKrv (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 05:47:51 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:42509 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdLZKru (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 05:47:50 -0500
Received: by mail-oi0-f45.google.com with SMTP id o64so23512482oia.9
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 02:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iBmWJnnR1yR3KYx5n9NrCp8uawqFnb0yO5M2URc6P/c=;
        b=jP15lXbEgmBbBhUTJjc27k5oRoqxthnbOXfFCAy+aor+u4VoU1vurZJXTb3oHtbGm0
         XV3Oae8+LRxkxT2/uVCkDeiRullCkb7B+pZFk6w0d0DQXC7aPnFRTHrN34JO7hyG6fSL
         kBYeGYq+1SX5Dxp9VQh8CcJAZJLHTgudYYDzgCMYVZ/rh8WPvLQMBSWe+cNKGNP3+0sK
         u9YTxWHCnM5TMscSKI+q/G/zLllZ/KwuBIubI63KKAq98pbQqJ+TTLjv7njk4BoENn94
         K5yHsyFHa8zBgoq3YEJRnF8V38O1EU0bsy5swePeopqSPOvxJik0SIB83HTIVGD+9WzC
         x+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iBmWJnnR1yR3KYx5n9NrCp8uawqFnb0yO5M2URc6P/c=;
        b=PhVqibH1P4OsKIpOZh86l9PQ+Dkpr+AoeDBF4aSZ9p+wb67QPkvdjKRY5vumKDelRw
         aPLRuMCBMQF4AYNIZJdIiw1qHJWdainBk7FgpZ82ypaiVHEXusztTy70gQ1YU14LhNbd
         ESfdeOiNo5++pOvV9nrnRQrUtmafM+XmN6hsqbVWOAMkZHwdWpE6afMZBeACjxypydFQ
         jgkimMdcIvjFPvLb8ZozApG6cNRyJRr4t2uWBlO7i2ilTJ8ORqyNPkn1gEERPx2Pn6gr
         IJXQd3fhhMoTDarxU3GqPPyZgGkicvHQz5oGEZh3o9zXhB5XVwdbx7hPqk/x2OwPdttY
         9pwA==
X-Gm-Message-State: AKGB3mJl/6r/xqRuFREHiunljYF0QoIVTYnBGyjp/jL0JZJpuqTmcXxW
        Va/uC9XtzCuET1zC79Zn5IWsH40VTCk5Z3cnN0w=
X-Google-Smtp-Source: ACJfBosoq3alnnD+28Fs99PPh8ntvk1rEFda/JUC03BykZXQMYxFX8pRYUkpJUSQYaPIsPzLtZ7o9LFWMYuUuCJjG1E=
X-Received: by 10.202.208.147 with SMTP id j19mr18829267oiy.268.1514285269531;
 Tue, 26 Dec 2017 02:47:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Tue, 26 Dec 2017 02:47:19 -0800 (PST)
In-Reply-To: <87wp1ar6j1.fsf@evledraar.gmail.com>
References: <20171222140032.21180-1-avarab@gmail.com> <CACsJy8B1FNpq-AYJdcs_gVOxdPSnh-kNaeVykLSSDL1+EW9YjA@mail.gmail.com>
 <87wp1ar6j1.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Dec 2017 17:47:19 +0700
Message-ID: <CACsJy8AmbKSp0mDLRaDCWn45veeNc03B-Gq8r8PQPrDt9bM_EA@mail.gmail.com>
Subject: Re: [PATCH] status: add a failing test showing a core.untrackedCache bug
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 26, 2017 at 1:45 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Dec 25 2017, Duy Nguyen jotted:
>
>> On Fri, Dec 22, 2017 at 9:00 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
>> <avarab@gmail.com> wrote:
>>> The untracked cache gets confused when a directory is swapped out for
>>> a symlink to another directory. Whatever files are inside the target
>>> of the symlink will be incorrectly shown as untracked. This issue does
>>> not happen if the symlink links to another file, only if it links to
>>> another directory.
>>
>> Sounds about right (I completely forgot about dir symlinks). Since
>> I've been away for some time and have not caught up (probably cannot)
>> with the mailing list yet, is anyone working on this? It may be
>> easiest to just detect symlinksand disable  the cache for now.
>
> I haven't yet, I wanted to see what you had to say about it,
> i.e. whether it was a "do'h here's a fix" or if it was more involved
> than that.

OK I have more time to actually read your test and play with it (last
time I stopped at the word "symlink").

First thing out of the way first, I think the stat() call in
valid_cached_dir() is wrong. We don't want to automatically follow a
symlink, we want stat of the symlink itself.

OK back to the test. If you insert test-dump-untracked-cached around
the "git checkout master" line, then we get the data that the
next/faulty git status uses. For me it shows this


...
/ 0000000000000000000000000000000000000000 recurse
/one/ 0000000000000000000000000000000000000000 recurse valid
/two/ 0000000000000000000000000000000000000000 recurse valid

OK so we have two uptodate cached dirs for "one" and "two". Strangely,
root dir is not cached (no valid flag). I don't know why but that's ok
we'll roll with it. It means we will ignore "/" content and do the
opendir() and readdir() dance instead.

This is where it gets fun, when readdir() returns "one", we hit this
code in treat_one_path() and correctly ignores it

    /* Always exclude indexed files */
    if (dtype !=3D DT_DIR && has_path_in_index)
        return path_none;

and we do _nothing_ towards the cached version of "one". In constrast,
when readdir() returns "two" we are able to get further and invalidate
it, deleting the cached data.

After the readdir() dance is complete, dir.c is confident that it has
all the good data in the world in its cache and notes down "from now
on uses the cached data for /". Another test-dump-... after the
second-to-last git-status can show this "valid" flag. Unfortunately
the "one" dir is NOT invalidated.

So the last git-status sees that cached "/" is good, it skips
opendir() and goes with the cached directories which are "two" and the
bad "one". In short, we fail to invalidate bad data in some case.

An invalidate_directory() call before the "return path_none" above
might be the solution...
--=20
Duy

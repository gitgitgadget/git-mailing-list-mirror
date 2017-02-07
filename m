Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C9C51FAFC
	for <e@80x24.org>; Tue,  7 Feb 2017 00:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbdBGApc (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 19:45:32 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:36807 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751395AbdBGApb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 19:45:31 -0500
Received: by mail-qk0-f173.google.com with SMTP id 11so73298457qkl.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 16:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=rJ3FFHvS/Xhs2fIGWIJUxhxBC8iX3KhpXHXuKBN+ow4=;
        b=M2dugvUpcgRVsGhoAF/G11UlGx/cQHXXoO9+BowKAVpiCOzhqNZJZl+iJZxhV1v7qQ
         j81KIn0YmVh7/y7/zYVrwpA91RNd+XiDk8x0dlMN8AKQFATc3Ls/dXF++4HidnAYnrkf
         F+DdtnAUOt4iRjtlkY+VyXAvzmyRI5ciF82KAG2axvHZ8vxjHL1HE+/PKjBTfZcc05j1
         FxJ8vYVYSPK+8UeVfJX34rmtYtBxrnJm2dHX/s5e1W+ztyK0uWzhdLZoT1lZvtIxS7bR
         zkVlhku7BMk6uKx/HKW4mOMbdqnPWKPjK+MUzgw1llyRdM2JLlDjSn8Ak4yspgKt6aDl
         lClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=rJ3FFHvS/Xhs2fIGWIJUxhxBC8iX3KhpXHXuKBN+ow4=;
        b=sFFOnnjAVNpmpdLxC2VwADQngE5Zc2waaUEM/M0ee5UX5n/LmC7Fm7sVnsefjdQ82n
         ic/Vz2TlBxUxiO94bY32VYtM49gt6nCz2qf4CgMrvMR/P7CayGSs68yMtbXS57Bxn47l
         TU059Jl8DTsM5ul+MvxFOHjQ/7KM+w6wcCRxcWb/n5eTVmnbHUHhtWU3/IwbpKePruE2
         HsexBKpYHnNafB9YdNEuNQp/rwCjOsKf1xK6aypKndtdRlEEt6DDdqHn+699lu5P1lY7
         ORCpGra0qMdB3EmGn2FylWdORg/ErN8ZXWz3Qwq080t5IjupBW9LV5J0AgXr7NKuA6gL
         kFXw==
X-Gm-Message-State: AMke39ntX0hSL5Wclz/eoOxOuURaAkwjl9AzP0QiOafczqIeAc74WPLnHcRYrSESLe9H1umlG244KnYQoilKMA==
X-Received: by 10.55.47.4 with SMTP id v4mr11876659qkh.77.1486428330577; Mon,
 06 Feb 2017 16:45:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.162.6 with HTTP; Mon, 6 Feb 2017 16:45:10 -0800 (PST)
In-Reply-To: <CANOj2JG5VuDtS30PfOrZ=4q8pTv_frY7=p+0g=UW3yV6ev+1KQ@mail.gmail.com>
References: <CANOj2JG5VuDtS30PfOrZ=4q8pTv_frY7=p+0g=UW3yV6ev+1KQ@mail.gmail.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Mon, 6 Feb 2017 16:45:10 -0800
Message-ID: <CABURp0qbKMfngfsC5pQeO+qyRPxa21vi090hMWDtLd+BBH_3Jg@mail.gmail.com>
Subject: Re: Request re git status
To:     Ron Pero <rpero@magnadev.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 6, 2017 at 3:36 PM Ron Pero <rpero@magnadev.com> wrote:
> I almost got bit by git: I knew there were changes on the remote
> server, but git status said I was uptodate with the remote.
>

Do you mean you almost pushed some changed history with "--force"
which would have lost others' changes?  Use of this option is
discouraged on shared branches for this very reason.  But if you do
use it, the remote will tell you the hash of the old branch so you can
undo the damage.

But if you did not use --force, then you were not in danger of being
bit.  Git would have prevented the push in that case.


> Why ... not design it to [optionally] DO a fetch and THEN declare
> whether it is up to date?

It's because `git status` does not talk to the remote server, by
design.  The only Git commands that do talk to the remote are push,
pull and fetch.  All the rest work off-line and they do so
consistently.

Imagine `git status` did what you requested; that is, it first did a
fetch and then reported the status.  Suppose someone pushed a commit
to the remote immediately after your fetch completed.  Now git will
still report "up to date" but it will be wrong as soon as the remote
finishes adding the new push.  Yet the "up to date" message will
remain on your console, lying to you.  If you leave and come back in
two days, the message will remain there even if it is no longer
correct.

So you should accept that `git status` tells you the status with
respect to your most recent fetch, and that you are responsible for
the timing of the most recent fetch.  To have git try to do otherwise
would be misleading.

> Or change the message to tell what it really
> did, e.g. "Your branch was up-to-date with 'origin/master' when last
> checked at {timestamp}"? Or even just say, "Do a fetch to find out
> whether your branch is up to date"?

These are reasonable suggestions, but i don't think the extra wording
adds anything for most users.  Adding a timestamp seems generally
useful, but it could get us into other trouble since we have to depend
on outside sources for timestamps.  :-\

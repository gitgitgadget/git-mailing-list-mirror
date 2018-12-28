Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9216A1F45B
	for <e@80x24.org>; Fri, 28 Dec 2018 18:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbeL1SXy (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 13:23:54 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:42108 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbeL1SXy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 13:23:54 -0500
Received: by mail-vs1-f43.google.com with SMTP id b74so13409668vsd.9
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 10:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4KJZpVtZDFKdqmu8VmIwB6bN1KukqmvJxJKGoY9Gsr8=;
        b=NRNmipPrBNntSILqYjkQ5TECyz2uolEoxF6nLYZl9vYp4TGvSyxhPWDVjKwV7YQHDn
         7LaUSRSnmt30dWzMyw4W7GUcp2e3bCW9Qf/TJ6IE5pbTFh0SgkzFQIH3bFTSw3DV1icu
         KDw/FaV7/gY1kV5DWBfNsgEHZo/fiVY5m2NkXkXQrT8pi/PRONJBxv/M6fzHmrCYXIDW
         UAJkatsAprgGwaphfZhFw/d9MeJCtKYYYB0iS+WoK2vt7VnRQGt23lz1V5tn0Ez32Q7G
         v+nUBgQ5hFljmHvpXvu7ZjZhhj6cLLx4PLIrUMN79nepyzgzpXpjMZDcU8VHqMl14zyB
         2D5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4KJZpVtZDFKdqmu8VmIwB6bN1KukqmvJxJKGoY9Gsr8=;
        b=HX+X2dRIrgsf0ZhH1NLefouZedUezXDSKodGjF0pCn7zyDh1rXQotM9kmWLXkHPzwo
         eNuYiXeoEnG4TSR1XiqoTB8a62o4/1D1PShdC9/5q7uVh5wQ/E3aa5Mw7QLuwraIoZpx
         zLWRu3EGwyjMUpRrzFhUmW53LZlSJNEwUFaSALvxVRYlCbvLliH867HY/w/hoP456hJM
         Q7GJXfT0ZMzveoHb6YHCjcsBlYL1vmzQOLF8/FKx1/4mGlUvW4lUMoUOD69ILVH1FuwM
         SNU1x03nUfhtv8rU/4HjiWh6JKvlDm+m6nDcdiFJxdCbgss8v/BYi2Le9oG5X+BKxdj/
         97Zg==
X-Gm-Message-State: AJcUukfqfr1n0DCv/KxEJ3S+dPBv+ralDslbexwLwuQ5oz/p2p6fEPrg
        bLzLxetkX5j7py18Yo1DYPh7H97TVMaIrkfXzPI=
X-Google-Smtp-Source: AFSGD/VTlWx0R3YiKAU9819qlPWcVxA1HKi1B24/3ze/43zZXLZMkHip8EXv4UIZwcum5ovX/XFyLNem3EQqRfFVSnM=
X-Received: by 2002:a67:3e12:: with SMTP id l18mr11765753vsa.53.1546021432797;
 Fri, 28 Dec 2018 10:23:52 -0800 (PST)
MIME-Version: 1.0
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 Dec 2018 10:23:48 -0800
Message-ID: <CABPp-BEd5-0Vcv8YApUxo0jK_ofxCORSG5H0wU=kiR2aOY1ztQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Dec 2018, #02; Fri, 28)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 28, 2018 at 10:04 AM Junio C Hamano <gitster@pobox.com> wrote:
> Sorry for being slow to recover from the year-end slowness; the 2.20
> release being rather large-ish and needed brown-paper-bag fixes soon
> after it, my temporary trans-pacific migration, or me catching cold
> that I haven't shaken off, did not help X-<.

I hope you feel better soon.

> * en/rebase-merge-on-sequencer (2018-11-08) 2 commits
>  - rebase: implement --merge via git-rebase--interactive
>  - git-rebase, sequencer: extend --quiet option for the interactive machinery
>
>  "git rebase --merge" as been reimplemented by reusing the internal
>  machinery used for "git rebase -i".
>
>  Expecting a reroll.
>  cf. <CABPp-BF8RupyfP69iqAVTXxEhBGyzVd-wUgp3y0pf+CbBFAQeg@mail.gmail.com>

Quick update: Two re-rolls have been sent in[1]; v3 on November 22 and
v4 with only a minor error message tweak on Dec 11.  I think I've
addressed all review comments from v2, but neither v3 nor v4 has
received much review -- Dscho was also heavily busy during the run up
to 2.20 and needed some recovery time afterward.  I was going to
re-ping in early January.  Anyway, it may be worth at least updating
your note to "reroll exists".

Thanks,
Elijah

[1] Latest at https://public-inbox.org/git/20181211161139.31686-1-newren@gmail.com/

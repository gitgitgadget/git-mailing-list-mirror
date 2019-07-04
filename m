Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC38E1F461
	for <e@80x24.org>; Thu,  4 Jul 2019 16:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfGDQjq (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 12:39:46 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:32855 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDQjq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 12:39:46 -0400
Received: by mail-io1-f47.google.com with SMTP id u13so9575121iop.0
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AnRYRxSpTPL9BJMmYGu4upHI+5+sHKGEDF+QdhFXtR0=;
        b=r71+3pgc6Z1I4byOL1F990FrJ+eS1PxTaYWSv7hyByWg4LKj/gNtJDZCxqo8oVO3Bk
         zmQmBFafpy53t8EwR4JXGADtDyau8OAHmRvMQbgCLJGcyi+MtS5fMfMNafXJ33bKRLth
         p1hsu/wjS9aSNs9vzn0KROEFkdPxdAIVYiB44tjcWF+nEBqUvSNq3RQCaXuELEq7WASl
         cP8KM6KSUpNTHM/8BedYO7GIbIPcP3IRiOLyvqpzUmxRp0NkoMGt7rruN2Hjd73g7Q5X
         iSL+iODMPy65KP/Wooi7K5YWGJ8ZbfQsJ8a5oopesw7pL++D3MsVui7/lAW2vky3+DlQ
         cEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AnRYRxSpTPL9BJMmYGu4upHI+5+sHKGEDF+QdhFXtR0=;
        b=eY1Jnc3LM3zNYqZzjZN1BhkONP69JP1g27cB8gV4f+pEUB/ulvGxPqDfnaJYVpqjZs
         LdgabyVJssyl221j7PElnw45f0aeSpCwhfokyPCC+aSGGzz1BSS0incx5xtNLntOL7jF
         7ZWoD1NO2IG7P8FX2wA9/fA8HsAnCWKKW32tB+Fqgrz8gy60RNU/e8h0ITvU3grfNrI1
         miGidHtbtRTkQEYNlkOooAfm1B3BGLhjLNr9cgyJVex+aa7SYFCarsMq5yrcwrBjQ3sH
         8OXrtBSDVBnAhV/CsiWey7XFlfBoHu3iQzQio0VKDh9RU8VPFNpKno5oHpu0s4DC9CXt
         csbA==
X-Gm-Message-State: APjAAAW+H/DEZpo+owZhqGM4C0CW81M6xYBlIkcOC2HadHZOBpNCOHZ0
        UXmdd2kR/fs31+iCbaiWJUc7JXTJGUujwes6RcSUyA==
X-Google-Smtp-Source: APXvYqxFzf/DG4NDYJdn7W6hyy0udZVtx5pqxx9fQ6y7/ZBV07tyErcpZaHNlqV2vsuXaf5qQTtpxKrg9zC2x7ZwF3c=
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr2850920jan.90.1562258385500;
 Thu, 04 Jul 2019 09:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907041136530.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907041136530.44@tvgsbejvaqbjf.bet>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 4 Jul 2019 13:39:34 -0300
Message-ID: <CAHd-oW6s1kGJqaRhm2f5ZG1C48upZu8ypeB_rw7do2=Vi3jZqw@mail.gmail.com>
Subject: Re: mt/dir-iterator-updates, was Re: What's cooking in git.git (Jul
 2019, #01; Wed, 3)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Dscho

On Thu, Jul 4, 2019 at 7:02 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Junio,
>
> On Wed, 3 Jul 2019, Junio C Hamano wrote:
>
> > * mt/dir-iterator-updates (2019-06-25) 10 commits
[...]
> >  Is this ready for 'next'?
>
> No. It still breaks many dozens of test cases on Windows (if not more)
> because it thinks that it can rely on `st_ino` to detect circular
> symlinks.

I wanted to take a look at the failures to see if I could help, but
I'm not very familiar with azure (and travis-ci doesn't run windows'
tests). So the only build I could find, containing the code from this
series, is this[1]. But it only shows 4 failures and they don't seem
to relate with dir-iterator... Could you point me to the right place,
please?

> In
> https://public-inbox.org/git/nycvar.QRO.7.76.6.1906272046180.44@tvgsbejvaqbjf.bet/
> I had suggested to do something like this:
>
[...]
>
> However, in the meantime I thought about this a bit more and I remembered
> how this is done elsewhere: I saw many recursive symlink resolvers that
> just have an arbitrary cut-off after following, say, 32 links.
>
> In fact, Git itself already has this in abspath.c:
>
>         /* We allow "recursive" symbolic links. Only within reason, though. */
>         #ifndef MAXSYMLINKS
>         #define MAXSYMLINKS 32
>         #endif
>
> But then, the patch in question uses `stat()` instead of `lstat()`, so we
> would not have any way to count the number of symbolic links we followed.

Hm, I think `stat()` itself uses this strategy of an arbitrary cut-off
when resolving a path. So we may also "ignore" circular symlinks and
let the iteration continue until the point where `stat()` will return
an ELOOP. (But it may be expensive...)

> Do we _have_ to, though? At some stage the path we come up with is beyond
> `PATH_MAX` and we can stop right then and there.
>
> Besides, the way `find_recursive_symlinks()` is implemented adds quadratic
> behavior.

Yes, indeed. But it only happens when we have a path like this:
`symlink_to_dir1/symlink_to_dir2/symlink_to_dir3/symlink_to_dir4/...`,
right? I think this case won't be very usual on actual filesystems,
thought.

> So I would like to submit the idea of simplifying the code drastically,
> by skipping the `find_recursive_symlinks()` function altogether.
>
> This would solve another issue I have with that function, anyway: The name
> suggests, to me at least, that we follow symlinks recursively. It does
> not. I think that could have been addressed by using the adjective
> "circular" instead of "recursive".

Indeed, "circular" sounds much better then "recursive".

> But I also think there are enough
> reasons to do away with this function in the first place.

We can delegate the circular symlinks problem to `stat()'s ELOOP` or
`path_len > PATH_MAX`. The only downside is the overhead of iterating
through directories which will be latter discarded for being in
circular symlinks' chains. I mean, the overhead at dir-iterator
shouldn't be much, but the one on the code using this API to do
something for each of these directories (and its contents), may be.
Also we would need to "undo" the work done for each of these
directories if we want to ignore circular symlinks and continue the
iteration, whereas if we try to detect it a priori, we can skip it
from the beginning.

> Ciao,
> Dscho

[1]: https://dev.azure.com/git-for-windows/git/_build/results?buildId=38852

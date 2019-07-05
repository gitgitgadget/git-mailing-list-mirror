Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C71081F461
	for <e@80x24.org>; Fri,  5 Jul 2019 14:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfGEO3e (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 10:29:34 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:45158 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfGEO3d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 10:29:33 -0400
Received: by mail-io1-f42.google.com with SMTP id g20so9938100ioc.12
        for <git@vger.kernel.org>; Fri, 05 Jul 2019 07:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0MYs0xezviIYElDuPpvlIyg/OdNGKrojd2fenEtpFM=;
        b=Eg86gIatxVzeux3tVMCKuwFtP/A5avvPmo3vYqBOjP3u9cbOwjnmigujWTv7fCf8eA
         FhAhAogWpkwgV0XcRcVvsYv9M83bEt36pgqnhkhrVsyQV7yhVWAMJU0AKtiWEkSwCohW
         y6EboETrw05ipGzKZD4Dbl3hLl/EdD5limnphMZp2mYcJN0ab+qAaoHlUZAEX+nsVW2T
         So89a5/CrFn8tFxprKyjSY6s0oKFU60USk5VGCHcZ7RJHtUVSf9bfa9mf5/nVqhfJSxj
         PAQCqpqWy6mz2cZsuGeC5/7DIbXd1oW/yGsdqBANC0ZYv0MQ3+N8AaFtaMMp0MbCU3ds
         KnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0MYs0xezviIYElDuPpvlIyg/OdNGKrojd2fenEtpFM=;
        b=A+ZAhqzBU6IrNk1kLI1fIENXW9G764DoB29l4/E+Nx9Z1MZZPo9mr7esiG1VUu6mJv
         Xb5IVnmJlwyTgGot6HNMDnqwE7tvZlWK/7Xh0oiufQrOQpsQV1v+rFO6+iispMhxdEdq
         Lbny4ff+2iPdzx66GOGRNK46OtTbOHhnsNHVWf4rYSrG96SSNJcFbWe/4w63YHUljqLK
         74boK9YBR3zNOHT/AYARiKmhmbA/r0089/83EaGldcK9PVsq+rva/q/t2YpEIg7InBGA
         n9o3uAy95ZsBgeTCW1rDyvMKudnPHs40XN1Tshl/18QkChXxyZpO1MTOk/QoEMuV5ipb
         digg==
X-Gm-Message-State: APjAAAV3cSySsZsdUXiMVgFmvXTu77cqplIrY52uTuluF2OQvvg71XTF
        GAVWEJ6WeGJcNdEsopdQJtgfu3i1R7AWf2faAb3+sw==
X-Google-Smtp-Source: APXvYqwdy0lnRwMyaa6J66K+yy+ego54Jjxm17ndEVkFzYA8innjnPeEvhzGS3lA6nHh0E7glGrCZ9HbExVUDSMqS4c=
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr5123643jan.90.1562336972616;
 Fri, 05 Jul 2019 07:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1907041136530.44@tvgsbejvaqbjf.bet>
 <CAHd-oW6s1kGJqaRhm2f5ZG1C48upZu8ypeB_rw7do2=Vi3jZqw@mail.gmail.com> <nycvar.QRO.7.76.6.1907042308200.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1907042308200.44@tvgsbejvaqbjf.bet>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 5 Jul 2019 11:29:21 -0300
Message-ID: <CAHd-oW6PTFY=_j1RDh8_MdeBmMX77kF+=kOpd-GUnbegMC89yQ@mail.gmail.com>
Subject: Re: mt/dir-iterator-updates, was Re: What's cooking in git.git (Jul
 2019, #01; Wed, 3)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 4, 2019 at 6:30 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Matheus,
>
> On Thu, 4 Jul 2019, Matheus Tavares Bernardino wrote:
> >
> > I wanted to take a look at the failures to see if I could help, [...]
> > Could you point me to the right place, please?
[...]
>
> I usually click on the "Tests" tab in that page:
> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=11495&view=ms.vss-test-web.build-test-results-tab
>
> You can click on any of the 1,384 (!) failing test cases, it will pop up a
> pane on the right-hand side that shows the trace of that failing test
> case. For the full trace of that test script, go to "Attachments" and
> download the `Standard_Error_Output.log` (via the horizontal bread-crumbs
> menu you can see when hovering over the file name).

Thanks for the explanation! I inspected some of the
`Standard_Error_Output.log`'s and it seems the problem is always with
local clone (which started to use dir-iterator in this series). It
seems all .git/objects/ dirs are being ignored. That makes sense,
since st_ino will always be 0 on Windows. But your fixup patch should
solve this. Is there any azure build for it?

[...]
> >
> > Hm, I think `stat()` itself uses this strategy of an arbitrary cut-off
> > when resolving a path. So we may also "ignore" circular symlinks and
> > let the iteration continue until the point where `stat()` will return
> > an ELOOP. (But it may be expensive...)
>
> This would not be equivalent, though, as your code also tried to address
> circular references when two or more symlinks are involved, e.g. when
> one symlink points to a directory that has another symlink that points to
> the directory containing the first symlink.

Hm, `stat()` also addresses this case doesn't it? For example:

$ mkdir a b
$ ln -s ../a b/s2a
$ ln -s ../b a/s2b
$ stat b/s2a/s2b/s2a/.../s2b

Gives me:
"too many levels of symbolic links"

> > > Do we _have_ to, though? At some stage the path we come up with is beyond
> > > `PATH_MAX` and we can stop right then and there.
> > >
> > > Besides, the way `find_recursive_symlinks()` is implemented adds quadratic
> > > behavior.
> >
> > Yes, indeed. But it only happens when we have a path like this:
> > `symlink_to_dir1/symlink_to_dir2/symlink_to_dir3/symlink_to_dir4/...`,
> > right? I think this case won't be very usual on actual filesystems,
> > thought.
>
> No, the check is performed in a loop, and that loop is executed whether
> you have symlinks or not. That loop is executed for every item in the
> iteration, and as we cannot assume a flat directory in general (in fact,
> we should assume a directory depth proportional to the total number of
> files), that adds that quadratic behavior.

Oh, you're right. Sorry for the noise, I forgot this function was not
only called for symlinks but for every directory entry :(

An alternative solution would be to use `lstat()` together with
`stat()` to only feed symlinked dirs to this function. This should
reduce a lot the number of calls. Although it'd still be quadratic in
the worst case, would that be any good?

[...]
> > > But I also think there are enough
> > > reasons to do away with this function in the first place.
> >
> > We can delegate the circular symlinks problem to `stat()'s ELOOP`
>
> Not really. I mean, we _already_ delegate to the `ELOOP` condition, we
> cannot even avoid it as long as we keep using `stat()` instead of
> `lstat()`

Yes, indeed. What I meant is that we may chose to _fully_ delegate to
ELOOP. The way it is now, we should detect circular symlinks way
before stat() fails. For example, with the case I showed above, we
would stop at "b/s2a/s2b" whereas stat() would only fail at a much
longer "b/s2a/s2b/s2a/s2b/...", far beyond in the iteration.

> but as I demonstrated above, that only catches part of the
> circular symlinks.
>
> > or `path_len > PATH_MAX`.
>
> This would have the advantage of _not_ adding quadratic behavior.
>
> And just in case you think quadratic behavior would not matter much: Git
> is used to manage the largest repository on this planet, which has over 3
> million index entries when checked out.
>
> Quadratic behavior matters.
>
> I don't know where the dir-iterator is used, but we simply should try our
> best to aim for the optimal time complexity in the first place.

Currently, with the follow symlinks option, dir-iterator is only being
used to iterate over .git/objects. As it's rather shallow, perhaps the
quadratic complexity wouldn't be a huge deal in this case. But I agree
with you that we should take care of performance so that this API may,
as well, be used in other places, in the future.

> > The only downside is the overhead of iterating through directories which
> > will be latter discarded for being in circular symlinks' chains. I mean,
> > the overhead at dir-iterator shouldn't be much, but the one on the code
> > using this API to do something for each of these directories (and its
> > contents), may be. Also we would need to "undo" the work done for each
> > of these directories if we want to ignore circular symlinks and continue
> > the iteration, whereas if we try to detect it a priori, we can skip it
> > from the beginning.
>
> Given that the intent of this patch series is a mere refactoring, I wonder
> why the new, contentious circular symlink detection is slipped into it
> anyway. It complicates the task, makes reviewing a lot harder, and it
> holds up the refactoring.

Yes, I apologize for that. I should have split this into 2 or maybe 3
patchsets... This series started really simple just trying to apply
the dir-iterator API into local clone. But then, other things became
necessary and it got more complex.

So, should I send a fixup patch removing find_recursive_symlinks() or
reroll the series? There's also the option to use stat()+lstat() to
reduce calls to this function, but it doesn't solve the problem on
Windows, anyway.

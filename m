Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73FC11F461
	for <e@80x24.org>; Tue, 25 Jun 2019 12:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbfFYMG6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 08:06:58 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45905 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732520AbfFYMG4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 08:06:56 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so2525392ioc.12
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 05:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+KikxFCFA+N47+XDC9cOGcHFAsDg1vgwB2das0xpUk=;
        b=NQPrQ87B2YWknapk5ab6q0Rw79MvaMyTjhzbay9YCvedihV81SvhUm8h9bQizlc0fK
         Xyw4V9m1RdZDI1nYP+bMn5PUQTkHs1NHbKVODxCrH2+QsfOSoI81H2Mb5EmWvGYg+yhn
         NhofHFO2E+E5hA+QOkLRCSI/QjVwiD+pJ6Cxiv8R6PavUo2wPEnA1R6xlPE2MO78eZw2
         fnrkWzvDCUm50lhpG55vdcIAKUB+u/kFOcj56yZGRjnN3tx4bJl6hOfCuwxQSmX7xN8X
         HvDwOrVgIsCtzqieckT4zda01faLi3oSXmPOzqRTKREaWh0tM+WwLzwZNgzeeVas7kWi
         WmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+KikxFCFA+N47+XDC9cOGcHFAsDg1vgwB2das0xpUk=;
        b=WykUsMmLzELkmgMEc9wXUNaPIGZQKpgvbrdQZfhhbQpFg+X6ob4SkrdsKEd+p0rOVj
         LsP6p6u/CRyXADh19CV3tAfbYvAzeyG21JBQC66FTdk4p9Hh38+5qaAFVHwRsWxnD/c2
         arkVTtduLzdApB/LWYvoSBx0qJSabRgfbT8WN2he1UNRBxpk6ubAg70i91/SZGj0bwEQ
         VFWfV0/g36etLf3Fobw+pfQAXhBfgTdie0xSmOcu+wXjUNJ5GNuI+f7Tor/SrSWn86Gf
         Vg6KfU6h31Bt8ARjQn5VmKFuMo+dM0Gk3kJdBmd11R2YcPATpy1QasAibBr0JiA1Pewn
         KC1w==
X-Gm-Message-State: APjAAAU4tRGoJOCEAAttvOf8Im3iDY6v7R0iVRmtGeR1uWiV4/gLFxva
        gbdTKixcibbIJGE5AZcN4CWQQzE5CPku25olNGw=
X-Google-Smtp-Source: APXvYqwFXimWdfMrXifCc1JpQH3kzRs+bodHMhLtAjnq0O0kWeDvwYkXTdFBJMpqqSaRvun/TXpvBdL7ZoWM3anwb8U=
X-Received: by 2002:a6b:f711:: with SMTP id k17mr8066693iog.273.1561464415910;
 Tue, 25 Jun 2019 05:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190624130226.17293-1-pclouds@gmail.com> <nycvar.QRO.7.76.6.1906241954290.44@tvgsbejvaqbjf.bet>
 <CACsJy8BsT-GaVvEmqfk5n1jGmkcLG_bRjqcU0M3yefBmNSxmnA@mail.gmail.com> <nycvar.QRO.7.76.6.1906251311280.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1906251311280.44@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Jun 2019 19:06:29 +0700
Message-ID: <CACsJy8B9vd9YaP_FHN-EDEPc_OHgD=MtFu8WymM66PURWX=25Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Add 'ls-files --debug-json' to dump the index in json
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 25, 2019 at 6:27 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Duy,
>
> On Tue, 25 Jun 2019, Duy Nguyen wrote:
>
> > On Tue, Jun 25, 2019 at 1:00 AM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > > - extension location is printed, in case you need to decode the
> > > >   extension by yourself (previously only the size is printed)
> > > > - all extensions are printed in the same order they appear in the file
> > > >   (previously eoie and ieot are printed first because that's how we
> > > >   parse)
> > > > - resolve undo extension is reorganized a bit to be easier to read
> > > > - tests added. Example json files are in t/t3011
> > >
> > > It might actually make sense to optionally disable showing extensions.
> > >
> > > You also forgot to mention that you explicitly disable handling
> > > `<pathspec>`, which I find a bit odd, personally, as that would probably
> > > come in real handy at times,
> >
> > No. I mentioned the land of high level languages before. Filtering in
> > any Python, Ruby, Scheme, JavaScript, Java is a piece of cake and much
> > more flexible than pathspec.
>
> I heard that type of argument before. I was working on the initial Windows
> port of Git, uh, of course I was working on a big refactoring of a big C++
> application backed by a database. A colleague suggested that filtering
> could be done much better in C++, on the desktop, than in SQL. And so they
> changed the paradigm to "simplify" the SQL query, and instead dropped the
> unwanted data after it had hit the RAM of the client machine.
>
> Turns out it was a bad idea. A _really_ bad idea. Because it required
> downloading 30MB of data for about several dozens computers in parallel,
> at the start of every shift.
>
> This change was reverted in one big hurry, and the colleague was tasked to
> learn them some SQL.
>
> Why am I telling you this story? Because you fall into the exact same trap
> as my colleague.
>
> In this instance, it may not be so much network bandwidth, but it is still
> quite a suboptimal idea to render JSON for possibly tens of thousands of
> files, then parse the same JSON on the receiving side, the spend even more
> time to drop all but a dozen files.

This was mentioned before [1]. Of course I don't work on giant index
files, but I would assume the cost of parsing JSON (at least with a
stream-based one, not loading the whole thing in core) is still
cheaper. And you could still do it in iteration, saving every step
until you have the reasonable small dataset to work on. The other side
of the story is, are we sure parsing and executing pathspec is cheap?
I'm not so sure, especially when pathspec code is not exactly
optimized.

Consider the amount of code to support something like that. I'd rather
wait until a real example come up and no good solution found without
modify git.git, before actually supporting it.

[1] https://public-inbox.org/git/45e49624-be8e-deff-bf9d-aee052991189@gmail.com/

> And this is _even more_ relevant when you want to debug things.
>
> In short: I am quite puzzled why this is even debated here. There is a
> reason, a good reason, why `git ls-files` accepts pathspecs. I would not
> want to ignore the lessons of history as willfully here.

I guess you and I have different ways of debugging things.

> > Even with shell scripts, jq could do a much better job than pathspec. If
> > you filter by pathspec, good luck trying that on extensions.
>
> You keep harping on extensions, but the reality of the matter is that they
> are rarely interesting. I would even wager a bet that we will end up
> excluding them from the JSON output by default.
>
> Most of the times when I had to decode the index file manually in the
> past, it was about the regular file entries.
>
> There was *one* week in which I had to decode the untracked cache a bit,
> to the point where I patched the test helper locally to help me with that.
>
> If my experience in debugging these things is any indicator, extensions do
> not matter even 10% of the non-extension data.

Again our experiences differ. Mine is mostly about extensions,
probably because I had to work on them more often. For normal entries
"ls-files --debug" gives you 99% what's in the index file already.

> > > especially when we offer this as a better way for 3rd-party
> > > applications to interact with Git (which I think will be the use case
> > > for this feature that will be _far_ more common than using it for
> > > debugging).
> >
> > We may have conflicting goals. For me, first priority is the debug
> > tool for Git developers. 3rd-party support is a stretch. I could move
> > all this back to test-tool, then you can provide a 3rd-party API if
> > you want. Or I'll withdraw this series and go back to my original
> > plan.
>
> You don't need JSON if you want to debug things. That would be a lot of
> love lost, if debugging was your goal.

No, I did think of some other line-based format before I ended up with
JSON. I did not want to use it in the beginning.

The thing is, a giant table to cover all fields and entries in the
main index is not as easy to navigate, or search even in 'less'. And
the hierarchical structure of some extensions is hard to represent in
good way (at least without writing lots of code). On top of that I
still need some easy way to parse and post-process, like how much
saving I could gain if I compressed stat data. And the final nail is
json-writer.c is already there, much less work.

So JSON was the best option I found to meet all those points.
-- 
Duy

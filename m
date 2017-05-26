Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1C7220A04
	for <e@80x24.org>; Fri, 26 May 2017 08:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937030AbdEZIGa (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 04:06:30 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36614 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759927AbdEZIGX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 04:06:23 -0400
Received: by mail-it0-f68.google.com with SMTP id i206so796250ita.3
        for <git@vger.kernel.org>; Fri, 26 May 2017 01:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7hCARQRQ8P+nVMH33lfdJaWGyYizFKJmCCLr6r8QAp4=;
        b=XdckEoCFGUYJiCo2MUpqhwUsqu5mgxFN+PIvvaQ25TD9oMDBEOQjwkAuHZ+Tp2yBeY
         sqy7pwDPO4LGp3wLBz4r1jdaoYCLqzCNJmlLaxnJ9hWf3LuJvs2Tj9Vtu6XBdXKKA1yd
         kssA5fjtV75dpgwz6PtyT5neu7ZDCsY4gVqvCEoNXDlBsYyxXnp5XKBKNbF2Rq8sPizn
         TJ2IUL4y2bFghW9JIcVeHEctjJm7tVQAVXMx4GfGsdOAdQKs8AABesbWpNfOJCLWHd9g
         sOwEilj9xwBo3G/hnv555wAZEtQDjfF1VJ9uLesZcwUGbrbN7K77OfYpjUq5Tf1OzQBQ
         npSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7hCARQRQ8P+nVMH33lfdJaWGyYizFKJmCCLr6r8QAp4=;
        b=LUODO7nAL+SxL6RvkIhcK0Zq8qXtqmhq5J08DJBrMRLdel32EGdv5w9PjH1bfRd7Tb
         6Je9ozj8ImFmXo8w3ka4lx0atXEyhnwPLv4X/leV4Lv0/hqYQ9DlFqPd8VH7CM2c0BdR
         tVE06XvLF7ZjpHrJAdXdStap8Mcl/O497K6UuTwlAgir8kwAbNSZ67tkSCUaQkVRovqd
         xvaLjaJOzlNeblv9eeq4ucCnLc4VcrloNYyCuoOqW+iPPi9HVnrS/JO48ubJ/kRibSAQ
         l0ihhdfCjcX7Kh3CxDBqPvMEgFC4NS9616jTuHavZZ9O28rX5ESZ8SSUJL2+1r0h2GMH
         5WHA==
X-Gm-Message-State: AODbwcBe8CDHGqwTPU0pw4I9iM6DczAnmfh45YQZW5ZFRkXHKgtSyIlW
        Lph23aCgfxY8DYYHeq+TD1sG9KcfvA==
X-Received: by 10.36.89.207 with SMTP id p198mr3133939itb.71.1495785982435;
 Fri, 26 May 2017 01:06:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 26 May 2017 01:06:01 -0700 (PDT)
In-Reply-To: <xmqqlgpkcu2v.fsf@gitster.mtv.corp.google.com>
References: <20170523192453.14172-1-avarab@gmail.com> <xmqqshjzqe9o.fsf@gitster.mtv.corp.google.com>
 <20170523192453.14172-2-avarab@gmail.com> <xmqqvaoqhnlw.fsf@gitster.mtv.corp.google.com>
 <CACBZZX51hmq-jCkwyDt6QWfLJ+qxziUV-Bef+yVDoViLNhC4dw@mail.gmail.com> <xmqqlgpkcu2v.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 26 May 2017 10:06:01 +0200
Message-ID: <CACBZZX7i2RqyjXmF8wxYvs0d1nijiopVQ2EUM5rmpztEbe6tKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] grep: don't redundantly compile throwaway patterns
 under threading
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Simon Ruderich <simon@ruderich.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 2:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I think it's a pointless distraction to start speculating in this
>> commit message what we're going to do with --debug it if it ever
>> starts emitting some debugging information at pattern execution time.
>
> OK.
>
>> As an aside, I'd very much like to remove both --debug and the
>> --and/--or/--all-match, gives some very rough edges in the UI and how
>> easy it is to make that feature error or segfault, I suspect you might
>> be the only one using it.
>
> I agree that rewriting "grep -e A -e B" to "grep -e A|B" as an
> optimization is an interesting possibility to look into, and I can
> understand that having to support "--and" and "--not" would
> make such an optimization harder to implement. "-e A --and -e B"
> must become "-e A.*B|B.*A" and as you get more terms your unified
> pattern will grow combinatorial, at which point you would be better
> off matching N patterns and combining the result.
>
> Ever saw a user run "ps | grep rogue | grep -v grep" to find a rogue
> process to kill?  That would not work if the rogue process's command
> line has a word "grep".  Because "git grep" is often run on files in
> order to find the location the patterns appear in, "git grep -e
> pattern | grep -v unwanted" shares the same issue--the unwanted
> pattern may appear in the filename, and the downstream "grep -v" may
> filter out a valid hit.  This is why "--not" exists [*1*].  I agree
> that emulating it within the same "concatenate patterns into one"
> optimization you are envisioning may be hard.
>
> Attempting to optimize "--all-match" would share similar difficulty
> with "--and", but your matching now must be done with the entire
> buffer and not go line-by-line.  It was meant to make it possible to
> say "find commits that avarab@ talks about both regex and log", i.e.
>
>         $ git log --author=3Davarab@ --all-match --grep=3Dlog --grep=3Dre=
gex
>
> This is not something you can emulate by piping an output of grep to
> another grep.
>
> But none of the above means you have to give up optimizing.
>
> You can choose not to combine them into a single pattern if certain
> constructions are hard, and do only the easy ones.  If you think
> that harder combinations are not used very often, the result would
> be faster for many cases while not losing useful features, which is
> what we want.

To be clear the point of my mail was not to say "I can't think of a
way to support both of these things, help!", obviously we can continue
to maintain two codepaths. The point was to raise the idea that we
could simply remove the more complex & doomed to forever be slow
codepath.

Obviously there are caveats with the likes of "grep foo | grep bar"
that don't exist with "grep -e foo --and -e bar". I'm less interested
in whether we can come up with cases that wouldn't be possible if this
were removed, than if anyone's using them in practice.

I suspect that to the extent anyone uses this for common things it
could be emulated by --single-line --perl-regexp and e.g. 'foo.*bar'
instead of 'foo' --and 'bar'. I.e. we could offer to AND together your
regexes and match them over the entire content.

If someone needed something more complex we could just show an example
of piping e.g. \0-delimited commit messages into an arbitrary perl
script you provide.

Anyway, I've only looked this over a tiny bit, and I don't know
whether it's worth it to remove this, right now I was just interested
in some reports of what it was used for. I.e. whether anyone uses it
for N-level deep mixed AND/OR branches, or whether it's really just a
lazy way to concat regexes and get around the current limitation of
not being able to match across lines.

> [Footnote]
>
> *1* For human consumption, lack of "--not" may not hurt in the sense
>     that there are workarounds (i.e. you can do without "| grep -v
>     unwanted" and filter irrelevant ones by eyeballing).  But it is
>     essential while scripting and trying to be precise.

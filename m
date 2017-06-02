Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6FE92027C
	for <e@80x24.org>; Fri,  2 Jun 2017 20:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751162AbdFBU36 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 16:29:58 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35523 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750966AbdFBU35 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 16:29:57 -0400
Received: by mail-it0-f67.google.com with SMTP id 67so12990189itx.2
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 13:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/gBQ8y5ZWp4elewkC5bPQqXgk4rbUGJy37bWLfVF5gY=;
        b=hBXzKbp54Foolk4UHS0suDXb6ga5KMOqtg5rej3t0xdKvgoIjFpk0zubezEFxTQdqg
         mr/mN0SS0PetEjcurdR1AhMWt1ruLqS49BGepLxGWsWSMrFh2AaVMfAr9qzv6jRJFy28
         ztD0fm4QSMYOIQ6iHiuzgY1Z20uNPINNAo76AxiOYTswRkkPhyMiJ1AK3eurI2wvlIj/
         Aheipf9lorROExRSnUg+olM7YdGingZ46OZBa+zO5jFzx6ZZCdfN11pKxicre3WMNiVY
         dWID+51AgPypxVqbHiKqnVFIp48iyESsUuMHe8U8gEcSLEO/LJNRAsYvOqNQJiaQ2Rye
         2inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/gBQ8y5ZWp4elewkC5bPQqXgk4rbUGJy37bWLfVF5gY=;
        b=nbEUsTt9kDo3LZIB7w7Zx8Nnrvz3IGhHq6HlkEGMatQ+NG2Q+F+b1rOjJak4GyHW2x
         gEt2xLwwUrbQe+OsZg0VayRGJcULLBLOe4ZvJy4uKoS7FqQVlwKbyRMPZEO8otpaObbt
         NvuE9xQGobdZEcXkgJR8P5oK2CjQy5PDZ+9l6bBelOLU6sukcydre3Enq+nE9saBm1Fc
         J4zhTRUcDxQp/Ka2Xry+2MTwaYPbErrPHV1bngss1KHzplT/oSTmCZG93z/wjeFYfHpp
         CbIVYH1e9bFotrydPxBA7otT4xa1V5Vctda5aI7Qom1uFYqjcevW+1HDob4o43vxReXN
         tjlg==
X-Gm-Message-State: AODbwcCvQ0XgJ8+qLtVDjjhFUSA1wTMGPTw9+2lWZgMyJ8ZU+NTmALC4
        2xSdiY1rtTlZmKegxorNEY+mKobLRw==
X-Received: by 10.36.53.79 with SMTP id k76mr1191737ita.71.1496435396716; Fri,
 02 Jun 2017 13:29:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Fri, 2 Jun 2017 13:29:36 -0700 (PDT)
In-Reply-To: <20170602175455.GA30988@aiede.mtv.corp.google.com>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170531104213.16944-3-phillip.wood@talktalk.net> <alpine.DEB.2.21.1.1706011329350.3610@virtualbox>
 <xmqq7f0v46q3.fsf@gitster.mtv.corp.google.com> <CAGZ79kaM9ryT1gWx=L6S90HPCaDPNZ6H124HAJscpeJCQFDN8Q@mail.gmail.com>
 <alpine.DEB.2.21.1.1706021442190.171564@virtualbox> <20170602175455.GA30988@aiede.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 2 Jun 2017 22:29:36 +0200
Message-ID: <CACBZZX7JRA2niwt9wsGAxnzS+gWS8hTUgzWm8NaY1gs87o8xVQ@mail.gmail.com>
Subject: Re: pushing for a new hash, was Re: [PATCH 2/3] rebase: Add tests for
 console output
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2017 at 7:54 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi Dscho,
>
> Johannes Schindelin wrote:
>> On Thu, 1 Jun 2017, Stefan Beller wrote:
>
>>> We had a discussion off list how much of the test suite is in bad shape,
>>> and "$ git grep ^index" points out a lot of places as well.
>>
>> Maybe we should call out a specific month (or even a longer period) during
>> which we try to push toward that new hash function, and focus more on
>> those tasks (and on critical bug fixes, if any) than anything else.
>
> Thanks for offering. ;-)
>
> Here's a rough list of some useful tasks, in no particular order:
>
> 1. bc/object-id: This patch series continues, eliminating assumptions
>    about the size of object ids by encapsulating them in a struct.
>    One straightforward way to find code that still needs to be
>    converted is to grep for "sha" --- often the conversion patches
>    change function and variable names to refer to oid_ where they used
>    to use sha1_, making the stragglers easier to spot.
>
> 2. Hard-coded object ids in tests: As Stefan hinted, many tests beyond
>    t00* make assumptions about the exact values of object ids.  That's
>    bad for maintainability for other reasons beyond the hash function
>    transition, too.
>
>    It should be possible to suss them out by patching git's sha1
>    routine to use the ones-complement of sha1 (~sha1) instead and
>    seeing which tests fail.

I just hacked this up locally. While a lot of stuff fails, it's not
exactly an out of control garbage fire and could be churned through by
someone interested. A lot of it's just lazy sha1 hardcoding for no
good reason where we could use a tag, or e.g. test_cmp on ls-tree
output without the test really caring about the hash. Things that
really need to test the sha1 could be guarded by some new prereq.

Both of my attempts to fuzz SHA1DCInit though resulted in some
segfaults, I tried both changing "0x" to "~0x" in the ihv assignment,
and just calling SHA1DCUpdate(ctx, "x", 1) at the end of the function,
not sure why that's happening.

If someone knows offhand what I'm doing wrong here I might be
interested in going through this if I don't have to sift through the
segfaults. I.e. what's an easy hack to make all of git pretend that
"foo" hashes to "xfoo", "" to "x" etc.

> 4. When choosing a hash function, people may argue about performance.
>    It would be useful for run some benchmarks for git (running
>    the test suite, t/perf tests, etc) using a variety of hash
>    functions as input to such a discussion.

To the extent that such benchmarks matter, it seems prudent to heavily
weigh them in favor of whatever seems to be likely to be the more
common hash function going forward, since those are likely to get
faster through future hardware acceleration.

E.g. Intel announced Goldmont last year which according to one SHA-1
implementation improved from 9.5 cycles per byte to 2.7 cpb[1]. They
only have acceleration for SHA-1 and SHA-256[2]

1. https://github.com/weidai11/cryptopp/issues/139#issuecomment-264283385

2. https://en.wikipedia.org/wiki/Goldmont

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D452B20970
	for <e@80x24.org>; Tue, 11 Apr 2017 20:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753522AbdDKU4Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 16:56:25 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:33735 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbdDKU4X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 16:56:23 -0400
Received: by mail-io0-f194.google.com with SMTP id k87so2812488ioi.0
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 13:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mQM5+CLlVkVGAvU7gwSgGdERLKufkB+l2w7ASbqJrz0=;
        b=EY+N0j8nwg8yVSwq2zN7muuljm+KwawMJs0ndHNHYwsAxTjDQtlCHe0sIGOAHmSHBo
         Y8Ei4+SKO5hWuWiYlzvqdGIsdE7/T+RBdJ7EgtZCrUs0/AbQeOIBVmUXWLR8xw5yH0Te
         cZ5p8f7KSf1Qr9YLIWUX2XDCa+eXaDpwTd5uFm+OSAnPUobwJcHDg57AzmM12eyg1mP1
         gngMRnV6sOIEMgahCiUVHwdVWbXjTttbdeIfG1hUWxAm4WENMcQQa3VLhMfi6cvNCHVE
         NsCmc+Z/lQWHShlCUcbV2xwTFWQjiJyMmTFR//BhQHyNV8qLS+GpP32/Cegng8mqUh+C
         6myw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mQM5+CLlVkVGAvU7gwSgGdERLKufkB+l2w7ASbqJrz0=;
        b=XMQwWcDwrqUnM22onw7Glus4r4fj8UsMgr++ufl3dwfVFsxTHWCmhSl7i6CydFuqaP
         eIv9Hsa44Z1Y30rHTORFVYUXnXzBSUbeR6sP7UsSSFCp7ZQxY0MbVM50uBPcGZWkEyFf
         yLJORTirjx8XMEssdpRVuBD4hfKESKOeeuijER337vJ6QHvfdqcWtozp0FaEGfx6VPb3
         OqVvS5PuGwlbleXJ6vrhnWl6lZOmgc4dXH/djV5k2JW9X0v/ehPbZPEQiBM7TQg96NN+
         1aR3TPmBYdvZTtPsIQCiPp8RfcM9RvGuXPNoNDkI0J2hgeHp0Ten2pd6HOqTh+8j0aTq
         trAw==
X-Gm-Message-State: AFeK/H2UgZvbxhTdVUea2pjfcJDWoaKsESwju2jaxBL3EL3JjHDcyogoqKcEpxchmle8Cx6DvJqSutc+AnShtQ==
X-Received: by 10.107.32.199 with SMTP id g190mr63595365iog.117.1491944182551;
 Tue, 11 Apr 2017 13:56:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Tue, 11 Apr 2017 13:56:01 -0700 (PDT)
In-Reply-To: <20170411203434.iiupo2oovzviqju5@sigill.intra.peff.net>
References: <20170408132506.5415-1-avarab@gmail.com> <20170408132506.5415-2-avarab@gmail.com>
 <20170411100656.5bptxdaptc4zznan@sigill.intra.peff.net> <CACBZZX7vEQ5jUzX3GsD6JXe50TnRUtGmSVi7zBxwOmAQGABQ4Q@mail.gmail.com>
 <20170411203434.iiupo2oovzviqju5@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 11 Apr 2017 22:56:01 +0200
Message-ID: <CACBZZX7Xi2OWqHQd7jTGBEZyqcWk59oXbPJOjuYrYAFzd5huCA@mail.gmail.com>
Subject: Re: [PATCH 01/12] grep: add ability to disable threading with
 --threads=0 or grep.threads=0
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?Q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Rast <trast@student.ethz.ch>,
        Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 10:34 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 11, 2017 at 10:20:59PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> I'm struggling to find a use-case where threading makes sense at all.
>> The example in the initial introduction in 5b594f457a is always slower
>> with >0 for me, and since then in 0579f91dd7 it got disabled entirely
>> for non-worktree cases.
>
> It's a big win for me in worktree greps of linux.git:
>
>   $ best-of-five git grep --threads=3D1 '[q]werty'
>   Attempt 1: 0.713
>   Attempt 2: 0.708
>   Attempt 3: 0.689
>   Attempt 4: 0.695
>   Attempt 5: 0.7
>
>   real  0m0.689s
>   user  0m0.560s
>   sys   0m0.248s
>
>   $ best-of-five git grep --threads=3D8 '[q]werty'
>   Attempt 1: 0.238
>   Attempt 2: 0.225
>   Attempt 3: 0.222
>   Attempt 4: 0.221
>   Attempt 5: 0.225
>
>   real  0m0.221s
>   user  0m0.936s
>   sys   0m0.356s
>
> In non-worktree cases most of the time goes to accessing objects, which
> happens under a lock. So you don't get any real parallelism, just
> overhead.
>
>> But assuming it works for someone out there, then 0 threads is clearly
>> not the same as 1. On linux.git with pcre2 grepping for [q]werty for
>> example[1]
>
> Right, my suggestion was to teach "grep" to treat --threads=3D1 as "do no=
t
> spawn any other threads". I.e., to make it like the "0" case you were
> proposing, and then leave "0" as "auto-detect". There would be no way to
> spawn a _single_ thread and feed it. But why would you want to do that?
> It's always going to be strictly worse than not threading at all.

I understand, but given the two profiles we've posted it seems clear
that there's cases where if we did that, we'd be locking people out of
their optimal thread configuration, which would be --thread=3D1 with my
patch, but wouldn't exist with this proposed change.

If you see better timings with 8 threads than 1 on linux.git, but I
see strictly worse, then if you apply my patch doesn't --threads=3D0
look worse than --threads=3D1, which looks worse than --threads=3D2 etc,
until you reach some number where you either run out of CPU or I/O
throughput.

Anyway, I really don't care about this feature much, I just wanted a
way to disable threading, but looking at the perf profiles I wonder if
doing your proposed change would cause a regression in some cases
where someone really wanted /one/ thread.

But of course my patch breaks the long documented grep.threads=3D0 for
"give me threads that you auto detect" to now mean "you get none".

Also doesn't --thread=3D1 right now mean "one thread, but two workers?".
I haven't dug into the grep worker/thread code, but it compiles the
the pattern twice, so isn't both the non-thread main process & the
sole thread it spawns on --thread=3D1 doing work, so in some other
universe it's synonymous with --workers=3D2?

If so do pack-objects & index-pack also behave like that? If so this
whole thing is very confusing for users, because some will read 1
thread and think "one worker", whereas it really means "two workers,
one using a thread, if you want three workers spawn two threads".

Bah!

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 487D1208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 20:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752670AbdIEUlx (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 16:41:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38544 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752584AbdIEUlw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 16:41:52 -0400
Received: by mail-pf0-f195.google.com with SMTP id q76so2132912pfq.5
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 13:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iozasi3f9DFHGkyeT5i8HkWyMdxWvEL3pmT1c0sjx58=;
        b=W2H5ar8hvXqCqjCvhmyoxY2Ujf7Pc8bzXXPiz+3vW/qsHIRZ9hHpOsSE4phaYZFS6p
         sW8Qbd8vOK1R1Pzqp39ruik3iv0vJpufACKx7+71WOQeGsrLY04Y4OB1qOqJkoC5V7IG
         O8UuPQH++OHELxljb79PIW4BpQpE/XhMA5A6mu9FLbUUInOmFyELb6B6mFQtUZAlSS6i
         v1v4V8SPHhjqZmCJoA0sOKDvI7xV5bv6ZolARMJ2DfRucMTMZ+VhiRCwAt3UlDqWlKD3
         MgRDTE7EO50i0/grYIWRjBooSbVhesuCzl0JwoIsNSE74Jk2G106UWwRrLBRVze/CO7h
         BIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iozasi3f9DFHGkyeT5i8HkWyMdxWvEL3pmT1c0sjx58=;
        b=AkgbqZhTT9eabLOKmETZ7DdVnVGtYwpqnw0E0e8jkM7ebJZQ2a5jIM4oxLf1Hwblps
         TlkMSY7wT55o6lOVfSdhCcqnjfPjjJS0zqGlbEffAIhJrb5/Hx0/6x4iIbqgj2hQIkwQ
         eUGjYJzNTd+ceMfRKljnxq9kZcVRVwoNYsLLfGJkqkkxYDFaH/6aWkK+ml0OvzL/WV9o
         V83uRLwjFZNXvtU7D6OFUuaVEr0nrpoU446uGlDN+ms55gRsnjFeOTLPkPhYEKuk5qGA
         RRI6QvVCfvPeOoc8X+e4OmgBzlGme/Fi5fLFuYuhozKkX2HOIJo/15wDpmyDLYw4mML+
         MrEQ==
X-Gm-Message-State: AHPjjUh1biwWh074ZfrRoubkZV4y9s6q7mYwdPxB22X6ipHDfYiO38EK
        XLm0WLNs9hqFvEx6RiBJT5QMOCkFCQ==
X-Google-Smtp-Source: ADKCNb70sf6Gm5wxIbBmxCKqJuvyp4QHMqImF6qYRIjPQqFXLAkK4DblEj58Xb9ZttoSm1DLvSFo9G/3L2XPzObHHv4=
X-Received: by 10.99.126.84 with SMTP id o20mr5262542pgn.201.1504644111903;
 Tue, 05 Sep 2017 13:41:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.142.73 with HTTP; Tue, 5 Sep 2017 13:41:51 -0700 (PDT)
In-Reply-To: <20170905190212.4xx4xukx2bbtudij@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
 <CAN0heSrVzRPc+iVqU02qzk=DB0WT6Fscn6X-hZPFkM1TikMPVQ@mail.gmail.com> <20170905190212.4xx4xukx2bbtudij@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 5 Sep 2017 22:41:51 +0200
Message-ID: <CAN0heSrz=tVHj13X+yHJpAR=5o7j8EqbBdw8hvrhcnhbA04QAA@mail.gmail.com>
Subject: Re: [PATCH 0/10] towards clean leak-checker output
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 September 2017 at 21:02, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 05, 2017 at 07:50:10PM +0200, Martin =C3=85gren wrote:
>
>> >     That line is the setting of argv0_path, which is a global (and thu=
s
>> >     shouldn't be marked as leaking). Interestingly, it only happens wi=
th
>> >     -O2. Compiling with -O0 works fine. I'm not sure if it's a bug or
>> >     what.
>> >
>> >     I did most of my testing with clang-6.0, which gets this case righ=
t.
>>
>> Hmmm, I got the same wrong results (IMHO) from Valgrind, which
>> classified this as "definitely lost". Like you I found that -O0 helped.
>> And yes, that was with gcc. Maybe gcc with optimization somehow manages
>> to hide the pointers from these tools. I know too little about the
>> technical details to have any real ideas, though. My searches did not
>> bring up anything useful. (gcc 5.4.0)
>
> Yeah, I think it is just optimizing out the variable entirely. If
> RUNTIME_PREFIX isn't defined (and it's not for non-Windows platforms)
> then we never look at the variable at all, and it's a dead assignment.
> And the compiler can see that easily because it's got static linkage. So
> it drops the variable completely, but it can't drop the call to
> xstrdup() with the information in exec_cmd.c. It has to call the
> function and throw away the result, resulting in the leak.

I see. Yeah, that makes sense.

FWIW, this series (combined with the other series you mentioned) makes
t0000 and t0001 pass for me with gcc/clang. There are actually some
leaks in t0000, they're just silently being reported to stderr, since
the exit statuses from git are hidden by pipes. Maybe you're already
aware of it. Depending on your definition of "running clean" it might be
out of scope for this series, which is of course still very interesting
and enlightening as it stands.

One is in cmd_show (you did mention git show) where we leak data in rev.
The other is some use of strdup. I can't immediately figure out how to
get a useful stacktrace (you mentioned this as well) and it's past
bed-time here. I'll try to play more with this tomorrow.

Note for self: getting rid of all pipes would probably also help flush
out a few leaks (or "introduce" them, depending on your viewpoint).

Martin

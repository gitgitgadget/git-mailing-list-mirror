Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B401820248
	for <e@80x24.org>; Thu, 21 Mar 2019 08:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfCUIuR (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 04:50:17 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37963 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfCUIuQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 04:50:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id q14so4315544edr.5
        for <git@vger.kernel.org>; Thu, 21 Mar 2019 01:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=JUe7fe3F/BeuS27Xb9uUuVEAYtli8UOkQ4zZZ8J4V38=;
        b=JD6JScI1E1Q2KxGTFeLJu3hRzsEdiQo53CM5SS21CpR4dcD2p08p93atZhjELMR2Ig
         v15+DliUSPZeGG/WSbxHjpzN0/X6oWi982w47rP2TPWqs8PkZZRFf9PAQzKnUuQ3fSTu
         X7QVq3YtPlAQ7shOmKbXYKes2YiPwPvmJLaIbGG1/L+1+i0hE/OOV0i5gsOHLIC1e0Lx
         DPtGdm8GtOfW1Rz07h7ie4JdnojB39R+m0KYOdK8cGtZuRitTfrxd1eP6ELH55udfaGa
         BnY1ZEy8EIwP+fXCxNLmAqHtre7OCKrHGswyqioUlQJUoE51XUHqgf8xbbn8IUf/5ENu
         Si0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=JUe7fe3F/BeuS27Xb9uUuVEAYtli8UOkQ4zZZ8J4V38=;
        b=qlnTsLx1ijFTe8HWlMFPgMKG+hjqiwm1ZpsXt7paFx+590R7gTSUdA8YDsR3reF2Lo
         M5lGGLT+7it2GC40Ca9oF9OrbqpawEvTYO07V27+0DJEKBD9TxZoUW/YFToMS0MH4l0J
         Zpq9iYG9I60IqK2SQRYP4qjwIHUUgtsV03irSFgXVRQfwJomQLQgsiIPYDCzTLCaYDEa
         /9mr2o0SpYAJQn69xUXr7SNUsdlchMN3gULjazLBzWinMCvrJcBf3p20HSgSYzz110SC
         LBE8cpUXuL3LoNNb1vJ7a8C1PVwT3EIDWNwEAyJV+MCWt1VaZdBgHi6a6I0NZsQEIptw
         cb2Q==
X-Gm-Message-State: APjAAAVJYpZN7rug5Agzylj5qYjBpew1y8asDpqMh29oIYtI0VOTITwo
        IeYi7WktId/EEyZpdXXxdLbDo+Z9
X-Google-Smtp-Source: APXvYqw9grytgHI8KuVwIXPS0Dhbf3SiidFZEJHVJ9dqarjEpO2+aUgFF4k6B6b6bn0Y+afXehdrKQ==
X-Received: by 2002:a17:906:2f09:: with SMTP id v9mr1626506eji.105.1553158214851;
        Thu, 21 Mar 2019 01:50:14 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id g4sm894921ejd.74.2019.03.21.01.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 01:50:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/13] more unused parameter cleanups
References: <20190320081258.GA5621@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190320081258.GA5621@sigill.intra.peff.net>
Date:   Thu, 21 Mar 2019 09:50:13 +0100
Message-ID: <87woksd322.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 20 2019, Jeff King wrote:

> Here's another round of -Wunused-parameter cleanups. Previous rounds
> were at [1] and [2]. As before, these are mostly just removals, so it's
> easy to see there's no behavior change (there are a couple of cleanups
> that ride along, though, so watch for those).
>
> There are two minor conflicts when merging with pu:
>
>   - jt/fetch-cdn-offload tweaked the "pack_lockfile" parameter to
>     fetch_pack(). A few other parameters are dropped in this series.
>     The textual resolution is pretty straightforward.
>
>   - ps/stash-in-c (et al) added a new call to report_path_error() in
>     builtin/stash.c, which here loses its redundant "prefix" parameter.
>     There's no textual conflict, but the new call needs to drop its
>     final NULL parameter in order to compile.

LGTM from skimming it, FWIW this is now what we need to compile cleanly
with -Wextra:

    make DEVELOPER=1 DEVOPTS="extra-all" CFLAGS="-Wno-unused-parameter -Wno-missing-field-initializers -Wno-sign-compare -Wno-empty-body" all

For some such as -Wempty-body we'd really need to contort ourselves to
get it passing anywhere near cleanly (all of those have existing "/*
this is intentional! */" comments).

I wonder if for the rest of these it's worth re-picking up this old
suggestions of yours about #pragma:
https://public-inbox.org/git/20170126143252.ne533mcv3n2ksbai@sigill.intra.peff.net/

I.e. for us to define our own macro for these cases & use it.

https://gcc.gnu.org/onlinedocs/gcc/Diagnostic-Pragmas.html
https://clang.llvm.org/docs/UsersManual.html#controlling-diagnostics-via-pragmas

I was looking into this for SunCC the other day, it has various new
warnings that are useful that neither gcc nor clang (or anything else
I've tried) has, but also has some stupidities due to faulty code
analysis, luckily those can be disabled:

https://docs.oracle.com/cd/E19205-01/819-5265/bjaby/index.html

This would allow me to compile there with -Werror.

It would mean quite some macro verbosity in some existing code, maybe
it's not worth it...

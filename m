Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA5DB20372
	for <e@80x24.org>; Thu, 12 Oct 2017 20:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbdJLUek (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 16:34:40 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:56016 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbdJLUek (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 16:34:40 -0400
Received: by mail-oi0-f48.google.com with SMTP id g125so10365342oib.12
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 13:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wLaUjgkiY67rNpeB/QohiB39t0zt8RsRD0rY6QQ6gD0=;
        b=Svq3Q7Na86MVmIQn3Bi7zDbi8/8AwPmJriwmPichi+oawr9L91e16a6lQL+0KR/ggo
         iPAzI09Ekx4FXxj+gAa2nHMWSvU2kRLUTPXChzA81KngXv3B8RSMXjV3iLSLrdtcOEUa
         KDhruRxK42+HLaqVoQrH3RwZ8NWNRHuVZrE6jRVen+U0BqqGYwdbAPCNq8kUYFbb30SE
         llFxTx9q2VsXREKo5Wclvfl0uU3hghGwKpXjB+CHptxKMn3RtAVWGUUu4UAC5EdGbt7Q
         zIYHQUc4VHLWvqVloLvqATEnJ0PqQKRTvYHokCA8PDJCymXZkN+i2tXYfwJ4JJWcKvGD
         4kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=wLaUjgkiY67rNpeB/QohiB39t0zt8RsRD0rY6QQ6gD0=;
        b=P5kHuFYm3CcYpEAYrmEE02vvr1CkHEeKe2mjV/NLG1byYsop7gvBQ5dlmKffJBstTS
         3MGDh5Peqh0Om6xLUHO4qxDC/UVspBkYY1CiXxm0UrxuKrrO1N/eSukumMpz+x7xOOv1
         6akYQqxeTmHCLJGOL/afgNbC+L8pUFbylslKk9nntoeB+RPa6pCV69Cpl/UnVkzQ9+GJ
         /+YB1l8K9+2e0XErNIWMo81EVV6boM/ciWUDuE/qLul5B7TIl+DGEZMnjnTXJKK/s5RB
         Erqj3yV6JRfdh349yz7xIQdphWqnbJOWzG3Ra0bev4BapT7OZCaN4TAGAJJZsH4HIKak
         V49Q==
X-Gm-Message-State: AMCzsaWlXmTXyij/QG3LZ0F2eIlOZZMCorEJgmvaZCSAoSGZ5GllTcnC
        AG6NWDdpJX2J2qQ1WWBs1c3au458z3oCW3mrnXWJXA==
X-Google-Smtp-Source: ABhQp+Q1JN4InE2cqL2Rezzx1zpdzG9UUiaYsoZGRJkHQaTj9y6J5UqjrRVbbe+34FCZUQcsaHL+ANC3N6se9poTybQ=
X-Received: by 10.202.8.133 with SMTP id 127mr929848oii.264.1507840479393;
 Thu, 12 Oct 2017 13:34:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.19.87 with HTTP; Thu, 12 Oct 2017 13:34:38 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <20171012201023.wrfbs7p7lups5glz@sigill.intra.peff.net>
References: <CAH8yC8mvG3bSpgshHay7B0SSyAafWLrPTtVZRuq2cShn9xQ9JA@mail.gmail.com>
 <20171012201023.wrfbs7p7lups5glz@sigill.intra.peff.net>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 12 Oct 2017 16:34:38 -0400
Message-ID: <CAH8yC8nHpdA+fX3pcaLRzEYwTCmoxF3NKSh6SUkORZuEvg0JGA@mail.gmail.com>
Subject: Re: undefined reference to `pcre_jit_exec'
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 4:10 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 12, 2017 at 04:06:11PM -0400, Jeffrey Walton wrote:
>
>> I have a script to build Git on some old platforms to ease testing.
>> Old platforms include CentOS 5. The script is available at
>> https://github.com/noloader/Build-Scripts/blob/master/build-ssh.sh.
>>
>> It looks like something got knocked loose recently. I'm seeing several
>> of these when building with PCRE 8.41 with Git 2.14.2. Old and new
>> platforms are witnessing it. I observe it on CentOS 5 with GCC 4.1;
>> and Fedora 26 with GCC 7.2.
>>
>>     ...
>>     LINK git-credential-store
>> libgit.a(grep.o): In function `pcre1match':
>> grep.c:(.text+0x1219): undefined reference to `pcre_jit_exec'
>> collect2: error: ld returned 1 exit status
>> make: *** [Makefile:2145: git-credential-store] Error 1
>
> Maybe:
>
>   $ git grep -h -B5 -A1 pcre_jit Makefile
>   # When using USE_LIBPCRE1, define NO_LIBPCRE1_JIT if the PCRE v1
>   # library is compiled without --enable-jit. We will auto-detect
>   # whether the version of the PCRE v1 library in use has JIT support at
>   # all, but we unfortunately can't auto-detect whether JIT support
>   # hasn't been compiled in in an otherwise JIT-supporting version. If
>   # you have link-time errors about a missing `pcre_jit_exec` define
>   # this, or recompile PCRE v1 with --enable-jit.

Ah, thanks. A quick search did not find that comment. And it did not
occur to me to re-run --help to read about it.

> It looks like autoconf turns on USE_LIBPCRE1, but isn't smart enough to
> test NO_LIBPCRE1_JIT.

If Git wants Jit, then I am inclined to configure PCRE to provide it.

A quick question if you happen to know... Does PCRE Jit cause a loss
of NX-stacks? If it causes a loss of NX-stacks, then I think I prefer
to disable it.

Jeff

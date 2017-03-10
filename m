Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25A4E201C2
	for <e@80x24.org>; Fri, 10 Mar 2017 21:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933094AbdCJVu4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 16:50:56 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:36564 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755585AbdCJVux (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 16:50:53 -0500
Received: by mail-lf0-f44.google.com with SMTP id y193so45920870lfd.3
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 13:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Mdf3epJEZdXEDQ0YWLyPKbTc60lZyjCtFDSlOA30XcM=;
        b=MBnH3UgOjSBPnAQHyntNZynjdy/CRInWI7G23K9SzGqjx+2dszptM9mlephHZcC/OX
         lvV1orLvrVdnobvGAwFnEpSYVFQHOp2Jcu2lzBgUgaUUK/We+MWTOWJR7bi1MPzJpL9M
         QJxVDcK/OHVTZ0cZNOE+Fhqw/QAMF/nKqa7tkeCyU33mLJwp4m/RbiZEgrDHjjaKlvwF
         lqv0FO1XgIJVzSV8yH/dzthvS5aZT6NljaZtm0Qc7qf85keqQMSZdixJOUTuy+t0wql4
         g5rnfY6x+zY79goHb3uy/sTXZdeo+I6a+7IcxvIzHoh5JM4ClQ/fcLrZyLL0sz8cItgK
         NaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Mdf3epJEZdXEDQ0YWLyPKbTc60lZyjCtFDSlOA30XcM=;
        b=BjEOcfRh4xo5wXh8oyHaOAJxaJLSLWKOag+7lwG7mOvKifdTFV3BXk+3W2b+2qtfCy
         77J8Fc/dlacEiOOtqAogslvEPjM92qBsRns2rJ7HAl0ye8sa/qhc7ruqmbi4jptBhAQZ
         QqbHkqfFhN93gx5IUjnRVvxhCBsW7rvnT3bCWNOAYr6wFhbtzXO1dQLUmgzxw0KEECS0
         Idc9MqGgPFxs1NUukYnUbdZyL1brRduLaYz/dUGXt86/fAYDPFxxgnveSagb7KgkwpST
         A0Yc5fxC7QzE1OSY5H1ZHE44tmv6V8syXfXZjaW60M3Qw9SuXXG6QdzMYFyfS8UsyTqX
         LaHQ==
X-Gm-Message-State: AMke39k73aPms4ZVLERhtbcalbm0BKy+g5CYWemcDUmsr2SMgT5eF2nEfMPwLh+1dQ9KsUL/0GdaeAFjFPyZ8A==
X-Received: by 10.25.233.21 with SMTP id g21mr5690882lfh.130.1489182650811;
 Fri, 10 Mar 2017 13:50:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.19 with HTTP; Fri, 10 Mar 2017 13:50:50 -0800 (PST)
In-Reply-To: <20170310181342.GE26789@aiede.mtv.corp.google.com>
References: <20170309193050.19988-1-sbeller@google.com> <20170310181342.GE26789@aiede.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 10 Mar 2017 22:50:50 +0100
Message-ID: <CAP8UFD0xCCcmd66ChsfxPBFohekucBx3ib4Ayi+KQOXNZFHMjQ@mail.gmail.com>
Subject: Re: [RFC PATCH] help: add optional instructions for reporting bugs
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 7:13 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Stefan Beller wrote:
>
>> When reporting bugs, users will usually look at the output of
>> 'git --version' at one point to write a quality bug report.
>> So that is a good spot to provide additional information to the user
>> about e.g. additional the organizational quirks how to report a bug.
>>
>> As the output of 'git --version' is parsed by scripts as well,
>> we only want to present this information to users, which is why
>> we only give the output to TTYs.
>
> Interesting thought.  This might also be a good place to point users
> to "git version --build-options" to get more detailed build
> information.

It looks like there is no documentation for `git version` which is a
bit unfortunate.
Also `git version -h` ignores the -h option so we cannot know that
--build-options exists.

> The existence of that option also suggests you're on the right track
> about 'git version' being the command for this.

I agree, but I don't think --build-options is the best for that.

>> Git is distributed in various ways by various organizations. The Git
>> community prefers to have bugs reported on the mailing list, whereas
>> other organizations may rather want to have filed a bug in a bug tracker
>> or such.  The point of contact is different by organization as well.
>
> It's tempting to put the custom information in --build-options --- e.g.
>
>  $ git version
>  git version 2.12.0.190.g6e60aba09d.dirty
>  hint: use "git version --build-options" for more detail
>  hint: and bug reporting instructions
>  $
>  $ git version --build-options
>  git version 2.12.0.190.g6e60aba09d.dirty
>  sizeof-long: 8
>  reporting-bugs: see REPORTING BUGS section in "git help git"

I don't think it's a good idea to add those "hint: ..." and
"reporting-bugs: ..." lines.

I think it's better to do things like the following:

- add `git version -h`
- add proper documentation for `git version` so that `git help version` works
- in `git help version` talk about the REPORTING BUGS section in `git help git`
- add `git version --full` or other such options to also print other
stuff like the current OS, processor architecture, libc, etc
- suggest in `git help version` and/or in the REPORTING BUGS section
in `git help git` that people just copy paste the output of `git
version --full` in their bug report

[...]

> I'm still on the fence about whether this is a good idea. At least
> having custom bug instructions in --build-options sounds like a very
> nice thing, but it's not obvious to me how people would learn about
> that option.

Yeah indeed.

Thanks,
Christian.

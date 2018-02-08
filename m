Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE5891F404
	for <e@80x24.org>; Thu,  8 Feb 2018 21:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbeBHVEO (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 16:04:14 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:40180 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752322AbeBHVEK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 16:04:10 -0500
Received: by mail-yw0-f180.google.com with SMTP id j128so3636480ywg.7
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 13:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TdP6bfWhvkrNqi1pUFWKATmjOwy7oIqlRXhQ8rZh/EA=;
        b=nRbzlwuKhbiIWo1g/+prN1RhJB7uCFbuXxp5KGH/zdfZcY88advGYMzY58qCZDmDsM
         CwLyszJruda4kEwqAoasepNqVyu/A4MWvK0OQrqq7V+/+uFnJ33eOlWz6YLkTVxXgtCZ
         zcpYTE7mXID77iDJR45c68laFrcCW3Gec0lkZv8IN03momfteKKEXo6O1A21sI++ZQCA
         P/N+e+lKdi4ricWA4qdQ9krKuL42aJVz3UrNzzH+PwEdcq++h5w+NAkU1qr5Px3hIJ9x
         NKQx14Xfd0eDU457+kWYc/KZFgbHM7cr+X57Rl2cHH6Miq/qvLwBamaifvLKhWiLkjfA
         kJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TdP6bfWhvkrNqi1pUFWKATmjOwy7oIqlRXhQ8rZh/EA=;
        b=tb8ITeQiDqzxKIIOkB8wxhlxcewXIJVgQCcHfh5UNeIQ4fd3puVNFsGns9/5pdJGim
         5/6p+lzzrrP8UqhayKuAleP+YD9m5VElCQPB0+UlTjo3JJVum/KHLAzYdan/UtLTN4vy
         8yFNu7I4jABgc3lCE+XJhysMyNVv9alc8DC4puwxqo8VKDXMPUa2iROHgTXcnYYu5iJI
         COl4LtPH8CXcTMmBW3srX/hnPVlg0mcMMW5Yho5VRFVJdZVnEWT22MskvxGd/kvPT77x
         l5Y0AoxmCcdLLErVpcgVlXPg2sfF4JiIl0s6mzM6RwM/EiFT4LNcagtkjSiowwiJzhKT
         kzGg==
X-Gm-Message-State: APf1xPB4o7F04tuUWama6wmaYpcDXwIaVGrFgBAv0POARwJX33PovIZH
        +9Xxd5m1DuUBNpcU+iuja/QCy+8dnUoCVK6a6xhsRg==
X-Google-Smtp-Source: AH8x227cId0uGXAb7y3DvU3CX07wLl+ekSf/s4CzWvVjsNy2pUTYqyO7PW++NqcPYuDPNn90N6VNdBrqCdxUR9xRG+M=
X-Received: by 10.37.12.130 with SMTP id 124mr276523ybm.39.1518123849002; Thu,
 08 Feb 2018 13:04:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Thu, 8 Feb 2018 13:04:08 -0800 (PST)
In-Reply-To: <20180208204309.GA4541@sigill.intra.peff.net>
References: <20180208201546.194935-1-sbeller@google.com> <20180208204309.GA4541@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 8 Feb 2018 13:04:08 -0800
Message-ID: <CAGZ79kb+xEVZagqqNCHCPQUbfH89N7fdrO7dp6WHRGgJJje28Q@mail.gmail.com>
Subject: Re: [PATCH] color.h: document and modernize header
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 12:43 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 08, 2018 at 12:15:46PM -0800, Stefan Beller wrote:
>
>>  int color_fprintf(FILE *fp, const char *color, const char *fmt, ...)
>>  {
>>       va_list args;
>> diff --git a/color.h b/color.h
>> index fd2b688dfb..8c7e6c41c2 100644
>> --- a/color.h
>> +++ b/color.h
>> @@ -72,26 +72,50 @@ extern int color_stdout_is_tty;
>>   * Use the first one if you need only color config; the second is a convenience
>>   * if you are just going to change to git_default_config, too.
>>   */
>> -int git_color_config(const char *var, const char *value, void *cb);
>> -int git_color_default_config(const char *var, const char *value, void *cb);
>> +extern int git_color_config(const char *var, const char *value, void *cb);
>> +extern int git_color_default_config(const char *var, const char *value, void *cb);
>
> Hmph, I thought we weren't adding "extern" everywhere. See:
>
>   https://public-inbox.org/git/xmqq8tea5hxi.fsf@gitster.mtv.corp.google.com/
>
> Other than that, these changes mostly look like improvements. A few

...

> Those are all suggestions. Given that there's no documentation currently
> on most of these, I think even if you don't take any of my suggestions,
> this would still be a net improvement (modulo the "extern" thing).

A funny and sad rant about why clear communication matters:

[Once upon a time, maybe 2 years ago] I had the impression that the old
code is nicely written and was consistently marked extern in header files.
(which btw is consistent with variable declarations, they need the extern).
All the new code doesn't make use of extern, so I had this on my low prio
todo list, that eventually all code converges to have 'extern'
functions in headers.

C.f. the following commits, found via
  git log -p --author=Beller -S extern

  5ec8274b84 (xdiff-interface: export comparing and hashing strings,
  2017-10-25) adding new externs

  1ecbf31d02 (hashmap: migrate documentation from Documentation/technical
  into header, 2017-06-30), a cleanup, which doesn't touch externs

  a6d7eb2c7a (pull: optionally rebase submodules (remote submodule
  changes only), 2017-06-23) new code using externs

  bd26756112 (submodule.h: add extern keyword to functions, 2016-12-20)
  (The commit message is as accurate as it gets)

You may sense a pattern here: I currently have the very firm understanding
we use the extern keyword in our codebase.

And I can also attest that this was not always the case, as back in the
day I remember writing patches without the extern keyword only to be told:
(A) be similar to the function in the next lines
(B) the standard is to use extern
and I was convinced it was a bad decision to prefix declarations with
the extern keyword, but followed along as I don't want to have style
in the way of writing features.

  $ cat Documentation/CodingGuidelines |grep extern
  $ # oh no it's empty!

Care to add a section to our coding guidelines?

Thanks,
Stefan

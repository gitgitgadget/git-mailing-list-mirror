Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D35B41F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 19:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbeJMCtc (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 22:49:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38939 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeJMCtc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 22:49:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id 61-v6so14539119wrb.6
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 12:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0u2H1XodyS1pM+Hy6GU7Owt6ZALm63Xgcv5Tz1RmwQE=;
        b=PYkWLjPjRZie2wfDSPfG/+9xM8kiP5Cs2Yf+LGxGCzipe5qKc4slcgAyL901Sw/+WS
         Co/mSYXEoXWEPbXJC2mdg89uWID6SQ3smaVXX8NCn4IzvjUjda1HrQt90V/NS8N9pexY
         u4a/KgcH1d00SzxslJD4aiUBitZ8MbAecE2WUDOij+52v3XIzU9ojmXr330SxGJFX2Ba
         9+7SDtW9h1JrYNpRjf5OUxVHI3tV6MxTxhOvh0ZSt6XMXx48Spjup7K3Yfc8liWkJY9B
         GCHCQ4B+GCpVRKe1O6yiSipZ8wMafOEuwNvwqXYrsqq9MRMfa3T5+EMk+EySiusYMYiK
         3Q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0u2H1XodyS1pM+Hy6GU7Owt6ZALm63Xgcv5Tz1RmwQE=;
        b=ZiU8A3o56XMrdVH51kJmcWDoEW9gFKBv47sklRwgY2eF1v65pgT9CmFEmBg54QgnMd
         0oIiRCcJ70VEcL9CFN3YmoOzPEuwK8ZYYLlZj5wa9JfE5NC2XXmiSP3a1Od5B53fwjbC
         PuQqV/R1DnEmEqtRWVy17pDVhhsmkhr6NEeLB5Oy0mzRA0PBSx+DrPG5i7OnDJJwpVdk
         q8FrjLHKGz9TtZpLUVFcmcDZCEZjFmqjuLG8A+fO3WhlBg+Hok25XO+zPHmKwAvA42IR
         1ENSxGsGC+K88V659xYDyWDyqhZMJby0X6n0am6c9VQTpJ9iPmRRzagjtoNymo9RUbsS
         TpFg==
X-Gm-Message-State: ABuFfoj4x5n7ZTSWNEXWmxgViTA4HIdxFAvPjLcyquIN2eRefuNkUdtA
        WoS8CwzN8bQ/bKI1WYwD/zw=
X-Google-Smtp-Source: ACcGV62e3zLautjiYgRgd2JXIvephE6H88qNoLkMnh1yd/BHB8RyuUigefW43VuDT3ZnrunEv2CNbw==
X-Received: by 2002:adf:f3c7:: with SMTP id g7-v6mr6050608wrp.229.1539371733671;
        Fri, 12 Oct 2018 12:15:33 -0700 (PDT)
Received: from localhost ([31.127.45.92])
        by smtp.gmail.com with ESMTPSA id 62-v6sm2487316wra.48.2018.10.12.12.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 12:15:32 -0700 (PDT)
Date:   Fri, 12 Oct 2018 20:15:31 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH] config.mak.dev: add -Wformat
Message-ID: <20181012191531.GA22611@hank.intra.tgummerer.com>
References: <20181012184037.15076-1-t.gummerer@gmail.com>
 <20181012184549.GC4917@sigill.intra.peff.net>
 <20181012185450.GB52080@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012185450.GB52080@aiede.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/12, Jonathan Nieder wrote:
> Jeff King wrote:
> > On Fri, Oct 12, 2018 at 07:40:37PM +0100, Thomas Gummerer wrote:
> 
> >> 801fa63a90 ("config.mak.dev: add -Wformat-security", 2018-09-08) added
> >> the -Wformat-security to the flags set in config.mak.dev.  In the gcc
> >> man page this is documented as:
> >>
> >>          If -Wformat is specified, also warn about uses of format
> >>          functions that represent possible security problems.  [...]
> >>
> >> That commit did however not add the -Wformat flag, and -Wformat is not
> >> specified anywhere else by default, so the added -Wformat-security had
> >> no effect.  Newer versions of gcc (gcc 8.2.1 in this particular case)
> >> warn about this and thus compilation fails with this option set.
> [...]
> > -Wformat is part of -Wall, which we already turn on by default (even for
> > non-developer builds).
> >
> > So I don't think we need to do anything more, though I'm puzzled that
> > you saw a failure. Do you set CFLAGS explicitly in your config.mak to
> > something that doesn't include -Wall?

Whoops embarrassing.  I had this set in my config.mak:

    CFLAGS = -O$(O) -g $(EXTRA_CFLAGS)

What happened is that I had included -Wall in an old config.mak that I
copied from Thomas Rast when I started with my GSoC project.  Then
when "DEVELOPER=1" came around I switched to that at some point and
just removed everything from CFLAGS, except the possibility to
override the optimization level, the ability to add extra flags and
including debug symbols, but failed to notice that I had lost -Wall.

Maybe it would still be a good to add -Wall to avoid the surprise for
others.  But then again if someone overrides CFLAGS they should at
least check better what they're overriding ;)

> Thomas, do you use autoconf to generate config.mak.autogen?  I'm
> wondering if that produces a CFLAGS that doesn't include -Wall.

No, this was all my mistake :)

> > I'm not opposed to making config.mak.dev a bit more redundant to handle
> > this case, but we'd probably want to include all of -Wall, since it
> > contains many other warnings we'd want to make sure are enabled.
> 
> Do you mean putting -Wall instead of -Wformat?
> 
> Should we add -Wextra too?  From a quick test, it seems to build okay.

We do have that with setting DEVELOPER=extra-all.

> Thanks,
> Jonathan

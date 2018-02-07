Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE4281F404
	for <e@80x24.org>; Wed,  7 Feb 2018 22:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750806AbeBGWUM (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 17:20:12 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:41844 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeBGWUL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 17:20:11 -0500
Received: by mail-wr0-f176.google.com with SMTP id u60so14695wrb.8
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 14:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5LwsjaQdlxPSFQD/XkGO+5B8tA450wLufL6kcpPhkLE=;
        b=JYUyrw7RCYy+Za/66GvOwY4g28mpj2yFrLVBPprEvWquKxgH6tyQ7f5QcY/NENgCWo
         9hzzK1je2LFEesFPtlhANBslCMcVcNU4jcCsYmq/VsvZNi5vp7qHeHq+4yS0I61XZ3p8
         Mjm8VkfANR9GZ7wSyDSECDM1XCc0T/5EYwfhY2VSn7a2X2eLDmG/yMSSm+xdSLMKb8Nv
         0GsXCKRW7x06zd9cQOc8uyeVgawxED6yr7BWQ49+2KXturXm5D/5sp8TgNO7Zgb0raQk
         /PTHzIbnzEcvY6OToBSgIxeW7qF7NsR6EY3ZuSC18wjVQN7Avl4ZwYvzEfxTDi9N2RpS
         16AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5LwsjaQdlxPSFQD/XkGO+5B8tA450wLufL6kcpPhkLE=;
        b=couVjwQjE5mCD+fw+z5L2cgC9W1HEqNueUNLM7hCK3TuSWQf8yE5mkfbSn05YE6P8O
         xIy+z8KMNYaEuGzkaGtVM1i9LThjhdMzO//MDSka3QMluJsRoPDPvVXgvBn6/Tw9wSus
         Kf57QdJuuqg3hlO+/ab5zGz1ZTv9+Pgs6+kIyTClDvSA61UvczMTQsmL4vUzTUxDYE+h
         FWm6O8ClR6Qp8fzi/+wSXII9gtdxPxVEwhDU4Mufi6dEmQGZjDniMrS/lN897BBdsNmM
         kiJm8Lvu3e/yPuWlBgPhUfQaQjHFPUDePSvhH/EWhCSjsuhWaNAklpz3kaYS6n1oTO1z
         DiGA==
X-Gm-Message-State: APf1xPCPICGJhLHpKnqayKnvWZJaTsG6PwYOdR+lVfdw1aBWfuO5MVzo
        Vq9pR32KsXB1FcwChSjNGKQ=
X-Google-Smtp-Source: AH8x226FJvd5lUP8uz3+PI0k0Kb1TWGqyzdwlIUgCxBPXM7BZmSZquTXX2F0fZhgedv2/7NwbRywhA==
X-Received: by 10.223.134.236 with SMTP id 41mr6783698wry.87.1518042010244;
        Wed, 07 Feb 2018 14:20:10 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5C1B.dip0.t-ipconnect.de. [93.219.92.27])
        by smtp.gmail.com with ESMTPSA id u43sm2013465wrf.63.2018.02.07.14.20.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Feb 2018 14:20:09 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: "git branch" issue in 2.16.1
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180207200859.GA9141@sigill.intra.peff.net>
Date:   Wed, 7 Feb 2018 23:20:08 +0100
Cc:     Stefan Beller <sbeller@google.com>, Todd Zullinger <tmz@pobox.com>,
        Jason Racey <jason@eluvio.com>, git <git@vger.kernel.org>,
        Paul Smith <paul@mad-scientist.net>
Content-Transfer-Encoding: 7bit
Message-Id: <F7E12F8B-6C55-4348-860A-B91942922A73@gmail.com>
References: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com> <20180206195754.GE1427@zaya.teonanacatl.net> <CAGZ79kaxf3qUyOe6R-LCgyLtwzrwhB=y767tk2qPbC_KR473ig@mail.gmail.com> <5A7788B0-6250-4D1F-A86D-E3155C03EF0C@gmail.com> <20180207200859.GA9141@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Feb 2018, at 21:08, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Feb 07, 2018 at 06:54:23PM +0100, Lars Schneider wrote:
> 
>>> Maybe the number of branches changed since then?
>>> As the pager only comes to life when the output fills
>>> more than your screen. Quick workarounds:
>>> * buy a bigger screen
>>> * have fewer branches.
>> 
>> Hmmm... there might be more to it. I just noticed the
>> pager behavior on macOS, too. Consider this call:
>> 
>> $ git diff --shortstat
>> 
>> This should generate at most one line of output. On Linux
>> the pager is never used. On macOS the pager is always used.
>> 
>> I tried older versions of Git on macOS and experienced the
>> same behavior.
> 
> Keep in mind that we always run the pager, since we don't know ahead of
> time how much output will be generated. It's just that with certain
> configurations of "less", it may exit if it sees EOF before there's a
> whole screen worth of data.
> 
> This is controlled by the "-F" option. By default, Git will set LESS=FRX
> in the environment if you do not already have a $LESS environment. So
> some other possibilities are:
> 
>  1. You have $LESS in your environment (without "F") on one platform
>     but not the other.

I think that's it. On my system LESS is defined to "-R".

This opens the pager:

	$ echo "TEST" | less

This does not open the pager:

	$ echo "TEST" | less -FRX

That means "F" works on macOS but Git doesn't set it because LESS is
already in my environment.

Question is, why is LESS set that way on my system? I can't find
it in .bashrc .bash_profile .zshrc and friends.

- Lars


> 
>  2. Git was built with a different PAGER_ENV Makefile variable on one
>     platform versus the other (that's what controls the baked-in LESS
>     defaults).
> 
>  3. "less" somehow behaves differently on macOS. The "F" behavior is
>     quite old, but possibly there's some platform-specific bug.
> 
> -Peff


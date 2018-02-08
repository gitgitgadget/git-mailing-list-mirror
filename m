Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12421F576
	for <e@80x24.org>; Thu,  8 Feb 2018 11:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751014AbeBHLNi (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 06:13:38 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34427 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHLNh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 06:13:37 -0500
Received: by mail-wr0-f172.google.com with SMTP id z6so4280043wrb.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 03:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OasKFhsv4n5mRASXF2NA4d5Ebz5wMeoj9NCjzYzRDXY=;
        b=HJtvYPDQbVVeiXqKdOcVcTqvZmmPC3lGSgJ6VYg4GAMX7uzJbL6eQ9PZ7o+WYrwLHG
         ACI88DfIBzu5jDhybvrZyQ7H2xL5jTQ8MCObMe5a4chRQXdlLE6toBepIyR4QhoqeslB
         VVr94JKipldh++enJuToIKtJpM3PsyzoHHWZS5cqIo6DTXG89tbKWp/T5pNOlI4cIZ1Z
         gr5cmotgEaUTQMgSzIBiO1VGQC5ayPgVbgFxMp6wy0/WZYTfFHFTk+jGtEB0jYpI1Mkp
         rGJjizCqiF603fRiwITP/VAy2mUJNGaGXZ2omCIKH1sG8pDMVeJEikwNpPvd45LzAbKW
         sZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OasKFhsv4n5mRASXF2NA4d5Ebz5wMeoj9NCjzYzRDXY=;
        b=ZUfUAw2U7BwEi8uhnIpsE3eRymYYr/0wnWdNTYgGJ5jpDi0lTaElmJkKwLAiRMcyuA
         xwsGlis9w6Y/9Slb6Ip/1VFomE3g8xLR6G/LO1PbFdrb4alNdNmg4SpH5WxUIAfQNf3z
         bQQbSdyCpDgHdOHiakOFo0VkBeISIE2P98hH74riOWmWvi/3nDE3L8H4vROoYZgUpzrR
         ymVSa9ZOi81KqAuUJNF0spqbbS9ipN7fhw15S8Z0MyPs/e6KlYWjansCss1kGdE3WUfE
         sYEaRq+uMFdkOA0QNKcaeHPzZWXFuinbgtsGqRqbQwAkSYitkJs3riSGEPy6w7tTNjE6
         yzqA==
X-Gm-Message-State: APf1xPCnvydpbHtME0Z2CohruehJ/GnXng1clQ9dpTvEbeXgcEz4XkB0
        BCRQtlN/MwyNGExCpLsEQ5STrNrk
X-Google-Smtp-Source: AH8x225HV6W0hfRM0aMOMVVGlR3UNTGVlL0d4puvBBZKVtLPWdo3DB3vzHpCOC82xXIZm8SmAS8oDA==
X-Received: by 10.223.136.73 with SMTP id e9mr386622wre.98.1518088416316;
        Thu, 08 Feb 2018 03:13:36 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id h14sm2799262wrb.29.2018.02.08.03.13.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 03:13:35 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: "git branch" issue in 2.16.1
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180208085015.GA24571@sigill.intra.peff.net>
Date:   Thu, 8 Feb 2018 12:13:34 +0100
Cc:     Stefan Beller <sbeller@google.com>, Todd Zullinger <tmz@pobox.com>,
        Jason Racey <jason@eluvio.com>, git <git@vger.kernel.org>,
        Paul Smith <paul@mad-scientist.net>
Content-Transfer-Encoding: 7bit
Message-Id: <CBF51BD2-0B54-43E3-BB48-884C7DB94237@gmail.com>
References: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com> <20180206195754.GE1427@zaya.teonanacatl.net> <CAGZ79kaxf3qUyOe6R-LCgyLtwzrwhB=y767tk2qPbC_KR473ig@mail.gmail.com> <5A7788B0-6250-4D1F-A86D-E3155C03EF0C@gmail.com> <20180207200859.GA9141@sigill.intra.peff.net> <F7E12F8B-6C55-4348-860A-B91942922A73@gmail.com> <20180208085015.GA24571@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 08 Feb 2018, at 09:50, Jeff King <peff@peff.net> wrote:
> 
> On Wed, Feb 07, 2018 at 11:20:08PM +0100, Lars Schneider wrote:
> 
>>> 1. You have $LESS in your environment (without "F") on one platform
>>>    but not the other.
>> 
>> I think that's it. On my system LESS is defined to "-R".
>> 
>> This opens the pager:
>> 
>> 	$ echo "TEST" | less
>> 
>> This does not open the pager:
>> 
>> 	$ echo "TEST" | less -FRX
>> 
>> That means "F" works on macOS but Git doesn't set it because LESS is
>> already in my environment.
>> 
>> Question is, why is LESS set that way on my system? I can't find
>> it in .bashrc .bash_profile .zshrc and friends.
> 
> There's also /etc/bash.bashrc, /etc/profile, etc. I don't know what's
> normal in the mac world. You can try running:
> 
>  bash -ix 2>&1 </dev/null | grep LESS
> 
> to see what your startup code is doing. I don't know of a good way to
> correlate that with the source files, though. Or even to ask bash which
> startup files it's looking in.

Unfortunately, this command doesn't work for me.

I ask around and most of my coworkers have LESS="-R".
Only the coworker that doesn't really use his Mac and has
no customizations does not have $LESS defined.

Therefore, I think it is likely some third party component
that sets $LESS.

@Jason:
Do you have homebrew, iTerm2, and/or oh-my-zsh installed?

- Lars

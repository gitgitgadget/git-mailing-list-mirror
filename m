Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9E71F404
	for <e@80x24.org>; Thu,  8 Feb 2018 16:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeBHQ2u (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 11:28:50 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:37454 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeBHQ2t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 11:28:49 -0500
Received: by mail-wr0-f169.google.com with SMTP id a43so5332250wrc.4
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 08:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5fB028nx1AQX5tH0nQsP/mXnNGjL+DYj3Xl3jPKEd0o=;
        b=lehyIgUmm2bJzUlp9bDe28KXtiCbpRHApKVUn/i0bEeKAzxIs3QrgALFv2+5Gb34AF
         00/L3KtoxgrCdAgF8AnPo0XcIO/ieOXkIB2CRoDp6Gs6Es7sdTKmDVKER1RElb1zCLw9
         EBxDb5Mtffmowdgb2dsa7+Y4SsZd2q9/aRoQsJ9wTqSGrsPE6IyUgkk6onzTSl2TGviN
         3DQ54Qka4KXA9QcBRXCBt1Jsjk+xsxJCn1vHhgnogqMRk4s96ry8zIv3hpAArSNk93Uz
         swC9QzEAvZxH7q+Lq+wtDoTjD4ncTfYWP1/VY6U5I+2/FZywVaRpRFxfFiLCvGV4fcZr
         uSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5fB028nx1AQX5tH0nQsP/mXnNGjL+DYj3Xl3jPKEd0o=;
        b=JnI96J1hYSxGtSPsZ4tuq0Pp+CW8x5WU2wBEmsHTNQ2EQIlmIYzqegVulPYPZ8wKbB
         ktjx/zAHGpENxc7X8BDsOYlw4smlGEHFLZj0VkhcyMK4+B1ob6KUrVJyw2miXzPUpmV8
         ShotJGsidJhINHTBpPC/mtAaimT7kfuq1y+YLx4MgQO6/Id1vgk5tXgSX4YvEuh7Yl20
         jSf0YGQCB4DYDSBMUa6nT+IvzygK9FTvQzxPZZhPctcQwP83sggUpa0LULhQ3sE7qdTk
         RNvsZqxzclNmeoy3rr1wX/JwxG4FKN7vRdDdhQPyVcZIwbKIRgu/M5AfYufcD6SrtLfO
         OPAw==
X-Gm-Message-State: APf1xPC1DaJP7Inwn5j8oGoU/AW/ZPb1cHN6lh/ec5R/kB/9cpeJH39P
        LufuBTf8KL9x3GwhoBy70Pg=
X-Google-Smtp-Source: AH8x224yZhX4CsOiabuPGM3uO8jHSZLcDu8XjLefrfQ5WQR18G3jPhKj1UhOgdvaMXsFadrjpBkPeg==
X-Received: by 10.223.130.42 with SMTP id 39mr1295132wrb.103.1518107328003;
        Thu, 08 Feb 2018 08:28:48 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id v107sm459391wrc.17.2018.02.08.08.28.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 08:28:47 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: "git branch" issue in 2.16.1
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20180208161959.GA4042@alpha.vpn.ikke.info>
Date:   Thu, 8 Feb 2018 17:28:46 +0100
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Todd Zullinger <tmz@pobox.com>, Jason Racey <jason@eluvio.com>,
        git <git@vger.kernel.org>, Paul Smith <paul@mad-scientist.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <70109B7B-61F1-491D-AC53-D06493E8E6C4@gmail.com>
References: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com> <20180206195754.GE1427@zaya.teonanacatl.net> <CAGZ79kaxf3qUyOe6R-LCgyLtwzrwhB=y767tk2qPbC_KR473ig@mail.gmail.com> <5A7788B0-6250-4D1F-A86D-E3155C03EF0C@gmail.com> <20180207200859.GA9141@sigill.intra.peff.net> <F7E12F8B-6C55-4348-860A-B91942922A73@gmail.com> <20180208085015.GA24571@sigill.intra.peff.net> <CBF51BD2-0B54-43E3-BB48-884C7DB94237@gmail.com> <44FE6343-9236-4F50-A0C1-A70A887A8BC5@gmail.com> <20180208161959.GA4042@alpha.vpn.ikke.info>
To:     Kevin Daudt <me@ikke.info>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 08 Feb 2018, at 17:19, Kevin Daudt <me@ikke.info> wrote:
>=20
> On Thu, Feb 08, 2018 at 12:27:07PM +0100, Lars Schneider wrote:
>>=20
>>> On 08 Feb 2018, at 12:13, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>>>=20
>>>=20
>>>> On 08 Feb 2018, at 09:50, Jeff King <peff@peff.net> wrote:
>>>>=20
>>>> On Wed, Feb 07, 2018 at 11:20:08PM +0100, Lars Schneider wrote:
>>>>=20
>>>>>> 1. You have $LESS in your environment (without "F") on one =
platform
>>>>>>  but not the other.
>>>>>=20
>>>>> I think that's it. On my system LESS is defined to "-R".
>>>>>=20
>>>>> This opens the pager:
>>>>>=20
>>>>> 	$ echo "TEST" | less
>>>>>=20
>>>>> This does not open the pager:
>>>>>=20
>>>>> 	$ echo "TEST" | less -FRX
>>>>>=20
>>>>> That means "F" works on macOS but Git doesn't set it because LESS =
is
>>>>> already in my environment.
>>>>>=20
>>>>> Question is, why is LESS set that way on my system? I can't find
>>>>> it in .bashrc .bash_profile .zshrc and friends.
>>>>=20
>>>> There's also /etc/bash.bashrc, /etc/profile, etc. I don't know =
what's
>>>> normal in the mac world. You can try running:
>>>>=20
>>>> bash -ix 2>&1 </dev/null | grep LESS
>>>>=20
>>>> to see what your startup code is doing. I don't know of a good way =
to
>>>> correlate that with the source files, though. Or even to ask bash =
which
>>>> startup files it's looking in.
>>>=20
>>> Unfortunately, this command doesn't work for me.
>>>=20
>>> I ask around and most of my coworkers have LESS=3D"-R".
>>> Only the coworker that doesn't really use his Mac and has
>>> no customizations does not have $LESS defined.
>>>=20
>>> Therefore, I think it is likely some third party component
>>> that sets $LESS.
>>>=20
>>> @Jason:
>>> Do you have homebrew, iTerm2, and/or oh-my-zsh installed?
>>=20
>> Ha. I found it it! It is indeed oh-my-zsh:
>> =
https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/misc.zsh#L23
>>=20
>> Let's see if oh-my-zsh is willing to change that...
>>=20
>> - Lars
>=20
> I've just added unset LESS in my .zshrc, but for most users it would =
be
> better if they don't set it at all.

I proposed this instead:
https://github.com/robbyrussell/oh-my-zsh/pull/6611

Maybe you can chime in there?

Thanks,
Lars


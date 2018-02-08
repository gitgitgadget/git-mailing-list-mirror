Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7161C1F576
	for <e@80x24.org>; Thu,  8 Feb 2018 11:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751153AbeBHL1K (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 06:27:10 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:45704 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbeBHL1J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 06:27:09 -0500
Received: by mail-wr0-f172.google.com with SMTP id h9so4297112wre.12
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 03:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oUtQmeNUScToDIonOKmV8f/Zs5QvEnL2G/MwM6ln+sc=;
        b=r2+uNsNT0srJ1CJLcBXGfZaa8vFNSJXiu2uPwig3UBbuz0LeVTmnqtIpw0E5bKoNvZ
         vWs9UUxAUBd33oLWLitCa4EDUBCU0sreayjZJpMc6pYdGJUw4RujuU0ysH3Yg/nE2PTY
         BDXxVba+IAORHmydkhvyRe5FsfxBsDDhgfqVE7ezOJ4ZT8fbDkNFuV9yL2wm4JBUt/xB
         AgrsijwDT4s4c1/skslwC8tfqw3oURlFgQrdllqZ4chqN463jRtiiX1SGkOS44h09OVv
         rHPF7k11TvqEWYX+AguCDjtS1v0uEdyKiAXeU6PoOf9+BHnPwZIvzFHS3noUf1XR8g9z
         vYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=oUtQmeNUScToDIonOKmV8f/Zs5QvEnL2G/MwM6ln+sc=;
        b=cWR7FI4lAFCWvCIN6izW7uJkxT1CrDtfllVcd64lwtMuVUe8GrchvlRuDz/K1h8xEJ
         LHkLBDpoe7aW2n38mHSI0ghhJSqLNTlEr3kGqZ8bF/U3nNvIeQXeGpnJk98d2JyOYTXM
         kbEnrfX7hXxi6tcy6n9jMay2+PDWXlgE5f0m6K2s4b8cCSJIYnX7XyCi6cWaQ55q6YA0
         Qth1GGBJ3D3cNDpk4KlX3JljIUM2h8OASgERyTu8P2dIeNcAJs5HGLaanGeDVrrd7Xsl
         6zb+QG8CPgZL3qLxJP7FfcYn5oF8hqBze1JHPan/ZG0RyKZybCiW0lkpim6uYvqgx9w3
         Ml1g==
X-Gm-Message-State: APf1xPA0jVMTwYTUy6bseRZfmNlGbLh5LqTfMtsVPNTB/SQipEt8BasR
        ijsm0TBF/ICuYPp2uIWVl2E=
X-Google-Smtp-Source: AH8x226N1c3Z9XfXZn18jXZmBE0usvc1MdTqnfKcGCRLwOd/DTf5/5Vu1tYvEassWvbcjK9tmde1GA==
X-Received: by 10.223.171.3 with SMTP id q3mr441148wrc.64.1518089228415;
        Thu, 08 Feb 2018 03:27:08 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id e16sm4520334wre.5.2018.02.08.03.27.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 03:27:07 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: "git branch" issue in 2.16.1
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CBF51BD2-0B54-43E3-BB48-884C7DB94237@gmail.com>
Date:   Thu, 8 Feb 2018 12:27:07 +0100
Cc:     Stefan Beller <sbeller@google.com>, Todd Zullinger <tmz@pobox.com>,
        Jason Racey <jason@eluvio.com>, git <git@vger.kernel.org>,
        Paul Smith <paul@mad-scientist.net>
Content-Transfer-Encoding: 7bit
Message-Id: <44FE6343-9236-4F50-A0C1-A70A887A8BC5@gmail.com>
References: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com> <20180206195754.GE1427@zaya.teonanacatl.net> <CAGZ79kaxf3qUyOe6R-LCgyLtwzrwhB=y767tk2qPbC_KR473ig@mail.gmail.com> <5A7788B0-6250-4D1F-A86D-E3155C03EF0C@gmail.com> <20180207200859.GA9141@sigill.intra.peff.net> <F7E12F8B-6C55-4348-860A-B91942922A73@gmail.com> <20180208085015.GA24571@sigill.intra.peff.net> <CBF51BD2-0B54-43E3-BB48-884C7DB94237@gmail.com>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 08 Feb 2018, at 12:13, Lars Schneider <larsxschneider@gmail.com> wrote:
> 
> 
>> On 08 Feb 2018, at 09:50, Jeff King <peff@peff.net> wrote:
>> 
>> On Wed, Feb 07, 2018 at 11:20:08PM +0100, Lars Schneider wrote:
>> 
>>>> 1. You have $LESS in your environment (without "F") on one platform
>>>>   but not the other.
>>> 
>>> I think that's it. On my system LESS is defined to "-R".
>>> 
>>> This opens the pager:
>>> 
>>> 	$ echo "TEST" | less
>>> 
>>> This does not open the pager:
>>> 
>>> 	$ echo "TEST" | less -FRX
>>> 
>>> That means "F" works on macOS but Git doesn't set it because LESS is
>>> already in my environment.
>>> 
>>> Question is, why is LESS set that way on my system? I can't find
>>> it in .bashrc .bash_profile .zshrc and friends.
>> 
>> There's also /etc/bash.bashrc, /etc/profile, etc. I don't know what's
>> normal in the mac world. You can try running:
>> 
>> bash -ix 2>&1 </dev/null | grep LESS
>> 
>> to see what your startup code is doing. I don't know of a good way to
>> correlate that with the source files, though. Or even to ask bash which
>> startup files it's looking in.
> 
> Unfortunately, this command doesn't work for me.
> 
> I ask around and most of my coworkers have LESS="-R".
> Only the coworker that doesn't really use his Mac and has
> no customizations does not have $LESS defined.
> 
> Therefore, I think it is likely some third party component
> that sets $LESS.
> 
> @Jason:
> Do you have homebrew, iTerm2, and/or oh-my-zsh installed?

Ha. I found it it! It is indeed oh-my-zsh:
https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/misc.zsh#L23

Let's see if oh-my-zsh is willing to change that...

- Lars

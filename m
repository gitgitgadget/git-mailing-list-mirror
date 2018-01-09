Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78A6E1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 20:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbeAIUjV (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 15:39:21 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:45679 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751374AbeAIUjS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 15:39:18 -0500
Received: by mail-pf0-f174.google.com with SMTP id u19so9385989pfa.12
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 12:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zbSBF85r7d+gAfL2LtUhOTWT9U/83m+XFpahMli5NpM=;
        b=AEXoA+UBgxsOC07/jg1FHSKkGTCBybtrQFYNogRAt7VnbhLKggqPlfeD+r8wCl4K0z
         uaaeDkiy9D1lV3N/6ipAZckh5HtoGkqm2Th9iBjf4F3o4MFMSjHRMAgggZV9av+/B6TB
         9kIhFeQGxAsJVh6RRPwggOOiNTdI0c/U0uo/twmA6b8k/wWqMgPsvEW+EJ9wFfs8Lv66
         TpAnFQwX43pIVFRiNdck2jVz0YsoDwdwfELYSwGzrWLk8VIA42+xGPZmrHUiEAJ71fBB
         CBO3QiXpUvdplAfbWCP4YbqK9kjjXbBvFO29Pg/yHeYAncKDMhR9TjklbKzkE3e9MO8K
         1imA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zbSBF85r7d+gAfL2LtUhOTWT9U/83m+XFpahMli5NpM=;
        b=Wa4IJrzjpLwP5g0Sa3iuQHmOIVHsMWM9lOhR0IsldgSum2eUD0uR50Ugo7q00sR23T
         6PCNXeAYeb2RUvQiZ9ss/bOHbiuA50tUB3NOA3+VoJcfsQUUGE7OsIvcXfmgyDhgdnXy
         7fdYuGET5UJygtTCCobxk2jGb42TNMnHyFUtSdw8bBe44Pwx1D8NStkNfr7THxqgIE6f
         aKkwWD43Fd8kL7Xg0Wf0MnyXoS0gie6wuFS5fdZWlCILLcxJ/ZHxgg/HiIklFbseNikX
         5g6fbpty6DHi4yyc1JPhslX+Snai5IywmbZZnf8tiyi0QJvmahTyUI+/4pC0KP4nZEq9
         nFuQ==
X-Gm-Message-State: AKwxytf+9EQdP0aJ6u8iN9MJwH/96J7ukKb0695qcaXR5QIFkCw8XJMG
        dGoS0ypEwDAUugcgMynojNATjnnL
X-Google-Smtp-Source: ACJfBosbjACm9/Sw1/mzvbEtVrcW3Az/yHrEcFXiBsgnBM1Dy0kPvg3aiJhpRTlkPUgKpiU49Sw9zg==
X-Received: by 10.84.175.132 with SMTP id t4mr625551plb.74.1515530358020;
        Tue, 09 Jan 2018 12:39:18 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b3sm7654847pga.24.2018.01.09.12.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jan 2018 12:39:16 -0800 (PST)
Date:   Tue, 9 Jan 2018 12:38:49 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Santiago Torres <santiago@nyu.edu>
Cc:     Colin Walters <walters@verbum.org>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: upstreaming https://github.com/cgwalters/git-evtag ?
Message-ID: <20180109203849.GA30468@aiede.svl.corp.google.com>
References: <1515442320.3241451.1228399576.66D7DA96@webmail.messagingengine.com>
 <20180108204029.m42qyezojak4kohh@LykOS.localdomain>
 <CAGZ79kZ8AXezcX1_5WJsUJMHiHCzj2B=Uj8+4K3VF+cC6mTCqA@mail.gmail.com>
 <1515465051.2895186.1228754952.0036D645@webmail.messagingengine.com>
 <20180109180933.jbyidmmv5xpsjuae@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109180933.jbyidmmv5xpsjuae@LykOS.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Santiago Torres wrote:

>> In contrast, working on hash-function-transition.txt?  That
>> seems like it'd easily consume many person-months of work.
>> And that plan only exists post-shatter.io, whereas git-evtag
>> long predates both.
>
> I think this is partly true. A hash transition has been brought up
> multiple times pre-shattered. In my opinion shattered was a much-needed
> PR push for SHA1 deprecation. In practice, things changed very little.

Sure, the main relevant things that changed are:

 1. The sha1collisiondetection library became well known, which if
    anything makes moving off of SHA-1 *less* urgent than before (but
    still urgent).

and

 2. We came up with and agreed on a design for a transition off of
    SHA-1 that we are (slowly but surely) executing on.  This means
    it's a good time to help get it done.

>>> Personally I'd dislike to include ev-tags as it might send a signal
>>> of "papering over sha1 issues instead of fixing it".
>>
>> I don't agree.  I think it's pretty clear that a hash function transition
>> would be a huge amount of work - not least because of course
>> there are now at least two widely used implementations of git in C,
>> plus https://www.eclipse.org/jgit/ plus...
>
> I agree with Stefan here. I think it's better in the long-term to
> push for hash-agnosticity. I don't know if git-evtag is hash agnostic,
> but if it is not, then we have two transition plans to think about.

I don't think there's even a question here: Git has to transition off
of SHA-1.

In that context, Stefan's comment is a welcome one: once we've
transitioned off of SHA-1, having a separate evtag feature would make
git more complicated without any benefit to match.  To put it another
way, the gpgsig-sha256 field described in
Documentation/technical/hash-function-transition.txt provides
essentially the same functionality as an evtag.  What's missing is an
implementation of it.

I'm happy to help in any way I can (reviews, advice, etc).

[...]
> Full disclosure, I published a "competing" solution a couple of years
> ago[1] but, in my personal opinion, I think push certificates can
> achieve the same security guarantees as my system with very little
> changes.

Work to improve the usability of push certs would also be very very
welcome.

Thanks and hope that helps,
Jonathan

> [1] https://www.usenix.org/conference/usenixsecurity16/technical-sessions/presentation/torres-arias

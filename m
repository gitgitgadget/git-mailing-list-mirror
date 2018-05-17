Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 414351F406
	for <e@80x24.org>; Thu, 17 May 2018 12:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeEQMCM (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 08:02:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36179 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeEQMCL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 08:02:11 -0400
Received: by mail-wm0-f66.google.com with SMTP id n10-v6so8578618wmc.1
        for <git@vger.kernel.org>; Thu, 17 May 2018 05:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=q1lOP++TVvqOhv3ROoVsVPt1AqG8MjFeVfVq0zb6JsQ=;
        b=MaoqlL2MoVSk/Fot/4MHt50Q9IKAS0y9XUp3UlKvh4b7MZje8dd/rA6Kj3toNpp2SA
         g8di9UY6A1OfpdrabxuTJiiFh/nWf4pdpx/bUNWEp3xfULugKA5YRivCqHof1h6XSCBE
         XisiJGHa6z5LylDRD+fNno8ChSUEvlqc3sxuVgEsyqKsuXYSKffwh+Tlq2O3AVuMjLO7
         uMgkCJzTmQASvOeFPgft/0gnkaOsrVvpT2/NGOOKx/3II3Tqze3fY1h6ItKGOOZEWKFi
         JPJ0dn4K6A5lUP41tKf/kdv6TdqGhVT2KJoCw7kZx/brSqDjsn7z1HcJCuZUGZFp2zlS
         Ki0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=q1lOP++TVvqOhv3ROoVsVPt1AqG8MjFeVfVq0zb6JsQ=;
        b=JxFMVIXSnn8LNTk4P30Gv5XYLTw00W9LHxGLOQMQhDVWIxTsYdzu2RWPgm0+JiFlNj
         1Bnf3mfDhJIQJB39Hu+zI1VAjibWPHZ1IiNJpV+rcu8YTCxUQqPdq2PylpunpuR0eHI5
         RzQdzuDjshxhWH6Opa/5T9Eab5TDiPaQGiWfuj7Y/aqRZfoIv9hS2BKmrCixPENoPHMW
         eamvsSDqOgJZps4BIKQRVYrYLMOJ26/4JNFP9wkwzJ1UJphStAE741FbWwcGBTMeHEOs
         wKsE4wdn5ldbHj+VC0irtVtE3TArbHJBJM2knX4T8IahKJ2b0WLpGKIHl6plAGy3xQ4O
         oH+g==
X-Gm-Message-State: ALKqPwePa/AgRKl8DElETkFwdSA2KoChLuy9Rznpcn+t/6+uFERn0dgo
        9APFSgscXYUFf67FXPa1OXuYd4oD
X-Google-Smtp-Source: AB8JxZpjrkNU554cdq/XdU7m7OPazOg4P+GW8si16S01Xk4NNCHoxz8c5MXTOju8sNsR+OD+rNA5yg==
X-Received: by 2002:a50:ee8c:: with SMTP id f12-v6mr6806447edr.10.1526558530181;
        Thu, 17 May 2018 05:02:10 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id o16-v6sm2396646edr.75.2018.05.17.05.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 05:02:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: jk/branch-l-0-deprecation (was Re: What's cooking in git.git (May 2018, #02; Thu, 17))
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com> <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com> <87fu2qbojy.fsf@evledraar.gmail.com> <57e90df8-9522-0988-f25d-59a132b5afbe@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <57e90df8-9522-0988-f25d-59a132b5afbe@gmail.com>
Date:   Thu, 17 May 2018 14:02:08 +0200
Message-ID: <87d0xubidb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 17 2018, Kaartic Sivaraam wrote:

> Hi Ævar,
>
> On Thursday 17 May 2018 03:18 PM, Ævar Arnfjörð Bjarmason wrote:
>> I've ended up with that $LESS setting via hackery over the years, so
>> maybe I'm doing something retarded, minimal test case:
>>
>>     PAGER=less  LESS="--no-init --quit-if-one-screen" git branch -l
>>
>> ...
>>
>> So I think this is probably OK for most users, if the have very few
>> branches they'll see it, and then if they use default pager settings
>> they'll see the stderr output once they quit the pager. I don't know how
>> common my (mis)configuration is.
>>
> I'm not sure this is ok, because I still see the stderr output with your
> minimal test case even when I have enough branches to not fit in one
> screen. The stderr output is of course above the pager output (after I
> quit the pager) and gets hidden out-of display as I stated before. I
> also get weird 'ESC[m' characters with you minimal test case. I'm not
> sure what I'm missing.

I don't get it anywhere, above or below.

> What version of 'less' do you use? Is any other configuration that you
> didn't mention affecting what your observation?

Both "less 481 (GNU regular expressions)" and version 487. I upgraded
and tried both. This is on Debian stable (and newer version from
testing).

It may be something in my system config, but I tried sudo-ing to a user
that only has stock Debian config & none of my custom .bashrc etc, and I
get the same thing.

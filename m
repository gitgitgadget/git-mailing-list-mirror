Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA5591F667
	for <e@80x24.org>; Tue, 15 Aug 2017 10:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbdHOKzq (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 06:55:46 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37433 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753542AbdHOKzp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 06:55:45 -0400
Received: by mail-pg0-f66.google.com with SMTP id 83so1008017pgb.4
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 03:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AXuMwAXM0VJLH3rNX2+YmfRsk4uuB/dnP32442RYPig=;
        b=NnSMRFPoWrUQ+W/CS63Izg4KtwO6/r38iAKamnFmaWLjHNkMMHIzr5P0h9iHOtS11K
         DzyRTWjMjqtxEqFJLouY7BEgpemoGpINoIuRY34kZu0DaDz7g8o5uY+i+7v0FM+auvk/
         OduI86dEK104tgAey56DcVl0yTFcrF8i2BoN5uWf7viSPwn9FAx6jT5eItQ+VkjKyPq9
         QGlB8t7lDpO6giU3ay/5GSb1jcfBJQs8Ej0bgM0cV5JoXVIsPJlvyWdgWwMVgQVSF9hh
         lv7BgjklcIAiSQPEvXTM1lN1dIi1nfyczpp6PNqjj8FM+Rr8elxol33N6OF1N9fq0VKq
         DxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AXuMwAXM0VJLH3rNX2+YmfRsk4uuB/dnP32442RYPig=;
        b=fgBhe128X0UWVDxsuByi2t+txtS/IDDzMggHGz3hbL9+EESDmwMsnKX7YOe2cpxb8U
         ZjIJ4vTUL6wjQwZ1RqRnTgpM29kjgBrdy+UHMef6Mx4gy1vvZ2Ni95GVrEhpGTs6efsl
         36Dd3wegSF1J+sjcF5WWh1Mz/JL+M0QZzp4Dp9CD0g3+GT3kK+VJG4q/oPJNaZnTo41+
         yUyvI4XFprlirvJdx7Taj3rwmVc2xRx4b0efmnQshV7nFUBoQmQPTjWXF0GyiXbxQ38d
         ogdpSVqmqGQzkoTy5yunwvAUFLvgho++uhd6eNol1X7iuWW1ozQIYttDNWOGYoCcyTNV
         TZRQ==
X-Gm-Message-State: AHYfb5iyQkMzKPs1h9YkqAOK5Ch+DnKBf/3vjGhvDjTEinOyN5coaQHP
        f0mobrD4wYHf6w==
X-Received: by 10.99.6.87 with SMTP id 84mr26533449pgg.426.1502794544532;
        Tue, 15 Aug 2017 03:55:44 -0700 (PDT)
Received: from ?IPv6:2405:204:700b:d138:d4f3:b513:ec16:b5d5? ([2405:204:700b:d138:d4f3:b513:ec16:b5d5])
        by smtp.gmail.com with ESMTPSA id k81sm18462727pfb.152.2017.08.15.03.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Aug 2017 03:55:43 -0700 (PDT)
Subject: Re: [PATCH v3 1/2 / RFC] builtin/branch: stop supporting the use of
 --set-upstream option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, martin.agren@gmail.com
References: <20170808171136.31168-1-kaarticsivaraam91196@gmail.com>
 <20170814085442.31174-1-kaarticsivaraam91196@gmail.com>
 <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Message-ID: <772aaebf-81ea-ac22-9d2f-35d0778f502f@gmail.com>
Date:   Tue, 15 Aug 2017 16:26:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday 15 August 2017 01:49 AM, Junio C Hamano wrote:
> I wonder if these two lines add any value here. Those who know the
> reason would not be helped, and those who don't know have to view
> "git show b347d06bf" anyway.
That's right.

>
> I somehow think the above wastes bits a bit too much.  Wouldn't it
> be sufficient to say
>
>      In order to prevent "--set-upstream" on a command line from
>      being taken as an abbreviated form of "--set-upstream-to",
>      explicitly catch "--set-upstream" option and die, instead of
>      just removing it from the list of options.
Thanks for the shorter version. I'll use this :)

> Because from the end-user's point of view, it has already been
> removed, I'd phrase it more like
>
> 	The --set-upstream option has been removed.  Use --track or ...
I thought I changed it. It seems to have gone missing. Thanks for 
noticing this.

> and make sure we do not list "--set-upstream" in the list of
> supported options in
>
> 	git branch -h
>
> output.
I guess the instructions given below are enough. They do seem to be 
doing hiding it
from 'git branch -h'

> Here we would want to use something like
> 	{ OPTION_SET_INT, 0, "set-upstream", &track, NULL, N_("do not use"),
> 	  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, BRANCH_TRACK_OVERRIDE },
>
> in order to hide the option from "git branch -h" output.
>
> All review comments from Martin were also good ones, and I won't
> repeat them here.
>

>>   A query,
>>
>>      I see the following code in the code path a little above the die statement
>>      added in this change,
>>
>>              if (!strcmp(argv[0], "HEAD"))
>>      		    	die(_("it does not make sense to create 'HEAD' manually"));
>>
>>      It does seem to be doing quite a nice job of avoiding an ambiguity that could
>>      have bad consequences but it's still possible to create a branch named 'HEAD'
>>      using the '-b' option of 'checkout'. Should 'git checkout -b HEAD' actually
>>      fail(it does not currently) for the same reason 'git branch HEAD' fails?
>>
>>      My guess is that people would use 'git checkout -b <new_branch_name> <starting_point>'
>>      more than it's 'git branch' counterpart.
> Thanks for noticing.  I offhand see no reason not to do what you
> suggest above.
There are two ways in which this could be done.

1. Duplicate the check done in 'builtin/branch.c' in 
'builtin/checkout.c'. This doesn't
     sound good to me.

2. Do the check in 'branch.c::validate_new_branchname' to ensure there's 
no way to
     create a branch with the name of 'HEAD'.

Which one is preferred?

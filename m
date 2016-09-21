Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 344681F935
	for <e@80x24.org>; Wed, 21 Sep 2016 17:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758204AbcIURtn (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 13:49:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33943 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756421AbcIURtm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 13:49:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id l132so9845293wmf.1
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=xuubjluHt0H1AWYUUuYFbN79pb/7glp6mCKHWYmGGwI=;
        b=G1yT40Io1UcwCQofK5f3724pYC9rjjWoG2GfwNS5mrld+HK3UhBwUM5zd94lBK3TcC
         zyOAPrS0IyVG9E7Y4mcEiP/NEZ8mbOoZOtIGr9N7PRpOIyCFgFl6tCw4rLzrD6pZfcMq
         X+56dkAY45Vbd86o4GXojFKzvxTEJNMg5mjpWh1+0U6RhTHgeoafs2hBV64qJqgi2uMC
         9+Pm5t0aN3gk6W5T75gM46U4M4yyAcMeJqCpVUqw29eggPVjyTjmvAbEDMAHZleUauw2
         0SWqiar6gufMbxLHdIhIPmhA+6QYde/F5iWA3D02peQ7qbIwv8J11j1B0BRExpsarvJ3
         4mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=xuubjluHt0H1AWYUUuYFbN79pb/7glp6mCKHWYmGGwI=;
        b=MI+I85ZelZtM1xLL/v+TThXgKkzA+TuPkp/0VRZ7kU44305Ljg7Lex8hKUVd/hVsN+
         xw2mWfXjMXmufpUkvXH7051x6ajlBwVgPrfcNXESjcQEjKJ7QnxZBy3Sg1ldW5UEHXL0
         ZEwswJhNYXOXi0H6G53d2AYsKHjWskiaz5BsWgsnkM9FXVOlr4EfMH23r0v2qQKPknge
         qiI8KpNPnTIPTs82bv2SF2C55n+zFT2DViwSGHxNm+wo17K+Bwz9CgCC4GKoj2Z6lpXJ
         SAstT63PNpWc+0lKJQMtShCK4aUdyU7gdXbD54DOzLjpe+Lzla7ag1wIsIL7ukDFfjcH
         zOAg==
X-Gm-Message-State: AE9vXwO1jn/ri0HdYXJuiyB1XaWTmVphHjvc3ZpcfW07M5dxd8oQjP8r5gAuFul8e09k2g==
X-Received: by 10.194.30.97 with SMTP id r1mr34000310wjh.8.1474480180804;
        Wed, 21 Sep 2016 10:49:40 -0700 (PDT)
Received: from [192.168.1.26] (enn40.neoplus.adsl.tpnet.pl. [83.20.3.40])
        by smtp.googlemail.com with ESMTPSA id ub8sm34710449wjc.39.2016.09.21.10.49.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 10:49:40 -0700 (PDT)
Subject: Re: [PATCH 3/3] gitweb: Link to "git describe"'d commits in log
 messages
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20160921114428.28664-1-avarab@gmail.com>
 <20160921114428.28664-3-avarab@gmail.com>
 <xmqqvaxp9oyp.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <ba9d9c82-4b5e-4d62-95f1-a1c56cfc70af@gmail.com>
Date:   Wed, 21 Sep 2016 19:49:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqvaxp9oyp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.09.2016 o 18:50, Junio C Hamano pisze:
> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
>> There's surely room for improvement here, but I just wanted to address
>> the very common case of sticking "git describe" output into commit
>> messages without trying to link to all possible refnames, that's going
>> to be a rather futile exercise given that this is free text, and it
>> would be prohibitively expensive to look up whether the references in
>> question exist in our repository.
> 
> When I saw 2/3 I wondered about one thing and 3/3 shares the same,
> which is that we only use regex match and do not validate for a
> false match.  Would it be too expensive to pick up what _looks_ like
> a rev (e.g. hex or g(refname regexp)-hex) then validate it with
> "rev-parse --verify --quiet" to make sure it is a rev, before
> actually making it a link?  Even if are we trying to account for
> people referring to commits that do not exist in this repository
> (e.g. some other project, in a submodule repository, or just an
> earlier incarnation of rebasing that has since been lost), it seems
> to me that it does not help to mark them with a link that won't
> resolve.

I think it could be a good *option*, but revision verification
could be costly, for example in the 'log' view with multiple commits
and multiple revision-like looking candidates, even if we were able
to do it with one command.

Also, "git rev-parse --verify [--quiet]" can verify only one
revision at once, isn't it? Maybe something like 'git cat-file
--batch-check' would be better (one fork)?

It's a matter of balance between false positives (and unresolving
links) and performance...

Best,
-- 
Jakub Narębski


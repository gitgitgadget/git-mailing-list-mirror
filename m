Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED3701F404
	for <e@80x24.org>; Wed, 20 Dec 2017 18:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755811AbdLTSTL (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 13:19:11 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:45949 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755292AbdLTSTK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 13:19:10 -0500
Received: by mail-pf0-f177.google.com with SMTP id u19so12872174pfa.12
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 10:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7Xe5PUDJDKm9452RXkhp+KubleclT55eNq4L21e530Y=;
        b=ZzjHB1Z1EdDb0nAF0/UwGGqkVsczLV8mb/hyEiMp24mR3On0lzD0MrxGWAjZhVTMK/
         DkU1ttsOvMlmDY+aO/RL2+XWVdvuVqsd0brKvOVTWXl/kX6ONtqYfT901jWhoFwXcEil
         WbgK9gCsCGB1QV0yvwcbwI+QXHnyc+9LydGVfxbwUqhOUWFKn60TjJRgoSoFO02C4Qgz
         nsQ6bJFcBFJUS2XDEsRGpCmPkyeLrrwXfCv6MTDKOd0V9IBY7hSGcJVHN8sUtJfo/rYu
         BBzfXfepVroc+ACps7iJwRdwT82t20YRrUF8WzHlryMV9pQFiWfGb9TcWoM+ZNu54yxI
         vMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Xe5PUDJDKm9452RXkhp+KubleclT55eNq4L21e530Y=;
        b=P6VkOkm5rzse07qNB9fMCxngkV210O49Gmxq24LgzT+X+ulQ2jo/nBayzfUDkq07nc
         Us4wHWWuc4NVF10O8Nb2s2Qer4WljHEhcawS+zdEonpR5Pvkhv87dWUJSgJCu8uyRTOG
         jG6DWxhnDMBiEWbsmSDDgwdpYZymvuXUBYNHzY4cT4kQ3MnBtXN7SSrY6mkxMHJByiGe
         QclG+3ALWG2aCGl3WqUk8K1iHdSX650+c/PtR8AHodDlAzaRovCqcMaYxxdARZ+I8/zY
         yo1pzezHLKC+lRO43O9U30z8RRb0ZXjbigzimpfPo1aDjIXLb+WZbAx33jHFj4xKOqh4
         Sb8Q==
X-Gm-Message-State: AKGB3mKKfzluNcpyj6n4hTA583dCIl6MUO4+Kn/YH7ue82jYcibUppLK
        ++Aw4kdv2eOvkn3MFUiEDprdWwI9
X-Google-Smtp-Source: ACJfBouqyXKcrJJuH0Wx0dj1pVBSPPvh1OaCrY1hZpHvT8ELtA75nUHYFXT1OYamGw8CAJ8Lk2G+hg==
X-Received: by 10.99.147.3 with SMTP id b3mr7234156pge.114.1513793950094;
        Wed, 20 Dec 2017 10:19:10 -0800 (PST)
Received: from [10.4.2.238] ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id i125sm34518663pfe.151.2017.12.20.10.19.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Dec 2017 10:19:09 -0800 (PST)
Subject: Re: What's cooking in git.git (Dec 2017, #04; Tue, 19)
To:     Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
References: <xmqqshc6tm26.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <9f58362a-c06c-5842-d22e-cc1ca165f0cf@gmail.com>
Date:   Wed, 20 Dec 2017 23:49:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqshc6tm26.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 20 December 2017 03:30 AM, Junio C Hamano wrote:
> * pw/sequencer-in-process-commit (2017-12-13) 10 commits
>    (merged to 'next' on 2017-12-13 at ec4d2b9c84)
>    ...
>   The sequencer infrastructure is shared across "git cherry-pick",
>   "git rebase -i", etc., and has always spawned "git commit" when it
>   needs to create a commit.  It has been taught to do so internally,
>   when able, by reusing the codepath "git commit" itself uses, which
>   gives performance boost for a few tens of percents in some sample
>   scenarios.
> 
>   Will merge to 'master'.

I just encountered a small issue with 'rebase -i'. My bisection pointed at,

     28d6daed4 (sequencer: improve config handling, 2017-12-13)

So, I guess it would be better if you could delay merging it to 
'master'. I'm not sure what how the commit and the patch are related but 
lets discuss that in the patch thread.

-- 
Kaartic

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20BE31F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 18:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387944AbfJWSHX (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 14:07:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42373 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732144AbfJWSHW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 14:07:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id m4so3722307qke.9
        for <git@vger.kernel.org>; Wed, 23 Oct 2019 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1CUcFTsUyrwY9H2eulEwheyueX6dBb7sThYjRivUu5E=;
        b=lk2Iw14oWcoGiRZRQZ/jJS+ATpeHZLsBhKe6M2z+4L3QpMzBxxWkEb1Rfw6LbI1lW+
         z0byhbcRQBuOTUUr7hfsmD+h91tAG0/coCPaqPAlVY9KuONooE28XR0WIv3vOo7zv76I
         j7QqADTGZZIKt+37J9cVAExarK/Sh8o6JA4kp6DhleaEhvh/j/NJEAtgKQ46HuTnV4t3
         MkeAbJrGwY48aqHefisGIvLEsNQHoNSNOqSj6/bu/OQklkyf/D61I7sh/fsVhx6beayY
         zMDI9RUsZmUsB0MMVky4Y4gevJRk+CzNNMOVCwM7VgTuP0IoBgWesbTpupcEiUnrDWvF
         kBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1CUcFTsUyrwY9H2eulEwheyueX6dBb7sThYjRivUu5E=;
        b=TAZOxnoE35PhL9Xqo9aoJdiJpyJ/iEVF1F5MwRLHkA5k8aGMLTrgoSsRkF4nUZr2vF
         plgUebl+mPgsrNVATE4w5QXd+vnGf+iVxj47TktLZ2dXcc0mDOShWGUiFBu3PHHA4/U5
         ZS7ZtfiwC6oqa50NZupB5NkTXvQWheqLLHkXh/yf0Qgw33cCWIuSTtWN8UFVNvaB0zfQ
         xyYZNdG/xb1zClY1PeXl0mcbFXQJyr4ws8ltAk81xIGMqddJJxOZI/wJzpJ5EKMWmyN7
         qNo/IrR43pElYluTNKDmWS2bamIqlV24M2h7+M4EKl2iJHQDp+2DLlAJJHBWx6ULYA6J
         ya0Q==
X-Gm-Message-State: APjAAAW1CBpaDH2BKBfADGnLdjWIR9OV+AKOmNDGmteC9Mt5g/MemoJ7
        /WiyDLnV3y9V0VLTcR/kKJ+vRfMcBbA=
X-Google-Smtp-Source: APXvYqxfZ3Rm1IpT73jsOFANX0O/B/XJF0iwHDK6zHQYlL/AAvXPnvi4MTvBXN2EGuOAXAliSanpXQ==
X-Received: by 2002:a37:c44b:: with SMTP id h11mr9635264qkm.150.1571854041564;
        Wed, 23 Oct 2019 11:07:21 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bd19:92e0:6c87:b219? ([2001:4898:a800:1012:6e4d:92e0:6c87:b219])
        by smtp.gmail.com with ESMTPSA id h3sm6094053qte.62.2019.10.23.11.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2019 11:07:20 -0700 (PDT)
Subject: Re: Git Test Coverage Report (October 11)
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <c863c09b-f0ed-19c6-356e-12a3ecbc08b9@gmail.com>
 <20191023170049.hnzb22iiflrigyfs@tb-raspi4>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ebe33082-976d-7146-1450-925e4785faf1@gmail.com>
Date:   Wed, 23 Oct 2019 14:07:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20191023170049.hnzb22iiflrigyfs@tb-raspi4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/23/2019 1:00 PM, Torsten Bögershausen wrote:
> On Fri, Oct 11, 2019 at 09:33:11AM -0400, Derrick Stolee wrote:
>> Here is today's test coverage report. The usual report format is
>> available online [1], [2]. The report listed below is a new format
>> that groups lines by the commit that introduced them [3]. Thanks
>> Peff for the feedback on that idea.
>>
> 
> []
>>
>> Torsten Bögershausen	ebb8d2c9 mingw: support UNC in git clone file://server/share/repo
>> connect.c
>> ebb8d2c9 921) path = host - 2; /* include the leading "//" */
>>
> 
> I actually looked into this one, and my understanding is that the code path
> makes only sense for windows and is only tested on Windows in t5500.
> (Linux/Unix/POSIX don't use UNC path names starting with "//" )
> 
> How can we avoid those "not covered by test" warnings?
> 
> One solution could be to use
> 
> #ifndef has_dos_drive_prefix
> #define has_dos_drive_prefix(a) 0
> #endif
> 
> in git-compat-util.h and hope that the compiler is smart enough
> to optimize away that line of code.
> 
> Another way could be to have #ifdefs in connect.c, so that it
> is clear "this is Windows only".
> 
> Or make a comment for the "cover report" saying "not covered".
> 
> Are there any good or better thoughts on this ?

One way to avoid this is to add ignored lines to the test-coverage
repo [1]. These only work if the exact contents match on a specific
line number, but can be a way to stop noise in the short-term.

For example, I added a few lines to ignore in commit-graph.c [2],
but I haven't added ignored lines in a while.

I'm happy to take a PR including the lines you want to ignore, or
I could take inventory of the lines in the current report before regenerating
a test for -rc1.

Thanks,
-Stolee

[1] https://github.com/derrickstolee/git-test-coverage

[2] https://github.com/derrickstolee/git-test-coverage/blob/master/ignored/commit-graph.c

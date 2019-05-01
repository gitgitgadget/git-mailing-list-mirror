Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD5F01F453
	for <e@80x24.org>; Wed,  1 May 2019 19:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfEAT7j (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 May 2019 15:59:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41601 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfEAT7i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 May 2019 15:59:38 -0400
Received: by mail-qk1-f193.google.com with SMTP id l199so127531qke.8
        for <git@vger.kernel.org>; Wed, 01 May 2019 12:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/0W3dvha+2QCf/8SzukJMDE0s1GVmygRIhh98Z8itLY=;
        b=vUUgkwRYjediMs1k4spBd25cwq+7pMjiCPS9XI3lIe2JwBB6doP2c+PKkR4MmpY7Kk
         OogjI7a7OU9Sec+wmmwWxiHcTwB5+6LwDtOQcjEdGp/Z+Cg8t8KRh0lxMsjL3NaqQk3H
         m/FTZgKEM0wWYcqY6rfnehmzYCaqIhIo4LDrJ+DD5qcOzMCpfG+VP2ORa5/sEiExj/m7
         3kbEFRfRUOuiOUbl700Yo1RaxBCpdstud5hzvqk+iEBThDDahG6XXgsCv9baGNaoGf/P
         VmUSMripgmcRe/FQB2W7pQxsjbCVw3FdlVqLso9KMbJ2rOk0t6o14XGjMx74t5NZyIyv
         gGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/0W3dvha+2QCf/8SzukJMDE0s1GVmygRIhh98Z8itLY=;
        b=YeOcYU6VMjWyecPe2rGUOw/xrpiS4F9OmO2D2G4ZMW739dy7NDCywyzL2k6LFuUxvf
         P4p8fsBuhOb4xrkZh5vXdbYHMrZ4n243OL7ZsZOwtj6TC8QcuJ0tKkznoPNK4ysvJ+Mv
         1pWcbfHNymbSM0lWbh8Z4EC05JBkhpSMhZqcGHC4PlLQ0i1jxlDYBQg1OZKQPE30xsHk
         MfNIbS+3ryF7rd2tuamMyWRvazqI0LziF8SX6gn2XLduHK7goOBf+coGo5lShVL84mGJ
         rKfUwZigIAmUSuTHhpMC5t6POkuQZCDHzjFjtanYX+7urtuU100KmpK6aDSnk9EGyEnE
         rPfA==
X-Gm-Message-State: APjAAAXVAf0Ck6HLk/q1XoGxyrvg3INd/erFUsLi68zlsrdpn85D5/M5
        2DHSEBwSr6Eg2G0J4eTSA8o=
X-Google-Smtp-Source: APXvYqws0lLCQJJcscsTZrr5xT0I3x0ZEbD6ri3QiCjGhWGOn65bMijkiaB4VgC0TsBbiW0aNY4Taw==
X-Received: by 2002:a37:c207:: with SMTP id i7mr2543qkm.74.1556740777823;
        Wed, 01 May 2019 12:59:37 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:3012:809d:d5f7:8e4e? ([2001:4898:8010:2:1946:809d:d5f7:8e4e])
        by smtp.gmail.com with ESMTPSA id t129sm20707230qkc.24.2019.05.01.12.59.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 12:59:36 -0700 (PDT)
Subject: Re: [PATCH v3 6/6] commit-graph: remove Future Work section
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.112.v2.git.gitgitgadget@gmail.com>
 <pull.112.v3.git.gitgitgadget@gmail.com>
 <e72bca6c784c5fc727ae4cf661526eec346c478c.1556716273.git.gitgitgadget@gmail.com>
 <87o94mql0a.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c1c91314-477e-ffc7-25f5-fb46bc64db4e@gmail.com>
Date:   Wed, 1 May 2019 15:59:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <87o94mql0a.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/1/2019 10:58 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, May 01 2019, Derrick Stolee via GitGitGadget wrote:
> 
>> The commit-graph feature began with a long list of planned
>> benefits, most of which are now complete. The future work
>> section has only a few items left.
>>
>> As for making more algorithms aware of generation numbers,
>> some are only waiting for generation number v2 to ensure the
>> performance matches the existing behavior using commit date.
>>
>> It is unlikely that we will ever send a commit-graph file
>> as part of the protocol, since we would need to verify the
>> data, and that is as expensive as writing a commit-graph from
>> scratch. If we want to start trusting remote content, then
>> that item can be investigated again.
> 
> My best of 3 times for "write" followed by "verify" on linux.git are
> 8.7/7.9 real/user for "write" and 5.2/4.9 real/user for "write".
> 
> So that's a reduction of ~40%. I have another big in-house repo where I
> get similar numbers of 17/16 for "write" and 10/9 for "verify". Both for
> a commit-graph file on the order of 50MB where it would be quicker for
> me to download and verify it if the protocol supported it.

Keep in mind that your first "write" may have warmed up the file system
and your pack-files parsed faster the second time around.

You are right though, 'verify' doesn't do these things:

1. Sort a list of OIDs.
2. Write a file.

And perhaps some other things. I should mean that "the main task of
'git commit-graph verify' is to parse commits from the object store,
and this is the most expensive operation in 'git commit-graph write'."

Thanks,
-Stolee


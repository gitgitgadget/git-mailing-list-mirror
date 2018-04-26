Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6BF71F424
	for <e@80x24.org>; Thu, 26 Apr 2018 12:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755645AbeDZMor (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 08:44:47 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:37631 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751713AbeDZMop (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 08:44:45 -0400
Received: by mail-qt0-f170.google.com with SMTP id w12-v6so31228055qti.4
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=88vF9dZUSokYm4OM9OlvRxlHNK+IDSSx1/Ai3UNfl1A=;
        b=LWgI+1oj2m8jG4oJO8kZL/Katch6z1A9z0ktBeJeHZJeXZ/4rtY/PC8jnS7WqzUQtB
         bYGSnAe0ahXh86Rc+E3XHYUbZHuZuOzJIUNahSfpFU38jUVfbv/6PozYr8B33/1VTGoM
         M+b8b17CrBV1BGffYQf8wm0qF30I2x9iByJ9r+7ELx5duuayPCt8xRqEokeqjrUHW3Zp
         JTs/ZJa/MVlJ0LJs45JvXRtedyHFkr9Jo3Mmcr1dYqUwBohUX8l2PCsB8tTFwJf09I6n
         x6wFHQCuXnUJ584tU444m25hL6pvwQ0RLAgSBX7mQDKM+HrTbJNnzcdSfpyQgtExVp8+
         mVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=88vF9dZUSokYm4OM9OlvRxlHNK+IDSSx1/Ai3UNfl1A=;
        b=AtOotBKT3sB9aHsgihiWJ50V1Jk2tZmUeGc8Uk3cqyxo4N2mU+RVKQKjlkF+jbC9P9
         EH3+s+50IrA7AA01QoLQimGbhORgM8ztGDrdJyqCNNrjzDzo3WL5wEB83h+0fjruEG0w
         fb6zwBVqqFFk5voeYkZTRpfbwBAVvx76Wiw7LSuKZN5QZBC/7ytE2VVYNQyEIh2gEvaY
         LvxGRONEkDEEy8wowG5b79r++9cJxx3gYdwd5dviHr4S9+SI4jy/ZRmd3+9kbJbYiLmd
         nAorWFKmVJ1FO1M8xwzcImkLTWdXVG6ouxKpPTwN6C8cOEHrb4x4Iaye746kTiW0FW09
         vpBQ==
X-Gm-Message-State: ALQs6tA8jGhiTmbGJHLT402IAOYMkE30co7UPxr2ge8zawG7mEKUWVC4
        tgicVzKNH1UgY8JJo/cPZN4=
X-Google-Smtp-Source: AB8JxZoLTI6tmsH8W/rLKKt71KHWYOEZKxUoMbnH7l5oin6hnxHVSsWq9JMWPZyUEyCXz4gYRGnK/w==
X-Received: by 2002:ac8:1857:: with SMTP id n23-v6mr10851412qtk.42.1524746684231;
        Thu, 26 Apr 2018 05:44:44 -0700 (PDT)
Received: from [172.22.150.178] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id r6-v6sm16409549qti.70.2018.04.26.05.44.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 05:44:43 -0700 (PDT)
Subject: Re: What's cooking in git.git (Apr 2018, #03; Wed, 25)
To:     Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Hesse <mail@eworm.de>
References: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
 <87zi1rd14k.fsf@evledraar.gmail.com> <20180425174300.GA49485@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4d0bd1a2-2f51-4a11-7e31-1e1ac5213c51@gmail.com>
Date:   Thu, 26 Apr 2018 08:44:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180425174300.GA49485@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/25/2018 1:43 PM, Brandon Williams wrote:
> On 04/25, Ævar Arnfjörð Bjarmason wrote:
>>> * bw/protocol-v2 (2018-03-15) 35 commits
>>>    (merged to 'next' on 2018-04-11 at 23ee234a2c)
>>>   + remote-curl: don't request v2 when pushing
>>>   + remote-curl: implement stateless-connect command
>>>   + http: eliminate "# service" line when using protocol v2
>>>   + http: don't always add Git-Protocol header
>>>   + http: allow providing extra headers for http requests
>>>   + remote-curl: store the protocol version the server responded with
>>>   + remote-curl: create copy of the service name
>>>   + pkt-line: add packet_buf_write_len function
>>>   + transport-helper: introduce stateless-connect
>>>   + transport-helper: refactor process_connect_service
>>>   + transport-helper: remove name parameter
>>>   + connect: don't request v2 when pushing
>>>   + connect: refactor git_connect to only get the protocol version once
>>>   + fetch-pack: support shallow requests
>>>   + fetch-pack: perform a fetch using v2
>>>   + upload-pack: introduce fetch server command
>>>   + push: pass ref prefixes when pushing
>>>   + fetch: pass ref prefixes when fetching
>>>   + ls-remote: pass ref prefixes when requesting a remote's refs
>>>   + transport: convert transport_get_remote_refs to take a list of ref prefixes
>>>   + transport: convert get_refs_list to take a list of ref prefixes
>>>   + connect: request remote refs using v2
>>>   + ls-refs: introduce ls-refs server command
>>>   + serve: introduce git-serve
>>>   + test-pkt-line: introduce a packet-line test helper
>>>   + protocol: introduce enum protocol_version value protocol_v2
>>>   + transport: store protocol version
>>>   + connect: discover protocol version outside of get_remote_heads
>>>   + connect: convert get_remote_heads to use struct packet_reader
>>>   + transport: use get_refs_via_connect to get refs
>>>   + upload-pack: factor out processing lines
>>>   + upload-pack: convert to a builtin
>>>   + pkt-line: add delim packet support
>>>   + pkt-line: allow peeking a packet line without consuming it
>>>   + pkt-line: introduce packet_read_with_status
>>>   (this branch is used by bw/server-options.)
>>>
>>>   The beginning of the next-gen transfer protocol.
>>>
>>>   Will cook in 'next'.
>> With a month & 10 days of no updates & this looking stable it would be
>> great to have it in master sooner than later to build on top of it in
>> the 2.18 window.
> I personally think that this series is ready to graduate to master but I
> mentioned to Junio off-list that it might be a good idea to wait until
> it has undergone a little more stress testing.  We've been in the
> process of trying to get this rolled out to our internal server but due
> to a few roadblocks and people being out of the office its taken a bit
> longer than I would have liked to get it up and running.  I'm hoping in
> another few days/a week I'll have some more data on live traffic.  At
> that point I think I'll be more convinced that it will be safe to merge it.
>
> I may be overly cautions but I'm hoping that we can get this right
> without needing to do another protocol version bump for a very long
> time.  Technically using v2 is hidden behind an "experimental" config
> flag so we should still be able to tweak it after the fact if we
> absolutely needed to, but I'd like to avoid that if necessary.

There's no testing better than production. I think if we have an 
opportunity to test with realistic traffic, we should take advantage.

But I also agree that this series looks stable.

I realize it's hard to communicate both "this series is ready to merge" 
and "I appreciate your caution."

Thanks,

-Stolee


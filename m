Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28F21F404
	for <e@80x24.org>; Fri,  2 Mar 2018 15:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031633AbeCBPOL (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 10:14:11 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39094 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030298AbeCBPOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 10:14:09 -0500
Received: by mail-qt0-f195.google.com with SMTP id f4so12227905qtj.6
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 07:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=PXeFwKGePI/y87dFBWsPsRJ5vco2axop9Lg/O/qg+zE=;
        b=YyrbJcG2rqYCWZhxZXbyZQkmCJ8sEE75zCiFjWZwYlVpxBO4chvESqD6UUATDQuC2p
         APwSxeIf8KZfmOPBLL2yR5oJ1LdayZiWINnBh/Mgrr06ULl5G1HfO8/LwLkP/1IyNZTv
         EvctkGFvKVTtBTgOryWMxGfvIycvz0+mnASWZw4QlRPxxDcUpMHr2XQ3Dz4NpKUBUWq3
         O4YpMScOMpFqyjPCH1fV6FY6l8O4/SfxjLFYHevElITk+q+RtBON+ocDddhAxsyER0V5
         K4qaEnp64dz++0s/3S1wZFsrSVI4wk7s5xJpSaNBBGGqQeafoi10qkNYbT9w3QZfeOLa
         6W9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PXeFwKGePI/y87dFBWsPsRJ5vco2axop9Lg/O/qg+zE=;
        b=t/x9zM4rzQcFVukOHaEh8AWz0vUvPBqMv2oP5MpxUHuPYHgwFiiv44c/L2Erp8x3xD
         Jq5ZGGIj43udWK06RN0gKzQSJIzoI2q6HGH9kH4hGZoPIuUm83ImK5CoqcrPAFwKvEpA
         G7PaQLHcJhKBCnPZRIyXAE99M74TPoRAemtoix1zGwDuQo/PNbI0vzxorXGjCH0+Nd0o
         Bp+EFRxmJpEGm3D7dY4zKo7/8BweusSURiugV2GtuUBG/pwBr92+Dz/PCOFG/5s0/+Mo
         9CdGogcKjAX06oPZ1YmQpRZXobmo5C3CwsssgJZpHew3A3CJD26PReBELDhBkMI23gm8
         4XqA==
X-Gm-Message-State: AElRT7Hq/Y3+nITt3eamerXMI7N9DLtz5gszTvAY9m/sB55DzhXUKV5T
        f9CR8Aq5jMh+BmUth0SKvLY=
X-Google-Smtp-Source: AG47ELvctsWRIH1mokourRDnvwhlnYzFG2YWxG7jw2H4uf5BqTkWPI5A/ittM3tE3EnGT8fSpAPFPQ==
X-Received: by 10.237.54.103 with SMTP id e94mr8564891qtb.112.1520003648915;
        Fri, 02 Mar 2018 07:14:08 -0800 (PST)
Received: from [10.0.1.15] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id m13sm4895552qtf.31.2018.03.02.07.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 07:14:08 -0800 (PST)
Subject: Re: What's cooking in git.git (Mar 2018, #01; Thu, 1)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        dstolee@microsoft.com, sbeller@google.com
References: <xmqqpo4ne8ud.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <acd10e97-20ad-d04a-a495-0a9223d8b3a2@gmail.com>
Date:   Fri, 2 Mar 2018 10:14:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:59.0) Gecko/20100101
 Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <xmqqpo4ne8ud.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2018 5:20 PM, Junio C Hamano wrote:
> --------------------------------------------------
> [Graduated to "master"]
>
> * jt/binsearch-with-fanout (2018-02-15) 2 commits
>    (merged to 'next' on 2018-02-15 at 7648891022)
>   + packfile: refactor hash search with fanout table
>   + packfile: remove GIT_DEBUG_LOOKUP log statements
>   (this branch is used by ds/commit-graph.)
>
>   Refactor the code to binary search starting from a fan-out table
>   (which is how the packfile is indexed with object names) into a
>   reusable helper.
>
> [...]
> --------------------------------------------------
> [New Topics]
>
> * jk/cached-commit-buffer (2018-02-22) 2 commits
>    (merged to 'next' on 2018-02-27 at af791d9a1e)
>   + revision: drop --show-all option
>   + commit: drop uses of get_cached_commit_buffer()
>
>   Code clean-up.
>
>   Will merge to 'master'.

Thanks! These resolve the dependencies for ds/commit-graph

> * ds/commit-graph (2018-02-20) 13 commits
>   - commit-graph: build graph from starting commits
>   - commit-graph: read only from specific pack-indexes
>   - commit: integrate commit graph with commit parsing
>   - commit-graph: close under reachability
>   - commit-graph: add core.commitGraph setting
>   - commit-graph: implement --delete-expired
>   - commit-graph: implement --set-latest
>   - commit-graph: implement git commit-graph read
>   - commit-graph: implement 'git-commit-graph write'
>   - commit-graph: implement write_commit_graph()
>   - commit-graph: create git-commit-graph builtin
>   - graph: add commit graph design document
>   - commit-graph: add format document
>
>   Precompute and store information necessary for ancestry traversal
>   in a separate file to optimize graph walking.
>
>   Reroll exists, but it appears that there will be a further reroll.
>   cf. <1519698787-190494-1-git-send-email-dstolee@microsoft.com>

v5 reroll (mentioned above) has limited review, so I won't be rerolling 
soon. I'm particularly interested in review on [PATCH 04/13] csum-file: 
add CSUM_KEEP_OPEN flag [1].

Thanks,

-Stolee

[1] 
https://public-inbox.org/git/1519698787-190494-5-git-send-email-dstolee@microsoft.com/

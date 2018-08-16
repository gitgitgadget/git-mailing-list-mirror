Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 816431F404
	for <e@80x24.org>; Thu, 16 Aug 2018 13:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403838AbeHPQOM (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 12:14:12 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:43903 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389123AbeHPQOL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 12:14:11 -0400
Received: by mail-qk0-f172.google.com with SMTP id z74-v6so3517931qkb.10
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 06:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=kp9NHQaN278GgC+Ka2hWq7GJveXh6MJ37qUuGk3y24M=;
        b=o5ga1tnNtIuW/+cu+FVyv1DlOKFRyM2J+Mmqvpffqb6AUAGQDebpmRxGvrj2LEmzqf
         mSKzX35LOHiqTgFCDNiWYo4BYLg7+I/f7A5CbjCYJ0JiM5sSuH0RDMfq2rY760o4PNeC
         lQYXjidEKmMdxR2cSkeUzxcL8LCr4arL0T18dj5HGDKAB1JM9dYcojY93Fwj5jJf470k
         X+iQju6s36ofPR1+/XEPvj1bA47ze/V9O3x4oy09TApanX3qVL6gdHZOurhkWpaUQNvh
         Rh8w+RzgAlh7bngVrf6uvdh5ymFwKNh7rkiBbjvLNN2UX6RYfmfwcZPAZmlUpI4gGJs5
         fvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kp9NHQaN278GgC+Ka2hWq7GJveXh6MJ37qUuGk3y24M=;
        b=WNug5KeyU29SobpQF3Nqe97g0bWqVATndAjOX7dszfBkRv0I5ro9g9XIg05suIjsas
         SoRTKoxJIfmwGhi/923v/LenECSSs22GyuxNZAus4tQd/a/y98r/QeBstJLps9CTgGfD
         Wou1LzAUlAoswlENWscSU+dvVyJj83bTZ2032km3EhL+BsrlqbtNLZtZTCD1+b+fh0WJ
         0GnCtKJuzkYj0Pc0VkIb04OR0LkVZutNW13xE+Z1ICtg5xluJW6pIEm8gtxI0sc/GbrP
         Zro5Ds3eKdiTiPHECjlXC3Mmk4Okb/qZmogOeSBmV3DOoqovgSnDRJL5kUmID8+HhZJ6
         B9Zw==
X-Gm-Message-State: AOUpUlH6NBtZxduDmBTmDWUulWaFdleupqojP5EzayPD/DPNu27lkn4F
        lQMgKuPIcaUzCRX4tvnsLcg=
X-Google-Smtp-Source: AA+uWPxQ7PvJuL0Fo2FXZT0t9MYcT3zmXiyAs/i5naxuY7aGkIlqBJww3tR4dJ84IVx6dTMZJLnMQg==
X-Received: by 2002:ac8:3525:: with SMTP id y34-v6mr28208011qtb.241.1534425338072;
        Thu, 16 Aug 2018 06:15:38 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:79e0:b48f:7e06:fa78? ([2001:4898:8010:0:6316:b48f:7e06:fa78])
        by smtp.gmail.com with ESMTPSA id q195-v6sm16099357qke.13.2018.08.16.06.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Aug 2018 06:15:37 -0700 (PDT)
Subject: Re: What's cooking in git.git (Aug 2018, #03; Wed, 15)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>, jnareb@gmail.com
References: <xmqqpnyjgroj.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <85c6eb4c-a083-4fb7-4860-b01a8ce9fa4f@gmail.com>
Date:   Thu, 16 Aug 2018 09:15:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqpnyjgroj.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/15/2018 7:01 PM, Junio C Hamano wrote:
> * ds/commit-graph-with-grafts (2018-07-19) 8 commits
>    (merged to 'next' on 2018-08-02 at 0ee624e329)
>   + commit-graph: close_commit_graph before shallow walk
>   + commit-graph: not compatible with uninitialized repo
>   + commit-graph: not compatible with grafts
>   + commit-graph: not compatible with replace objects
>   + test-repository: properly init repo
>   + commit-graph: update design document
>   + refs.c: upgrade for_each_replace_ref to be a each_repo_ref_fn callback
>   + refs.c: migrate internal ref iteration to pass thru repository argument
>
>   The recently introduced commit-graph auxiliary data is incompatible
>   with mechanisms such as replace & grafts that "breaks" immutable
>   nature of the object reference relationship.  Disable optimizations
>   based on its use (and updating existing commit-graph) when these
>   incompatible features are in use in the repository.
>
>   Perhaps eject and replace with another reroll when it comes.
>   cf. <a3640919-95cf-cca4-d552-4715a031dd7f@gmail.com>
>   cf. <86bmap7l7a.fsf@gmail.com>

Yes, I am working on a re-roll. Feel free to eject in the meantime.

For one, I need to base it on jk/core-use-replace-refs. This is not 
hard, as it is already in master.

For two, I was waiting for resolution on the way to handle arbitrary 
repositories in for_each_replace_ref. Stefan had a few proposed patches, 
but they don't seem to have completed. Can someone fill me in on the 
status there? I could re-roll with the two simple patches that I have, 
which send the struct repository pointer into the 'void *' data parameter.

Finally, I have some non-trivial feedback from Jakub to work on.

Thanks,

-Stolee


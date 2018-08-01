Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 169131F597
	for <e@80x24.org>; Wed,  1 Aug 2018 20:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbeHAWkn (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 18:40:43 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:39208 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732469AbeHAWkm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 18:40:42 -0400
Received: by mail-pl0-f44.google.com with SMTP id m1-v6so9321083plt.6
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 13:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=GE2kV/GxN8YDv2N9vkEe43yQ6wgMqAWvdifLXI8tOUE=;
        b=IF/fUzRa6aZd4jk/de3oAYwOeHjepZW12MBKVYITNf0LtPr3sdwi8a8nhf/icQlJ57
         hLsmQZLpzYBWmTprLrumuhyAzMdnStJxBabCoto8iX+XR3XMXbZtOosGgFHr1k58xHns
         tXdU60OMf5bffZA/SrLI9VYc20qkO7xvLlHPESgc361HNkRbOWc+7rshMSY62PCbyHim
         0i8B3tXA0pJ3+V1IYBc9kPqrP0y5ybPj/PMD8xeCKLMVEbCwUq85+7xhtjCinpzaOQh1
         kR2J289WJuV01gXAImAu9oSRV5aFTJLeKcKy2tgMu6PZ2ZJKmziYRXDepCYLBsAPejMY
         4lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GE2kV/GxN8YDv2N9vkEe43yQ6wgMqAWvdifLXI8tOUE=;
        b=Fe6voQBShke2gKradYKuiCLW7JJ6cCkUhVnbbFJ772/nHkhFpGeQfn39kyiTavSaEO
         KSnMHj+TPi1B4vnfe0ClNarNF9nqj6zSujabA1atgK3xbswP1UWKY6BpEOrB4n4d6eIF
         FDYsNZJK3SxQBXtU3wFbaxs8Ijmvle5c/cj6ctfgff25QAMcJH7MEXsZ9GIpWve4pHKf
         B7miQth8rhqwwOa27ZM28O7UoGKemDHMWnsbs8RpjazbbPXtH9d6kAGaNfZM5D7qCt6H
         pFIaQUX1lFFj1EWpNwgtmvUwxtyNX/YkETwTvFj7tDSFiQrWMJU2a54tnXkYyhMy3Lr+
         p6Fg==
X-Gm-Message-State: AOUpUlFY94galvxalYFvkLyv+VhFKJe1Cy3IsgmP9Vd3zRSQZQZ8iIbT
        CFatDTGqJqKUiQh2mSVss44=
X-Google-Smtp-Source: AAOMgpexVc0gVx9IJmSOxwSJueTI2jf0Y48MRXNCLgd/Ympmf0NenX9S2YBq0vI+nbtyPF/1P4lY5g==
X-Received: by 2002:a17:902:123:: with SMTP id 32-v6mr25546459plb.181.1533156785457;
        Wed, 01 Aug 2018 13:53:05 -0700 (PDT)
Received: from [192.168.5.149] (143.120.102.199.static.airbits.net. [199.102.120.143])
        by smtp.gmail.com with ESMTPSA id e126-v6sm35618644pfg.31.2018.08.01.13.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 13:53:04 -0700 (PDT)
Subject: ds/multi-pack-index (was Re: What's cooking in git.git (Jul 2018,
 #03; Wed, 25))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f17a6d57-e6cb-9efa-d648-cd4f298dc47f@gmail.com>
Date:   Wed, 1 Aug 2018 16:53:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/25/2018 6:13 PM, Junio C Hamano wrote:
> * ds/multi-pack-index (2018-07-20) 23 commits
>   - midx: clear midx on repack
>   - packfile: skip loading index if in multi-pack-index
>   - midx: prevent duplicate packfile loads
>   - midx: use midx in approximate_object_count
>   - midx: use existing midx when writing new one
>   - midx: use midx in abbreviation calculations
>   - midx: read objects from multi-pack-index
>   - config: create core.multiPackIndex setting
>   - midx: write object offsets
>   - midx: write object id fanout chunk
>   - midx: write object ids in a chunk
>   - midx: sort and deduplicate objects from packfiles
>   - midx: read pack names into array
>   - multi-pack-index: write pack names in chunk
>   - multi-pack-index: read packfile list
>   - packfile: generalize pack directory list
>   - t5319: expand test data
>   - multi-pack-index: load into memory
>   - midx: write header information to lockfile
>   - multi-pack-index: add 'write' verb
>   - multi-pack-index: add builtin
>   - multi-pack-index: add format details
>   - multi-pack-index: add design document
>
>   When there are too many packfiles in a repository (which is not
>   recommended), looking up an object in these would require
>   consulting many pack .idx files; a new mechanism to have a single
>   file that consolidates all of these .idx files is introduced.
>
>   Ready to move to 'next', with some known issues to be followed up?
>   cf. <xmqqefg8uplg.fsf@gitster-ct.c.googlers.com>
I'm not sure if there is anything actionable for me to do in response to 
this message.
>   cf. <CAPig+cTU--KrGcv4C_CwBZEuec4dgm_tJqL=CFWKT6vxxR016w@mail.gmail.com>
This message is in regard to UX around the usage output when the 
command-line arguments are incorrect. The recommendation is to 
explicitly state what the user did that is incorrect. For such a simple 
usage line, I don't think this is necessary. The message also included this:

> I wouldn't want to see a re-roll just for this, especially for such a
> long series. Perhaps such a change can be done as a follow-up patch by
> someone at some point.

If this is something we _really_ want to do, then I will tackle it in my follow-up series that adds a 'verify' verb (thus complicating the usage and giving me an opportunity to improve this area).

Thanks,
-Stolee


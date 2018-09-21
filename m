Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FA2E1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390976AbeIUXbc (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 19:31:32 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40886 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390433AbeIUXbc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 19:31:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id e9-v6so2114688qtp.7
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=YfIWiImof7Y1A2btR8jkoRD+2iRZdzoh2LTLJiy6ELg=;
        b=rEjIWnFStPLikBZ/rIpb5xyPpA9WU56NkVw7uitk6qFFswh9cDBgBWq0Kv+lu6Ccdc
         CYNONBvcooFi9LiQkrumhwwzlpd56mYRzl3vA+o8ltun+hTU/34HjwgG8TFyF0jb7+DP
         nRWD9wmKYb4s21PoJB6SbFuJrc9u3FzIvrAlv9B7rBGgkQL7NYvCUAV/kgx3bKtS4rB4
         FXbyZ7iGAgPZDIfbIRmRPy2szPglXVf76jDT8gNFLOus0Ztxq14EVuFuxlajdJqEm1PP
         ReVZ1TgwSI20PZ72pBQ8c38GW+CufvhaUZc8QJDEa8Jxqhj8Bi268dbMXkuXqv0YhD3V
         rR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=YfIWiImof7Y1A2btR8jkoRD+2iRZdzoh2LTLJiy6ELg=;
        b=hgK7MXunW1+rOM0JfAx3DSiv7GiarSl8eSliAJj79A880Mc1KcFAymZA+gpS5aoXKN
         GaUmGYqFn/oalnsoeQYsB49euYLa15z/alSVTU3HiiW1qhezlWOVRVM9pndweXS8BVTM
         LIOni8jxsi41HkV1mWAUJG/x1nU2jZbmjvuPDTwbrJS02CXqmqchqtHLOvs3U8lVP5Mc
         HVQznVkLU2kVvegtpRdK3DAy0vTh6wJxg83fFCUcq5QA6LHhyyZLKun76NXKrGhEcUO6
         XcO25Pe30i1OpjcmgTP+9h6lleMTdbGzNCX2Q+BXpsYaDE5bgCtDgYSNVz8qghVN7AoS
         aznw==
X-Gm-Message-State: APzg51CwmrclfPk/2/YmJXUy6HvFSb1sqJtTsMSj8qLZugkasJh8Yu4T
        F29k7VyhWgqXAek50bb9OiEC8XKq
X-Google-Smtp-Source: ANB0VdYexFyqwSiTusqmiKtkLvpkgbX8w2Et5TqPXcZkJ0+KOIjQnFRe3JCa8+/h5boiJFlbFDnj/Q==
X-Received: by 2002:a0c:f8ce:: with SMTP id h14-v6mr32351607qvo.201.1537551696167;
        Fri, 21 Sep 2018 10:41:36 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f452:f7ab:45dd:bf7c? ([2001:4898:8010:0:dd88:f7ab:45dd:bf7c])
        by smtp.gmail.com with ESMTPSA id x189-v6sm16246113qkd.44.2018.09.21.10.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 10:41:35 -0700 (PDT)
Subject: Re: [PATCH 9/9] commit-reach.h: add missing declarations (hdr-check)
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <089b2111-b7e9-6795-b04a-ed259f78796a@ramsayjones.plus.com>
 <eb77d563-8b3e-9b00-59b8-b050e6378c69@gmail.com>
 <2809251f-6eba-b0ac-68fe-b972809ccff7@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <15ffe24b-0ebb-6723-07af-703bc45becba@gmail.com>
Date:   Fri, 21 Sep 2018 13:41:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <2809251f-6eba-b0ac-68fe-b972809ccff7@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/20/2018 11:35 AM, Ramsay Jones wrote:
>
> On 20/09/18 00:38, Derrick Stolee wrote:
>> On 9/18/2018 8:15 PM, Ramsay Jones wrote:
>>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>>> ---
>>>    commit-reach.h | 5 +++--
>>>    1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/commit-reach.h b/commit-reach.h
>>> index 7d313e2975..f41d8f6ba3 100644
>>> --- a/commit-reach.h
>>> +++ b/commit-reach.h
>>> @@ -1,12 +1,13 @@
>>>    #ifndef __COMMIT_REACH_H__
>>>    #define __COMMIT_REACH_H__
>>>    +#include "commit.h"
>>>    #include "commit-slab.h"
>>>    -struct commit;
>>>    struct commit_list;
>>> -struct contains_cache;
>> Interesting that you needed all of commit.h here, and these 'struct commit' and 'struct contains_cache' were not enough. Was there a reason you needed the entire header file instead of just adding a missing struct declaration?
> Actually, the original version of this patch didn't add that
> include! I changed my mind just before sending this series
> out, since I felt the original patch was conflating two issues.
>
> The reason for the #include of 'commit.h' in this patch, but
> not with my original patch, has to to with the inline functions
> used in the commit-slab implementation. My original patch used
> the 'commit-slab-{decl,impl}.h' header files to sidestep the
> need for the definition of 'struct commit'.
>
> I have included an 'RFC on-top' patch below to show you what I
> had in mind. NOTE: I had not finished writing the commit message
> and you could argue that the 'implement' macro should go in the
> ref-filter.c file, since that is were the contains_cache is
> 'defined and initialised'. I had not intended to send this to
> the list ... :-D
>
> Note that, if you compile with optimizations disabled, then
> run this script:
>
>    $ cat -n dup-static.sh
>         1 #!/bin/sh
>         2
>         3 nm $1 | grep ' t ' | cut -d' ' -f3 | sort | uniq -c |
>         4 	sort -rn | grep -v '      1'
>    $
>
>    $ ./dup-static.sh git | grep contains
>         24 init_contains_cache_with_stride
>         24 init_contains_cache
>         24 contains_cache_peek
>         24 contains_cache_at_peek
>         24 contains_cache_at
>         24 clear_contains_cache
>    $
>    
> you will find 24 copies of the commit-slab routines for the
> contains_cache. Of course, when you enable optimizations again,
> these duplicate static functions (mostly) disappear. (Two static
> functions remain, the rest are actually inlined at -O2).
>
> However, if you apply the patch below, you end up with all of
> the functions in the contains_cache commit-slab implementation
> as external functions. Some of those functions are never called,
> so it's not necessarily a win ... ;-)

Thanks for the explanation! I prefer your #include "commit.h" above to 
the alternative.

Thanks,

-Stolee


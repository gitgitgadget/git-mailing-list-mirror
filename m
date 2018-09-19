Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_12_24,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555321F453
	for <e@80x24.org>; Thu, 20 Sep 2018 12:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbeITSeW (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Sep 2018 14:34:22 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44637 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387701AbeITSeV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 14:34:21 -0400
Received: by mail-qt0-f194.google.com with SMTP id k38-v6so8281124qtk.11
        for <git@vger.kernel.org>; Thu, 20 Sep 2018 05:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=thecSTK4easko1lj7vwoDN6vFIqJrnsXYfRcM2WoBP8=;
        b=EwOlXV7P+X/u03epZLneIFnSRenEEsAnGp0g+4xQS9zA2g9bKeY4eveN3lXXdqfCZT
         buQs31SwKOJcg4ZxXSJYzdptih6yWdkMq2AK8WjY6MjkBRWjzsme1uqzJ3SiaQkqGhxF
         ukl+AZ3cDLYnE1VGMNao6H0GUX9/mA39N4zzF7Vt7Y/9NXmtQzuWU2hxaSSi/zm1oRGg
         LzBmhW6L49N4+iMrrHACY0rDGZBrO8F2w2AUhUFk7D9WQ87G6JvQYX2LrGEm4WYOvaMh
         JDkszw5oGXoNJbxm6v+uJKnxJwISWbi4YYLgfFWOu15AzVRT9omJDrWbIINv/iLNs80O
         ZR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=thecSTK4easko1lj7vwoDN6vFIqJrnsXYfRcM2WoBP8=;
        b=CJ9Aj9+KU1SjO5Fo0ryrblpUH9XYNJaGc/AVHNk2WNdDUKym6DfwENWWob3JVyxbwf
         3DKs4gtEuICm4YvJbmkcMk3duXtTyRi+1NhjRbpqc3zQ2Kla3S+vT1IqVD1j348YWjKL
         3OD4v2o9NtMLF6RyJQGGUA5v2Qj8AwCYlO22xt1HSMBoBnpfrqFEkSJLX8W1e93j1/tw
         UdjcrqQEqiA4w2vjFsQzgdgaTuPfRm1DqPBpIH/pJpmaS4fF2Ub/BdyE66e17fGdWkrP
         mS+7v2Jfe4gGXD+QKiSIn53P90athhGd5knk7uRGUvC09mfFQoUPv8HqjQ9OHh4Cu1Ta
         qP2w==
X-Gm-Message-State: APzg51CVd7ygp19C7RiOjXwq/TLO6IkEXg5rzA/9znnKUPtqgKD8plXv
        yDAbhsfNYbN5S9lMzTTmcBYqms4E
X-Google-Smtp-Source: ANB0VdavbbZrQ+eh2S5RK4Uj++x64EkWzCiVK1bX3sRfKwNE8ElKufOGG2GOFc1so3wqikZDiEoB+g==
X-Received: by 2002:a0c:8c05:: with SMTP id n5-v6mr28614878qvb.185.1537447859462;
        Thu, 20 Sep 2018 05:50:59 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id v10-v6sm17088384qtv.77.2018.09.20.05.50.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 05:50:58 -0700 (PDT)
Subject: Re: [PATCH 9/9] commit-reach.h: add missing declarations (hdr-check)
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <089b2111-b7e9-6795-b04a-ed259f78796a@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <eb77d563-8b3e-9b00-59b8-b050e6378c69@gmail.com>
Date:   Wed, 19 Sep 2018 19:38:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <089b2111-b7e9-6795-b04a-ed259f78796a@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/18/2018 8:15 PM, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>   commit-reach.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/commit-reach.h b/commit-reach.h
> index 7d313e2975..f41d8f6ba3 100644
> --- a/commit-reach.h
> +++ b/commit-reach.h
> @@ -1,12 +1,13 @@
>   #ifndef __COMMIT_REACH_H__
>   #define __COMMIT_REACH_H__
>   
> +#include "commit.h"
>   #include "commit-slab.h"
>   
> -struct commit;
>   struct commit_list;
> -struct contains_cache;

Interesting that you needed all of commit.h here, and these 'struct 
commit' and 'struct contains_cache' were not enough. Was there a reason 
you needed the entire header file instead of just adding a missing 
struct declaration?

>   struct ref_filter;
> +struct object_id;
> +struct object_array;
>   
>   struct commit_list *get_merge_bases_many(struct commit *one,
>   					 int n,

These look like standard inclusions. Thanks!

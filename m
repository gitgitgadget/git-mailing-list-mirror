Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B2C1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754763AbeFNRju (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:39:50 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37359 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754616AbeFNRjt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:39:49 -0400
Received: by mail-pg0-f67.google.com with SMTP id r21-v6so3242629pgv.4
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ff208sDr4/KGwbxCEX3kkT4DxJqcPxOZTZ1vkX/yq5U=;
        b=b0nkcFnV6VOElcabN2m77qO6C5scC8HjtTAPIuAW8d3QBTF0Yq9pZD1AymKQcRPalI
         e6zmRyVIs80TPKImiWWPiJBnwAIzMfU7t2Pz4LTCyXmrJMmEE7WQoukpKaf6W42bRTwI
         zcX2GPR+Gs4TeP9Bgk2BxoAdx1pC/BgAciC4Xs32YwDQtaPf5jUozbifqg94Djto4JW3
         IERbOYZXbdfqJHYDyGtgxe7NpSQQbxHVwOChZ49uozMjWAE7R1/ZRk/sMFvu5ifA6KsS
         BLPVEzaVyOWKAQrtGAWveXq5Vx4b7YmuVceKEFxoHVlpz3F1jfYVC0uUfEaTL1BUGjiu
         NFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ff208sDr4/KGwbxCEX3kkT4DxJqcPxOZTZ1vkX/yq5U=;
        b=WBPUeYMEKBZnuJjFO+lRSpRJiTzRp7hkViYxxHB/6OiI9R4FzUyBUYJkxsPq17M/lp
         VDzLAVHO1sbzKBxlNErcKnAHohaiASJpmyhr/aIdS235kyqDw09Xzrxy3g4FYyiVBn3b
         VUxiaymo53LyQbumDAUKcaMrB5MkvXIdZrLYsdhAarLbxzIvPmq62STV6MtWQEBRYWt+
         3GMH3ITnZIluh4PSLidgTFhVz5BloPk8JPY8x7lEcirvia1lBE0UBdtI8D2uiiLJry4D
         jHroBpDfyhgjNK2fWXPedd5bfhQpdDbW3enbgX0AugCeqVFTp3NfjKS3xKE7tohAsLFv
         pLEg==
X-Gm-Message-State: APt69E1uuq7c8PTqzqoKJlFWQBbBeQupRQXnYO+p4R5BzTU9CXWno9DV
        ZGiVCdWKgCQjJYADAGJ7dRrUKQ==
X-Google-Smtp-Source: ADUXVKI63IQ/kc99fyNuMtatLrir0wDG5s/x0EypAIwTYjjL+lhGHTDuRY9yqU/rHhzoBPEW6AMOuw==
X-Received: by 2002:a63:8ec8:: with SMTP id k191-v6mr3107827pge.435.1528997988875;
        Thu, 14 Jun 2018 10:39:48 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id m12-v6sm7179314pgp.88.2018.06.14.10.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 10:39:47 -0700 (PDT)
Date:   Thu, 14 Jun 2018 10:39:47 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2 8/8] negotiator/default: use better style in comments
Message-ID: <20180614173947.GF220741@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <cover.1528317619.git.jonathantanmy@google.com>
 <aa0df5f449c2f5c1f2e6d6edf933aad5f58b2a5e.1528317619.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa0df5f449c2f5c1f2e6d6edf933aad5f58b2a5e.1528317619.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/06, Jonathan Tan wrote:
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  negotiator/default.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/negotiator/default.c b/negotiator/default.c
> index b8f45cf78..a9e52c943 100644
> --- a/negotiator/default.c
> +++ b/negotiator/default.c
> @@ -46,11 +46,10 @@ static int clear_marks(const char *refname, const struct object_id *oid,
>  }
>  
>  /*
> -   This function marks a rev and its ancestors as common.
> -   In some cases, it is desirable to mark only the ancestors (for example
> -   when only the server does not yet know that they are common).
> -*/
> -
> + * This function marks a rev and its ancestors as common.
> + * In some cases, it is desirable to mark only the ancestors (for example
> + * when only the server does not yet know that they are common).
> + */
>  static void mark_common(struct data *data, struct commit *commit,
>  		int ancestors_only, int dont_parse)
>  {
> @@ -80,9 +79,8 @@ static void mark_common(struct data *data, struct commit *commit,
>  }
>  
>  /*
> -  Get the next rev to send, ignoring the common.
> -*/
> -
> + * Get the next rev to send, ignoring the common.
> + */
>  static const struct object_id *get_rev(struct data *data)
>  {
>  	struct commit *commit = NULL;
> -- 
> 2.17.0.768.g1526ddbba1.dirty
> 

Don't have this be a separate patch, squash it into the previous patch.

-- 
Brandon Williams

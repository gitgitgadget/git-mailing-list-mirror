Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6B63215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 13:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeD3NLn (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 09:11:43 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41698 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeD3NLl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 09:11:41 -0400
Received: by mail-qt0-f194.google.com with SMTP id g13-v6so10772004qth.8
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 06:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6M5EZmNeL+KNeGMq2dnFGI2efAO4JO7oXb06UqIkjIM=;
        b=gf02YQ1GMcEeATBpS4fUxxqtBHlilzi6TfClVxs4B5G8LnN8FIgBqyzs3gMquuJMoP
         wR6jX2oJLiQ0uT7MdGBRsvwdCBwd1P1dLvvpAFTMxiHZIdgXfuLnvdKRwPLqSXaIfD5F
         h43CFTnuwWN47pL+dvGM2kV7M115PfcbBrgWZq0+bG4JbkwhmEbOFaCAszMmpem0nu+N
         a4zxJbb3BPFMiAugUzNvdX4va4kHV2zniB0Q54r40kp4vV6vC3Iv7ZpI9LqnVYSZgByX
         lfZlpEUN2w+Y7vI+hBINBzZLoRphuJEGNzKiX+WdltVJxF0gcOK2nXJYsIkuXl/Mq3cb
         r5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6M5EZmNeL+KNeGMq2dnFGI2efAO4JO7oXb06UqIkjIM=;
        b=RO8DUmVS7x1TaAiUKL85AlNNM0zLVq9hGrxyKzlKugF1NsJG12CUhAkRnWwojwnMGR
         v58ffDnbr5DAAsrbK8P5rhB18W1AvFNhoT/xxylguk02yGkZMuZyvuD9yVCsTHXmAGCj
         Jb3TUBGUPIraZGcctuZOEFJH8jtA3HEbGKCOhkIMetRdVwgwMQ02p9sxK5ujTccF5kZf
         V+FP3aPzQyClhgKCrRUTBA1wJiGcFaHrCf1iVoiJHQ96U844atocHkoWyWSXkhF7eznG
         F0V67gwpshlgP15ysODa4AKHMS7kCnUwieG8lPXsK4TiGwhfq5qOVcb6yW6qGGF6bbth
         obSQ==
X-Gm-Message-State: ALQs6tDbPhRYhi5eaJXZWBMQjNOhJ40g6S5w7GpbasM0LOUtIvBKgCjM
        5x2HfNPyzvCt2WAiK40b1t0=
X-Google-Smtp-Source: AB8JxZpJrlr+32QHmlHAjxgPiTGreaqCwZQzJsfhXu/iWdtBaqhkszvfjCgKWurYAufVhqU8oe/rrA==
X-Received: by 2002:a0c:900b:: with SMTP id o11-v6mr10857653qvo.32.1525093900977;
        Mon, 30 Apr 2018 06:11:40 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id w22-v6sm6042846qtg.60.2018.04.30.06.11.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Apr 2018 06:11:40 -0700 (PDT)
Subject: Re:
To:     Elijah Newren <newren@palantir.com>
Cc:     Ben.Peart@microsoft.com, Johannes.Schindelin@gmx.de,
        eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, kewillf@microsoft.com, pclouds@gmail.com,
        peff@peff.net, vmiklos@frugalware.org,
        Elijah Newren <newren@gmail.com>
References: <7de8f144-8a37-e471-48e8-0b6f17a7bf29@gmail.com>
 <20180427181937.7607-1-newren@palantir.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <e753d8fd-5329-b819-0076-0ff4659dabf1@gmail.com>
Date:   Mon, 30 Apr 2018 09:11:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427181937.7607-1-newren@palantir.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/27/2018 2:19 PM, Elijah Newren wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> On Thu, Apr 26, 2018 at 5:54 PM, Ben Peart <peartben@gmail.com> wrote:
> 
>> Can you write the documentation that clearly explains the exact behavior you
>> want?  That would kill two birds with one stone... :)
> 
> Sure, something like the following is what I envision, and I've tried to
> include the suggestion from Junio to document the copy behavior in the
> merge-recursive documentation.
> 
> -- 8< --
> Subject: [PATCH] fixup! merge: Add merge.renames config setting
> 
> ---
>   Documentation/merge-config.txt     | 3 +--
>   Documentation/merge-strategies.txt | 5 +++--
>   merge-recursive.c                  | 8 ++++++++
>   3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
> index 59848e5634..662c2713ca 100644
> --- a/Documentation/merge-config.txt
> +++ b/Documentation/merge-config.txt
> @@ -41,8 +41,7 @@ merge.renameLimit::
>   merge.renames::
>   	Whether and how Git detects renames.  If set to "false",
>   	rename detection is disabled. If set to "true", basic rename
> -	detection is enabled.  If set to "copies" or "copy", Git will
> -	detect copies, as well.  Defaults to the value of diff.renames.
> +	detection is enabled.  Defaults to the value of diff.renames.
>   
>   merge.renormalize::
>   	Tell Git that canonical representation of files in the
> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
> index 1e0728aa12..aa66cbe41e 100644
> --- a/Documentation/merge-strategies.txt
> +++ b/Documentation/merge-strategies.txt
> @@ -23,8 +23,9 @@ recursive::
>   	causing mismerges by tests done on actual merge commits
>   	taken from Linux 2.6 kernel development history.
>   	Additionally this can detect and handle merges involving
> -	renames.  This is the default merge strategy when
> -	pulling or merging one branch.
> +	renames, but currently cannot make use of detected
> +	copies.  This is the default merge strategy when pulling
> +	or merging one branch.
>   +
>   The 'recursive' strategy can take the following options:
>   
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 6cc4404144..b618f134d2 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -564,6 +564,14 @@ static struct string_list *get_renames(struct merge_options *o,
>   	opts.flags.recursive = 1;
>   	opts.flags.rename_empty = 0;
>   	opts.detect_rename = merge_detect_rename(o);
> +	/*
> +	 * We do not have logic to handle the detection of copies.  In
> +	 * fact, it may not even make sense to add such logic: would we
> +	 * really want a change to a base file to be propagated through
> +	 * multiple other files by a merge?
> +	 */
> +	if (opts.detect_rename > DIFF_DETECT_RENAME)
> +		opts.detect_rename = DIFF_DETECT_RENAME;
>   	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
>   			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
>   			    1000;
> 

Thanks Elijah. I've applied this patch and reviewed and tested it.  It 
works and addresses the concerns around the settings inheritance from 
diff.renames.  I still _prefer_ the simpler model that doesn't do the 
partial inheritance but I can use this model as well.

I'm unsure on the protocol here.  Should I incorporate this patch and 
submit a reroll or can it just be applied as is?

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 258791F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755023AbeDKUjE (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:39:04 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36907 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753884AbeDKUjB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 16:39:01 -0400
Received: by mail-pl0-f67.google.com with SMTP id v5-v6so2246791plo.4
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=LIc2lepr6NTKsIB3nZIRkR5+lwggNuvcKWPGsWyztow=;
        b=oG+ji76KNl06URsRaN5soICuyiW2T6MJ7L99bdvowTM+knTjLQYDoLE2Sq3ooMxxke
         7BOM+GyQgUgH2Zzib+p28G1T1i995hm2Ch6793SrAp1nlf+MV1aaFOQmccuuPe/tOSpy
         K4+oHNGF51vLrnxMgx0Btv6+/XoSr5FZomU3kZx4i/NLzYKo1BZSZpt/YZjAIcttteiN
         mjpM2m7y7tEswp/Esbw/P8l7VVXwrAXXsKnsJewSn2jLzCVxMHdWNUwPQ79NHMqLeKjF
         6TR96l3GDiUL3OpSijExiq5D6XsBN6KTKBTkRNHHyUyO1JJAWTnJVcIy+psqxAogFU8m
         q9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=LIc2lepr6NTKsIB3nZIRkR5+lwggNuvcKWPGsWyztow=;
        b=IX3whyq7CuW+smfFWJ8RXjBQGwQ37oUfRLuk9tyL8xD0w7T30kjtPX7aCiYCh/VVMO
         L4d3od24MfQO93J1d07hD9XwCh4uKNVMIJoCYjNuANenW6Ad4p6LFMWnDOLRx4TVQvWk
         +BqoSbMgkv8RlI+EqWWCFb7voGBkdR7xF3DQyPd+JKNAx2HTuY3BwmvBzJMvZtFPTgEk
         ryfV1KiDvp4EcHd/YpBIYKBojXYK3saD2vJZcPyaPKtCbKfiTQL6LPyW69PUk90tFwjT
         N9Fp31h3CQpb2EtWdwm3NcM7RZLjvMZhVTfsGBLO1M1ZOeJgJnO7jwmrIxG4BTmkAGyi
         /HAg==
X-Gm-Message-State: ALQs6tCmSUEHwXTZ7pemiZwF4TjaHRqwYzBgy42M6i8msfAMmMn6WlGw
        ITsZJG2tIa+71OY1DlcfdTy8Sk4L
X-Google-Smtp-Source: AIpwx4+4B2OeHl7uPTv/RKkuIqDF86b9HvRI6elS5HgrxaFe7XJspGMv7qpWNgAC7EUv+ssb7tacQw==
X-Received: by 2002:a17:902:f24:: with SMTP id 33-v6mr6646218ply.242.1523479141017;
        Wed, 11 Apr 2018 13:39:01 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id v144sm4779053pgb.11.2018.04.11.13.38.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Apr 2018 13:39:00 -0700 (PDT)
Subject: Re: [PATCH resend] SubmittingPatches: mention the git contacts
 command
To:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20180411202000.31086-1-t.gummerer@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4f19d1b0-72e1-4c9f-6027-16e0e6cfc24d@gmail.com>
Date:   Wed, 11 Apr 2018 16:38:54 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180411202000.31086-1-t.gummerer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/11/2018 4:20 PM, Thomas Gummerer wrote:
> Instead of just mentioning 'git blame' and 'git shortlog', which make it
> quite hard for new contributors to pick out the appropriate list of
> people to cc on their patch series, mention the 'git contacts' utility,
> which makes it much easier to get a reasonable list of contacts for a
> change.
>
> This should help new contributors pick out a reasonable cc list by
> simply using a single command.
>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> I've originally sent this at <20180316213323.GC2224@hank>, during an
> the rc period.  Eric had some comments, which I interpreted as being
> okay with the change (hope I'm not mistaken there :)).  As I still
> think this would be an improvement for new contributors, I'm resending
> it here.

I didn't know about this tool, and it seems helpful. I plan to use it 
now. Thanks!

>   Documentation/SubmittingPatches | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index a1d0feca36..945f8edb46 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -260,8 +260,8 @@ that starts with `-----BEGIN PGP SIGNED MESSAGE-----`.  That is
>   not a text/plain, it's something else.
>   
>   Send your patch with "To:" set to the mailing list, with "cc:" listing
> -people who are involved in the area you are touching (the output from
> -`git blame $path` and `git shortlog --no-merges $path` would help to
> +people who are involved in the area you are touching (the `git
> +contacts` command in `contrib/contacts/` can help to
>   identify them), to solicit comments and reviews.
>   
>   :1: footnote:[The current maintainer: gitster@pobox.com]


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50DA71F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbdGYVVQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:21:16 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33994 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdGYVVO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:21:14 -0400
Received: by mail-pf0-f170.google.com with SMTP id q85so62930464pfq.1
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6w48oVxeZPNSWmo7cc9+DJ88t5BmNmgtc6eLW1iIbnA=;
        b=DZwBG3X2tSvFtgqKKqge/FZRPvJBdGA7MLiL5gGfhBkbj8GemN/zPNCLl4VKFcObhb
         qROGXJs6w2BES/NlrTmlR2w+Qa7DTKtXUcMNSmiHhKaNR7/06IQ9wbHg9ARrasQnUdO1
         UtU28p2+9augoVu+8zuW0iOPl/pO0/Ss9Y8rjfVCheeDkAWIuu3JxKPQ4ehbGcw7sUoi
         X+kBZ9XWQbD12FEQGS4vYk7LHRYP2xZGvxH+FeNoeU49vv6y7Wcd4uMuZmHTv4cgLmI9
         ciWqPfWhc9hjlSiakhektUEIdtPfYSKehf98gKqATDexfaBxlxVwLZw6tdVhLodyq3vh
         ZMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6w48oVxeZPNSWmo7cc9+DJ88t5BmNmgtc6eLW1iIbnA=;
        b=T8HbWOZy8mHVDBHB5sx8F5MZ6XW0qCEaCZVy20S1QrQhK7EI4h7JCZSmgKvnHO6iOe
         bWWaCxvr7paIOqrB5rXADA7zJn1R+SNvn9zHUEJkLWrSRHJPS9aDJRAQfLHG6vuPMsJH
         6nbCbl4PqYLJj4TEu/jd8KHYTaI6hJCwW93Im0cE0NvXh4aniUKxwbTd3uIdQgQCa4vQ
         YF7RnOlkWBniEtUjZtP5JjynZs6PulnOzZqGHQbGA6KBLXQLspboh237Z/FCZ25BVXzx
         Kk64AGMYoHucs7ylHoYA0aX74ma+Qie8XlNIx1f9gdxgPMKSE33EHtb/+eUueImO6ddj
         4emw==
X-Gm-Message-State: AIVw111eJtJYUprV+TJyS9RHiO3I4s7eqJigNtiQcfL9QVf6k9a6jMRA
        IAmqh+cHqd3tIXVkVV0=
X-Received: by 10.98.95.67 with SMTP id t64mr20309312pfb.127.1501017673471;
        Tue, 25 Jul 2017 14:21:13 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:66:1d4e:8666:f816])
        by smtp.gmail.com with ESMTPSA id 85sm30576592pfr.90.2017.07.25.14.21.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:21:12 -0700 (PDT)
Date:   Tue, 25 Jul 2017 14:21:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] setup: update error message to be more meaningful
Message-ID: <20170725212110.GG13924@aiede.mtv.corp.google.com>
References: <0102015d7ae53b0a-a6505296-9257-4b0d-84d6-2152e17eb070-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0102015d7ae53b0a-a6505296-9257-4b0d-84d6-2152e17eb070-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Kaartic Sivaraam wrote:

> The error message shown when a flag is found when expecting a
> filename wasn't clear as it didn't communicate what was wrong
> using the 'suitable' words in *all* cases.
>
> Correct case,
>
>         $ git rev-parse commit.c --flags
>         commit.c
>         --flags
>         fatal: bad flag '--flags' used after filename
>
> Incorrect case,
>
>         $ git grep "test" -n
>         fatal: bad flag '-n' used after filename
>
> Change the error message to be general and communicative.

Thanks for writing this.  These examples describe *what* the behavior
is but don't describe *why* it is wrong or what is expected in its
place.

For an initial guess: in the example

	git grep test -n

it is confusing that it says "bad flag used after filename" because
test isn't even a filename!  At first glance, I would imagine that any
of the following behaviors would be nicer:

 1. Treat the command as "git grep -e test -n", or in other words
    "do what I mean" since it is clear enough, at least to humans.

 2. Focus on "argument" instead of "filename" so that the message
    could still apply: something like

	fatal: option '-n' must come before non-option arguments

[...]
> --- a/setup.c
> +++ b/setup.c
> @@ -230,7 +230,7 @@ void verify_filename(const char *prefix,
>  		     int diagnose_misspelt_rev)
>  {
>  	if (*arg == '-')
> -		die("bad flag '%s' used after filename", arg);
> +		die("found flag '%s' in place of a filename", arg);

Probably because of the background I am missing described above, it's
not clear to me that the new message is any better (or worse) than the
existing one.  The old message with "after filename" has the virtue of
explaining why an option is not expected there.

Thanks and hope that helps,
Jonathan

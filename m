Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA922047F
	for <e@80x24.org>; Wed, 26 Jul 2017 13:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751641AbdGZNIf (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 09:08:35 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34023 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751634AbdGZNIc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 09:08:32 -0400
Received: by mail-pg0-f51.google.com with SMTP id 123so84162021pgj.1
        for <git@vger.kernel.org>; Wed, 26 Jul 2017 06:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=0Cq0kNZbGeW219O9ySv8m6GCaLVQnzt+A/1lXOPn9iM=;
        b=Xy8QfUksjEAPB6dTOwN17or8lAlPzoHNWKDIO7VupfN96Al+jHQGCYwdRBAz7fa1uO
         sCWyWvOX1TpLHIRxWg1pXeulvG56wmyhfulk+B30uyxMuBZfEoIK7Vnc54/ue1OXuWoT
         bMEbznCwnVjK6BoiNSqIm/zZuH9NWDFGm08g2o9EZ5GfWG7LuST9AqTrfLbvlvt+nkQs
         Og16Ttyt2yP6h8704StDRentSVR3Wvbpg5U65vvaVHAKATTCbN+c1EH69rlqAWjUU7hK
         Z6zS5hdftj4frdwqeHVHElk/6NIZtqs8maTG6y00H2lfLdA8+N2csL+XcjwFcZQ2Z8tL
         BJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=0Cq0kNZbGeW219O9ySv8m6GCaLVQnzt+A/1lXOPn9iM=;
        b=Knqamf/bxGvpi+wbMFRnEfQ77Q4cI6CgrK30tgpe5orccBkViobC81c5sbALnfb6eU
         lie3B9r6JtOjMRbFWowwdr/B1ZZbjssbOvY44zgZw5EKu4kzvZBbbrcz03fbjrsWujAg
         Imv0bpJZ/wuovKNvwVVCzsGln7BbAuWH+oKPSTZ6JYuZjUXsLZ5XaY5/dFiXoK7I2xSH
         UNU2L1/qQwmkZ6IPbg4O7pCLBZZCyhH5mpxZqos/GaaZIavcvwoOkQ742k35kfklO652
         Y+F6XsMVCgYofuEtQ4gMyuib/cYYX5ADu1+/gxXhOeHNxIu9AyVvOvK9BSZPYLFjJfYl
         Xdcw==
X-Gm-Message-State: AIVw113URjOgbsofazC2vFNYsVSTlfsmhAYFYAGgWhf/7/xjmaQjQpGH
        7vf9rU1E21jdUw==
X-Received: by 10.84.228.214 with SMTP id y22mr891089pli.245.1501074511620;
        Wed, 26 Jul 2017 06:08:31 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id i5sm40359664pgk.61.2017.07.26.06.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Jul 2017 06:08:31 -0700 (PDT)
Message-ID: <1501074537.1792.2.camel@gmail.com>
Subject: Re: [PATCH/RFC] setup: update error message to be more meaningful
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
In-Reply-To: <20170725212110.GG13924@aiede.mtv.corp.google.com>
References: <0102015d7ae53b0a-a6505296-9257-4b0d-84d6-2152e17eb070-000000@eu-west-1.amazonses.com>
         <20170725212110.GG13924@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Wed, 26 Jul 2017 18:38:57 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Jonathan Nieder,

Thanks for the reply!

Jonathan Nieder wrote:
> 
> > The error message shown when a flag is found when expecting a
> > filename wasn't clear as it didn't communicate what was wrong
> > using the 'suitable' words in *all* cases.
> > 
> > Correct case,
> > 
> >         $ git rev-parse commit.c --flags
> >         commit.c
> >         --flags
> >         fatal: bad flag '--flags' used after filename
> > 
> > Incorrect case,
> > 
> >         $ git grep "test" -n
> >         fatal: bad flag '-n' used after filename
> > 
> > Change the error message to be general and communicative.
> 
> Thanks for writing this.  These examples describe *what* the behavior
> is but don't describe *why* it is wrong or what is expected in its
> place.
> 
I've fixed that. The new commit message is found at the end of this
message.

> For an initial guess: in the example
> 
> 	git grep test -n
> 
> it is confusing that it says "bad flag used after filename" because
> test isn't even a filename!  At first glance, I would imagine that any
> of the following behaviors would be nicer:
> 
>  1. Treat the command as "git grep -e test -n", or in other words
>     "do what I mean" since it is clear enough, at least to humans.
> 
Sorry, I actually didn't that. Could you rephrase it a little.

>  2. Focus on "argument" instead of "filename" so that the message
>     could still apply: something like
> 
> 	fatal: option '-n' must come before non-option arguments
> 
I used "filename" as the function indeed check if the argument given to
it is a filename. How about,

    fatal: expecting filename; found '-n'

???

In the context it looks as follows,

    $ git grep "some random regex" -n
    fatal: expected filename; found '-n' 

    $ git rev-parse --flags
    README.md
    --flags
    fatal: expected filename,
    found '--flags'


> Probably because of the background I am missing described above, it's
> not clear to me that the new message is any better (or worse) than the
> existing one.  The old message with "after filename" has the virtue of
> explaining why an option is not expected there.
> 
That's surprising, I thought the phrase "in place of filename" was more
explanatory as it doesn't make assumptions about the previous arguments
and specifies what was expected.

> Thanks and hope that helps,
Yep


The modified commit message is found below. If it still seems to be
missing the *why*, let me know.

    setup: update error message to be more meaningful
    
    The error message shown when a flag is found when expecting a
    filename wasn't clear as it didn't communicate what was wrong
    using the 'suitable' words in *all* cases.
    
            $ git ls-files
            README.md
            test-file
    
    Correct case,
    
            $ git rev-parse README.md --flags
            README.md
            --flags
            fatal: bad flag '--flags' used after filename
    
    Incorrect case,
    
            $ git grep "some random regex" -n
            fatal: bad flag '-n' used after filename
    
    The above case is incorrect as "some random regex" isn't a filename
    in this case.
    
    Change the error message to be general and communicative. This results
    in the following output,
    
            $ git rev-parse README.md --flags
            README.md
            --flags
            fatal: found flag '--flags' in place of a filename
    
            $ git grep "some random regex" -n
            fatal: found flag '-n' in place of a filename

    -- 
    Kaartic

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB272036C
	for <e@80x24.org>; Wed,  4 Oct 2017 17:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750951AbdJDRqK (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 13:46:10 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:55477 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdJDRqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 13:46:09 -0400
Received: by mail-pf0-f170.google.com with SMTP id g62so1015253pfk.12
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SzdbeaA5wbPtKRwN2aZ2kVKzeusn78sjEajdLJsCWuU=;
        b=LPizYeouKKsPDp74uHnxdafo4KoDFbSZAH42kl7nRbux60e/2rpARZRvRx4+IchRv3
         g5DeyLNcSv13ppNzeb9h4B1sneoBqlj377/q4kmu4ugg6iffF9yte9K22cCsjKu1TvqS
         2EdQKitiBmyqiK1fk8sVskxghFwpbU5ILlH/uUztq4jnCTl1PrDa01p/bC5pPQucUo2h
         hEjz71uelA8ulrge4qLVqcDgcppWLA9RHPKG6bo30OI8RMlIXYz6ycVpGjIHFwlUKVZX
         iTp2TgWFHeaypKsv3V44olGogPdLBuu8OQXbFC2WDwG2ikZWBO6xfvFJHNW6w/AC/WQz
         Mw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=SzdbeaA5wbPtKRwN2aZ2kVKzeusn78sjEajdLJsCWuU=;
        b=qSwr3tb7Cs9LW4hPNzZqYQSmWv/KQOrEKETVcDL3DEIjlYIphtY2BUe71k1Bt/IR8D
         rYafqJB3nxnIHAFEoUMr66OlVdcRFAl5vjq9GeAGi5mSwcFoWWrtLxDZToINux+CuGGj
         jOSIhKnpHC/VVUWw9gda3IJ4iYc+Vfkd+5vMgi2mXf1FUey/gHvqUvwX60GrYMcorMa5
         mmsE3cbIUEJavBkyUcHh7x/UCE7h5TEKCN+iQn1h04mySN17THpGt1hbElmJeuNKBV9c
         QrNrJuMayKzF/L6kZOvDRvO2BibMV5r5wMoTLunHMRkgGIhuoJU9it1tZDRILpg7oUsh
         WIpA==
X-Gm-Message-State: AHPjjUjaObrUP/doyXLlzkcb9vSrMFpjlTMZNtzco3bGQ4/mpavJi8e6
        BTQgQTJWGD9MuWNsc1AhtUCDsNUo
X-Google-Smtp-Source: AOwi7QDBkuru3iAjaDG5IVfnbhS4cAuvWr29jFU3kHVFtLN/vjWnZQQoSjYSH6TMb/aNH8DASOZXoQ==
X-Received: by 10.84.133.98 with SMTP id 89mr20887932plf.294.1507139168692;
        Wed, 04 Oct 2017 10:46:08 -0700 (PDT)
Received: from mix-director-10 (astound-69-42-0-111.ca.astound.net. [69.42.0.111])
        by smtp.gmail.com with ESMTPSA id h70sm27852852pfc.51.2017.10.04.10.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 10:46:08 -0700 (PDT)
From:   Ernesto Alfonso <erjoalgo@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: disable interactive prompting
References: <87tvzehp13.fsf@gmail.com>
        <20171004170532.6pjcwdurcokpvcop@sigill.intra.peff.net>
Date:   Wed, 04 Oct 2017 10:46:04 -0700
In-Reply-To: <20171004170532.6pjcwdurcokpvcop@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 4 Oct 2017 13:05:32 -0400")
Message-ID: <878tgqhkmb.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for pointing out the option. 

I tried "git help push" and searched for "prompt", "interactive",
"credentials"...

I don't think I would have figured to try
 "git help git" from "git help" even after reading it carefully.

I'd suggest adding a hint in "git help".

I also don't seem have the GIT_TERMINAL_PROMPT in "git version 1.8.3.1" but I can fix this.

Thanks,

Ernesto
Jeff King <peff@peff.net> writes:

> On Wed, Oct 04, 2017 at 09:10:48AM -0700, Ernesto Alfonso wrote:
>
>> Waiting for git-push synchronously slows me down, so I have a bash
>> alias/function to do this in the background. But when my origin is https, I
>> get an undesired interactive prompt. I've tried to disable by
>> redirecting stdin:
>> 
>> git push ${REMOTE} ${BRANCH} &>/dev/null </dev/null
>> 
>> but I still get an interactive prompt.
>> 
>> Is there a way to either
>> 
>> 1. disable interactive prompting
>> 2. programmatically determine whether a git command (or at least a git
>> push) would interactively prompt
>
> I assume the prompt is for credentials, since that's generally the only
> thing git-push will prompt for.
>
> Try:
>
>   $ git help git | sed -ne '/PROMPT/,/^$/p'
>          GIT_TERMINAL_PROMPT
>            If this environment variable is set to 0, git will not prompt on
>            the terminal (e.g., when asking for HTTP authentication).
>
> Of course that just stops the prompting. If Git needs a credential and
> you don't provide it, then the push will fail.
>
> For advice on that that, try "git help credentials".
>
> -Peff

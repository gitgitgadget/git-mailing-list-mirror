Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396911FF6D
	for <e@80x24.org>; Wed, 30 Nov 2016 19:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755215AbcK3Tyf (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 14:54:35 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36803 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755288AbcK3Tyb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 14:54:31 -0500
Received: by mail-pg0-f46.google.com with SMTP id f188so85082718pgc.3
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 11:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lQI1rSKeARm+KtE7xNcFHIf3mbBZi1UzckXc/KiPLlo=;
        b=o80uXDHDBSEsJlho4E3FhbwfqIx9Hj5USqmvQJJEzk5xFRok3K/UGmknAGMwAXvqHh
         ZH9tFUIZdjl/gc2gIwl9lh/kZbDuv/9G5dE6uphXcv7QvLoa4pRT1D+wxWD+X4sJLROS
         KwZdZqYEStPDfmgy2dgzNfnK0a0+42Mf0tU6XU1bqYt4m8JxXsgX/CwW0DPebnR9r5Lz
         OX9StzIhYN/gBGHgQtGH7aFFaZmQPAm5Z9rrCmTaoNCXyGwVWCTqb03fhQbbAhDpZngQ
         xVg+TY1WH1LKL7Y3ygCNAeWdVEcwD/6qT/r5wORz5rPv5LQMUXlYL9vI2+ZZqKld4rNv
         HHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lQI1rSKeARm+KtE7xNcFHIf3mbBZi1UzckXc/KiPLlo=;
        b=Jg2oeoFa+4D/NObUcc2tkGQJ5GMzB1V1QO3sP/y54aKm3YodEoDGGvxMjlXOvQCXp9
         rEMOFWd109/nJ8izA5npra0P2VzNRuX2BgYHEYGORuoPaPNnMEVr2akZK5goIi4IftOi
         zG6yq4Ka0bnDxz98yiDdOxfV2WIusbkDP7hsjFmI+4wdeCHqz6snAywUZMYnKPrYKZJw
         /e5gnmvTpz5R6wWp9bL+3g+fRsnD5y1295C+DLWHDHreisQXJU0glinWpe02DybVLbwy
         RXg6Ro63BdhW8AkNMZIfTf+5pxc84T6p1WyltVrwNBtx+aWWSke599xp6S14yioYVJ7p
         L3cg==
X-Gm-Message-State: AKaTC03vO+1KTej2Nu1yE/MJw7hIK0Kcp0dKOFfFyWIJ6MVvPUakpvyZnhviVCV9d6kHhYME
X-Received: by 10.99.3.202 with SMTP id 193mr62422463pgd.157.1480535669536;
        Wed, 30 Nov 2016 11:54:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ddc5:5173:1b11:9434])
        by smtp.gmail.com with ESMTPSA id c71sm87004730pga.22.2016.11.30.11.54.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 11:54:28 -0800 (PST)
Date:   Wed, 30 Nov 2016 11:54:27 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161130195427.GA166433@google.com>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161129010538.GA121643@google.com>
 <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
 <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29, Jeff King wrote:
> On Tue, Nov 29, 2016 at 01:37:59AM -0500, Jeff King wrote:
> 
> >   2. Grep threads doing more complicated stuff that needs to take a
> >      lock. You might try building with -fsanitize=thread to see if it
> >      turns up anything.
> 
> I tried this and it didn't find anything useful. It complains about
> multiple threads calling want_color() at the same time, which you can
> silence with something like:
> 
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 2c727ef49..d48846f40 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -207,6 +207,12 @@ static void start_threads(struct grep_opt *opt)
>  {
>  	int i;
>  
> +	/*
> +	 * trigger want_color() for its side effect of caching the result;
> +	 * otherwise the threads will fight over setting the cache
> +	 */
> +	want_color(GIT_COLOR_AUTO);
> +
>  	pthread_mutex_init(&grep_mutex, NULL);
>  	pthread_mutex_init(&grep_read_mutex, NULL);
>  	pthread_mutex_init(&grep_attr_mutex, NULL);
> 
> But the problem persists even with that patch, so it is something else.
> It may still be a threading problem; -fsanitize=thread isn't perfect. I
> also couldn't get the stress-test to fail when compiled with it. But
> that may simply mean that the timing of the resulting binary is changed
> enough not to trigger the issue.
> 
> -Peff

With you're stress script I'm able to see the failures.  The interesting
thing is that the entry missing is always from the non-submodule file.

-- 
Brandon Williams

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD411FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 23:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932785AbcK3X22 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 18:28:28 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33209 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932760AbcK3X20 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 18:28:26 -0500
Received: by mail-pf0-f175.google.com with SMTP id d2so41708018pfd.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 15:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/4WftXSDq91jUvk5IsuDakirYsOjDm8Q1OHwLJ4tBy0=;
        b=PVHNXahEHHu5VNCSUozZzUBmXCqzwOb9oRayLKp3Q5Cf7xsDfkeO0yxU6seWShdzDV
         Mp7hcYFfhwF7opVzqpi6BibPsgOHcy77Zg1yPGzXcCjP1mhlJLNCKNcYjWYaFQJNChEW
         6AfjvLo8klMCRt+CyipjjHPMOVLPIPJuznG7oCHAECfCQ6KvSajbv4lKoeClB38AvfDq
         vQZF79soMmuvEw6IEc6xZADfI9yfqGuwKUxiOE4VUACP/ZgJ1iYDHYLTQmarw0ayQIou
         O96T5VvMD1VyGsFmQwIQ43kQ5qpd9XuaEo9/TKX2BAxS03355ijMvuzGOWiIjDY4pXEW
         XpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/4WftXSDq91jUvk5IsuDakirYsOjDm8Q1OHwLJ4tBy0=;
        b=YzAoEMUxVqOvKmeqqiO2nmwuZyLUI5irmgm1zpZgRkZt+mkzlmcy54qbr/tlYoGwXW
         vVsxMem+keWF+zEc2fzUEqLW+YsxRfHrS5T9mL7TVHKXwksK1bjqiYBhFnVmz/wRzxst
         ITpj8TMrmeNJ4J7hDMGgAvEnIgg6vUjuq5kXWcP74BRN9k2WiEliW6mDEOmpOXQ/cKYh
         HeTnJgF8fzWmWTQpfuEkrxDRpTl/d6OkkkUBpQ/wclO9DDDi4xTJ3NvHVn2WBqES4sJM
         nC/Bclb/oB82f/9lgX2aH89dZ8ARx/JUCZUukOwiiTBGX2pZyPzBe5RBijOt839FjLAD
         GxLA==
X-Gm-Message-State: AKaTC00eizror2kh0dTnxLZfdEqqbK2rFRY+5h+l1uHuqx+JOey/scbViuFZCTPY7f2nWOhe
X-Received: by 10.99.100.132 with SMTP id y126mr62755956pgb.177.1480548505558;
        Wed, 30 Nov 2016 15:28:25 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ddc5:5173:1b11:9434])
        by smtp.gmail.com with ESMTPSA id r2sm105294790pfi.67.2016.11.30.15.28.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 15:28:24 -0800 (PST)
Date:   Wed, 30 Nov 2016 15:28:23 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161130232823.GA192901@google.com>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com>
 <20161129010538.GA121643@google.com>
 <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
 <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
 <20161130195427.GA166433@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161130195427.GA166433@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/30, Brandon Williams wrote:
> On 11/29, Jeff King wrote:
> > On Tue, Nov 29, 2016 at 01:37:59AM -0500, Jeff King wrote:
> > 
> > >   2. Grep threads doing more complicated stuff that needs to take a
> > >      lock. You might try building with -fsanitize=thread to see if it
> > >      turns up anything.
> > 
> > I tried this and it didn't find anything useful. It complains about
> > multiple threads calling want_color() at the same time, which you can
> > silence with something like:
> > 
> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 2c727ef49..d48846f40 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -207,6 +207,12 @@ static void start_threads(struct grep_opt *opt)
> >  {
> >  	int i;
> >  
> > +	/*
> > +	 * trigger want_color() for its side effect of caching the result;
> > +	 * otherwise the threads will fight over setting the cache
> > +	 */
> > +	want_color(GIT_COLOR_AUTO);
> > +
> >  	pthread_mutex_init(&grep_mutex, NULL);
> >  	pthread_mutex_init(&grep_read_mutex, NULL);
> >  	pthread_mutex_init(&grep_attr_mutex, NULL);
> > 
> > But the problem persists even with that patch, so it is something else.
> > It may still be a threading problem; -fsanitize=thread isn't perfect. I
> > also couldn't get the stress-test to fail when compiled with it. But
> > that may simply mean that the timing of the resulting binary is changed
> > enough not to trigger the issue.
> > 
> > -Peff
> 
> With you're stress script I'm able to see the failures.  The interesting
> thing is that the entry missing is always from the non-submodule file.

So I couldn't find a race condition in the code.  I tracked the problem
to grep_source_load_file which attempts to run lstat on the file so that
it can read it into a buffer.  The lstat call fails with ENOENT (which
conveniently is skipped by the if statement which calls error_errno).  So
for some reason the file cannot be found and read into memory resulting
in nothing being grep'ed for that particular file (since the buffer is
NULL).

Maybe there is something wrong with the way I wrote the tests
themselves?  So I could try rewriting them.  Any other ideas?

-- 
Brandon Williams

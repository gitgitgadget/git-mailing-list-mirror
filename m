Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD0341F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbdAYWeb (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:34:31 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:38043 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752325AbdAYWea (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:34:30 -0500
Received: by mail-it0-f53.google.com with SMTP id c7so23260741itd.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6JOJs8sts0K/P45z+PTYH5yEvhNi06jvy3fT1fBKyd4=;
        b=ug/La7l/+vlzHO0vwrVW+l9DVAayWQHQG+QhfbMrl63IaXb5y9MskPHHt/N2BHlJv6
         lmgpJroEwyvpNCCNjs7mCNjRs9cVYlmBJ7wQpo8+7yfuuIWU5TVKcCrZI0ajwrNAvrLV
         eGbjH5LDH55gi5hJMdti+yDV0glQQSVj/8hEoh/KsHMz5WgbtD+oryP/Gyi57kXRKrR9
         dQ6EQ24GEQSl30mKfz5yIJGBbO0zpjG46kkDOggU983i7vCaGIPnKTXIxAcWCCpSJSxd
         caQkhOsW25o1HUaywwC3Do3RMcakYE4m6dAeIBn/nwFkUlanGMr6U2KNzQbi87kFKvAS
         l59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6JOJs8sts0K/P45z+PTYH5yEvhNi06jvy3fT1fBKyd4=;
        b=nHSEno1ZyIXuHA/Ms6xlZYPW/BVNkBlt98XXomQPP3npz7N8j4htuihBUYCqziyMQX
         9v1LBB1aoyV3ln5NocY5DZpl66xRcq0UFTEv6qUKF4zXvhv7BdiDguwDZCz0xEe+NUUg
         2krTKnjsLzUQurtN2m+x2tBWesjcD9t4iEl/8N+SlOqf2KqfASa2/w6D4Od+MJHNfuvS
         Oju1lkIGXvHafsMMh2++QHn5dS8ITfUYGAXi7MZei9H/AW7KHF5TqojCystxnceZhJp7
         chTBB+l/k9Cs1A7VEUtVHErnj5eJCmN3VA2cN0b/3fzyrtHEe9eNBmXWlDhRz4eNY2QD
         prQA==
X-Gm-Message-State: AIkVDXKa0O/u22LzUZ40wJAUfleM2xmamtq9YrqRQYX1B9SXE9R1ixpXz9jIl3H5VGNlOsNQHPrJ2HxbHbtkgRJg
X-Received: by 10.36.65.161 with SMTP id b33mr204363itd.114.1485383669681;
 Wed, 25 Jan 2017 14:34:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 25 Jan 2017 14:34:29 -0800 (PST)
In-Reply-To: <20170125222627.jlswvwmzli62fnnt@sigill.intra.peff.net>
References: <20170125215931.26339-1-sbeller@google.com> <20170125220632.whjnpvrnhve2h6f6@sigill.intra.peff.net>
 <CAGZ79kb_g5Wq=Aeo1RH-iA5M-drU5Gm1LAJZuPZU7oe=xdHaOQ@mail.gmail.com> <20170125222627.jlswvwmzli62fnnt@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 25 Jan 2017 14:34:29 -0800
Message-ID: <CAGZ79kbC=1MCYXR+p1=6=2A5Uxoyndp8YFiRmaBJFLEW21kgXQ@mail.gmail.com>
Subject: Re: [PATCH] Add more proposals to SoC 2017 ideas page. (lots of
 submodule stuff)
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 2:26 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 25, 2017 at 02:11:15PM -0800, Stefan Beller wrote:
>
>> > Thanks. I've applied and pushed, though I'll admit I didn't really read
>> > it carefully for content. A few of the ideas look like they would need
>> > to be aggregated to be big enough for a SoC project, but that can be
>> > fleshed out in future patches (i.e., I don't think we care enough about
>> > history to have people polish and re-roll what are essentially wiki
>> > edits).
>>
>> Yeah, I wasn't sure if the ideas were meant to also contain microprojects
>> so I wrote down everything that came to mind, that I do not intend to work on
>> myself over the next couple month.
>
> Microprojects go on their own page. But make sure that they really are
> "micro" sized for an applicant.

Yeah micro as in real micro.
e.g. fix the SubmittingPatches doc, after confusion about "signing",
start reading here
https://public-inbox.org/git/923cd4e4-5c9c-4eaf-0fea-6deff6875b88@tngtech.com/

(I did not push it, as I'd need to copy over the micro projects page from 2016,
and then find out where to put links to have the web page not look broken)

Thanks,
Stefan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C8231F462
	for <e@80x24.org>; Wed, 19 Jun 2019 09:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbfFSJMm (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 05:12:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40458 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbfFSJMm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 05:12:42 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so36477827ioc.7
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 02:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8WoPeu67DCiUNwzSRofjX1TavKYdTqFGzg5rz2fPyVM=;
        b=njv3K3MXmqxsJkNu/BBdMM3vVBgxrQIZLf3pSCfsd+DkzyQtGVQUk0CqYCFtqyAdSK
         j56wGvDTJuWSnt4uoAybNUmdqRbArHlWQepiZnlGU8DuzxF8D9Llobps/z+vwIn3gIpy
         etHkkhjnkInHwOSxzuvoaKWrkcc/svGpMK9NIsDbGt9UUupEYmXm8H0BT6BANCNkddPN
         qzwSwyiLxsUNc6No57oNm9t41sgNEQspOAfwqYxJHtWrAAx29uNsoy0rbCFyGTBmtkX+
         nOAy9dSX3mu0Ruppbq0WVOa3cdPhynDEfjAkFFLzkZI1U9LpPeGl1x0U4Sz98HyBuKw1
         pYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8WoPeu67DCiUNwzSRofjX1TavKYdTqFGzg5rz2fPyVM=;
        b=JauGmV9wGCur+pb/b2hh1TZEkk4uQDM59megalwFLpJoprCUBss+p0+6pqqAqzYvkn
         owpGNa/1hcCJgQQRCqZJz0qRogrEoEBNBEWnlw4o0bA3l6uMtQs0iBHvAE7l30eEJ/JQ
         dycovY//f1xwmjO5UlKpqsy8BFz30J4QOeCexthzDa8sjate8uLqcFk0sKSKWbVvhntS
         x21p0fKW4lSvsl/zrG844HeFgBwf+qAf2yFi23g0CmL3kMxDSVxhDUcJuMW850rRzlat
         Tlq3G9weX+f9XyUBcDtb1rLGOmSlZXTqRzLk8s5FvbqoJ44RB6rTenRBcWkC49gm2s30
         WkNg==
X-Gm-Message-State: APjAAAVl/r0xWC84uYFpOGmj36vOC5GuEuxLJvcfYxJUo0WbJXNF8dJn
        GzOuCj2v5nTwpFhEMLeCLNcZzRaLQA9slwk2fT7eAg==
X-Google-Smtp-Source: APXvYqyMJL8hg7UaT2wk1kB4PBRE/4GXpgYpLZxHY9jRLJUmjIUvS8nasad+ZsWw0qHsbVqi+DqakvnYKcEpV6kgYKw=
X-Received: by 2002:a5d:968b:: with SMTP id m11mr1543000ion.16.1560935561212;
 Wed, 19 Jun 2019 02:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190618064537.62369-1-carenas@gmail.com> <20190618155326.GA4014@sigill.intra.peff.net>
In-Reply-To: <20190618155326.GA4014@sigill.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 19 Jun 2019 02:12:30 -0700
Message-ID: <CAPUEspgRnGd4nT3yd2YTGMt8t4qQ=V3GGNeTih3cmjnZHNextw@mail.gmail.com>
Subject: Re: [PATCH 0/2] a few more redundant system include cleanups
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 8:53 AM Jeff King <peff@peff.net> wrote:
>
> Thanks, this looks good to me. I fixed the system headers in xinclude.h,
> but didn't think to check for individual C files including them.

also noticed that after the refactoring some files will include a couple
of headers twice (not an issue, though thanks to the header guards)
but didn't send that patch to reduce the churn and avoid confusion.

> I did a quick grep for similar cases, and didn't find any that I think
> would be problematic. There were a few cleanups, below.

would you mind if I add your 2 patches to a series and include that
missing one?, that way I'll also have a chance to write a better commit
message from my original change, including the other feedback I got
as well

Carlo

PS. is there a recommendation on how to version a patch that move
into a series that would be preferred?

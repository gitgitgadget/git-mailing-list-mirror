Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7CBC4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 19:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BF0321D42
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 19:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgIYTCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 15:02:02 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37185 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIYTCC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 15:02:02 -0400
Received: by mail-ed1-f67.google.com with SMTP id n22so3575625edt.4
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 12:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bYFqfMPKk+VnRsSHTkEDBgBE/Tnv9TVk6seS3toQD4=;
        b=DMCW6v61KWu8DhrACOFRGXAi3RJhqzQn+Cu7e2yjJVfhdDZQVMIQpOm92gHGzXgnx7
         bLX/XrwIfn63vWuNIkCJnSm3kF7kJB8V19pYqLdafYi5YlT0zxxZZoLr6XLpBf4JUgZb
         I47K7ZDaZYcYKb/y47ShSIfHj1BIXfBWwL3x11mR+mwlyFAK6jqqiH/1JzdJHRHq85Vh
         h+RVgfXJCm1Q9+0AKLYRiDP6+QKIPv2OJUwNgybBMskKL+I9YodZe90TPBMUyc7VDt/L
         kyc4FLfqXUjgj832G+jQwUlOZlwvk8SqN9XPuQ5zvkE1KWPq9p5ES14slAko3TJ50jVS
         EZhw==
X-Gm-Message-State: AOAM531TgOwcRt6VmoeV7g8h2Sf2wcu7kVlGoqo++pb0dZBVRAy0gvbV
        jsxGGhAlhkGg85M67ktlOrw+XQACmvTRKMw5718CO2bb0+c=
X-Google-Smtp-Source: ABdhPJx6v0VHrr1Zk8hoSTxZpijV22FUTDxuXRd91Nge8ZpMN8BXkuQoOc3/QfwX3LkNghg2X40qXFw1+d6w5J03EeM=
X-Received: by 2002:aa7:ca4f:: with SMTP id j15mr2862584edt.233.1601060520654;
 Fri, 25 Sep 2020 12:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200925170256.11490-1-shubhunic@gmail.com> <20200925170256.11490-9-shubhunic@gmail.com>
In-Reply-To: <20200925170256.11490-9-shubhunic@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 25 Sep 2020 15:01:49 -0400
Message-ID: <CAPig+cTeBoGCUgo9rrqEszCJve2vZd9Jn=hUGrwxq-vaOzBE+Q@mail.gmail.com>
Subject: Re: [PATCH 08/11] t7001: put each command on a separate line
To:     shubham verma <shubhunic@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 1:03 PM shubham verma <shubhunic@gmail.com> wrote:
> Multiple commands on one line  should be split across multiple lines.

Drop the extra whitespace between "line" and "should".

I might have written the commit message with a bit more explanation,
perhaps like this:

    Modern practice is to avoid multiple commands per line, and
    instead place each command on its own line.

The patch itself looks fine.

> Signed-off-by: shubham verma <shubhunic@gmail.com>

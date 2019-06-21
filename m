Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C7CF1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 16:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfFUQiM (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 12:38:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36012 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUQiM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 12:38:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so6016414wrs.3
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 09:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zrQ0s+7Zwb1wB3G7cWJnWghUOd5EVf74efH9rqagsVA=;
        b=YZDLhL2LzFkooiRgda+/wprBMKDbUAe0ALKx3RZ2sFZ2Gv6xU2fyU/DcSL7AuzUcRP
         VIaTStBPvxSHQCY0pAWynlaUF5Aj1ZAY5hy9YctCz/sMfq4wDb1UcYZoXmpJeNA4kTJG
         4DEFdziI12bcKCkMZhQYG0tAk/YqjYK5Pl0vThAkkD2YUAn7gjfy8fIAGrFHZqiyDt23
         0hMjbsQOOa9vzXd2ANxNBawRplpCiFTLfV3cTHzZvsYxagRvSOKLmByp4y5gLEuHU0VM
         j4JkM5bbm+HxwCHDLjKdPf7bsYiCoXkVwbCP7y1DP5AACVn61sd1qMGH+8wIPVQI7fry
         6JHw==
X-Gm-Message-State: APjAAAWOIAwIY4SqkqDjAsZmk4DyUUeD34E0elntQcWSdxPlDXKI8gB1
        IFN9SeRu8Avu/mov/vvT+c/nuZCgBwpZeA1Xx3A=
X-Google-Smtp-Source: APXvYqxnj1Yz1usKew4j+nrjv++kx6voJmEtpuq9zkSMHZ4ootaV6YxzBPInnP2xV78JMDlAzVRQWaGQGYUilQ4MVDw=
X-Received: by 2002:adf:f101:: with SMTP id r1mr6164926wro.170.1561135090776;
 Fri, 21 Jun 2019 09:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190619221315.7343-1-chriscool@tuxfamily.org>
 <20190620212922.GB87385@google.com> <CAP8UFD1KRq9gUJQbDP9d3xewS9F_9wHnt463Qt7UXoi7VdmOJg@mail.gmail.com>
In-Reply-To: <CAP8UFD1KRq9gUJQbDP9d3xewS9F_9wHnt463Qt7UXoi7VdmOJg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 21 Jun 2019 12:37:59 -0400
Message-ID: <CAPig+cQh0MC9JQPMkxhDKFzzCwRTC-_rVBR7RnzcP3SM_kn_vA@mail.gmail.com>
Subject: Re: [PATCH] doc: improve usage string in MyFirstContribution
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 6:43 AM Christian Couder
<christian.couder@gmail.com> wrote:
> On Thu, Jun 20, 2019 at 11:29 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > It doesn't require 1 or more args - you can run it with no args. So it
> > might be better suited to state the args as optional:
> >
> >   'git psuh [arg]...'
>
> Yeah sure, I will will resend soon with such changes.

More correct would be "git psuh [<arg>]".

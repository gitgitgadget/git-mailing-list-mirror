Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1221720899
	for <e@80x24.org>; Tue, 15 Aug 2017 01:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752825AbdHOBD6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 21:03:58 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:38882 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752740AbdHOBD6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 21:03:58 -0400
Received: by mail-pg0-f51.google.com with SMTP id l64so57381652pge.5
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 18:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jaYkL7J0J3FsQ9r0AfTQ36k7gzYe4DrRzOKnqARk0RQ=;
        b=mRpZvezVBLwnczHzDWe00URx2IQLP65Jr/dj1etdYkTnwPuO6KHLWhPstuBnYTvER1
         S+EzJa9Iq6FY606oNGgSDF7fopab1o3Mh2qEYeofQwcAQWkmhpH5p3Ogdp0MEo1ll7Oc
         A2HOa0ggf2AHWAstI8ivmG1ixL6R4BJ+hYpdKkAIDPvS5DTV585pYirmpKe3I87wJoxA
         hz/OUL8MLS4wKtBFx7HCaZeg3+mn+1cMsgOEeawACFD0jybu2JQ4BP0dBUMnWeuDIpCL
         7PX47bkpBIkgvvWacVdhMC3GmFWRtSaRXUtPsLexvYujdfZgQvG+u/+o8OdVFE/bKbfQ
         cwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jaYkL7J0J3FsQ9r0AfTQ36k7gzYe4DrRzOKnqARk0RQ=;
        b=KYsr8VOa5WItTFF3DwyIJYkPrdcSxcg5JE8KICcc718xHxpVyYBXz+7f1zmEU7Ki89
         KELqjoR7o/Rkv7z1mtfj/iDWRXxTA4Q6UeRNzojHl0N1M73yrREZRBmrYZ/gxLUAzQzP
         ng2TM4CO0aP91mWMveKrUc9oMqHiACwhY0cB4dz5KIglORHuY7Y0tmUWQKD2JtlTcTyx
         R/aV0+c2Y5kjzglMoNsaj0SyXAFlz85t0DjtYbCj3VuvW96nxxWfzYuqffgqM8tacl5O
         fyuufIsyqNC+H2Iyc/Md//kjVFkm1o3KoANutvwsPQYOHjJyW92N/CGF+U3A3DXbxUYD
         2nUA==
X-Gm-Message-State: AHYfb5hPaAxPNKpPQ0Rhkwq38mZDfbQSImpoi/+5DK6RWGooAJS0b+rw
        ESbW4mf6IyVY8g==
X-Received: by 10.99.127.21 with SMTP id a21mr25244005pgd.379.1502759037464;
        Mon, 14 Aug 2017 18:03:57 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:5181:69ef:a50:cd47])
        by smtp.gmail.com with ESMTPSA id 133sm14937579pge.29.2017.08.14.18.03.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 18:03:56 -0700 (PDT)
Date:   Mon, 14 Aug 2017 18:03:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
Message-ID: <20170815010354.GB78174@aiede.mtv.corp.google.com>
References: <CAGZ79kZRhTNez1jJq+DcCyERufd_YfWK7L+ujPjRCivzHz7LBw@mail.gmail.com>
 <CAGZ79kYEyebHxFO++u5RkPBj16xx5nMcahBPxra4xWUfMrXydA@mail.gmail.com>
 <20170809231900.3535ja3zqdvyerv4@sigill.intra.peff.net>
 <20170815004036.m5ejio6gdyvu6e6a@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170815004036.m5ejio6gdyvu6e6a@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

brian m. carlson wrote:
>> On Wed, Aug 09, 2017 at 03:53:17PM -0700, Stefan Beller wrote:

>>> We may have different opinions on what is readable/beautiful code.
>>> If we were to follow a mutual agreed style that is produced by a tool,
>>> we could use clean/smudge filters with different settings each.

I think this is a long way away --- long enough away that by the time
such a change could be a serious possibility, a lot may have changed
and the project is likely to know a lot more.  In other words, I don't
see speculating about that future as being likely to produce useful
results today.

It would be a different story if we were writing a new codebase from
scratch.  In that case, I would be all for the gofmt approach. :)

> On Wed, Aug 09, 2017 at 07:19:00PM -0400, Jeff King wrote:

>> I'm less worried about a difference of opinion between humans. My
>> concern is that there are cases that the tool's formatting makes _worse_
>> than what any human would write. And either we accept ugly code because
>> the tool sucks, or we spend a bunch of time fighting with the tool to
>> try to make its output look good.
>
> This has been my issue with clang-format in the past.  I have an SHA-256
> implementation with an array of 64 32-bit hex integers.  These fit six
> to a line, but for neatness and consistency reasons, I'd like them four
> to a line (4 divides 64, but 6 does not).  Last I checked, clang-format
> didn't allow me that option: it reordered them because it could fit six
> on a line.  This is not the only issue I discovered, just the most
> memorable.

In case it comes up again for you in a project that has adopted the
gofmt approach: you can signify that your line breaks are intentional
by putting line comments at the end of each line and clang-format will
respect them.

The clang-format documentation also mentions[1] that you can do

  /* clang-format off */
  const double kIdentityMatrix[] = {
    1, 0, 0,
    0, 1, 0,
    0, 0, 1,
  };
  /* clang-format on */

Thanks,
Jonathan

[1] http://clang.llvm.org/docs/ClangFormatStyleOptions.html#disabling-formatting-on-a-piece-of-code

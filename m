Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD20A20899
	for <e@80x24.org>; Tue,  8 Aug 2017 18:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbdHHSX2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 14:23:28 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35159 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbdHHSX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 14:23:27 -0400
Received: by mail-pf0-f182.google.com with SMTP id t86so17685890pfe.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2017 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PqyERgMnJhLhzMvKvfi85n7naqWhlSKisKo9Zd+8lYo=;
        b=OvlkAqwek3anw7r6KEKKc/VQxZ37t/owOSnXQFlC71OspwDevBgd9CGET2i7Z6b24I
         +LPxBEsdQCibl0MUa5w+fEUrfDLK9ysD1YAYeq0W/TsJq2VIG5Fio59rqhylJOMYnRnF
         xkoo1Yv6y/cBK6NZGRrJtlpiB1Rs0resoS3esVhBHSFOMoCRjJJPBdw3QcIjAkGqAPvj
         I8JiZWa8YZgzUXPlLh2siKzzXSG7fvz/Ef6Mg3nZtF/0GayY5p9oH4Y6iC69y72S90pd
         vQNfoAZgAgnqCAIMlF/gF1a06MkuUfPJFw225OIXL5o0IuDZHUidsnFknclp9aua71e8
         W1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PqyERgMnJhLhzMvKvfi85n7naqWhlSKisKo9Zd+8lYo=;
        b=KPZqILXrE2mFLTVYoJYBecDwSC5e95XhqOATFC8MW3YiKHmQPMie3ggZ0cRzkYdIFE
         gZ8fRGv1WmjmYbjXZ0Ubei7SNkjxnA/U3XAZlniTVehV2x5gfAItKvjKYSYGda5AS/So
         3wGMTWh03TQSNEMsaGyLb9wNIDAy0s9BEYISQSGviuMFmDC7EyP8wwZGoZw/pYKwwfTC
         xXDRfNoGsxSX+4yp6lLaxXHuHaM5N53tXD+oqpcAgf+RMluwTrC6TPiSvKRH0QrMsLy5
         BBv1Va3T2WYz8aqXSHdv/uDQRVd0+VNlba92Sj2rFx/5y7HxrYz024TNDi57mgsjAtrd
         UxSQ==
X-Gm-Message-State: AHYfb5iqieidAGZqhjasCNuobwKtilJyS/fXVIVtHoKTw5YNpCD01X7G
        0zA2zQO3p1gaB8+HMQtaAw==
X-Received: by 10.98.60.5 with SMTP id j5mr5507058pfa.0.1502216606507;
        Tue, 08 Aug 2017 11:23:26 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3453:175f:fdaa:f8c5])
        by smtp.gmail.com with ESMTPSA id e64sm3734080pfb.129.2017.08.08.11.23.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Aug 2017 11:23:25 -0700 (PDT)
Date:   Tue, 8 Aug 2017 11:23:24 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
Message-ID: <20170808182324.GB73298@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <alpine.DEB.2.21.1.1708081404200.4271@virtualbox>
 <CAGZ79kb2860nUs46bP=x-gAx9Ao6DxnvXQv3x387Wxw+kEyxJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kb2860nUs46bP=x-gAx9Ao6DxnvXQv3x387Wxw+kEyxJw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Stefan Beller wrote:
> On Tue, Aug 8, 2017 at 5:05 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Brandon,
> >
> > On Mon, 7 Aug 2017, Brandon Williams wrote:
> >
> >> Add a '.clang-format' file which outlines the git project's coding
> >> style.  This can be used with clang-format to auto-format .c and .h
> >> files to conform with git's style.
> >>
> >> Signed-off-by: Brandon Williams <bmwill@google.com>
> >> ---
> >>
> >> I'm sure this sort of thing comes up every so often on the list but back at
> >> git-merge I mentioned how it would be nice to not have to worry about style
> >> when reviewing patches as that is something mechanical and best left to a
> >> machine (for the most part).
> >
> > Amen.
> >
> > If I never have to see a review mentioning an unwrapped line, I am quite
> > certain I will be quite content.
> >
> > Ciao,
> > Dscho
> 
> As a thought experiment I'd like to propose to take it one step further:
> 
>   If the code was formatted perfectly in one style such that a formatter for
>   this style would not produce changes when rerun again on the code, then
>   each individual could have a clean/smudge filter to work in their preferred
>   style, and only the exchange and storage of code is in a mutual agreed
>   style. If the mutually agreed style is close to what I prefer, I don't have to
>   use clean/smudge filters.
> 
> Additionally to this patch, we'd want to either put a note into
> SubmittingPatches or Documentation/gitworkflows.txt to hint at
> how to use this formatting to just affect the patch that is currently
> worked on or rather a pre-commit hook?

I'm sure both of these things will probably happen if we decide to make
use of a code-formatter.  This RFC is really just trying to ask the
question: "Is this something we want to entertain doing?"
My response would be 'Yes' but there's many other opinions to consider
first :)

-- 
Brandon Williams

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A169620899
	for <e@80x24.org>; Fri, 11 Aug 2017 17:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753508AbdHKRwm (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 13:52:42 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:38594 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbdHKRwk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 13:52:40 -0400
Received: by mail-pg0-f52.google.com with SMTP id l64so18084628pge.5
        for <git@vger.kernel.org>; Fri, 11 Aug 2017 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fJmXZJ+qobpeSI9FCZvTru7IdNuMU0WuB2yLL4QNe7s=;
        b=aGB5gLEsnLNTWIcU4YbUfFWl/F6pZ/RGp+JK0hdb+O9WPXt0QUUL29571kngMnQi+8
         GelKjQRzpha3G4HGoE/beZiZl7XWa/hRPRdp8lxtJ0wvkZdFQxuTI40lhFluIUfH+L78
         81bCu1msFKj0TfoQ/8XsHfOz3kFbLn570Py3iALjm6dYDCRhTcDP+llU4Sxj5S751Wze
         fIbsmO9juVBC1Awo3MWK5w7o4UXTxQVPxVBog0Fdbm2uq10c7rDs6iqV8IdRxFNQaK9i
         3NUs2BKWrXrNon07y45DZ4gpalWxnFNb8ULDA6YrZkKiBoYeimJolRQNt70P+mQ13yJ7
         hiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fJmXZJ+qobpeSI9FCZvTru7IdNuMU0WuB2yLL4QNe7s=;
        b=HzMuk7BUnEDnyh4UYDtSPNh45LfqBjhK2UFGHIruzZ+zN5zn7Yw9finEEm5x/7Hopt
         X87vlBW0PtNLyrUEACKBMerUxZ3/kpgxEN+LifHwYR/zsEgdL2x4/MQoIwkAC9fKZ6eQ
         /gAqUTX3G84vR7GTUq5jQA8DXHgLrR6pITqfHhKS+QKHPhwwTlsTvqh+Gnqi32+U/eOM
         Q7hdm3v9RdsQX6sg+Vd+dxUWcEmCAXeG89n2hF1lMyMSuiURTRMphAm3+Yt1u9TuWXeE
         hTHME2CfG6vKDYjjfa6+WMK9KgJYtwGDXqLo88cgbU966MdN7Al8ymT2FjMNH6MSzMM3
         WmcQ==
X-Gm-Message-State: AHYfb5hOUaK3g4tC7fnzS5vYUvKg0Mt4qQ5oEQfnl2gleRH4je54v//5
        utWQ7wJZS41cMRfx
X-Received: by 10.99.127.90 with SMTP id p26mr15954004pgn.377.1502473959463;
        Fri, 11 Aug 2017 10:52:39 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:bd89:8abb:3c45:bf8a])
        by smtp.gmail.com with ESMTPSA id 133sm3044164pge.29.2017.08.11.10.52.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 11 Aug 2017 10:52:38 -0700 (PDT)
Date:   Fri, 11 Aug 2017 10:52:37 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] clang-format: outline the git project's coding style
Message-ID: <20170811175237.GC59325@google.com>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170809130127.ekd4tvyp2rrb7ftk@sigill.intra.peff.net>
 <87y3qsg7ni.fsf@gmail.com>
 <CAGZ79kYEyebHxFO++u5RkPBj16xx5nMcahBPxra4xWUfMrXydA@mail.gmail.com>
 <CAGZ79kZRhTNez1jJq+DcCyERufd_YfWK7L+ujPjRCivzHz7LBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZRhTNez1jJq+DcCyERufd_YfWK7L+ujPjRCivzHz7LBw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/09, Stefan Beller wrote:
> On Wed, Aug 9, 2017 at 3:53 PM, Stefan Beller <sbeller@google.com> wrote:
> 
> > I would think based on these options, a pre commit hook can be
> > written that formats precisely the touched lines of code of each file.
> 
> I did not search enough, "clang-tidy-diff.py --fix" should be all that is needed

I believe clang-tidy is different from clang-format am I mistaken?

-- 
Brandon Williams

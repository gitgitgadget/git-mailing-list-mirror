Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B5FD1FEEF
	for <e@80x24.org>; Tue, 22 Nov 2016 00:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754134AbcKVARC (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 19:17:02 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33342 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbcKVARB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 19:17:01 -0500
Received: by mail-pf0-f172.google.com with SMTP id d2so407236pfd.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 16:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z1x4ebz1UC9Jh04OFPauXRTYiv97FAbnVoZMQX05rsU=;
        b=KUFF4ZfcGOlMcrY2Av5jEm5Y34sjN0keAj+n766O2ZMzU0mQK/rMK0+5PDP3rGx2To
         G5llnXVONlRR3Xe/h1trDoJ/YkZy2RrsbSIOBfl8ruLXnnlp7InxI7LCP4mzAZ7kIMtl
         8LF0xm6jbEkiGwDA+BUNion7FDkWsHcSLy+WeFxKx9QpWUJFKW5Q9xoEQzSaf5XAXNZw
         arAjUIPzuZ/MHlyRG/a2mRpoALH6k9/xPafHid5jtJCz/v1dWs28U9ZRNlNONs9wJUMb
         0S/S/c955p2wGj6OXRZEIbq0/QQKS4MOZVv5LRXhi0jg8JqrzLv3OJ9Vn1dW0mfzz8TT
         Z2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z1x4ebz1UC9Jh04OFPauXRTYiv97FAbnVoZMQX05rsU=;
        b=UwWx/kYi2bmgi6YumRxkBC4SHml3oIhzwwH7tQ+6UDbSfeaAvOee8busGIjxzw4e7X
         UEVXhHiVWyzPWGp8h6Fp/yLtxcCTN8atlW2ZgfNbbnKVm7O1ncj7vhCYxPdwdxELVn7y
         NVyun4081NXb1xXkz+pLpvGRvhozm29RJVqkHHyyNAEllMdzC+JIKh94iM8v8Uq7zxh3
         Qcw5WWoI7lHzKuOXqP4s5zA5l8tQSDSlu3HvmM87IgdMPqBwf2Tb4waSQsXk++nGCYIP
         LsjeQOKYRHqdcG5ZdhkCc+pUj1nneR9QRHNEjkDDxNH9hZrYJTBuKC3NQCCfjBhDvqzD
         eTpw==
X-Gm-Message-State: AKaTC03yMjZNRvzCyqBos1HzWh1cUCFhDirIzoe7v7PADSDatAlHAiSjUEh/cmREEOakhct3
X-Received: by 10.98.32.151 with SMTP id m23mr22365808pfj.127.1479773820458;
        Mon, 21 Nov 2016 16:17:00 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:9837:5b20:fc2:14ed])
        by smtp.gmail.com with ESMTPSA id s8sm40021682pfj.45.2016.11.21.16.16.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 16:16:59 -0800 (PST)
Date:   Mon, 21 Nov 2016 16:16:58 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCHv2 2/3] submodule-config: rename commit_sha1 to
 commit_or_tree
Message-ID: <20161122001658.GE149321@google.com>
References: <20161121232709.8906-1-sbeller@google.com>
 <20161121232709.8906-3-sbeller@google.com>
 <20161122001148.GD149321@google.com>
 <CAGZ79kY+0WHFgXfVmEmw7H-qwuUcWcSssRyMzg2XqsGSDq+FCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY+0WHFgXfVmEmw7H-qwuUcWcSssRyMzg2XqsGSDq+FCw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/21, Stefan Beller wrote:
> On Mon, Nov 21, 2016 at 4:11 PM, Brandon Williams <bmwill@google.com> wrote:
> > On 11/21, Stefan Beller wrote:
> >>
> >>       switch (lookup_type) {
> >> @@ -448,7 +448,8 @@ static const struct submodule *config_from(struct submodule_cache *cache,
> >>
> >>       /* fill the submodule config into the cache */
> >>       parameter.cache = cache;
> >> -     parameter.commit_sha1 = commit_sha1;
> >> +     // todo: get the actual tree here:
> >
> > s/todo/TODO
> >
> > Makes it more clear that this is a TODO
> >
> 
> The // is more annoying here. I'll review these changes closely
> before sending out v3.

Well I prefer // to /* */ but that's not the style we use :)

-- 
Brandon Williams

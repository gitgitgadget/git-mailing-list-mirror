Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B7781F42E
	for <e@80x24.org>; Wed,  9 May 2018 16:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965588AbeEIQsL (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 12:48:11 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41603 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935343AbeEIQsK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 12:48:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id v63so25906351pfk.8
        for <git@vger.kernel.org>; Wed, 09 May 2018 09:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2MFLqrxflkSVzggtWELT3fHbR1PJP9kpLMMPrZav8a8=;
        b=oIM8DaNY9PNnhoNL9NS9YJGMIjTAx9HkSfnDSYWvc5rzK9chmiP3XyQHEOZr+Lx0+f
         zTxIS17YYyB94a9wdlvKZpvF2xS/D/aXLZ8TqTImhaIUkdc/mdLhRmlefzUI5eK7t4z4
         cAsLoqsreclNlt+9kDFWWvVDNFO3R/WxQbm1aWMmKlMAnkAyU2cPDp3DpH4ccoY8bLRh
         GcvxE5M8T5B0AyCtag0Ms0tdyGsjoK4RG4wShteEhLjZ5eLBP4gdPQFRmQ5j/WhB49Kb
         ZE05yDQuW+NuuA5p6EYTySyg5WN9Zmq9JzSJrSHxv9C7u6RY4g9kRc84jCqE2WRod/Kq
         nDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2MFLqrxflkSVzggtWELT3fHbR1PJP9kpLMMPrZav8a8=;
        b=DG76Ljd6j1mkAlwUBCIOhr39ewu/Fu+mMEmMBY4VvtbI+/5h2UGJDhQXMvIKWZ+Xxk
         ePLWcMgTByu94nUOepkQH/cElbGPE+6Rj1h7M8ebNmbVkTguoMtQEeLYXWaPvs8kvsqm
         7B2n46XLaqRa6/jhDGjaETv6HHM0lPeE4LhyDABmV744dO9KhY9sNkB6CtYRdyLV7KkC
         eDwUc6D4DX/LBPMBEux4tMkpbhuCyJFbRi5eyZqStLmTsXDFgLYxbk8QWzOG8mN3lWpW
         Vm5P8CoKgdS6nUlSceaLir7U/bMLC5nvv0Krnxa7PTltMyeze5c7CDqCp9RTNwaYxHbm
         aXxA==
X-Gm-Message-State: ALQs6tD+WXBKNNvhwDYDRIDgq4cXVkXPfeEBXFIy9LnPBJVKZiz4upxn
        c8W38hcG4f+Q5SdREKqlVyOoCdqQ
X-Google-Smtp-Source: AB8JxZqB0xkFgoTPQd7ISyTcaAFwwKSDnm5LzdGUcb/WHtntn0fJASD51V+E6YtSqg/UvynIuGNgZw==
X-Received: by 10.98.11.210 with SMTP id 79mr44456254pfl.4.1525884489515;
        Wed, 09 May 2018 09:48:09 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 5sm48531215pfx.140.2018.05.09.09.48.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 May 2018 09:48:08 -0700 (PDT)
Date:   Wed, 9 May 2018 09:48:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Implementing reftable in Git
Message-ID: <20180509164807.GI10348@aiede.svl.corp.google.com>
References: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Christian Couder wrote:

> I might start working on implementing reftable in Git soon.

Yay!

[...]
> So I think the most straightforward and compatible way to do it would
> be to port the JGit implementation.

I suspect following the spec[1] would be even more compatible, since it
would force us to tighten the spec where it is unclear.

>                                        It looks like the
> JGit repo and the reftable code there are licensed under the Eclipse
> Distribution License - v 1.0 [7] which is very similar to the 3-Clause
> BSD License also called Modified BSD License

If you would like the patches at https://git.eclipse.org/r/q/topic:reftable
relicensed for Git's use so that you don't need to include that
license header, let me know.  Separate from any legal concerns, if
you're doing a straight port, a one-line comment crediting the JGit
project would still be appreciated, of course.

That said, I would not be surprised if going straight from the spec is
easier than porting the code.

Thanks,
Jonathan

[1] https://eclipse.googlesource.com/jgit/jgit/+/master/Documentation/technical/reftable.md

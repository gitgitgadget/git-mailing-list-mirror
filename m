Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8C421F45F
	for <e@80x24.org>; Wed,  8 May 2019 17:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbfEHRuU (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 13:50:20 -0400
Received: from mail-it1-f173.google.com ([209.85.166.173]:34665 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfEHRsU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 13:48:20 -0400
Received: by mail-it1-f173.google.com with SMTP id p18so2880547itm.1
        for <git@vger.kernel.org>; Wed, 08 May 2019 10:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZlH2WAHH8N1MotR4rGmLORbiwUCNkbNUPNl4ylWwwc4=;
        b=s8/jwOnSeKxkdGBgTVGdNDBZaBl0hnln9h7wMUum/9dwKwiW1GQSJ+wM7emT00EatF
         zy8FT07ASORzKf6bHo/+JuKHD2sQ0rWZHkb1FVlFfvPTAhwtZJWy6ag0PP6xoneXEygj
         YQacgARLuBwJiT59lfDFLf63YVJTgBv8kQ+1Co4E3HMcox0IbUp/SSLLL2q8GjQjMZlJ
         7gn99kRdvkXWILrUJilQdAeB7NYkVPqJvNI0xALNhwCt98Ar76oGNpS5PWLry83/8UIs
         yT4RxfO1/c6lGISPexZJYa9T+Kgg1qjK2eMe7stxEZqg0SzP5umHLh8PpgkPtONRMyWU
         f+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZlH2WAHH8N1MotR4rGmLORbiwUCNkbNUPNl4ylWwwc4=;
        b=mR6NlNQi/9ssz+z9AacA4WZg9iO9DkHkno6pH7rB+CvzCXtmWzJPVGOyZVtyS1l/JI
         aupEd5uXwJX1XJ8TEWIdpgAP7MLw2i/9jpGA4oEuBuSGjM9MuJcvmcyR1kl7idxF6h8q
         xaOXqrGjaCqGX8rtyJIYWmfM3KxcSKL7tO3K8WuF7LXJY1h3amTCyarlPxBoErz5l8zw
         4p8IQMkv1uNzRk3xKJjfBVTWtSyR35O/o7tGELI6VSDAAiEvYFuM0iWS4YuASacKXHig
         djAgtnUq8IVcj0TSfdEjp1aorSJZib3wjKbT69Sz6KWyj7EoRBEXVZj07ojzcS9ZReDj
         BCQA==
X-Gm-Message-State: APjAAAU6lea1h4ZnVfryvDfSvtJ42y8+mhOnktqx5t3sFHTMlbT0dvz5
        faX3v1gDVwqmJSPnxmprU9o=
X-Google-Smtp-Source: APXvYqxWgIs28q5e4PNPVhpmwxDneeNi9/VyLI4tIJOZ6Owcj/uJQYfN8nq2m1L6HXBzDmw+c110zA==
X-Received: by 2002:a05:660c:443:: with SMTP id d3mr4677262itl.147.1557337699943;
        Wed, 08 May 2019 10:48:19 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id u205sm1316378itc.44.2019.05.08.10.48.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 10:48:19 -0700 (PDT)
Date:   Wed, 8 May 2019 13:48:17 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2019, #01; Thu, 9)
Message-ID: <20190508174817.GB23712@archbookpro.localdomain>
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, May 09, 2019 at 02:23:24AM +0900, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> The 8th batch of topics, which Hopefully is the final one before
> -rc0, have been pushed out to 'master'.  The "no-extern" topic is
> now in 'next', with its merge conflict with many other topics, is
> still slowing me down when it is moved earlier in the merge order.
> I expect it to need only one more topic shuffling before merged to
> 'master', so I hope I'd survive.

Thanks for taking on the hard work for this!

> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>     http://git-blame.blogspot.com/p/git-public-repositories.html
> 

[snip]

> * dl/difftool-mergetool (2019-04-25) 6 commits
>  - difftool: fallback on merge.guitool
>  - difftool: make --gui, --tool and --extcmd mutually exclusive
>  - mergetool: fallback to tool when guitool unavailable
>  - mergetool: use get_merge_tool function
>  - t7610: add mergetool --gui tests
>  - t7610: unsuppress output
> 
>  Update "git difftool" and "git mergetool" so that the combinations
>  of {diff,merge}.{tool,guitool} configuration variables serve as
>  fallback settings of each other in a sensible order.
> 
>  Will merge to 'next'.

A reroll of this was sent at
<cover.1556518203.git.liu.denton@gmail.com> based on some comments that
David Aguilar made.

Thanks,

Denton

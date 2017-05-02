Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D390C1F790
	for <e@80x24.org>; Tue,  2 May 2017 19:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750888AbdEBTmj (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 15:42:39 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36255 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbdEBTmi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 15:42:38 -0400
Received: by mail-pf0-f174.google.com with SMTP id q66so1858038pfi.3
        for <git@vger.kernel.org>; Tue, 02 May 2017 12:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V0MMt2SZFAplyLEvdroFPN6e+rf0CtEFtMouUhBE658=;
        b=Z/W2R221A4Hn5EfazX11FbuNScIi4xvVf4vFMth22L+hwhdVlXO5DD39rAzsgrPTbg
         m3732MYUC3ca2nsu8WhrI4QCFlGSndfl5Xpp27DD3EPYr4KM+NaivPFspugEBmPNSo0H
         PzpPVgJjF7evuOCRUtGEPrbGJ0iqoYPgSQ/ZTvQZb0WJg/lgH4g9x/kF4gsS/arxE8ix
         l6zX5/p7bGQm5H5YvH92vmMteJ+Z7YB374LKMOj60eQqeTe1TTMQc0F/WIRZ1IJewBU7
         Mvqh7i0NanG35Xic6mEitEIlvkjzeAUJuAn6dYXxhUM95bnpoa6+t62gtlTK48WuUNL7
         O07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V0MMt2SZFAplyLEvdroFPN6e+rf0CtEFtMouUhBE658=;
        b=IwQeA9owX2+Jdc3YB9Kq9SGuxfRtisoxRLQ/VQwqsUxdN29ljeWzCNCj6jxuPxJY67
         56xV3WNnGKBky9fFP7EuXsYsVlwtqQAZhHddxrEvans+AeLDNb3B2ojLtfqgHE8zHjA3
         rNbAI6OmnzVZ+91nQJTOHt/rnQ8KQm4DRBBiLAfrEmHecld0DAmYx2G8Bl2YR1wdBw6i
         DGojMQR5PQOp1ti1tS8zK/KQjovG+uq6F2xZ5d/ge/D+rQKeiI0k+fXHjshj1cnr4BDt
         JLguBByjXaDoS1j2sedVljS/immf81lELqU6cPH5bKN3QOY8PE0VEcWnaMQScVxvWDAi
         tByQ==
X-Gm-Message-State: AN3rC/6Ut2sibdOYeDnwZIXuBGWRg7p86i+8W3AVlmAgxCroXFl90+ov
        tfeb+LGsPUMbpaumwCVhdQ==
X-Received: by 10.99.247.83 with SMTP id f19mr35327412pgk.190.1493754157754;
        Tue, 02 May 2017 12:42:37 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:bc40:7b3a:46b3:66f2])
        by smtp.gmail.com with ESMTPSA id u23sm418479pfd.63.2017.05.02.12.42.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 12:42:36 -0700 (PDT)
Date:   Tue, 2 May 2017 12:42:35 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com
Subject: Re: [PATCHv2 0/3] Some submodule bugfixes
Message-ID: <20170502194235.GH181268@google.com>
References: <20170501180058.8063-1-sbeller@google.com>
 <20170502193214.7121-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170502193214.7121-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/02, Stefan Beller wrote:
> v2:
>  * I dropped the RFC patches for reattaching HEAD as that is not the main
>    concern of this series.
>  * patch1 is just about dropping cp1 to reusing cp, instead of additionally
>    "fixing" mem leaks as finish_command does that for us
>  * reordered the patches, former patch 3 now as patch 2 (avoid auto-discovery
>    in new working tree manipulator code)
>  * Regarding former patch2, I wrote:
> > Junio wrote:
> >> Sounds good (if only because this makes it similar to other
> >> codepaths).
> >>
> >> Is this something whose breakage before the patch is easily
> >> demonstrated with a test?
> 
> > I'll try to come up with a test in a reroll.
>  
> done
> 
> Thanks,
> Stefan

Changes look good.

> 
> 
> Stefan Beller (3):
>   submodule_move_head: reuse child_process structure for futher commands
>   submodule: avoid auto-discovery in new working tree manipulator code
>   submodule: properly recurse for read-tree and checkout
> 
>  submodule.c                    | 21 +++++++++++----------
>  t/lib-submodule-update.sh      |  7 +------
>  t/t1013-read-tree-submodule.sh |  1 -
>  t/t2013-checkout-submodule.sh  |  1 -
>  4 files changed, 12 insertions(+), 18 deletions(-)
> 
> -- 
> 2.13.0.rc1.19.g083305f9b1
> 

-- 
Brandon Williams

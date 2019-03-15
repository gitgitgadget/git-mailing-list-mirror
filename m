Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE13B20248
	for <e@80x24.org>; Fri, 15 Mar 2019 22:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfCOWkC (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 18:40:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53297 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfCOWkC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 18:40:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id e74so7933594wmg.3
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 15:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P67LN/UT0sBqhAFtDEiRNScGW3gbGet8sDfjinx0AUs=;
        b=Mq96tLHBkNzSuLPhWQmOmLFbYBQEkOomQ8SyADlDUnyUgMxe+Y1Go/hJZg8xFhefco
         w9PgfEtaaqBGG1bF/7VEvdnxjhSvLxw9YKKrx6vhd43rpduuek9x5NNHosyYJKDbPIGU
         LKplkluHH29NuBdNSK4ha4/QBidNPl1QBGo1of2/fe5mAfc+3CTzJGyRSKw4gxsIZ2Eh
         K5l70v89ysQmgFlofx3oNNvrzXMcRXB5zXtarJFCKoyW2z5+xyDBJsY6lZ2aT2d1cDCZ
         ZLfnQqXyhibCxXETxvux0hUiu0uClh8NdVS54BY6vV069WygsjQw7iLHWtIuYjYwKQIs
         ZpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P67LN/UT0sBqhAFtDEiRNScGW3gbGet8sDfjinx0AUs=;
        b=GM6JxHeyVHCbOfHHPtXNGebvNLX7u0usEmkbwE3T5ULWsb1ifBHhAtTM0sxszX0XGH
         2uu1zBs9QvIkJCiC6O4t0qDym7SIkPA/Qb8DqlILU2Y4nrNAs/zCdvtInG1qsHG5Bllf
         VGGJxRIQYfNWTW/8Js4Iz2ttSifPqK7h1kI6NtbIDnLvHxpadCs5rAwyQq//l4rPkohO
         M+8gxjr+aqha+Yf87tl9h+yapDETkj+jUfgpc5sbu0+HH64pcQotfmr1+YjjlsGLT/IK
         39AjRlnHl5EwPAgN8g4rFbjs98jyb+fYoaIm0tQ+wB2yVdS762nu/1ZvVVmS/n16ryG9
         13jg==
X-Gm-Message-State: APjAAAUEbNx+d2da/Add7wboyAgTeK78AA1Jgd6FY4ERMKY+5NFAeoi0
        Q1plSTTE8RHSPAmpX/HWWzI=
X-Google-Smtp-Source: APXvYqwIPo4RWHBLbpD1d7ZgcRomPuy38kj5TAaj8RvvhX6vx7ZBjhcoUNo/vSm5QrfLtIpwoNw2rg==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr2960216wml.55.1552689600308;
        Fri, 15 Mar 2019 15:40:00 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id g9sm2399359wmf.19.2019.03.15.15.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 15:39:59 -0700 (PDT)
Date:   Fri, 15 Mar 2019 22:39:58 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     jkapil.cs@gmail.com
Cc:     git@vger.kernel.org, alban.gruin@gmail.com, avarab@gmail.com
Subject: Re: [GSoC][RFC/PATCH 0/1]
Message-ID: <20190315223958.GI16414@hank.intra.tgummerer.com>
References: <20190315150142.20672-1-jkapil.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315150142.20672-1-jkapil.cs@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/15, jkapil.cs@gmail.com wrote:
> From: Kapil <jkapil.cs@gmail.com>
> 

The cover letter should give reviewers a short introduction what a
patch series is about.  It's often not worth including a cover letter
if there is only a single patch, or only a couple of patches.

It is okay to send a cover letter for a single patch, however it
should include some explanation for the patch series, and not just
duplicate what's said in the commit message of the actual patch.  An
empty cover letter as this one here is just noise, and should be
omitted.

> Kapil (1):
>   userdiff - support shell script
> 
>  t/t4018-diff-funcname.sh | 1 +
>  t/t4034-diff-words.sh    | 1 +
>  userdiff.c               | 5 +++++
>  3 files changed, 7 insertions(+)
> 
> -- 
> 2.14.2
> 

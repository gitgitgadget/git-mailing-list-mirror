Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71641F463
	for <e@80x24.org>; Tue, 10 Sep 2019 00:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390518AbfIJATD (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 20:19:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41733 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbfIJATC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 20:19:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so8802033pgg.8
        for <git@vger.kernel.org>; Mon, 09 Sep 2019 17:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kivSZDnPH+h6FBkJsFjIusILNS4v53IEA+zkb1IW2RU=;
        b=hYA0Zj428Zr50Nust68LxZhTYvuU5bT2G1ZwkZzqom4J+iENTyjp8nL/6H5y76xm5d
         1XYecRCQuGRLhOyAR02Vpy9abAeeNOSmgYr4maV8/zYmuh2nk8Q38u3SGX2CpJe3AjZ+
         iLyBWNv1Kievrp8BlwYQgTfClpRqyrZm/nEx0Iy2xUkoI/YMcWd9/tU18AzDqPQxuPMh
         Uqmh9mL9aVjdkDiE/sgjtJSdAGYqvgk1cdHXqV09TiKSPS+DBhwizNsl8Dbn0zDhtPRd
         BvOZVqnoGXwuqS16DE+cGfqGNt3/qKopB2YZjWvr10MOhZbTBNPih1whZYdYkt8I/rZM
         Pr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kivSZDnPH+h6FBkJsFjIusILNS4v53IEA+zkb1IW2RU=;
        b=JRsnpL3lAoVBQaW687ncgPznCJ474mpDZcNm6o7c3NkCzno95vXiYzpQkV/EYdLSOd
         4+jVhNgpH3vfpFrP3mMW3d0vpze4AxsxW3BgYIySBkSTSy+Wjz5ZTl9osiTIq+0nl2X1
         wOlMgMDMGFO6ShrvZo3CMn5jsirIn1r6JO/tX3w0aHrZB/rNrldLO/09llv37sByKy+r
         EP/AuwwcWr7nNFh8mQexYnR35A+O2YR/Rzo0fcOMils+69Qe2EPJ4oI6Hy2KOqKRhdNk
         XVfjFzGG4wEvLUyMqVCtOQPf98jABUChIAaf5+ijWmHUwLej68eSQ9YhQd6bQAP3HBQw
         4PIQ==
X-Gm-Message-State: APjAAAVE8yqRht62CDmFYS2+ZgtXxCcaQ7MotNYMwgWMuHSwu90jM+QT
        7HtQ3BFc5wj88TSEGEMSA2U=
X-Google-Smtp-Source: APXvYqzejdgqIw+IhEBy3rljqti8wwn8YwZRUkNom7/YlMmcu4pkCU9Ke/tWJRd04TDCU8bqzuGxtg==
X-Received: by 2002:a63:f505:: with SMTP id w5mr24408593pgh.217.1568074741920;
        Mon, 09 Sep 2019 17:19:01 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id q186sm24954633pfb.47.2019.09.09.17.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 17:19:01 -0700 (PDT)
Date:   Mon, 9 Sep 2019 17:18:58 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2019, #01; Sat, 7)
Message-ID: <20190910001858.GA63889@dentonliu-ltm.internal.salesforce.com>
References: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
 <20190909185829.GA88988@dentonliu-ltm.internal.salesforce.com>
 <xmqqo8zti6oy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo8zti6oy.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 09, 2019 at 12:57:17PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Hi Junio,
> >
> > On Sat, Sep 07, 2019 at 10:26:53AM -0700, Junio C Hamano wrote:
> >> * dl/complete-cherry-pick-revert-skip (2019-08-27) 3 commits
> >>  - status: mention --skip for revert and cherry-pick
> >>  - completion: add --skip for cherry-pick and revert
> >>  - completion: merge options for cherry-pick and revert
> >> 
> >>  The command line completion support (in contrib/) learned about the
> >>  "--skip" option of "git revert" and "git cherry-pick".
> >> 
> >>  Will merge to 'next'.
> >
> > Did we end up deciding whether or not we were going to drop "status:
> > mention --skip for revert and cherry-pick"?
> 
> If you are not convinced it is a good idea, we can easily drop it
> (and I do not mind dropping it---I am not convinced it is a good
> idea myself).

In that case, let's not drop it. The original impetus for this idea came
from cherry-picking a range of commits where one of the commits in the
range patched a file that didn't exist on the target branch, so in this
case skipping was the right course of action.

In any case, I believe that giving the user more information in this
case is, at worst, neutral.

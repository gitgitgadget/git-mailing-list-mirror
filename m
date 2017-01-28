Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D571F437
	for <e@80x24.org>; Sat, 28 Jan 2017 20:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752003AbdA1UBe (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 15:01:34 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35013 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751876AbdA1UBc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 15:01:32 -0500
Received: by mail-wm0-f65.google.com with SMTP id d140so67192465wmd.2
        for <git@vger.kernel.org>; Sat, 28 Jan 2017 12:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pY86auYukDo6rgpvGEQy8URO/XCQ8h1bvFx1qq61BTg=;
        b=MJ0pxQFkxTe880S/fUocvug+HBY0E8HsaQq0jKsqvse5xYngtX7DstybBlZLnTJoEX
         VNZVTYGjvo7iHN08pGPM98PISCRH2MS02zy5YsoVzUyQe95FQWHdjKgj+dMnjcsOsAhx
         9ZEbMt6vKFzqDySZ88OcUwEeN2+cJBBoPQ+9bhX1pf9/s/tc6nR0AztZBBEKFu9nqO4R
         ppM6FMioIFElu0X5mKQ64cQVH40PdKGQtUqdhHzZ4g5ctK3Hy35i5KWU++B9Nq3xA8Sl
         rdMK1H+1aw5Y8H4a5pquimDZhJvDerdUWDBUqoaEWLVy/yOvTjKONkggr+t4yJgp5QA1
         f5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pY86auYukDo6rgpvGEQy8URO/XCQ8h1bvFx1qq61BTg=;
        b=rwjgFGQeDs7wkSXwQLcfromMA76/coUC1Nou+vkEjowah5dUY56QjpBS+hLlP6eKqw
         BKmbjSMax4Jr/5VzkXxuJXk/LDSsGdYFfHdu3PQQ1TEHDYI5zjgqC7qRlLhpDzkbHiDj
         gMQQTCKPx5fy16Lk61EZJDCw8fVqu7QK316KbOyBtszlp1AhY/7/RJNX4eEei86Xa/RT
         S0+fuO6OAeXadpQMDbOGrosqHfXMcWvtWGsrPMkP2/aU7YNdKxif+Vw8gLWWcteTCZ8C
         n639wGgbiHkXm4ZXXdsIxdocK+jgpfcelr5ODZa1mMNtx19FiZ80ShCrlZwsq1wBCHfg
         yrAA==
X-Gm-Message-State: AIkVDXK8CprNJFiV/msYt6sdG+6CrlwlabV/ZvIBeiP6AyFvW03NqmdXjfdVOR1MjLt21w==
X-Received: by 10.28.111.75 with SMTP id k72mr7787309wmc.39.1485631811646;
        Sat, 28 Jan 2017 11:30:11 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id o81sm10184658wmb.14.2017.01.28.11.30.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Jan 2017 11:30:10 -0800 (PST)
Date:   Sat, 28 Jan 2017 19:30:28 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Documentation/stash: remove mention of git reset
 --hard
Message-ID: <20170128192958.GB31189@hank>
References: <20170121200804.19009-1-t.gummerer@gmail.com>
 <20170121200804.19009-2-t.gummerer@gmail.com>
 <20170124201415.zzyg4vt35vflwjnb@sigill.intra.peff.net>
 <xmqqfuk6alba.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfuk6alba.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/25, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Sat, Jan 21, 2017 at 08:08:02PM +0000, Thomas Gummerer wrote:
> >
> >> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> >> index 2e9cef06e6..0ad5335a3e 100644
> >> --- a/Documentation/git-stash.txt
> >> +++ b/Documentation/git-stash.txt
> >> @@ -47,8 +47,9 @@ OPTIONS
> >>  
> >>  save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
> >>  
> >> -	Save your local modifications to a new 'stash', and run `git reset
> >> -	--hard` to revert them.  The <message> part is optional and gives
> >> +	Save your local modifications to a new 'stash', and revert the
> >> +	the changes in the working tree to match the index.
> >> +	The <message> part is optional and gives
> >
> > Hrm. "git reset --hard" doesn't just make the working tree match the
> > index. It also resets the index to HEAD.  So either the original or your
> > new description is wrong.
> >
> > I think it's the latter. We really do reset the index unless
> > --keep-index is specified.
> 
> Correct.  So the patch is a net loss.  Perhaps not requiring readers
> to know "reset --hard" might be an improvement (I personally do not
> think so), but this loses crucial information from the description.
> 
> 	Save your local modifications (both in the working tree and
> 	to the index) to a new 'stash', and resets the index to HEAD
> 	and makes the working tree match the index (i.e. runs "git
> 	reset --hard").
> 
> That's one-and-a-half lines longer than the original, though.

Thanks all who chimed in here.  My new description is definitely not
right.  The reason I wanted to change it is part because it's an
implementation detail, and part because it's going to be not quite
right when the filename argument is introduced.

How about the following:

 	Save your local modifications to a new 'stash' and roll them back
 	both in the working tree and in the index.

As an added bonus this also matches what git stash save -p does.

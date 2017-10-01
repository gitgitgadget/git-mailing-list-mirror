Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C427D20A10
	for <e@80x24.org>; Sun,  1 Oct 2017 20:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751672AbdJAUPR (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 16:15:17 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:57005 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdJAUPQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 16:15:16 -0400
Received: by mail-wm0-f51.google.com with SMTP id e195so3325197wma.5
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 13:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ns47xvPrz8u7b/OnUQPwwLx45+dfTmPCXJ9gzGsTX0I=;
        b=TPz8S7CK9kXnzmLvE0brTSvcPOE6Mn5mlBwe3VOoWyZF8vtAmdPQPKaB8j1NFi82tr
         /BiU1vi5TNhmCrAIlX5ytI8oBrI0WHnvqAhW5fzFzOOtdgOybhc9dJkZ0Z7Z+Y4sI7/d
         3Wy3Vj22o7XGeB75wSsYbOVJjwNfBjFp1IhKs/6kurPfOawdHduyxM+RhE9d2+RDaSrk
         vvjPQDkkbzDgeuTkQKuY6+egVhPE3XST90eYETtD+AWYbQdLnn/+y2j95onlKSMvbIWn
         q90fj7JN8AzC1Y1jGP0tgi3S/v2wDTmhqzWV4rB4DTwkwiSsYorfEJxDgjKYqYzT0B3S
         yH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ns47xvPrz8u7b/OnUQPwwLx45+dfTmPCXJ9gzGsTX0I=;
        b=RvXoDrGW1uGenaYc84REpRVWkqpLU5/5dR0qU7dh9nsDHFhf2XVC/AyGJy2Q8En1+g
         mgUIfzVH89hWmB0OIeUTQe/FEMjsH6DNjHTD3q+jL4NNV1k+9u5Kad3tS+zcMpmRFA5f
         ZtPqIB4kYgQsEZaKF+QLD12IREozJ2IqRofsba2BaOd9kxi+5W6XOv1HirrBmQQwmiDV
         6VgqhVzjJTmwVvf5Cjomax5QPCNGikfmRHiDllWBeqD0EPU4bFDUr5U+RjKczIKUJPjq
         zGrxb6LhDue7zmhgB5QlkRh89i8KVQ7hjg60tCny009fQ+GihUr/vCD/HG8XhpGvYra0
         IdAg==
X-Gm-Message-State: AHPjjUgDV5ThmikUJIKA2DynKDbbIHV+h0Whz88d3ZK7czZZsS/LdiRE
        o97ZAvEjwR/johtOi01Q/T/5ku6M
X-Google-Smtp-Source: AOwi7QDsdkW0apWhm8pZ6tWE2Ee8Jd72hzXRIofShYtCMPPSM6UQPNhcnHicEekfZdw9YhPrN7WvzQ==
X-Received: by 10.28.168.69 with SMTP id r66mr8593063wme.2.1506888914779;
        Sun, 01 Oct 2017 13:15:14 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 30sm9177863wry.34.2017.10.01.13.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Oct 2017 13:15:13 -0700 (PDT)
Date:   Sun, 1 Oct 2017 21:16:04 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "man git-stash" explanation of "--include-untracked" and "--all"
 seems ambiguous
Message-ID: <20171001201604.GA30301@hank>
References: <alpine.LFD.2.21.1709290650530.1446@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1709290650530.1446@localhost.localdomain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/29, Robert P. J. Day wrote:
> 
>   from the man page:
> 
> "If the --include-untracked option is used, all untracked files are
> also stashed and then cleaned up with git clean, leaving the working
> directory in a very clean state. If the --all option is used instead
>                                                              ^^^^^^^
> then the ignored files are stashed and cleaned in addition to the
> untracked files."
> 
>   the use of the word "instead" suggests you can use one of those
> options, or the other, but not both at the same time. but it seems you
> can combine them, so that paragraph seems a bit misleading, no?

Looking at the code, really only one (the last one that's specified on
the command line) is respected, so I think the man page is correct.
This happens silently, where I guess your impression that it's
possible to combine them comes from.

This is fine when --include-untracked is specified first, as --all
implies --include-untracked, but I guess the behaviour could be a bit
surprising if --all is specified first and --include-untracked later
on the command line.

Changing this could possibly break someone that just adds parameters
to their 'git stash' invocation, but I'm tempted to say allowing both
at once is a bug, and change it to make git die when both are
specified.  Do you have any inserest in submitting a patch that fixes
this? :)

> rday
> 
> -- 
> 
> ========================================================================
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                         http://crashcourse.ca
> 
> Twitter:                                       http://twitter.com/rpjday
> LinkedIn:                               http://ca.linkedin.com/in/rpjday
> ========================================================================
> 

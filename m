Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B15D20254
	for <e@80x24.org>; Thu, 23 Feb 2017 07:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751032AbdBWH73 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 02:59:29 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35817 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdBWH72 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 02:59:28 -0500
Received: by mail-lf0-f51.google.com with SMTP id z127so12694968lfa.2
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 23:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nikanor-nu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ujJ46TMeaHU6CyuQ8Oao/l0OeP++iiYLh4c0fFsOKRE=;
        b=LpM83CjyUzNNChkjNaTfbyenLUZVjXt8vP9Y2jIac/YGRz3LFqlxKzzXxL6BZziwbR
         sMpNny5oDCtDlGFnD3g1v76Vmy5YACZi8evpq9LFGupDGT8KCQ0y/BVot50UTTeV7S+R
         L5OkQwHF7lCMfRgiCdbusgqwHlOvmfAlPeDW7uPjA837XvYhZgwhsfbZkKj14TTfcYvn
         GS9AIZ6aQu+QcwVLCs2anw9TwCG1QZ3/9B/NOBt6nKIycHbJESzhZdtcqaJ7KbFU5MLk
         StQw72Bbe9M4lcxznfRk+3CP22w9+8wcAqT5tWRu5BcT04WYZTTYOx/eLu2xlqP5ow0/
         9RYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ujJ46TMeaHU6CyuQ8Oao/l0OeP++iiYLh4c0fFsOKRE=;
        b=Fghy+2sbCgUNvYBcexK+r0HtCXCyvXjydMq6b3oNAH/j7J4TPvWpun+LlApPqU2rI9
         qu1rpFeAV7CwS1CwyaH16O5HOLZ44GATSYF9NStQR3SrYlcFM6O9PYwzsL4GH3h8KvmM
         1mwXKmAfiWpEK8lPCJYhpRO8hy/wqAMeIgRGaQN6LWqhzgocDSL64bbQjM5OS5CnREGv
         T9spk6seWlS0h6rRzr0aZTt8sPiTmKFOH9y61jTIVAWph4lHKJqidxxHssogY8Tre03Y
         qbxeSiTqQH2Z1BF0sxjeIRR7C3gH3B6F3GvCzlIaOzPhsq76WzbniSaImMy8/3L2eBk1
         ef1A==
X-Gm-Message-State: AMke39la0Ww62ZI+R5pnQiMpO65mIoVH8ZdKqoAaHLHQYiZiTxQsDvBZoK7rssebRKIiAQ==
X-Received: by 10.25.215.103 with SMTP id o100mr10237156lfg.126.1487836766427;
        Wed, 22 Feb 2017 23:59:26 -0800 (PST)
Received: from localhost (h-129-173.a258.priv.bahnhof.se. [81.170.129.173])
        by smtp.gmail.com with ESMTPSA id g11sm7837641ljg.64.2017.02.22.23.59.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Feb 2017 23:59:25 -0800 (PST)
Date:   Thu, 23 Feb 2017 08:59:23 +0100
From:   Simon =?utf-8?Q?Sandstr=C3=B6m?= <simon@nikanor.nu>
To:     Jeff King <peff@peff.net>, Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Driver Project <devel@linuxdriverproject.org>
Subject: Re: git email From: parsing (was Re: [GIT PULL] Staging/IIO driver
 patches for 4.11-rc1)
Message-ID: <20170223075859.g6ert55bvbe44dxc@localhost>
References: <20170222145613.GA17333@kroah.com>
 <CA+55aFy1JpXmo_PpC7f0zZa0YAP6rz+bztJ+fpDUoWgCz0_FMw@mail.gmail.com>
 <20170223060444.GA26196@kroah.com>
 <20170223061702.bzzgrntotppvwdw6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170223061702.bzzgrntotppvwdw6@sigill.intra.peff.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 01:17:02AM -0500, Jeff King wrote:
> On Thu, Feb 23, 2017 at 07:04:44AM +0100, Greg KH wrote:
> 
> > 
> > I don't know what happened, I used git for this, I don't use quilt for
> > "normal" patches accepted into my trees anymore, only for stable kernel
> > work.
> > 
> > So either the mail is malformed, or git couldn't figure it out, I've
> > attached the original message below, and cc:ed the git mailing list.
> > 
> > Also, Simon emailed me after this was committed saying something went
> > wrong, but I couldn't go back and rebase my tree.  Simon, did you ever
> > figure out if something was odd on your end?
> > 
> > Git developers, any ideas?
> 
> The problem isn't on the applying end, but rather on the generating end.
> The From header in the attached mbox is:
> 
>   From: =?us-ascii?B?PT9VVEYtOD9xP1NpbW9uPTIwU2FuZHN0cj1DMz1CNm0/PQ==?= <simon@nikanor.nu>
> 
> If you de-base64 that, you get:
> 
>   =?UTF-8?q?Simon=20Sandstr=C3=B6m?=
> 
> So something double-encoded it before it got to your mbox.
> 
> -Peff

Hi,

Yes, Mutt on my end caused this. I used Mutt 1.5.23, and I either had
it misconfigured or it simply can't handle files that contains encoded
From:/Subject:-fields when you run it with mutt -H <file>.

I upgraded to Mutt 1.7.1 which solved the problem.

- Simon

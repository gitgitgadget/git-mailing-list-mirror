Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35E481F404
	for <e@80x24.org>; Thu,  4 Jan 2018 20:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeADUP5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 15:15:57 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33397 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeADUP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 15:15:57 -0500
Received: by mail-wr0-f193.google.com with SMTP id p6so2592372wrd.0
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 12:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/WapJIX0u2OukBmSBSUAKTT0UGW3kGKR5z3BotWCVpM=;
        b=OoPxdSTwAqLvn8kjAcCyzJMZ1LAD5R1LPSUTkMwsRQDqxvoxT2dXunGxOa0K/aHxT4
         R2ginS7R7Xj9Lw7C23abZESBFzKY22jlJzvIhWcYmwE3Kofda5bwpmf7aB0qnsAvwP/L
         tvv/IS/2rfjnM6vabzxT5bqqNHfEk+wDZB1k/8sR32ukV//7G4MTbpyPYfMdrVHyAhEn
         8bjYNbh/8FkVMw+FUDNP68PARMUg+WQNbRxJ2Y6e4iRkmznTeAvKJvi6mZzZIod0CM/a
         FdTVPeQ1eTO2MVfKtl1eVxYXF4LqbJU9EBelrtAUmK4dVeXeuDRy8EBWvX+T4LSKUJ8j
         esWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/WapJIX0u2OukBmSBSUAKTT0UGW3kGKR5z3BotWCVpM=;
        b=W6bm8JiRdIOuFHWq9nICbPqPWobv1lBAl/3MopiW/D1OOEOnJvVMvjDzh9z6QJMy9e
         vV2xXw1RD2EgLR3RArBj771LaDJQlmUsXM4+G2wRcNgmS8JLq73+bVXvIVIqZwRvrMIc
         xuBbt8gbBOVmVkyhhsRyk0IIgJ6nQ7+qvk0eZJ6cVrch3oQA/k6OujiFLiRnsoiP9Wv+
         xmW0gKJ2O1MFqwINhb7eOg8AadSkzbw5kj1JbeB11qeKITfuG9j4KHI0JVjRray1uo1N
         dlnrq+pQYdr0oPsrZzyNrrqiuuqt9RvX3eChtTuf5pyZRRQDMzOAqia9h1IFmbvfpfQA
         q/CQ==
X-Gm-Message-State: AKGB3mKSWvSXsDzuesnup6aHRnx0QLmFneKCMEAS5mB6bWOlsR9Ue4o1
        zS9TpujvTVkWqLe1SxV5qHyJ22eO
X-Google-Smtp-Source: ACJfBounLs/p6aNkR4vgKzdH7ug0DnmFvkVVUnhDN8/EyZ/YVJykntYw6WXoX2iROzkz0BNMNZVQsg==
X-Received: by 10.223.164.148 with SMTP id g20mr671375wrb.177.1515096955984;
        Thu, 04 Jan 2018 12:15:55 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id f125sm3289056wme.45.2018.01.04.12.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jan 2018 12:15:55 -0800 (PST)
Date:   Thu, 4 Jan 2018 20:18:04 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
Message-ID: <20180104201804.GE2641@hank>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
 <1514567611.3270.28.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514567611.3270.28.camel@mad-scientist.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/29, Paul Smith wrote:
> On Thu, 2017-12-28 at 20:30 -0800, Junio C Hamano wrote:
> >  * The way "git worktree add" determines what branch to create from
> >    where and checkout in the new worktree has been updated a bit.
> 
> Does this include the enhancements published a few weeks ago to allow
> worktrees to be created directly from remote branches without first
> checking out the branch locally? I'm really looking forward to that
> change...

Yes, this release will include that.  It would be awesome if you could
test the rc, now is the best time to scream if something about it is
not as you'd expect :)

> Thanks!

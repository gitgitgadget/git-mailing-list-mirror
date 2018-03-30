Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9F751F404
	for <e@80x24.org>; Fri, 30 Mar 2018 20:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeC3U4c (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 16:56:32 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:41562 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752568AbeC3U4b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 16:56:31 -0400
Received: by mail-wr0-f181.google.com with SMTP id f14so8861902wre.8
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 13:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vZHD+I5NHdGdtltRaQfEcdb/tJeinyxouU+aZuK10oQ=;
        b=segQHflgnO5qOYC+ukfd3v2p3KVNBgdHIDshqe+V4zPAWX4aHAdM84cYZMSL2UjJTa
         GJED82DmSxbDkjxUWz617iJ+zDNlmntdmHw0lTRQXsDcHCRJ7MOtLhOs/OuM4fWZbVtG
         eau+3+7eIBkOK5u6eJ4Pc2j80C9WS5PsO42JTko4hQnzFhWAc71aiHPXxXJ4LDOBcuq4
         TkyxX528+jOm2TwkRzkLHmMevBz/R0LPHzq9aRZrBZXUbR3Ny6yTPyioP5WHx/XPd7xY
         TOUtOrQCwe9jTLEaJdFEw27IwsXimXg5/CLJKai46HOtWPev0EfyNdvJa62k/iWvL/+q
         nY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vZHD+I5NHdGdtltRaQfEcdb/tJeinyxouU+aZuK10oQ=;
        b=rT9Sjfc4jpv3Wd9gQw4bG8MJvsr3NKqARGKYCgSivEI5g34M7KN3r5q5iPh5HGRWsH
         q9d1Z0tBTkV5im2QnlKfSvY5tLiVRJGbELqaiAxmzLE0P3u6WI/NTqBqbH+edOvZpO0+
         tvD1+12CYPbG+rD6xFYc0ILP2t7hgAJ8Y4UxHABtvCRMrXYiKuGWdtW6U6+Y6l9AfWvI
         fruLA00+ixEELavpPUQIo9zka0n8vgebd8XLjqxio1rd2uUnKoMFrx0AdW82ScOB9W0h
         Wy786x0xbfaw1/MSwdDghPDoSydrNXUQug5HcilHIlEuojWPhuE5Nh8ECN0l3zEHzQOe
         iRMA==
X-Gm-Message-State: AElRT7GiMvqDCagBZRKYbgUUbdv0NT4FPak9o3ThMp3crY2c7GzzvWlK
        tqH3L0G7cSg+6Bgh20gMsfY=
X-Google-Smtp-Source: AIpwx48g+qDc+VKuVc1oYFAlCqVO78gDLwu4rq0ps6JrLSSlG/VL5XC5Fbt5ng800F4tUm9DEqbW8A==
X-Received: by 10.223.201.3 with SMTP id m3mr294334wrh.137.1522443389779;
        Fri, 30 Mar 2018 13:56:29 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id c14sm6621944wmi.28.2018.03.30.13.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 13:56:28 -0700 (PDT)
Date:   Fri, 30 Mar 2018 21:59:56 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2018, #06; Fri, 30)
Message-ID: <20180330205956.GA13643@hank>
References: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/30, Junio C Hamano wrote:

> * tg/worktree-add-existing-branch (2018-03-27) 6 commits
>  - t2025: rename now outdated branch name
>  - worktree: teach "add" to check out existing branches
>  - worktree: factor out dwim_branch function
>  - worktree: remove force_new_branch from struct add_opts
>  - worktree: be clearer when "add" dwim-ery kicks in
>  - worktree: improve message when creating a new worktree
> 
>  "git worktree add" learned to check out an existing branch.
> 
>  Is this ready for 'next'?

Not quite yet.  Eric spotted some UI deficiencies which I'm currently
trying to address.  I hope to re-roll this in a few days with those
deficiencies fixed.

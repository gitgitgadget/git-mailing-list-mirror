Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8726E1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 21:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeGFVSb (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 17:18:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40988 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753450AbeGFVSa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 17:18:30 -0400
Received: by mail-pf0-f196.google.com with SMTP id c21-v6so4734525pfn.8
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 14:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bZ/0reW/6mUilxu9hDdsN98d1YAH0RZgJK0CGn99xOs=;
        b=n9Sgx2E+MeumQcgfBdaHkse3Annipx/cSMyzFlOxfHrCvr+fLSVNYNOQqZ75hjKI2M
         IYHvciGGAsFkB21bdbP9DCmh6wZ+kIcHL5JwHHBPGw9kh2nwcTs9SblGFT02d1ijd0AZ
         3vdNZ/DxJboR2ynhKfWReU0Wedi5qNQ7Q0tvphX4oKJlYBUCd1TmmUf5SvzwpQ+7/D2Z
         81dmmFyG52WfjCZl16n0ierZXjGD/1X2hRKrkHTN3gU1XpUNFAgoLGI56Z4Hu6wwEBKH
         m68ZqGmwMtQCGHsYGRuMTRhKWjWib+JJLg33ERMxufDT5e2KnyNHM/d5jpN12rhaNmvb
         cmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bZ/0reW/6mUilxu9hDdsN98d1YAH0RZgJK0CGn99xOs=;
        b=bvOx0881brVqfjZ+SbUJryes3+23vNTrsnGFX6Qz3ScXY6p4BxhoE4VAZKiyMd+w3D
         uwwfhUoGFMY8k7HzBv7vJ+PhQziE1zAP77jSH9VifvecJiU0L6xInzsKMGcTbJwzAfRE
         O5cy7+YqDElU2O9t+2iwgEwxDMHqRlf4ZAC+CPpjIOQ6RXGEZm1MgJhmeO4zPlG8D9tj
         otHHQO5p6fPE6zcxKgJ8CII4LHmnU/fxltgKQBBhFQcM/Z1shchetNnz5MEEpE9Q/gid
         /uQ9o8x1T2rQYF0qwx5KTuyeEJ898nDJ8pNWWAyF5leg5lX3+hc4ZcLCzhTYRe795MLo
         KRyQ==
X-Gm-Message-State: APt69E1bvl34VaMCjeku5Hx2fhHKUaRMSxF1HVkW1AV+CQXgl6aPLOrk
        XFjSdxFC1OBqTYbqEoBcjbnp/RQU
X-Google-Smtp-Source: AAOMgpdrbXChW5Wrhe0DQoqarvKNDTyV62sAtTy64f4F+x/KsmXWrPn6f8DsDRW7XyyuFACDlYvurA==
X-Received: by 2002:a62:d646:: with SMTP id r67-v6mr12131999pfg.130.1530911909813;
        Fri, 06 Jul 2018 14:18:29 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id v11-v6sm28102707pgq.6.2018.07.06.14.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:18:29 -0700 (PDT)
Date:   Fri, 6 Jul 2018 14:18:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Frederick Eaton <frederik@ofb.net>
Cc:     git@vger.kernel.org, "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: de-alphabetizing the documentation
Message-ID: <20180706211828.GC6195@aiede.svl.corp.google.com>
References: <20180706200423.GC6343@ofb.net>
 <20180706211600.GB6195@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706211600.GB6195@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:

> Ideas?  If you start with a proposal, we're happy to help refine it.
> People in the #git channel on irc.freenode.net (wechat.freenode.net)
> might also be useful for inspiration in coming up with a proposal.

I meant to link to webchat.freenode.net.  But
https://kiwiirc.com/nextclient/ may have been a better link to use
anyway.

Thanks and sorry for the noise,
Jonathan

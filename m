Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6DAF1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 15:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbeHERGM (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 13:06:12 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:45286 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeHERGM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 13:06:12 -0400
Received: by mail-wr1-f41.google.com with SMTP id f12-v6so9896559wrv.12
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gczYvQdEln8ukl3loo1GNHoTVsNstYF38BDIN3oRem8=;
        b=MM9LawECqYrrxyR6YLHAKW2IPN/VrAydcXsfM+5Sa/eyLrypv5yl6eMiJj5R+fzVoZ
         r+61iKgFxpaaeAlso4QFUCG0Y2VvGnT7afB+G3Dpr138mpeVZ10LodOE5Nyqv7UWsN9I
         b2miDSy/PgSea7Utld5iGwR9QhSE1XJVJMJdj2n3FBGzydCY9KJYZlDw7h0lUa0DNdVe
         eRnWcRN70j5RIwudE0c7m80Jl7cvmEYZ2/QTXcUrkh34DT7bvuMTSBhhWa5ZA0xMldn9
         UJ8B4r8OxCzFgDDcaHlgwK8DQEnnDPHsKc1fX12tmy4LSK/qRX6DqNawwHUVn/SOypUg
         LNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gczYvQdEln8ukl3loo1GNHoTVsNstYF38BDIN3oRem8=;
        b=lx89IiiZ65A4X/vCTpr2FK1/BYf5kpsQSkaS6J5E/g0hHYVhFII70DBPSEzeq9KtIX
         3jXL1t36l4K+qYBgp9IGrf68Gqo24ElcsQaNFSnxOt6MQM6atDPFpXQSf7ygPJjEl82m
         JWbS0J07dqdyqEJtyJY9MU8aIt87XjO05QlLFkPjyukzIXzsnq27WYpf1DuMnNk9H8aT
         3PInMLO9ovsIIANGWKkmWIV4SURqxEz/PJK2NHT+nzEInuQHastbNwAIzAXz9HGSprj/
         hhNt4H+37kvCBiEamIRKUKy93hJtQREW1ZdsdpFe5zEYQ6qJI2ra9BgebJu85EVYAScF
         KMDw==
X-Gm-Message-State: AOUpUlEkv1DVuxBDyqvRidrwfLQ9QgDQ6tiBgTxv91k8nBREDzgMwJTe
        9dMEH8v5QIsDjjmG0ckxHNs=
X-Google-Smtp-Source: AAOMgpeO9iHwgq65oPJsL+/+0U9tWFH5TRmP/f0m5ppNFFM49cA8wsLZ0SQ71AIcjj5Wc10K2sFODw==
X-Received: by 2002:adf:8325:: with SMTP id 34-v6mr7125633wrd.67.1533481279154;
        Sun, 05 Aug 2018 08:01:19 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id e12-v6sm7420480wrt.29.2018.08.05.08.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 08:01:18 -0700 (PDT)
Date:   Sun, 5 Aug 2018 16:01:17 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Karen Arutyunov <karen@codesynthesis.com>
Cc:     git@vger.kernel.org
Subject: Re: git worktree add verbosity
Message-ID: <20180805150117.GG2734@hank.intra.tgummerer.com>
References: <02659385-334f-2b77-c9a8-ffea8e461b0b@codesynthesis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02659385-334f-2b77-c9a8-ffea8e461b0b@codesynthesis.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/05, Karen Arutyunov wrote:
> Hello,
> 
> We are using git for automation in our build2 project.
> 
> What's quite inconvenient is that the 'git worktree add' command prints some
> output by default and there is no way to suppress it, as it normally can be
> achieved with the --quiet option for the most of git commands.
> 
> Could you add support for the --quiet option for the worktree command?

I think a '--quiet' option would be nice to have.  I wouldn't need it
much personally, so I'm probably not going to work on it, but it would
be great if you could work on that.  The best place to get started
with contributing is to read Documentation/SubmittingPatches document.
The CONTRIBUTING.md in the git-for-windows repository [1] may also
have some helpful pointers.  Some of it is windows specific, but a lot
of it is generally applicable.

I'm happy to help reviewing these patches, and give more pointers to
help you get started.  Another useful resource is the #git-devel IRC
channel on Freenode, where you may be able to get some help (may need
some patience though :))

[1]: https://github.com/git-for-windows/git/blob/master/CONTRIBUTING.md

> Best regards,
> Karen

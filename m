Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 452F91F403
	for <e@80x24.org>; Fri, 15 Jun 2018 19:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966231AbeFOTr0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 15:47:26 -0400
Received: from mail-yb0-f182.google.com ([209.85.213.182]:41988 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966153AbeFOTrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 15:47:25 -0400
Received: by mail-yb0-f182.google.com with SMTP id d123-v6so3909692ybh.9
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKmsLjIeMyfAxw5sxcxDWtdAwM0iUlTN+thx1TwMMv8=;
        b=mZxxfpiYxy8jZwa7+xlUCUxw03HccE0pM6gRzqnwbzEhQfnOTcevnrWsi/IAeVMavz
         Z/LnAklcGqtG7twtxpRdCG69t6KPPest5RQ6FPVZI67gPLvQsDkav5vivsqNvnLeDWSc
         FqIp2pgZZ3/hy4uoUnJOnloL6yR88Y8+13hzApFqts0Djv8eRcecSaG5wGADhPD1WqmV
         1x0WJSY25mKucDQMe7j3EFugXjBCbDPsfg04es8y6F3+2s8mT70SwISGKT1WoUCFIEAF
         lb6cMpFRegCZ2i15PW9y+F7XUeuZrEhVqeI0QjXz5tT7nsnMs357FBDvXWwdWEdFpznw
         60YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKmsLjIeMyfAxw5sxcxDWtdAwM0iUlTN+thx1TwMMv8=;
        b=FBER733xz0HhnaKn3LyvVG0nx/pw6IAvlWzaSIqLXG6LmOTw+vlZlqDY/xKa7EDHyz
         ta8ylyNnRnoseh3kSCeT3a1w+3XERq9vsvd2E2mClJ9SbZLmyaA9OrL3TA2t6vRVAidJ
         u5XgP2wK5lP21D034LoqxzyLlA/wxpl7NE8e2FtO/VvLtqso2rpnnJEvbF79OWRD2nT+
         A6felkTSBh81rLYl71h3uBsPnuBF57HqLFlPkW5cFlEGP+jhCCBzErEc/25T6G0Funys
         Uh2HQ/csIBFBDc0us/C12LoKT/o/iOhFYUYdLDjSPqXXNMxnDN5BgMdO4oAUHji8x3KE
         w4VA==
X-Gm-Message-State: APt69E0YxbAXboXfpNAk4108Q3f0Q5M0C++sJHlKuZAiEUVDI1S5hTNM
        mVRojedPh2xC+YMSdklcrENEHuGeCK2XdVjHyAQdZaEZ
X-Google-Smtp-Source: ADUXVKIAG0TTUAiamUMm3fp9dnZTvIoJPbpLckJI92pwO23vCxZao71WbY6oopDx40cThCeYvx3WySMxE0cfLBV5tKY=
X-Received: by 2002:a25:8481:: with SMTP id v1-v6mr1438448ybk.307.1529092044328;
 Fri, 15 Jun 2018 12:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <DB6PR0101MB2344D682511891E4E9528598D97D0@DB6PR0101MB2344.eurprd01.prod.exchangelabs.com>
In-Reply-To: <DB6PR0101MB2344D682511891E4E9528598D97D0@DB6PR0101MB2344.eurprd01.prod.exchangelabs.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 15 Jun 2018 12:47:13 -0700
Message-ID: <CAGZ79kYUyzJK7a+=bQMxi=YJ5LgkS_2eJA1dB325U71ks1jjGg@mail.gmail.com>
Subject: Re: fatal: could not reset submodule index
To:     awe@frontmatec.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> # Trying again with submodule.recurse
> git config --global submodule.recurse true
> git clone main clone4 cd clone4
> git checkout with-submodule
> # Submodule is still not automatically updated (sub folder is empty)
> # It seems like submodule.recurse does not affect git clone

That is true; submodule.recurse is not affecting git clone.
This was a design decision once it was introduced, as the git clone
might be too large. Maybe we need to revisit that decision and
just clone the submodules if submodule.recurse is set.

The problem that this bug report highlights, is the following:
Each branch has its own .gitmodules file and they can be
all different, however at clone time we only clone submodules
from the currently active branch.

So you could get your test case to pass with
    git clone --branch with-submodule main clone5

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04554C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 17:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiHGRW2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 13:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHGRW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 13:22:27 -0400
Received: from mariecurie.labrat.space (mariecurie.labrat.space [116.203.185.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5CA5FE9
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 10:22:26 -0700 (PDT)
Received: from labrat.space (adsl-178-38-36-59.adslplus.ch [178.38.36.59])
        by mariecurie.labrat.space (Postfix) with ESMTPSA id B77A43D10712;
        Sun,  7 Aug 2022 19:22:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=labrat.space;
        s=201904; t=1659892943;
        bh=Qa/hwQ0vuYCaWM9AEEBe4h3KZXCt+RNa+G2qQ4I3Io0=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Disposition:In-Reply-To:From:To:CC:Date:
         Subject:Content-Type:Content-Disposition:Reply-To:In-Reply-To:
         MIME-Version:Message-ID:References;
        b=WLfM2D/rc/cctNq/GBIkHdUSDCllxwCRrbPyEpmzGecoa1mZ0fDAHznlgp/yd8wu1
         Kr+0qY/lHPER5icdwF4nUAVivl6m+/JVKVfRzmQE8328qW8m3sMnxOWC9bRlSWD2Jl
         d6/vxekzeTazfd97mFqJ9Lju/6Gpkof7C00+2VO/os9V7sfQl4rvhyEsKTAxHC3g/J
         oSgb2VMlA0CaTAYbOwSK0FJfEfOX4nNGWatfLBPJ4PNKfgCPeAW2/xuWzyW2WNDzFL
         GuCwKdRkwp0wnq2FXhfO6ghFiiAMo4lCkbjx20UAM+fRzW5bWqaOtNSKxQJNuB74pt
         mfVtkpf/YWGRA==
Date:   Sun, 7 Aug 2022 19:22:20 +0200
From:   Reto <reto@labrat.space>
To:     "Alex A. Davronov" <al.neodim@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Init-add-reset bug in a fresh repo
Message-ID: <20220807172220.z35ilb4z3xyywkor@feather>
Mail-Followup-To: "Alex A. Davronov" <al.neodim@gmail.com>,
        git@vger.kernel.org
References: <CAKBAyV4XaXC=Gw5SN9So9UAMJ9ZQE=8dA7B5D8+Wn4JKuFRDeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKBAyV4XaXC=Gw5SN9So9UAMJ9ZQE=8dA7B5D8+Wn4JKuFRDeA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> What did you expect to happen? (Expected behavior)
> - Files created prior to repo aren't getting removed

> What happened instead? (Actual behavior)
> - Files are gone.

That's literally what you instructed git to do...

--hard really means that, reset I don't care YOLO, --force, just do it
mate.

>--hard
>   Resets the index and working tree. Any changes to tracked files in the working tree since <commit> are discarded.
>   Any untracked files or directories in the way of writing any tracked files are simply deleted.

In other words, the flag does exactly what it's meant to do.

Kind regards,
Reto

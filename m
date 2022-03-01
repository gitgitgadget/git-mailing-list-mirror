Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803A1C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 17:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbiCAR7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 12:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiCAR6z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 12:58:55 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBCC3EBB8
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 09:58:14 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p4so7963702wmg.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 09:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MU9hDK/OijL9rPTivGsy+Mad8pYP8/tknSR37EmTj0=;
        b=jdgQj4Y9Yx4aJLyPBOLi84up4A1rmCsevdecB8/bxl0vzyO06a1YIoNbT6kOlTOXB1
         wd00r9HTNzKoYCOCq+xjC28pjQIOJzRpPRY2tsLcAi2mR/6I81XoI/a2wodbpxu0NbkL
         J8SVKiur8DdtOOJDc5CHSei8JtgStgkWU6y0UWcxsc96T3viFzYJno6JszTl0q21taXb
         +ZtQgfyL0TnIp9O7buewDz57MFpfKqgqrV6iTh/cnTitQqM9vBuCNa4wQczzGfU93i8Z
         qpV9y9NKFThAe/Pcqth8uRCmeZN+y2Vr8XjW+nkv9DDgc+ksW0x9BjbaIv0MaSGhVE+o
         NXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MU9hDK/OijL9rPTivGsy+Mad8pYP8/tknSR37EmTj0=;
        b=kK0/0kOryLJvnkSWc0mBH8B48w8sQQ11QOU1EEjzeOCcPsvWBiHiIaYlyJxbLdMZi8
         kFrq6F3hdam7vsK901sdO7i0LLQugCtiHimgguCH8V7FWLLpFbAttHll8MMED5qyPcVR
         G028xKf1mxKMT+Sg94P2tijZK+hThfUIC/YyY1X+AtKudSlgzPIXSkUD3f8TxpagPY9y
         ao0sKNnBMTldwTAiuYq6LAdJ8FXyoMw/Dpd0y4jx70resc07SvRXwGtBFUEXiYL5KE5O
         j/IBlM/1WekFDNuNVKuuaiwvqrtbwkYCyzW9v49rw/Dx6ipc+7Xg9n2YkKjqBA9wNg8I
         pAzg==
X-Gm-Message-State: AOAM531EAZm1mhl5UH7WvXbmPYznnAXjm60t1zjigGcIfscfGNci/Dgy
        f/glXmlgnOWx/87DAjHPTo40JydTzWe2FFtVvIqMH2DXxl0=
X-Google-Smtp-Source: ABdhPJxVDV64ljAmaKSAXvSiuCCDK1Ej3QY0WH2vPXLj3Ya1stdNbNNemWxpI820l0vcf3ccYqF3qoF+fA7Kpv7V9M4=
X-Received: by 2002:a05:600c:1d15:b0:381:1979:a7dd with SMTP id
 l21-20020a05600c1d1500b003811979a7ddmr18137591wms.137.1646157492684; Tue, 01
 Mar 2022 09:58:12 -0800 (PST)
MIME-Version: 1.0
References: <CAFVSqg1arVNwWMANwR6CDP++5hXAEW1a_ajekNe+TXNpSSZFPA@mail.gmail.com>
 <20220301175334.ctem25nxckynnvco@meerkat.local>
In-Reply-To: <20220301175334.ctem25nxckynnvco@meerkat.local>
From:   Ed Warnicke <hagbard@gmail.com>
Date:   Tue, 1 Mar 2022 11:58:01 -0600
Message-ID: <CAFVSqg3i_ANc1sTmEHaxjxxdkkN9HbUEUwejV5S5V5tM2fhWWA@mail.gmail.com>
Subject: Re: URI Scheme for git object ids?
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Konstantin,

I suspect you read a bit more into my question than I intended :)  I
do appreciate the breadth of your thought about it though :)

Mostly, I'm just looking for a way to express the git object id as a
uri scheme so completely outside-of-git things can refer to it clearly
(ie, know to prepend the object header before hashing to see if the
contents match).

Definitely not thinking of any vaguely web3 ideas :)

Ed

On Tue, Mar 1, 2022 at 11:53 AM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Tue, Mar 01, 2022 at 11:35:52AM -0600, Ed Warnicke wrote:
> > Has there been any discussion of how one might represent a git object
> > id as a urn or uri?
>
> This sounds similar to what git over ipfs folks wanted to do, but they ran
> into obvious scaling problems. It works fine for small repositories with a few
> dozen commits, but once we're talking millions, the process of doing anything
> with such remote starts taking hours and days.
>
> If you're interested in a decentralized forge solution, then Radicle has the
> closest to something that is working. You just have to ignore all the crazy
> cryptoblarf web3 stuff.
>
> -K

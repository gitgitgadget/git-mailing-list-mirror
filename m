Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07633C433EF
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 12:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353435AbiBNMob (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 07:44:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiBNMo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 07:44:28 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4B949279
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 04:44:20 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id i5so17219689oih.1
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 04:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WmPJ5u3O2/xvc8WamDgvk0SMIgHQ2Y/xKXS1xyZ9QWo=;
        b=LVvzEVMo6nk+oENzQ3ltAyTOQ6kn4jV19fCzcCEJVwVgKVSbxmY8PdnQIQ1uziNlID
         5I0chxx/XhIzz64kC8s5GZ7EzvrHTRU/dFSKgdX2wR2LKD3WieARq7U1CVCvIwhCXhSa
         JlETYLZgw9C2nj5vAmDmNwISflW0Byir58gq+bUJyEzjJ7yxU2CRdQWSmPhZjAPcPyq2
         A0ayJVJPWCN87cHttSn9UoafdMRJzI85lbjhtPonWTp+mQjXy86zxzLH6iVRzXRYUUP0
         WC8Ry/MFaMP7gN12mzieuqyftu8x9WjjGEljYdXstbp/hVHUxw2jnRMBhav2l0hAntOo
         D4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WmPJ5u3O2/xvc8WamDgvk0SMIgHQ2Y/xKXS1xyZ9QWo=;
        b=uriuxd8EOLjYv4HdMAmsp0PERS5fvrkLRWwhX8aGga83vVd2wRhGAwSxq520EfrOcM
         uEaD8Oeg7/l30M5nSHV19cXfZ/Q/QXqb/edaBJ5ypCR/Xx+tzgBj1hAdkIm2+far48+o
         sbhEWO7IVgiV2ollNgyRu0KTaJx/gQWJ+Qm8/KjoozwECF9mpu0oS5pcgoMagEMNQxyC
         U8atVNBGuVdisMh+WF+OW2Oy2UwNUd3vaeICqbh/KB0p9OatxST8fVlNNJzj3RWCwm3o
         RE7D7Q/KizaURdCtGmBY6/eQv30tSq9UDHmA6vcnJ91qnJy4dimThdaEATBTJCZDpcPf
         LwUg==
X-Gm-Message-State: AOAM532lICc+liwuYL/c1+w4OvNEnJwZnm6geO/wJST1SWk4zmH6035B
        3T+SUGbgYydY7t6TK93i7O1Co/+Ru7wPJhbE0tVlhNtl2eiThQ==
X-Google-Smtp-Source: ABdhPJx5JMsg5nnfuHhDnN3b0G0QK+Fg0JBaoOl1ja1r9wqA6/BHfnk0f0o/jliYG200EOVU6ArYMFeEk3zXhbUPjCc=
X-Received: by 2002:a05:6808:d47:: with SMTP id w7mr5270223oik.78.1644842660057;
 Mon, 14 Feb 2022 04:44:20 -0800 (PST)
MIME-Version: 1.0
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Mon, 14 Feb 2022 20:44:06 +0800
Message-ID: <CAJyCBOTuNn24_WvHv-xQsCdtr9-4_fdrMrOC7ZApg1xFp4RNWQ@mail.gmail.com>
Subject: [GSoC] Interest in "More Sparse Index Integrations" project idea
To:     stolee@gmail.com
Cc:     vdye@github.com, Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee, Victoria, and Community,

The self-intro was done during my first practice patch [1].

I've been paying attention to the updates to the SoC 2022 ideas
page. And find your sparse index integrations project quite interesting.

It took me around an hour to read through this blog [2] written by
Stolee, and I felt
that although it's a relatively new and quite cool idea (seems a bit daunting),
I think now I have some basic grasp of it (just a distant big idea).

The most amazing part is the drastic improvement of speed when
sparse index is used on huge monorepo (not sure but sometimes "git
status" on git's
repo can make me feel slight lag). I can see this efficiency boost
is beneficial for almost everyone, especially those who operate on
huge monorepo.

And I think what makes me feel excited is that it actually connects to
many topics that I want to learn as a newbie to git community,
e.g. index, the new ORT merge strategy by Elijah (I didn't know the
default merge strategy is replaced if not for reading the blog),
and possibly many other commands' underlying magic (guess because
I can have the chance to integrate them with sparse index and learn more
at the same time).

Generally speaking, I feel that working on and researching about
the project opens up the gate to dive deeper into git and meet tons of fun
(I just finished skimming through the Pro Git book and can barely understand
what the blog is talking about, can't wait to see them in practice). Plus
it is also a good idea for a beginner to walk on a "decent paved-path", quoted
from Stolee.

And the main purpose of this message is to first, show my interest
about this project idea and second, use it as a thread so I can follow up
some questions during the research process.

Question: It is a good idea to start looking into the commands listed
in the idea doc [3] and make some practice patches about sparse index
integrations?

[1] https://lore.kernel.org/git/20220123060318.471414-1-shaoxuan.yuan02@gmail.com/
[2] https://github.blog/2021-11-10-make-your-monorepo-feel-small-with-gits-sparse-index/
[3] https://git.github.io/SoC-2022-Ideas/#more-sparse-index-integrations

-- 
Thanks & Regards,
Shaoxuan

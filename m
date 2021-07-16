Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44B4C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA7E613F3
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 15:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240888AbhGPPsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 11:48:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:44579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233204AbhGPPsk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 11:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626450339;
        bh=bmPCvSumGcB0TSpsHMEAnD9N3hFoFPp6eCasjuNgUhg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h3dXvdDxON/rbG9IbQW0UJAX/nYh8GwTtlVI/NseePG2ggw37Dc64qji2gZUemmIK
         hBw4apGjeE5qGHG3Xp3WReLFp73e/pgsVTiBOOsoHbCrNBRSL+7S32HGvXzQUg8xDy
         VrfK3zdV07mX8c0S+lLp2G6RgqNA34H8fYljtAFk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.111.2] ([89.1.214.95]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Il-1l7jri30Gb-013QKi; Fri, 16
 Jul 2021 17:45:39 +0200
Date:   Fri, 16 Jul 2021 17:45:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 02/34] fsmonitor--daemon: man page
In-Reply-To: <87v95e2j71.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2107161732150.59@tvgsbejvaqbjf.bet>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com> <pull.923.v3.git.1625150864.gitgitgadget@gmail.com> <5db2c0390a657d5790cf24404201505c4ec3a829.1625150864.git.gitgitgadget@gmail.com> <877di9d5uz.fsf@evledraar.gmail.com>
 <533d47fc-ea37-1e6a-b6f4-ac4fdd24555e@jeffhostetler.com> <87v95e2j71.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-704036014-1626449861=:59"
Content-ID: <nycvar.QRO.7.76.6.2107161738090.59@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:JEkSbPmBh7qc59+t63SaZ52krvLV3Qg0+QbRYqLkOM6bSvLFfh+
 tjgKZuOMmeqiqY1pUudjwzHNwcgZvPdrcQqVnmXl72HfBUB+YhCK/i62VOiMR28sH8FYbNM
 FwrHHuS3Kl2eBlns970EtzE9Xfm1qgtQwUyMPHU+MkFVarFnzNucUZPRtr4kXlag1cwQ7mI
 g54X1KSl6ml9z+1kZwh0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fE9L32K3gRg=:vY9Mz4uvHaisjlW0mJ30e2
 WlICs0UvTSAZnburfRAkYoZfYWOWZFM0cWllPxYQnB/3oeaAHwlDfaEo5qCIltien925gE9Cx
 J82gdOxNzat5Pcq34GqMWuf+IUJYLYud+YVlKV7sTXTWvEN1U/TgYieXBE2P5filP8oZdwQ9g
 ZvTqOFSa4xIOw3Dy84U4myJmkHcYrp7K0UZltu1RTyi2py9sRMHzMQnFdXsVRgxY8FV/LZ2jb
 GVZzOZZ3BxCTuUteS/7VvLuylLWdDe0Psw3St3cxazoy9Bk++yf5dimJ0LbH9hUCg5OWmjUV/
 aANnGthIUKuqk5SBl7uxTGn5cz2XUcAnreJybK1MwuZvrOeEid/qNDjDJ38NXCaT8bRz0eMs6
 r9dfW+3dcg77NX9lL/1wOBPmrz/6GJy+Kdx+dL3lDNTa6g0HrHTxJxO3lEVzifeXqNr+PP+ZK
 LbMDRMUot6qcKyhd0lyyb9NWUDSG2dK6Z7IRINuNz3V7jaB22SUTdTMpnbZYmsIiphTEQlTps
 /3rT8D/owQVZnAfT+mBIeHxX5geGkxBisbVc3n5/T37wOdlU2rKWYbJY4y6vuoqABy4qN4B3u
 6/SEisFntijP8bj0T8F79t+pYfAMHj+HkG5mzg6UCudi+vZWMNYsQzUoePczyWtk14Aa5ZsuF
 hieoGEITifxF2mKc0Wr7gxPXi+G1GuwGowoaRcGZX20CGHWMs5jQZazeBRlgF/zrXDHLBMyas
 +xt2kMh5/QhCBRms8wQke61I9oJ4pQnkDlPsN2SNCyqwaWCC97AGuoPUKT2vCcRfEHAy8x54f
 3PYKtBGpKHCpgGtX6YWp6LxuaeqQSNuvLDvr6hk5phnO0qQ2p68O0vZ/Eczy2HuxW8ciEM5tS
 bTHb8JVXQBpptR9S8XGg2DqWUnd0tzRkrFjDbpf1HpwSt+TGc/urJGIHoV0bRxOJ0iWIVt0IU
 9hfP3ZT/GLOdOdUc+K3daNiPCd/NqmAeUZIkYWEHXnmT3+MQBDscPJpgH710UlUNHcxg2ohaq
 qM6FmK5K8anZZYN9iWie/bYUUcYsqgdYh0O/XlKMqoqx2uByNpEri+OR8DU95U2Vp1X/89rOT
 xrraVt26FspxauBARKAD6GNn9auKDeEViYPqnJAk26f5ZQ+y2/6YiMlPA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-704036014-1626449861=:59
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2107161738091.59@tvgsbejvaqbjf.bet>

Hi =C3=86var,

On Tue, 13 Jul 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> [snip =C3=86var's suggestion to populate the manual page incrementally,
> interspersed with the commits that finalize implementing the respective
> functionality]
>
> I suggested this because I think it's much easier to read patches that
> are larger because they incrementally update docs or tests along with
> code, than smaller ones that are e.g. "add docs" followed by
> incrementally modifying the code.

My experience is the exact opposite of yours: shorter patches are easier
to read.

> That's because you can consider those atomically.

No, in a patch series you cannot consider any patch completely atomically.
Just like you don't consider any paragraph in any well-written book out of
context.

> If earlier doc changes refer to later code changes you're left jumping
> back & forth and wondering if the code you're reading that doesn't match
> the docs yet is a bug, or if it's solved in some later change you're now
> needing to mentally keep track of.

You only keep jumping back and forth when reviewing _patches_. We try to
do code review on this mailing list, which means that you have the code
locally and review it in the correct context. When you do that, a design
document is quite helpful. And the proposed manual page serves as such a
design document.

> Which is not some theoretical concern b.t.w., but exactly what I found
> myself doing when reading this series, hence the suggestion.

Part of the problem here seems to be that this patch series saw many
reviewer suggestions that forced it to increase in length. That was
probably not very helpful, after all.

The first iteration had 23 patches. Reviews forced it to grow to 28
patches in the second iteration. And that was still not enough, therefore
the third iteration consisted of 34 patches. And if you had had your way,
requiring Jeff to include a Linux backend in the same patch series, it
would have to increase in size again, and not just by a little.

This all sounds like we're truly falling into the trap of ignoring the
rule that the perfect is the enemy of the good.

I really would like to come back to a focused review that truly improves
the patches at hand, and avoids conflating the review of the actual patch
series with matters of personal taste (which is a recipe for
disagreement). After all, we are interested in getting this feature out to
users who need to work with very large worktrees, right? At least that's
my goal here.

Ciao,
Johannes

--8323328-704036014-1626449861=:59--

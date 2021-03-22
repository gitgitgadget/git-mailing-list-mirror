Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BD1C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 740D46197F
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 18:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCVSEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:04:42 -0400
Received: from mout.web.de ([212.227.17.12]:48493 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhCVSEP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 14:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616436242;
        bh=gpyXOXzkPPKJukqiIasoA40Mde6ek82AbmPuN2FrVac=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HeswJLpUJlgT8+QzB+VdxmikrOTSjiOhoeCpU1718nsgqe24gFBSZ2+g7WhPlPSxh
         RDc8uYrh+RPeVRjOxqHUx83L7mo7kUMJsVPVa6PYvBeKRt3vzRC5hphujlgJK0Acc7
         I07NStW1cKrGoC7U+aDhJb3eQC4q27Mq48BxlvYY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.22.17]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0M5OUd-1lb5np3BaJ-00zZu3; Mon, 22 Mar 2021 19:04:02 +0100
Subject: Re: [PATCH v4 1/4] Makefile/coccicheck: add comment heading for all
 SPATCH flags
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
References: <20210306192525.15197-1-avarab@gmail.com>
 <cover.1616414951.git.avarab@gmail.com>
 <d8c6efd2464782b1c313d0bb5c8e3dbde86a673d.1616414951.git.avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <477fa639-8f54-13d8-afad-0069183f714f@web.de>
Date:   Mon, 22 Mar 2021 19:04:01 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d8c6efd2464782b1c313d0bb5c8e3dbde86a673d.1616414951.git.avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DxJSefFVSz6LxNzXtOeTszjPq6F4rcPF8n92Td9E7TcCJ4Q0cgm
 fmwrbVZmMIVdLy/v9CMYW0n+Zj84K2cotvcl8Th5zaN1Ovlnqm5kd0pBVU3jzTonklYFVHa
 EQkQkvhJ4iQC4VJf/dyVdG4ay9zhPXsWZ/M8GD+8Er7w8uKCwIvfN5lC4Zo1Iw+4QwnGHAc
 GE6g4/uRwnJCNejv3CAAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2n8dLBDO2UU=:clyLcxwzqf6UNfzyzji6my
 nuxXrSguETMP9CII2o1m9XdSgU/e8gU5/EfezM0vDbvSaiCQlMo/QdibPJfVc+JgkzxKY8BNI
 uoIyl+teEI+LifZY7ZnxUG1t6LxHgirNOY9Hmzo2QJYkN2+vyR2sot3IDy11M1Ke/kdwLu45e
 Tit4fVICwh9OtNwpnA93bJ40Y7jvVdGCRn0W75R3lRw9ic64tA6ytLCA+nk0g36mAJSaDAMc8
 3YPQMMVZcU17RF1v9a/B122eJ6frzt25xueSiawP3snMxifFbC/FUaEdkAxwgLm06JvIi5Cvx
 8q7XNP8jDDLJThqn6WIUbfiSsMd1DyaSaoubzuTFAM1yBdcptR6MbhWz+r3kDVzjyOxsf8zib
 MN1TK9HUR0hzU8PJ/its9Cj+OIqv09LDED0VlgLm+VTati6XVzfk6weazEvdIiUdLm6Mp5tWx
 Fw1lSPpwjiILLeCjHDn3vL2qcer8DX5kKSwkLbqwED3LjXV2bPjfYqJBmRTHmdunTOCPhSKZo
 nTEFWOWmIqoe295sKN/0Ws8PSZpbA24RQqUp2CVeWhRjDARID80pcWLcIwMDQz5d+Xk5Uvzjd
 2m5lgdgdzP4abP6DRrZZPtpPfWSLM+Hb4KVGlVRYwmze54H/uvpO3qz6t7xXO3xu+OqD7vERz
 7Jm+gnk4UD9hm2yLr/gNVtZCbttDsl3lbpgMLwMZRH577hgZ5XHExkeoPHmM6V0eKmc6iG2FQ
 b1uqZ/bbEnpfFnK/zUHzVRZ4D9/HOIfS1Ealhu9/zrd9gQF7bgeXdmkRSyWNoNDGKHYfGgY4u
 OY9gm8m4akpugD2B6D4ozJvo/6Dts2vx4YgNtoUG8FwXKIXr5JlIeRw5PcnqaLpAgC8nX1iPB
 H4YlvfEOG1Fp9rvj3oSQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.03.21 um 13:11 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> In 960154b9c17 (coccicheck: optionally batch spatch invocations,
> 2019-05-06) the comment being re-added here was amended and reworded
> to apply to the SPATCH_BATCH_SIZE variable.
>
> If we'd like a separate comment on SPATCH_FLAGS now the diff to
> introduce it will need to also move the comment.

None of the patches in this series do actually add a separate comment.
So SPATCH_FLAGS could stay where it is, no?

> So add this heading
> back to make subsequent diffs smaller.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index f3dc2178324..eef99b4705d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1198,10 +1198,11 @@ PTHREAD_CFLAGS =3D
>  SPARSE_FLAGS ?=3D
>  SP_EXTRA_FLAGS =3D -Wno-universal-initializer
>
> +# For the 'coccicheck' target
> +SPATCH_FLAGS =3D --all-includes --patch .
>  # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
>  # usually result in less CPU usage at the cost of higher peak memory.
>  # Setting it to 0 will feed all files in a single spatch invocation.
> -SPATCH_FLAGS =3D --all-includes --patch .
>  SPATCH_BATCH_SIZE =3D 1
>
>  include config.mak.uname
>

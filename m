Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F78C4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7B660F70
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhHCXBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 19:01:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:50091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhHCXBy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 19:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628031700;
        bh=19Cl7YT60OCKGmpwirWchqZIGpBeJDSmcTWsJGkcNCc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Pgk7d97AdZLr7LP72j79rl6JHk95fQlsvfUGhOpikj/54IgOxBCLRCue9K52FrMF4
         b6jMMZOVOgtm/86NWQ2+c/GtzWWTyzLUlAGt9bvjrEBT/xtjGrvqv+cptOHm7vsUce
         IdxZJ35+4QWze+M6JcxddP6cYbAlbq83Lr3BobF4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5mGH-1nCxZv2qwl-017GT4; Wed, 04
 Aug 2021 01:01:40 +0200
Date:   Wed, 4 Aug 2021 01:01:39 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 08/10] merge-strategies.txt: fix simple capitalization
 error
In-Reply-To: <010702d08417f86da033ae8a6093ec4b9ce6e19a.1628004920.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108040058520.55@tvgsbejvaqbjf.bet>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com> <010702d08417f86da033ae8a6093ec4b9ce6e19a.1628004920.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rrEKFOekh2zyZFDxNg6pKXklGgZHmZaWwmRsRx1TBqCmpBoprVe
 TTBFRK95W1Js2ilxOGPSYbGLRZL3Jp3X4wEMWO7vwiXbNky8EaJvUv5R/xcx11CX6aty3m2
 9Mbv7ampMYYXtFiwnlS+3qFepe/E/EvMsLOYGVZiWyUkDEfjcDIB79gxll4iyd7AGr1P502
 mtTvTmxXPJV/xF9uCZTuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DpD1bmPZR3k=:SC4DNn3Ou79geJLRgOlTTg
 AbVBIu/Ha9znOBidT5Li5JDZDeSYLFzm2QVuepNqV2cqv0fJ0jjbwgjJyFXo7wtIDdYdJ9ZDi
 tZ3r/juan/iiGy0yXXi9t4sVRUJs7jtmYBGlT6wmzFRVa9i2q6/2GfO3IIvhpDW5IzqpXUgQJ
 RTsWXeiAY9HKb+qLrhAuQMhzU8Hq6rr+8rBCYQNJ0+jRSo9KWfIfrV47fegbWRFU0qzUNHXUg
 H093wS1ljKruW+/3vWpTeg1hTmvXfWVpn36zpkXn8a/HbEycZ7zpn2Qf/y0Lm+Il+yjmgih+Y
 TP+2+9Byu7V43+0yjvpYVgqWSdSIdI0p5BA7yEb8IryxIFfEvtTWskYD2D8LMxNQyr2yv48PK
 bMNBRQ/G617PqlPDV2aUAmFL2tBEdHig65AbOX80rVdq7fyaB5oVdBYyMby0G2TGCMIV1nYPU
 rtRoKAZ2kYHAOUBJSem7br9098MlAXtIsSouhc+QffIza0BSqJ3zZNyqTPnStA4+UKDV1kaFO
 qkQyrE6f7oXeNEs8nKsqRqY9ckXNybEqTirBm5D6elDfw8xKYIHMDYQ0LgDnC5TTSUNlfFz1r
 zs8h7SkeMqq2OfFV721AA14YdrVmaZcvuSXGw2CvAM2vdLqctcoSmuAS6zURVIyD+Vrma61jv
 eyK+Cl/2H8eNxmc+N0NBpuz+Vg51mJPMMDZeZbT4au8UfW3gm2DNAT4NVMh+HCj+Oh07N6gFQ
 u6iibLgonHk0bP5FikVj0uufvKvBJrWgy3Ha/aYdn61zfS2QIvHRdIGOwO863kP+KPfz3ztNV
 qnHXFON4Tpt3Y8lEvcqwDV79ZquHK16LHse40ym9H76l+BGraO5flwkKD7A7PIhbfNH7ZkpHL
 NdC/emiWVJznX7RIGC9HYU+gRaFFzlGFwgU/XW+UQVD+T3trINYHmXUKjDmFgZPFkH+q7/x5J
 wzG6p13B3aiWFY9h8X/CzX6yq3UVkt7DrqGgLIdlARcKmp2Ud93tWoZ875UxN35Xk1Ts+fRqY
 LvFY8fBh5ceDqgss0bUVqTCU7WdWvt3DdkLsEywJ2nNJh9J/w6hid8xh3zqhSQsDP0TQDbY6N
 hVGYOHci3X6w/c/CWRMAYGl9mdRTzWwyigulqoOL8IaZ3J5TL1fknFFag==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 3 Aug 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  Documentation/git-rebase.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 7044afba362..b4429954480 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -530,7 +530,7 @@ The `--rebase-merges` mode is similar in spirit to t=
he deprecated
>  where commits can be reordered, inserted and dropped at will.
>  +
>  It is currently only possible to recreate the merge commits using the
> -`recursive` merge strategy; Different merge strategies can be used only=
 via
> +`recursive` merge strategy; different merge strategies can be used only=
 via

I am not a native speaker, so I'm eager to learn what is the correct thing
to do here. In particular since I continued in lower-case after a
semicolon for _years_, right up until some native speaker mentioned that
that's only correct if I continue with an incomplete sentence. If a
complete sentence follows the semicolon, so the advice went, I should
start the sentence with an upper-case letter.

Could you help me understand the correct rules here?

Thanks,
Dscho

>  explicit `exec git merge -s <strategy> [...]` commands.
>  +
>  See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
> --
> gitgitgadget
>
>

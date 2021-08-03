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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BAFC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD50260F70
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 23:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhHCXFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 19:05:31 -0400
Received: from mout.gmx.net ([212.227.15.18]:32827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231482AbhHCXFb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 19:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628031918;
        bh=Ush3+vcJ2LL1KQqZ16ooPL+T34Tl8tVpXQzkrVvXB3w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OTQfKpXT6usUGyImT3kHnvMljafwVIZueuiQk1f8YI5qpnBVisRYK9UEgzdfqk3R1
         AkMwnv44/TwscwJ+h4IqBow/AJMtZ/J1j5Xd0LBfBZbqWKzcE5BEvOSlpif729zVJf
         FY/fo+YhNTff2yoNhQ7tY3gl8c59H+HyiL0rj8ww=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzOw-1mVtkA0x5w-00PQ62; Wed, 04
 Aug 2021 01:05:18 +0200
Date:   Wed, 4 Aug 2021 01:05:17 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 10/10] Update error message and code comment
In-Reply-To: <2a7169c8c1be425d4234e414c106ad1278aacdd6.1628004920.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108040104150.55@tvgsbejvaqbjf.bet>
References: <pull.1059.git.git.1628004920.gitgitgadget@gmail.com> <2a7169c8c1be425d4234e414c106ad1278aacdd6.1628004920.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GrGdAcGOqd0RXbkRBL5PGmvyXXDprxvd3CxR88iCbS9qG9yYAoe
 Nuw2NeIvLpZFB2iHhXKsV1fPwcI4oTdRgVrXj6xflqbjYf0uFI1s58gIQs6xNbHAgo/0Jjd
 PztSMHouEE4Ili12vDcCrz4HyNJ+xCLGwKIUL0DB23C1/ke28TWS2rZP7fngoNH7fE7Iqud
 vboDUpVqRnvdF6Mgu19Zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FljxyTqvy/I=:a8gjBH8hMa7ydpvAtCZnFg
 Rrun/0Tx4nxbKh8nc4aG3p6D7NaIHvZ4t+mKmlLne/plOj30DUgVSb+osDd1QzlYfxR8Py9hd
 4mp7tnGCkbzmdHLrgvgrSNdFboc8tceaO03c47XxH0GDHLaw/b5eQfJgPaZHfieO2lX8qdxXN
 WDT44Ii9XMK/fqO8wSG+lxrhTC3mJaUjaPi2aApfE593L3edPl4nU+Eg6WJSg00WgOQo+2+VK
 nyReIrLgy4o2XwzU8qeyaaS+ddgpn9vXk8sPP/+22Te3hjimu/jCe+9momSgOHGkhBLa0KF6D
 S0wr+yG4WHJ9xJ7XAAtGQ3V6SrUYr3B45cPNSQAHeohMf+tpTpq2/1dQbgsxW6NhFipNV+Kcw
 C2zN8yJGY7rpfDEaJiZXRspn9UbHuuQpBe9flnxnTBh+XXdincozKoDEsZmJo7+i5R24Rjnj9
 90BbQED75oCE8ddFq51gscQDI3iqb8qylZLeIj6LSHYENGiGWqnC+i67+urR+4s/7Nwql1Naq
 Jntv2f0FQ+6xIlykjvfbkzTvSci6tMWhkZUCwqOrWtdbHi71AQ1UQtXS+E6lZTcG4qNFDxeoT
 7w4RQ1GIZSNiDzAzX04V/GGAYA1NB/Vo6UjJToH3XypuXXF2d6CFREMfJ7RZwhdx7vHkecX+d
 hc5K6iLnAqYMq/PQjsLnVDiNH2J7z6QCGQ1xdaVlvaa+wDvQhtnmPxAKoVCt2zt1dErsb/PE2
 osNKtoY1DK5c3yjgJ8+ZYjfXHcs20seQ35KsFpfDOtPanw8bQR2aN5xYv2J3CY6B5stnNNGg2
 qZMZXPlUH0EtBZmAp31aOalAaiqO8ZAwVVhgAtAKRKXrV1Fs0UHJauvbJ5YgZKj1CEnAv6s4W
 tE3KEf+bbjQY2uv6rMjGIjMS2Y4a8Qj/0O1RjC7gdPSfbKT7a5UVHulU8D+ILCg1bXF5dVFg/
 BhGYd02auZbfC8cuvSLkOSopoQrY3qMcBhGJtjNpvv78ZFrKq45JjaeQ883FCCQwAKHFJ/E1o
 v7uAY19JhjT++7L7WuJ58LMmCOPjjr/0mp8R5dpLkqMbf6wUSRW88X+nZ4ucXKQvuh9HP0USF
 XL20r1s8CdURQoSLMaIGZbhl95GuqO+w/IKYVhWWL2ECsE5WWBgOK44gw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Tue, 3 Aug 2021, Elijah Newren via GitGitGadget wrote:

> From: Elijah Newren <newren@gmail.com>
>
> There were two locations in the code that referred to 'merge-recursive'
> but which were also applicable to 'merge-ort'.  Update them to more
> general wording.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  builtin/merge.c | 2 +-
>  sequencer.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index a8a843b1f54..24b62a9c532 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -738,7 +738,7 @@ static int try_merge_strategy(const char *strategy, =
struct commit_list *common,
>
>  		for (x =3D 0; x < xopts_nr; x++)
>  			if (parse_merge_opt(&o, xopts[x]))
> -				die(_("Unknown option for merge-recursive: -X%s"), xopts[x]);
> +				die(_("Unknown strategy option: -X%s"), xopts[x]);

Since we updated our rules to start `die()` messages with a lower-case
letter, we could sneak in this change here, too. That would save
translators one extra round.

Thank you,
Dscho

>
>  		o.branch1 =3D head_arg;
>  		o.branch2 =3D merge_remote_util(remoteheads->item)->name;
> diff --git a/sequencer.c b/sequencer.c
> index 7f07cd00f3f..a4e5c43fcf2 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2065,7 +2065,7 @@ static int do_pick_commit(struct repository *r,
>  		/*
>  		 * We do not intend to commit immediately.  We just want to
>  		 * merge the differences in, so let's compute the tree
> -		 * that represents the "current" state for merge-recursive
> +		 * that represents the "current" state for the merge machinery
>  		 * to work on.
>  		 */
>  		if (write_index_as_tree(&head, r->index, r->index_file, 0, NULL))
> --
> gitgitgadget
>

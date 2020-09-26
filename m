Return-Path: <SRS0=tECa=DD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD26C2D0A8
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 18:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B02D20759
	for <git@archiver.kernel.org>; Sat, 26 Sep 2020 18:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="LOP8rh0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgIZSZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Sep 2020 14:25:19 -0400
Received: from mout.gmx.net ([212.227.17.22]:48939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIZSZT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Sep 2020 14:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601144706;
        bh=dPR0K1SJIoJ+w+c0ivK1J2UiXZw0fnVc8q3p+bzrpNE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LOP8rh0Q+LsToC5OQa8EOea/fYLZGxlTP3QKBIV3hOiZC/1hZT8TTTA8qTBk1d1J0
         aKog3YslITzoui3G2YtstxlPVE7w6Hp1TnMOzaxuGPa2gL52GUJf2/j6Gqp6+Nj+5a
         VpHaDy9Qd+MWmPBbEnbif8rfafIHbZY5oJU61vKc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.213.116]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dwj-1kY2a736Ob-015dQ1; Sat, 26
 Sep 2020 20:25:06 +0200
Date:   Sat, 26 Sep 2020 06:20:15 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] tests: avoid variations of the `master` branch
 name
In-Reply-To: <xmqq4knqep8t.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009260619260.50@tvgsbejvaqbjf.bet>
References: <pull.734.git.1600279853.gitgitgadget@gmail.com> <pull.734.v2.git.1600725687.gitgitgadget@gmail.com> <8f59e19b9562f2673c4fab5509ad8e8e2d48c19c.1600725687.git.gitgitgadget@gmail.com> <xmqq4knqep8t.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:l1iRcSTOjOaJKtcXunF0gVai2DR4wa9VS7sIz9W+5f2umveWWqq
 +UXYmeZ6hj900JSBhksQ9Rga92ZAz14oFFkb9Ts/5TGhJWlPID06uWSgRZ1D1qj63xUe702
 NrvLjYbwfc0aA/Yv/SxcIZiFIgJ6WrGKgba1o3akSKOSTSvi3G8s0WzGz8foN0mS7/KhUR1
 hy3eeKnChqqrhz+HctAKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DaVOE2u+/0o=:TTymkVvVN6F6OZOxZfGuKS
 g+IJMeT6nJ+CLiQmcLytms25f9Lb9jBa/xbGtYlldUuib/vw4sdPLOKaKyJf0AMSYzKU1ZFaN
 B6y9cvj/1/g5rvchkNf2TQa57CRzAQjw0hKulYSZmUvN4blrNj+9V7Q8noK0SaLETc0l0cnq2
 zPtHyuhdM2Bf3pVyP7WMtv884iEyz4Xl5OqAh1BaO21ySeJaClaquilz6sn8L1uVHdOEroCFC
 uKOB3Mv17jsdmib1fTHcI3MHuauCXy4JieyjTDtPpmiHk9ruRtvhqUc4WId+ZpAqKZP7eLF6o
 SU8iox8ADz9l7rBbhtowgi1dDBlcB90M77irj1jo25nVPd7ww+kHLvIL1N/qfXkor59zqiYU3
 s5blm+tdFonKLbhVfkZuMnHxybuw6CvwBY07rnum8lAJKEQJmIGxIRB6ubsKgXzn0VLQpEshv
 bTulW8N4Eqj+z/UhWnjsQ19JqUb1/+39+3eNNGTmIX27HHPQKEmR/K0FwayCX9vU3y0Df1Lxd
 1fb7GekiGZaBVXvxmJm1XmA4D3qDqhfzEXaKVkAtOB9V2uCxhcX6ULmRgqn7qg3Wr+arxZ2eB
 T19mEonsp14HkIHE/+pd1VXClzV7q5Ir+gtdECX++sBRkA2oUw1NBBxns8sVuiCCrVfFf+om/
 S87NaLubst3fM/VjQdIVSsYGTDVArsYtEAlE/OcSvHODbfILjE6M+FYS8GgzA6dmr53GgUMuy
 u6iJV5gr9Uxq/DoXFdGWWBassVxFFFJWbnqTho5xVxYc2VSFN9wDrJKkW3GTUtjhQsPiXUlrK
 1pg2/bsc9gF75YiaQetpdllUiopRjh5rPSV4LZEkl6P726u9ci0/2DI1V9yZK3eABB6wfHcwV
 Di9eH8Ypl8yZLWw9cKZv2pZHHe0gYZwMxbYStx07tW+9EbRHwLXMjI7jl/6+woy1w/nflBzYi
 ChMcESB/zEsOAua+6UksYdUHXmltgpgQP248W+RUUDggREekxiqP2+xlLSm3lILRq8vDygmS5
 zOApWIAGAmjiPNwn1pb9LgsM57wqVPjakt7/R/D6rzNAfaekG2garfj46p0/yrcoo//il46kf
 y4npZeHx6a83qmLSgtdQRd4AZSHSr3d5R2xHmWBSs6I1Rj//CmUa7oC//1ECro+bLmSlPxGdQ
 obOKEkbaA2uQw4ax7XEpcCeBvtnlAj8ixX0pJCC5GnZbX/NYBjTMjG7tevrRfZBuFV3ybAZIr
 4XywKishrC8+WsqOVFoVwgIytXKWArvf/VHx5ew==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 21 Sep 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > diff --git a/t/t3427-rebase-subtree.sh b/t/t3427-rebase-subtree.sh
> > index 79e43a370b..ba27e9d603 100755
> > --- a/t/t3427-rebase-subtree.sh
> > +++ b/t/t3427-rebase-subtree.sh
> > @@ -15,12 +15,12 @@ commit_message() {
> >  # this test script tries to document them.  First, the following comm=
it history
> >  # is generated (the onelines are shown, time flows from left to right=
):
> >  #
> > -# master1 - master2 - master3
> > +# main1 - main2 - main3
>
> The improvement between v1 and v2 made to t3200 (the previous step)
> would equally apply here, no?  IOW, master1 didn't have to have a
> name derived from master but could just have been called topic-1.
> So replacing master[0-9] with topoic[0-9] may be more appropriate
> here.

Indeed. It also has the benefit that `topic-` has exactly the same amount
of letters as `master`, therefore we need not worry about any ASCII art
that is modified (and might need realigning).

Thanks,
Dscho

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612F9C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 09:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BFD60EE2
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 09:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhKLJfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 04:35:31 -0500
Received: from mout.gmx.net ([212.227.17.21]:34997 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230510AbhKLJfb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 04:35:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636709557;
        bh=kRKAfLFnHVPmsMphzKgRwFkHK4q1oKcV2coLCNvZoPY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W5kbyxSYEoerzFFXnPAsXYz82oc5JPT4waMujzI8V6/CJlUM+NhF7ZXmz9YJRyqAi
         nrlyJleATFnyFqwGc62Y8OdZQ73Za2se+QbngP93PoET4viPy4zEj8IMkW5fZdYdsd
         8skwup4Z74yhP5DEl731gSrs2J2QMIuzuhYjiM+0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8obG-1mfZH11Q2Q-015nUH; Fri, 12
 Nov 2021 10:32:37 +0100
Date:   Fri, 12 Nov 2021 10:32:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: js/scalar, was Re: What's cooking in git.git (Nov 2021, #03;
 Tue, 9)
In-Reply-To: <xmqqczn6mtw0.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111120854060.21127@tvgsbejvaqbjf.bet>
References: <xmqqy25wygek.fsf@gitster.g> <nycvar.QRO.7.76.6.2111101343570.21127@tvgsbejvaqbjf.bet> <xmqqczn6mtw0.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qRs599k5dTBUGhiwHlDxBcm9T7ED0WFPDv0th2OpKsm0BCwkgDY
 kczr1H1FbqRgquK3O14sSQBF9mMm68yJURj3co6Rln7lEAWL1+xpSo6pO9P2hWFn2PmD69O
 IFO13jOUoe1aUX717gZnE5QPk4u3LbV5U0XkvczmslEKsoATumX5Eyxn6I/uuTBzvT1s7sB
 fDSbfHhW+UJiolRht53Lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2PU6tGCC/dM=:pOJgzhZCpgTgwyG3M1NcFS
 J5rySeAO2t1ryackroLrU72HTJuZynwUxcFkBMIjMyXSLW768ktfPcLU8YTMePaa8uIpLWts4
 CirZ2jOZsJKhKpJqZqj5axWZ8azX4evRcn7BGUIfo9Z0MYTiUkHziqd6NxM183ldWlunp5Ec6
 r6vugnpaUvxfLqmFaVZgJZbkDd/d6M8/p+zv9Rt439vgsUvdTcv+7Hf/nlPNiyHOE2nAExt/N
 36kBnF9SNJ+CJYQ2t2t1JKnrxmVoMq6mpyp+nHvCI+ZYW/yflLSMgPymbmGVP/WaSPkd++wCk
 /7RgS7CogA2iYRI8PpL3e9p7LBU7RxRCVKRWW9K9mCBl/heanUxDSqZsa187ds8a21pzILG9E
 Gi2X/XyKgV74dbsPMy7AMwfr5/55UOquXLmY6cI2MdsKRmtUJKSm4lbyly+Vw2hEnoUx0hicL
 5Z+CaYWdtFMzOcMIyLFIYMCwOTHssTzWoPvqpKPBkGvfCStqSubORVzUbzkycCJsFMJOC6Hit
 9pGVysmT9M9Ih/Hyt77BO6NwYyDkr/s8KcJvNE1xOVx65wS1j8Lj4ENhhe/lvSgaOF1m2UHd2
 KbsLsZh3P5d6Abk9vW6Cg+Jj8ocodTH5P8bXqq7ZBPTH+e4zJa8El6YkNQi4Rtrmw7bE+xYm/
 mEVtVHnmxkFtZSoZ+lYlSgoXHsRPo9GPIMKro5Ynqh2p7MDJfSWtTqdgO1PTOcFtxlRc7mPYd
 3cAtFTKO/dsuHN34EhzuHkCeCMDlcTdNLvk14G/zVJXwM5UD6HpIlxbXpUJElDAeHL6DmAAzQ
 Ge2y+7C0r7bzL8duefw5u8GRaDPm+pnzVsxTYHLId+VptgJePikYnUC0ahrvRnVdhpaEM3Bz4
 YtPv2AG9WrfIcvggRYHB0THhCxez10eTiN0Mcm4bOtKrU282AdQGkylX7ykMAE6npzaF7AYPG
 njEmQKOf8Us5Ce+IMvBBOIPoKPfajB8KEzOn+VhFAe2EpHRITAprlAJNNbzleLRsvMeJMgQiG
 x41b/uVKXaDEtfSNMR1TyaeFCf/ssJSD+Y0cXhfG6Igl4KKTfYkUApvT2Ihix1XXWX9p2Pab3
 wQFHtWf1yX41Kw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 11 Nov 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > P.S.: The second reason is that I was uncertain as to your decision
> > regarding Stolee's thread about the optimal final location for Scalar.
> > Since it seems that we can actually go forward with `contrib/scalar/`
> > even if you eventually decide you prefer another place, I plan on
> > submitting a new iteration with adjustments for v2.34.0, after that
> > release.
>
> When "make install" at the top-level of the tree starts installing
> "scalar", I'd prefer to see it outside contrib/.  That is the only
> preference I can think of right now.  Before that happens, if there is a
> way to install it, e.g. "cd contrib/scalar && make install", as long as
> it is clear that it is not yet official, I have no problems with.

Okay, I will rework the patch series so that you can call `make -C
contrib/scalar install`. It is a bit premature, but might help users try
it out.

> There is no hard rule that "git" has to be the only top-level
> command the end-user interacts with.  We already ship "gitk" and
> "git-gui" with us, and adding "scalar" to the mix is OK.  Some
> people may love it, and others may hate its design choices with
> passion, but that is the same for "gitk" and "git-gui" already.

True.

Thanks,
Dscho

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7418C433E1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EABF6195D
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhC2Nhb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:37:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:48273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231544AbhC2NhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 09:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1617025043;
        bh=C2xMoxH3l7wDK1xipj6imHygOst2pg82Jxrlxc6Mq/o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gMbtxIhZIMFrPUNecBI01VEofl8dP1DiaGo71N3AL7rrlN5vgD7SqED9Cfvp53IWa
         bzwbaHm6dNQEAszCZpflgT1YAQxB80u/prrUx1Y/L0d7QEWNHRfCCkBk3aINzohV7b
         /Rqq2pR0936cnBOJsJveHsNYERKQMjJhcjUuENFk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.207.193] ([89.1.213.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYNJq-1l5NDt28ck-00VM1a; Mon, 29
 Mar 2021 15:37:23 +0200
Date:   Mon, 29 Mar 2021 15:37:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] SECURITY: describe how to report vulnerabilities
In-Reply-To: <YF51hOQlNlBRQRcl@generichostname>
Message-ID: <nycvar.QRO.7.76.6.2103291536440.53@tvgsbejvaqbjf.bet>
References: <pull.917.git.1616796767.gitgitgadget@gmail.com> <2c9f5725d96fe45aa5d1a6bbc522f9ed6161173c.1616796767.git.gitgitgadget@gmail.com> <YF51hOQlNlBRQRcl@generichostname>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6DTMU+P5picz9K9A9FsCjWh03HdEi2lrF4y9ykfrthHxoTN3Wcm
 iUz0On8Lt+CZD8KQzwGopyoPIZaLMrbmm8r247vhRI6zxJ6Spu2Kis1HU6wObpnF+Qa2yal
 BiwokbwXrKBJwTN3rlszOG6SxMiFDdCnsRbDjGBuH+58QW2EWgdWemxnaaFosWkEuqAyqYZ
 rAW7b8OB3xqjdwaUZup4g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9xsIler38aU=:GbqSEJqRZhO8EEElwmEWRz
 vW/NEIbSSnlIRThr0L6CvgfZgGExA11z9s5loDstjkfyV8d02IV6AxJDq0zBYbD/pXf35gBVB
 ZmR8bvbSgp4yfUBgda77qujxLCYs81yISn2ZP4Wzd6m5DwaOimk833mDzgjGb6usfjTSj57ec
 9+mVYZhh231yWBBgKbq4g+mQIlyDie1ZNvtcjhXtv2gVz4bus6DHmfsTRdZQZLSylx2jEqZhf
 +Bz3cjtlFxoxZAPnSVfWtiV1hUG3CkRUsoa+UJIniFOqLwxnNCjqeGeRVvnNLyodH6N6s4KR2
 50Trd6vpT6rsiJt+sl13FulzbeyF7q1IehZim/xodf07dANkGbcC+Qh9V0PwgfJ0ShYgs7Onp
 /VdTpKqeBEjoDHel0JoMfwpN0QXfdx8c3hdTxsxpepmyyPxATkNfz5RiNUxTI0pNiXIYf/ApO
 /1GqPGM2B3uAQNEK5FTZZVAeQ9uRfJsiLM7nVeIz/Va7QedHhwRyF39ZfToFM8+wo5ZGzMZR6
 YLkv6yi0rUAoMsSrLvnpM+UnCqyorwCYPkoEgd14JmVsW990cRuLKDiHbgbRim/cDKnfevayw
 4LCwB6WGnjkPAegc3txWNNitWqd8K4GmRfTqSyvw6daf/BKU3/3PK+XUBHOcHgWc2ktngvZPH
 VT5d8kR7XMyMwbYMiTRgcIHosQC3iU0c1ljyhcJOFMF2d9cKwvbWvz3320BqjItFSyWERoi6+
 NjB3cH8oO9JfmUKuEWrYxtXVe+MnPw8Ui2RcIbpk7CY4gDqjEJnLyYhwr0U/UoR3G0wE7j/J4
 zxO3wqQwuhH0ZsA/+cc+xCcTTUhSx1H3jPNWHmvaIOC+YS8HB+Nd5qtnYcxHBgBYQswGEuYyC
 xPcvdm+QQLOFHHKn/dxdT+Xqt5Bn4bX2s+tn2fviTJMS1qWMOeTxXIsA7ihZ5Qt0HsV9pOS/b
 o0J1q7V11sWsyiN/89yhuDimnpzd4oxXwq/O5mycOQmXJNfEDtCSL3IS2/zG09AZLxCt3aMYU
 rE2yFsoUStSOrqse+dQnndK1cHX3/EqYbWkQ8XfnbNK1FrbaA+8ryeNIrKk7ahq8BGsK4hA3L
 woZ19LJi/HSkTBHI1W+d9Xdpt1smNXH/gazHBYDg5TboLYj2sg5eF1HAlo/bjcdXi/gUEYpB8
 qR799ZEs5c29Ux9DE8dCJjxUsoFKV1pkU/YOIVRiKdWD26/DY0EHYt9OLM3lyRSlwTh+pLpnb
 /f6hjth3D8qbBZpKj
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Fri, 26 Mar 2021, Denton Liu wrote:

> On Fri, Mar 26, 2021 at 10:12:45PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > [...]
> >
> > +
> > +Examples for details to include:
> > +
> > +- Ideally a short description (or a script) to demonstrate an
> > +  exploit.
> > +- The affected platforms and scenarios (the vulnerability might
> > +  only affect setups with case-sensitiv file systems, for
>
> Small typo: s/sensitiv/&e/

Thanks! Fixed in v2.

Ciao,
Dscho

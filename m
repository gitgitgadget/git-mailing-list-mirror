Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D612C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA79B61100
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 10:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhIIK4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 06:56:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:57871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232903AbhIIK4G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 06:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631184893;
        bh=xLRrpMYTlaWJanXCim+3TsGDPdR9MQPGqFziDDWrfNQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=B3F41jVh3SUbCYxVIVOf3v/pRd8dK60QmedSeF1FvQX8QGczmSrh+FuGHB1Gvk0Cc
         ls7JLxVDNEY3LxdMyQtMoL/3Px30GqQo25rMLJI5QtCd1kMyTZHKuZoQZVH4GV1a0x
         7lyaXNfIH3B+zHTtY//cJlmNgDMofy4Ko2trcKSw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MKKUp-1mezTP3Zr5-00LlNw; Thu, 09
 Sep 2021 12:54:52 +0200
Date:   Thu, 9 Sep 2021 12:54:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 5/5] rebase: remove unused parameter
In-Reply-To: <c8a92d4242b4dfad71297d1eec9c3ef658641193.1631108472.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109091254010.59@tvgsbejvaqbjf.bet>
References: <pull.1034.git.1631108472.gitgitgadget@gmail.com> <c8a92d4242b4dfad71297d1eec9c3ef658641193.1631108472.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bLImUMx7Wum+lXB16nj9tZAwIEhwVPg03Evt5l1z6AwHyqHBZPo
 KF2XqEKkPfZ2Xb2waz+jWtViJr1C7Z/rZfMSlU+bojoReutgiNPkUSWXUzbHpHLn9VW23V1
 8A2YHLMmtcvT7hh+8hOOzeooaRpDoTsboaTKdwWCwtishO4Bd3BM+CUllTRvkPIAkHTzffz
 Z3+cKpBrURoNxzOTBd9Ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WRqdTyFfGg0=:PKVqqPQw5qMvfUboSAqSt/
 OgyL1USxwahuZu62yEvRTFNuFtbmv7Prk9+TCfgb572mGfFCyrLNTkoQBGjLDXg6ZlgTkfaoU
 HdJNRpEJPOVuM6/F7g+0eYTfojamyT3DbTWM30bu2jCdhxoxvmDAH0hJuttK9+NUdDfASnTgv
 1k0meyglbmz/58RDE3tsSqXqdJ5jcsOc78Eau7B9qfIA0euMeIvWtJZspqh/OyU+Mg4niyyb1
 nXZAsjZCKBIGGTfijBM04AhaCek6v4Z/xpqAwe4zgpOFK8OlQgAR/7TyE0p6OpWNoqgcoWLtq
 yqzzBc9tcmkwTqPViBXpuQ8rxeBDmLFgStqq0vjHZvF48KbZFQk3HF0/0RkJ5stU0BDbBg2D4
 AtImsHuDx3eF0eK71fjW7WLRquKCnEDRAcIEcxbilfTSiGoK4yuMbZraHAN48m4JjGG6LJF5f
 e1lR8BkaG/+J3bfigncqGe9xvmUWtz+NFG2RnXBZ/1QsIRBxhmAmpXgrcQoZyrb2opBcibSOX
 VCtmYHBMhV9m0vre9TPuptVS5Mg8KehPHems9tCwc0WCkzO88iSWq2lwuGQWS5KmGkMlkC+yC
 0eudR+KG6x0r8EqzJTG39Vns8zv9eVYLTeybclyTnj3d7olLq/b91a348Fdmy4kFbSmveH7rK
 uC1EoU9I0Pfg7LwSmHtGhQ/CGdP6G6IopvgnFGz9usm0zzQ1Ad9Dj1wdpLO2cb+TttinqP4Sa
 qckFeVCq7TixLl0691lNWS5MjEmAAWvsVdW+Ar94Yh33Y8ZDe+kA96LRzt1RILo1izpb0Tjdz
 tJVJt6cxC2FcE/8mqnWwqTeGszsehBpYj74DSvLjAmCYKynRmPFB+YmE7ODtsiNBujI4XqXSO
 aNbjEKzuJeWeRtbxkoNna4ULCBisgfTqJZbazRQJsG3+CG5QWoPz2JQCuZ0BEgR1AzDfx8zTE
 ygWWpOAUcNyjg05o138ImHiZ/L3rtXh22c+rBGIWf030xOTvJxyR/7j/l5W4Q/2R6gn6Y8TZ1
 D7QddxxjKQN5gfgaqvm4VOEVZSAX1PHPKmtCi0P/MWxrhBNd1Nqou/U2oFRPFc3k2XuubgHhk
 q0dPW3ATcUGb88=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Wed, 8 Sep 2021, Phillip Wood via GitGitGadget wrote:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Now that we use reset_head() we don't need to pass orig_head around.

Does this indicate a change in behavior? When we call `update_ref()` with
the original `HEAD`, we get some version of safety in that it will fail if
anything changed the ref in an unexpected way in the meantime.

Ciao,
Dscho

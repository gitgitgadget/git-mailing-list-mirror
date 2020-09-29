Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2F0C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 13:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB2E208FE
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 13:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FOtpsXnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgI2NFt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 09:05:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:54965 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728675AbgI2NFs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 09:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601384742;
        bh=+NqPLfB1aBK05IpnZnp5ZcMkwAzYkeGbP1KDPHQg/XI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FOtpsXnWE4z+pNT1fzbc/HQHsxFFwiUBxIjVal1cfRdCk78Xcnj8bW4okj980riT3
         LfqnS+3f6tzs/MAkViIQtGJIp8XAFK9hgR7fd1doczsdYHmPDc1AKZaliuLodO6x1o
         0FYzuwLa6WMn9QiNlG0JhePm7M+bJPMkzD+E3FDQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.214.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mlw3N-1kmvMD11F5-00j1GF; Tue, 29
 Sep 2020 15:05:42 +0200
Date:   Tue, 29 Sep 2020 14:07:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
Subject: Re: [PATCH v3 11/11] cmake: fix typo in message when `msgfmt` was
 not found
In-Reply-To: <xmqqtuvhk0vy.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009291407130.50@tvgsbejvaqbjf.bet>
References: <pull.738.v2.git.1601155970.gitgitgadget@gmail.com> <pull.738.v3.git.1601327357.gitgitgadget@gmail.com> <c3e235fe39b41b90a8a00d81220cb28e83580f13.1601327357.git.gitgitgadget@gmail.com> <xmqqtuvhk0vy.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nae0jzLysTU2dlOXA7Iep+XMsoY8GP3Mn3U+7yNCqw1PRdgPoBU
 WQD6+T5aYSOAqM6MV4t+nvOz052QFhq0Qap9U+ErGy/c5B7zWDuCPZQmB+s8pX2ZIFZMbuv
 z57Ye8VaIGu2dS5D/sDvymKgUSEXUhLk3PHxk8392D8VkzbwNboLyimo06r5ffcVJjqtdxK
 YhMlvBfjO3bKYsIIgo4bw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uW/njR8b1Ko=:WjrRiysv87AXU4o/AIppeU
 xN6NgAiDUQfr547Rs+ZSPRjYvAtE9Lrr3zRt0y1b1TEHUxl69jWCPc1nGo0R/l24v7pepjJYJ
 8tIqYv4zZdifeTijBhG3uktTu1CjUNGmNsg8OiE8E3oNu/FgxFMuwSn7+BW12zSZMPukeN2ve
 9hxGKbELS342PWXiJCPHjk8BPpqbV2/jGjiAK+ATEw3sihQb7oitUt3cGnvOEN/0oab3VmNEp
 p8CpOzM7WsVkjD8obwTU3yn84d4Et81s6PJ/J/N72HBFGlrodOUi0oggLJ591tdxZqYLvUC0V
 RVIUGZWPBHHxaPiH3pTzsxHIc12MKeHQQbGL3rAlqPq8R1hNIUZDLhXOtqCloptx4bUSMPP4j
 9SVjsrgxfQiWQTZGlmjXCnnaqxiVEQQ4S7Cf8CvGmxFoUVNZWy2YWEcquXZdS4Q7DPE23fxrM
 q8IEO93e/PEaPErvvVzAQbZ2vQZ4scDd5/U3+qGXh2uw/gNB/GnBHkR1Eb8VVYNvrli+rf/rp
 YWeyREB785ey6hN/93Tuxt1l17+FrRtcQiBMQZLAp/8HVsCO73LUeUXIGqwRy6+ocLGuFDOsO
 Kq/Qsb2+nKd2d0l3olCsmTDzLbgn0x9aWPq1qRSwH+yDgXtYbumFYxmEvHaJse8hAZj6KIUQM
 npX4BuenV2168Pr/S2YgDQVh7/Ai4jueliZGm0TSRK4domYjHKABwCLot7n3lJByejdgAEyXn
 gWnXt2KG9uAEJ6jqLK16bp6RGYmlH7YLqkQtZNVRKRCR0ZywomBI3+pqVGPWVj1of34xALswl
 HBXsYys1meMrpqqPWio7YzCtXJzkn2REZRBQI5AOvGq4XF+UvAFiVOlfQC8RLgF751OzrA+vp
 L45R7UgAfgM+NDpNDD3tQTCfds/ZEAtQOaIwJ6aaa8tyfcVH+0GI7O216ob87g1Ahfcmi0JhB
 PUY39d1BdzHu1hsI6BbNb9Xa0+SL4fic5qcIupeA23uCrFgiUs/mG7zfA0qhAMTDrgpsZTajo
 /g2bA588SALnAzBimfIO4jEqg8Dy1H8j325lCbsy41TucwIdYSBn1Llr8MLppH97CoFgrV37w
 nX1tcvcJcvrv11pRzymXJPj3xntAOjkMuNSApEArq5mQPdVm1X6/ZSlTec4kK+BtSqOy3l95T
 3hplC33U88bo141aR631KrLi9v//Jdskvy98JoDt342oj7sia+E1pO+UsYtZOqcC1M1Br2e0j
 DlfrMhOfUUwZjG5f3xLBeKAXkPCStcoJd9eAwhw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 28 Sep 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
>
> Shouldn't this be squashed into the step being fixed, which is part
> of this series?  Would it be the "fall back to using..." step (4/11)?

Oy. I did not even realize that it was _my_ typo. Fixed in my branch. I'll
wait a little, just in case that anything else needs to be fixed, before
sending the next iteration.

Ciao,
Dscho

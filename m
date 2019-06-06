Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633571F462
	for <e@80x24.org>; Thu,  6 Jun 2019 12:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfFFMsw (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 08:48:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:49811 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFMsw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 08:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559825329;
        bh=cwpcksP7I+f4ZSM63qTSpfN12M0n6CVvMtFFf8S1T/8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EG5DkQOKzPgmY3KKNJ8CFSB1U3v9Y1C8e514FXtd7LQMaljMCUZ9BcTZZ1JgJrQ8R
         YV8R6pyWcQoiHCiGLLlO8lX/380dfKYEjmQayDJSlNRe7Fl5U5YC6WxemaMaVeDJqo
         2GWQMbwwh2V9F7ZDccuvDreidc8wrLN63ENblgDA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LobGI-1gtlNL2GpG-00gbKs; Thu, 06
 Jun 2019 14:48:49 +0200
Date:   Thu, 6 Jun 2019 14:48:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Doc: document alias accepting non-command first
 word
In-Reply-To: <cover.1559755652.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906061448350.42@tvgsbejvaqbjf.bet>
References: <cover.1559333840.git.liu.denton@gmail.com> <cover.1559755652.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jzmTi5qcHRkw84+8If5Ba+bMx8VWKPZqCFEsBNQlVkfnQ8PqbIt
 2bWAe0ZdXEQ0R6N3FyCKsoE2aTJDbjLrlPuYPo5tx1fUlYiGmOG5vUz1cpqDlXOMynHd7d5
 F12tPUypgRPbY42bj80fGjvrjKM92byAGQIOHj8dTSEhhUucujKr5nl5z1MuScNgo21nOtU
 erXisBFhu1iEDQSXmSR3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w7b1NcN1Vwg=:MntHDTYL79L3As4+buZ65Q
 1zUQcnINsV1pb5fEyU++0T3Ds/y1MKanPnHyW9Fk408N0esk1aPYZlLyDtSE8mAhPPz5OYzla
 v2Ih36nJVdjZd4j0sUVQ/FjcmtPdz+aOiKTWWWP9z0tjO4Hw4Dcs1amFfG7mUMIIstmzuFjj2
 uhac+3AyPgLCdkfGT/4jWAzdwqqQkLQZhNlKOMW74qnj9iwtToxgTsYp1whXfZjyjH/187SVB
 SoPirYSUyjLcjN6A973qiawKjbM16rrh8CMRRBCTufbYmagNDRDVgQhUgA4hRirnScZsob/bj
 jlQIWQUWxs7gflDT1wyTFc/AbHMgJs8O7Mot36luyWtAFZNCagnevy70sHHnv+R4duQe0ydrW
 6cX1uSoRdhs/Ax8i72GqMdgkohRqfI+Rav4E47xqwza6oN9tILwyVwHqXa+skPxy8l34+AHyB
 r4D3aZ1yArvseNaF3dffw3i8NV+J1vpesoTbh747KaVtjydW+db8gRnX8i6WNWEbSMXyAApLp
 e8zrA9gRiB3NN63YTyFW1J5Q5/7PGLHdA/NgZaf/Y8I9udhpznBK4YmJCMGi8urzDCmtdSdaQ
 Crz60pY7YEng+9T5s3tnSY3UW3Ce4giHbJwazD9wxsecHRY235lbuaPx4FoTIfLaFjWtntVRr
 BctjsxjDX1cLh5iW2pckk4iY7vCxg0IRG6MTK2B2a9N4hDcKBydWGiFtrlhBYnW2YYl51hAOk
 wk2N4+H82uQ9YUFwY0xNrUYC6wSucw8ix247HqnrtKjs61Qvj/8Sb9bcRqLmQtmVCRLCBpGlM
 SeuSviWuwSL9+CzR+P6ILL8P8w8cb2HKPLWRT4wh0r4gNxKlck1TUbD0x988+FmAI+mlk9PgD
 BJ07GDQofVZOVO233fGze4wYou0OETVltmnV9iqc2qB44VAecc7N0spW3+zBXmu1opZLV3GG2
 hzS58n+H8U3Pt+7ACqrPfYBzEyyjy+Y+8m/tSi8r/cwwIHO0Humq/
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Wed, 5 Jun 2019, Denton Liu wrote:

> Thanks for the review, Johannes. I think it's a good idea to add another
> alias for `-p` so included that suggestion. Also, while I was at it, I
> found a typo so I fixed that too.
>
> Changes since v1:
>
> * s/loud-merge/loud-rebase/
> * Add `-p` as another example since that was Dscho's original use-case

Looks good to me!
Dscho

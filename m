Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897341F463
	for <e@80x24.org>; Wed, 11 Sep 2019 12:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfIKMBj (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 08:01:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:51591 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfIKMBj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 08:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568203289;
        bh=npNzrbfCRoffmDqann2eLRuDnwtkxnFrw1WYGYubkYA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TuXTfbhR7DFCUNYJ/kE0y/16HjBNUuhxHfndo1GimvEHko/2qXTWb8l625VHeSw9n
         xirSc0BgBghpGYfjbKxHTBbF70q8PHZ4AnCBidxI4J9nFqGmMDzL/RMW5qa8cJScKl
         xZ29UlO9WEjRSOFBMC7DBZp5e+NGqQP6wJr1htPk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MbrR4-1hs0Mh2sAI-00JNGP; Wed, 11
 Sep 2019 14:01:29 +0200
Date:   Wed, 11 Sep 2019 14:01:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>,
        Palmer Dabbelt <palmer@sifive.com>
cc:     git@vger.kernel.org
Subject: pd/fetch-jobs, was Re: What's cooking in git.git (Sep 2019, #01;
 Sat, 7)
In-Reply-To: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1909111359150.5377@tvgsbejvaqbjf.bet>
References: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Gw0yEC7BX+CG4DZARotqrtE4T5bxsNv4eTGHdna6K++hRx9rpU4
 oych46i4NLlQilKT++3I0HArkJ6IYCscLgdgowLd7O81iveSFOuw4UcyZarV23u1u0W52j9
 KV0IoW1n6XcVViDA3WoMlZQ6vndvSQIFaJkYhDTbdcEHSaXcp1MVmsMxg5t3tGUOva0yFne
 GomGShquSSIBD6o6qTWew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G1QyrtnfMgE=:5E6KH5rcjoIcex1RRuVd5L
 TLo1qR3I95eH2fV6y1OzbVl1RnCoGpUTcZunduB21PIKa8U3qdCU2NicgWrqzR4xK9FJ+8/la
 7+Wpxosuh/7qDxguiq87vMEcRczeqPkjKD+z3lxWBa5AMrt25y4ao5rw913No4jFjOxoyu8Zw
 liu2KLxSF5Q59WwQAvNwaGduqGe9ZNHeAV3G273nZyIKGApMAnWA0Aa5qL6LzCNaAFoDOOOuk
 0nzgeumw/U+GAxZJRstF4QzcIXm8CnQaOaDwGYrCZMPJZ5YUPe5mZ9NNkyF3A4zncmTCIsKx7
 rn9bK+24zp2+6rtpTr9RwkU28tP6xEbnvDNDfF/MbICvf2DeydDgvxkdVq1KMKOnT7AO5MNFT
 ORZe8mSo5AbAZjci/udDV9NugooDluj96K70Xe92yub7pUiCsEna9x25XRoHr8vYcaDxp8A0+
 2I5JtRVSYoYwPmanPrk7+edmth4vxvyWTYEFNHun6uhJkgb8qiX3eFy7nsOdZG1+WpTgpJCAf
 6j9Wo4Uwkt7J+PaysrHqB/EyT1B0hk1KV+aVUsrDSgBc5eGD+IKliScKBUpAmsT2zGwN+vcAv
 3Fxu+wlaILHdB7GM5TDHEATZDHzB3005popYvxtvsHtbzjQAm1PGKrfAPQ3+ss6N0tGNGcOEn
 kxO2IgkYsvOqdh2uIH9/fif9AXVqHOKt7m3pvahxagnKNNNkPf3c4iML4T2VxDHaJ8HGvDm0G
 cBZXVOQYC7PNgfYrnUdHQk76CEB8Z9shrVv5FYuqlaQ9JcoL+0priNcQecR5kXfnIX0bqWy/s
 SQ54N6bs0CPQLKVyLv8p+zuf8jtvLoJojSZBtj5z0DmLAw9XI3eyPOAiQhuq0FsUOts77VlX1
 JpgNOrens+PdBXx6TV6Z4PCv+yE4MIwmvSkeIma525MXDfa5pMlY0GG2IU8q8WE+O9Nlcr43O
 IkGpY05xJGBBYtp7q2S7HeS4461R2pSzb2HeoD6kC1TxA6TV5eT3nbAPgDCiwo4CKLQzpJtOU
 dgZDBPkHL28SWYoQfCooD+RI/6kFMjVUm4AD1GrIU3Ow69nz3GB01ktZoW1jFaeJrjv9jCdbd
 solEnipsZiuBHnTdBWNs3LgvioZrK3iZnp3Siezio60zqqgrAj5JGriRqor6rrVUAoyf8aQ26
 0Vez8wv/wQTU5j5MSiU3nHvceWISJbWQdf17QyW4nU1+OfGNQ3oNfxtrJ/oTJ9e+YdCcieDB9
 +Nr4IpxNhK+4sW6Nu
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 7 Sep 2019, Junio C Hamano wrote:

> * pd/fetch-jobs (2019-08-13) 5 commits
>  . fetch: make --jobs control submodules and remotes
>  . fetch: add the --submodule-fetch-jobs option
>  . fetch: add the fetch.jobs config key
>  . fetch: add the "--fetch-jobs" option
>  . fetch: rename max_children to max_children_for_submodules
>
>  "git fetch --jobs" is getting taught to also run fetch jobs in
>  parallel when fetching from multiple remote repositories.
>
>  Comments?

I still stand by my suggestion that it is undesirable (and makes the
code much more complicated than necessary) to end up with three options.
Having only `--jobs=3D<n>` would be the ideal solution.

Ciao,
Dscho

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D31FC433F5
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76EF661102
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 21:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347372AbhIGVmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 17:42:45 -0400
Received: from mout.gmx.net ([212.227.15.19]:44339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347360AbhIGVmo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 17:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631050894;
        bh=F5n7cPU0UC1ueKmuTDgVpXKqYRGOqw5H5zOTegVOMDM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Ou1sCP3NWx3ILw7tiFZqXx+cF5rnBmA/gc0KG4JoULJtT1G4N8pzgBoyrW/6KYYzT
         inHS9xI6ejXkqow/JedYdmmt488NMEeGB0cpEpYLJoBmCa+T2mChmwxIOPjlvL4jZ7
         r2vCRkpXEt2k9buvW1rIt9DlOvQ+CtQbPY6+BQ2Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([213.196.213.44]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26rD-1mPdie3PRp-002ZRn; Tue, 07
 Sep 2021 23:41:33 +0200
Date:   Tue, 7 Sep 2021 23:41:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Sibi Siddharthan <sibisiv.siddharthan@gmail.com>
Subject: Re: [PATCH] test-tool run-command: remove dead "testsuite" code
In-Reply-To: <patch-1.1-d1e464da0a9-20210906T002938Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109072339550.55@tvgsbejvaqbjf.bet>
References: <patch-1.1-d1e464da0a9-20210906T002938Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-453903156-1631050910=:55"
X-Provags-ID: V03:K1:nwQnKa/kk+oUgDEYIfFF+bGVZWpL1VwXzHpfSWs4ANZDKVskwfQ
 XTYoFoqkKaBplsla6kBJaK3p01ZjQfVXrLxVdwF92bnjlneJSn+zHlNEcD50JWED/83ZOJf
 ImKlnSDUlZH80ahbPpgRr18FAIJhXobsV+ZzTAEvM4t3OJ1wXOPIWc9eVYBagcT5fTXIgo4
 nVNBM7rUwBdKGguuEBXxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4Bmdr3zS5vg=:sQ57t9b/1Bou1Ovv23PsON
 PUqmbSAkDW9LUGipqm3O/3qKLXk+MB3BxhNfnhJ6EIuuMYgWIgri8uA1FJnm80GIimVxpIC8M
 FCSMw0+juppiD5nEL/xH+r10FgxQS9G8UCXL5JcjU/ahb7R9lX4CUmdzPXBKGBbPrjwqB+U5Q
 p5GQBnNdd6MJoUxaJBoIKuos5kEttGPJ9U/BwvnLSvtgHxvj6SvsxjW1KrDQznRaFAjDiaaz5
 MFgl5GUtm5RX57DQvXb/ZCdIv7mv60SSXfpKCqfnD8y/P8+cCewtYjzY7G7+FRJqTcQsRW/ZV
 BtdU9gtbTH5r+mdZmJ3WWDrGDehvyhWBmFTs2qA6ZwdYQM2/0kvCwqNeLL8+RjRoGK09KKJo1
 TCGic8Yq7ho99ge9VWrq1BJdtDdJ4wtg+Y3PnYt8fadnqxtEfzwlHyJe7oCRfBnMQ2/7ZpnRh
 K58N+kGmardu9h0F6IJaQZF4EDA5sCZQzXrn4PtzGGz4QWeqnvaqoyDsH2RL9y1g7jpbkncrm
 POupdCQvd7Gd0SYkIdMCAmaMbssT+wkveeVyV1dVAjnQ0jnk0msJUgxZFekzT/Vtc2t4hO2ll
 Plh9elDQNO7K4/uUBnVd5U3fALE8moGOgADFK1EKbsQR8MGVsW5VSz3KD279aFu+4NnFo65dL
 yC2E2ukiJD+az0TltHoglUZVsrNZwTxCJps7nyleQkRypX7k209HCwWhsxN3X0pQQ+fw8lvjN
 +G3TMsN5LIUIjUz67C3fRcECtSIvnKdZkI1QXGJQ24yTa7jyEywaFoBwNBBOQmtp9d2fdyC7t
 sHqdCQW+nCRX4pUVnxJF3uWMmkpmHVZtPtTG6f0pcMdZhlovaw63M8pi8lvYRp2DCgl9zEkf3
 tky/bMkrABm1N98wfl51Giu89yJBoxuqJTmuDYD00ik6v5GKn3zfxoCYde/9HZXK1fI/tNAEn
 tXYPF5fiI806FE5zpk46lMjmiaIV+hhyYQakm8h54phQjWYKsFrOp3gOrPL3114lMhiwIW9Du
 P/qhVpRM09St+BD1VFyKzfpsSzIIL8H7Beq7aDMLWyB55EVLCczcocgVfEUCUjGhX45aKfyhK
 QqA+B5Th7e++z1Rk+RJDGxQ6gg0vXFGEKop5EjiSjoIRnohsqX8elKrlA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-453903156-1631050910=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 6 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Remove the "test-tool run-command testsuite" sub-sub-command, it has
> not been used since 4c2c38e800f (ci: modification of main.yml to use
> cmake for vs-build job, 2020-06-26), see also the earlier
> 6081d3898fe (ci: retire the Azure Pipelines definition, 2020-04-11)
> for another phasing out of the command.

Sure, the code is currently unused, but I had hoped to use it when
BusyBox-w32 support in Git for Windows would be more robust.

Ciao,
Johannes

--8323328-453903156-1631050910=:55--

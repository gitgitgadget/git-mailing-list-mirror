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
	by dcvr.yhbt.net (Postfix) with ESMTP id E4EDD1F462
	for <e@80x24.org>; Thu,  6 Jun 2019 12:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbfFFMwq (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 08:52:46 -0400
Received: from mout.gmx.net ([212.227.15.15]:46301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbfFFMwq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 08:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559825561;
        bh=pRYy2CV1qUipaepAzEjDkunGACiLm2vhsu1o9x24ihM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=OxJgxVtRopwhQcmGfmYJA1ovY3uW9ro78CdCIotAyAbfuzTacJNPCD/M2pDpjdOW+
         FdrP9LjWfX+H3XzE21V+h/rzZvb4S+2TcOf8h7ZgUmtrurUOAcao6kfx0oPdoYzzt0
         L+7L+xLIJ8eaRrRHxjSC42uAJKQk2IIaHiwNWDPQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MEFlg-1hJVoH2Fjc-00FOok; Thu, 06
 Jun 2019 14:52:41 +0200
Date:   Thu, 6 Jun 2019 14:52:42 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] config: learn the "onbranch:" includeIf condition
In-Reply-To: <49e22269d5a66d1975fca71a300e9099f46e1c40.1559769658.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906061452130.42@tvgsbejvaqbjf.bet>
References: <3573995264441c50ea9529b3ee926d1ed3ec4ac8.1559330905.git.liu.denton@gmail.com> <49e22269d5a66d1975fca71a300e9099f46e1c40.1559769658.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZLXdh/j66tc+oguPSKLQj8GMuEDJHfqmgNsObeocQEeGQlZE/St
 PH2eiY5RVSQ0bNDJvO9pHqf0V6CExrwIc0/M7hzjtfr9ZK2eeSW8AFz50XgIjAUAgPIzWh2
 usOjTxWok9614lZhqkT7dHr/dpWGNQfVWrH6bQeQ5v+NF7ApVmWmUX3tpvPRliVhZO07Sd5
 aUOQn/isJQlxRptQKDohw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yeahmhzBEH0=:1r60IdsP9sgUHokAczs7iQ
 jAbPmLhQ0zWoQNt/qbnw8hy/P/7FfXxp12+ioakNldFLaA0dYS4Szbvb7xeNK12Z51doMqF3W
 8UgxmFP3oBZtr6BeMmlNsQCNcG8eaTmrZ7IUJp7/rsLYC33mQg4lJKME6Ie9xoxXWqZO2jcRZ
 6wP72pQion0A0vZtPT38cUFCj6ajXbVroCpSFjt+zxOLZmNiFTM2vyjRCxwivughN9GwR/adM
 e1ztHbZIbDjeu2RPz4arAwW/hpcdv2UZvtycYhtbHC0LTGb/i1dTQkHxiZesNiOShiW4Cu+u3
 kYhrh8FDNdA59OBFe/VI4OQpLGQInLcLbpaOZH9HjZyArlqui73mpVAXphiZJUO+PUTK2uYw1
 UPqsm/kEeqmoREXUMK6MVczXxxtGrPh63kfJyRzByLfAE9q5hjEPkNOvaP/ujnaUU0BH1gibo
 qfhKkGwyqv97DO7qqfEDnPHHAV5ewpQo5D5/Kqn6MGssnmoyJv6uabXrgoUSJr2Zc7BV07Tvg
 aoLvPh0m5LJvOfjzLeg3uQgyX37gB2fI2NPN7iMWBiEOf3NAfseqUpPi1qmKTJXv47EZCq9ci
 bQObnMqP0BZFnpL4Z2kJiDcdyp+Kx9bNdy8r4Uadfb8/uVMSuxVk8ZvCKoEX0UMMsfyLgAFTQ
 CzM8xvmUBhoQAkjLkoH0WSMyT1+0lXR3VUeFAgj6R+xb0L3PIg1ZKd0C3bhvZdXnaD1BFs4cY
 F6JAnyimwhD6TWvsC7tcWsTLaZuPxBIyLE00qFKPBkL+i5xspjKwr8//vdadK3ThB+4WxvDi5
 R163SwhANR8S/RGDwrqnWD7WQD2VQmpR9v8Bp+NDjWlPivR6QUdVw33Kci00D5qvvYAXunVeh
 4HV9JNadDaSe/UTE0HgCZJuasjoX9HdESJCb0P7PvtWF2GsPV3017dabbvhHj8/B2LD+1QJyv
 XaSwPGRuhgdHzsflH5KLa+Hgj2x0ZwSNE5+2Xhr0bLeSW62V8vCAz
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Denton,

On Wed, 5 Jun 2019, Denton Liu wrote:

> Currently, if a user wishes to have individual settings per branch, they
> are required to manually keep track of the settings in their head and
> manually set the options on the command-line or change the config at
> each branch.
>
> Teach config the "onbranch:" includeIf condition so that it can
> conditionally include configuration files if the branch that is checked
> out in the current worktree matches the pattern given.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> Thanks for the review, Johannes and Duy. I've incorporated both of your
> suggestions into this round.
>
> Notes:
>     Changes since v2:
>
>     * Run test-cases outside foo/ since the subdirectory is not necessar=
y

That should indeed take care of my concern. Thank you!
Dscho

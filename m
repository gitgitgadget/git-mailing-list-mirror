Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01C541F461
	for <e@80x24.org>; Fri, 17 May 2019 18:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfEQSaX (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 14:30:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:45867 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbfEQSaX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 14:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558117815;
        bh=HvLJuzAvxdFU0IXD3rhxlgWI1/vl5jGjuVk91bAIVsk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aJm9okW+xNqCTjOZPdJxBRGcNtpZOng1h+VwmSLvJP2bhxX6MFCP6iKwQdNbHnj82
         22rIc1WmUZnCF5N+BOhFA/3sxQteaV60XMgGGFOtgFt1KqlicuFfO9tbeiLNNftNQv
         bz0y7iTyEtvYqyKgYrnnYBhuT5osMtVfc5LFAC0A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Me8RK-1h1l2f2Yak-00Psdr; Fri, 17
 May 2019 20:30:15 +0200
Date:   Fri, 17 May 2019 20:30:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 1/1] stash: document stash.useBuiltin
In-Reply-To: <xmqqo9445cba.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905172030050.46@tvgsbejvaqbjf.bet>
References: <pull.193.git.gitgitgadget@gmail.com> <6c250451658f34c1415bfcba35ee6303cecac0dc.1557825553.git.gitgitgadget@gmail.com> <CAPig+cRoyOJrEuVY109NKafTCUc399p9tk64L9sZok=AOZ1MPg@mail.gmail.com> <nycvar.QRO.7.76.6.1905151025580.44@tvgsbejvaqbjf.bet>
 <xmqqo9445cba.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mWs41DnKaBbV74Ac1Zj+FjcHUyGJAtWVxXAi2zTuVCfvzThU4Bj
 ql2NhICDhlsGhfRe2DMZfiHyIkF7vsstWktx/grZvM0cjWB/N6k7plXAhCEFoRiuf/wgiEG
 RwZ2KZuX/50FUvv7Ntq0FJchv0pJJGq+k/udYDqAU10zAXyu3KvDjY9HF7lwGsRnCCpFT/6
 BfSUeIVca1AYOXtP9IG6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vABglpDE/54=:RsOyZqG//X9WZy7IiG28Oj
 xc9+Ja7b0Pnco87L8Znf7K6AwPhzznZST07aeo3KxojnaEPqBysT5TJzKVBhuP4L7avUitzXs
 EHd1+q76cI33iYcLRn4WV0j3C3tTUjASx5giKzK9WssquW8tFfjKN8PEoo6acNovA16sSQyPk
 JX4AJ/sPU1dvOGoqfsd6ARYBEkTyK3cQ5l0Za1NWSlu+i0ph9eDWxj2EhdhqZ88KW5M7e9waF
 ZdiU01UQu/jWO081lNvNzws8iSGoxdUdsoUeGatTV7ScikTx/TGhkyY1GXXzohewK1LNkhceh
 +mwPUlUVLPOMItidiK6prrIW0r+XI7CY0SSuKbeUkHSbfdunEA9cyBxzWS7zOb/hRCFH9KGuF
 uVXUeL0yYXV14P8bgYEycJjezVMvz/ycEJ/hMxfMI5H0FYEsr2ISprKF/3KlcBoWiYTs+soCr
 b/bynKSR0Ue5bdemBENTYZE6ZzM5HzWBycQ6+eme4UT3Fc3JImDoKxC2i6vQxci62XXUD9cTj
 mto7vCjlkNHGS7VvQR/2/ibeVRbELfAElnpKUIiv1UEvt7xpHWPGqS3jlrty+0ODJu4GRizeh
 cLldT7ZnELRaXav2yn+0tbYxOQQ2nNmw7PoEcKUUF1rEWGfQdbJ3yRf7jGlRniqn+18h8Yo6b
 USQOOCnpQNx4oa/Eez1pLiuY/avzMMPqgvHePDGV9sGiUIltHA7fvz3JCuPZNBFS7au6S/Gzo
 numgSphDZSwLcuTbHXsZDgZnI0G52YltmHPFtgdDPORrxqV37l0VrhJ51IIJrpyqfNb2/818C
 gPTtks9OjithE2tlF+ernmW5fBG2QA5Y4CRnY4Bz5SoMUVgNeXwD1xs8C3uk9L+ou8HBIZ5XK
 ebszXN8tHo6JVtYhoXw4SSi30g0VsMy94CaCgUnws/zI+II/ourLgSLoZeFsSAGMR5m9KCPDc
 uqwdJYPUotFpuK6jI59cT/RQmwA2VAdOkqkxG+g+KYXgthOmxORNl
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 15 May 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> See a few nits below, none of which are necessarily worth a re-roll.
> >
> > Thanks!
> >
> > Junio, do you agree, do you want to fix it up on your side?
>
> I think you'd see all of them in what I've pushed out.

Indeed, what you merged to `next` looks good to me, too.

Thanks,
Dscho

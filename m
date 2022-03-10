Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9079C433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 14:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbiCJOzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347337AbiCJOup (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 09:50:45 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A798190B50
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646923547;
        bh=QSVRiyxLvctXZHOoVZi2IgL6FiMxMf/8thLLhGIrUn0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DGybXzGE2cXGQ5UsQL6ziEDqUcrP7wNLIviPti6qvfSqEiqnKQy62Q5KTOYPbzfcI
         g+3mM9cBq70+lFNJ9Qqj4XSLSKL6JCTwMhUMyNrpM1FztUN5Hf4tPoTGSAXtR8W4WG
         cZyuFpde1LQFwPy4rjKrQi6NpFLvGcaUysIxr45E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVN6j-1nc2iC1zIV-00SOaA; Thu, 10
 Mar 2022 15:45:47 +0100
Date:   Thu, 10 Mar 2022 15:45:45 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <derrickstolee@github.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH 00/25] [RFC] Bundle URIs
In-Reply-To: <ddebc223-1e13-e758-f9b1-d3f23961e459@github.com>
Message-ID: <nycvar.QRO.7.76.6.2203101545140.357@tvgsbejvaqbjf.bet>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com> <220224.86czjdb22l.gmgdl@evledraar.gmail.com> <15aed4cc-2d16-0b3f-5235-f7858a705c52@github.com> <a6981d6e-16b0-b0e1-a94d-a87ec20871bd@github.com> <220304.86a6e5g44z.gmgdl@evledraar.gmail.com>
 <1469e420-63e5-e2db-21d5-c70674ab04d5@github.com> <ddebc223-1e13-e758-f9b1-d3f23961e459@github.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1470902776-1646923547=:357"
X-Provags-ID: V03:K1:l9Prz+F7u10dQG/JdcmqSky4/CN3ePfiAqeIvg8J3yCCeMoZZ/x
 ytZGhFr0AY0IW1DJVH7VUmBRge80vcdQ2e2ZUQKG2HTOECNbKUa8+L2AkByTJkTg2IgzapM
 uiJphDQCE7vGi39C/5ezz65Is/94s0AoEEHP8NM/5MgAccfJC6sn0BtZhSwrnYoOLeDL0zv
 Esqoy1zh0nwFHPrh93eFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b4nkLEd4VFs=:dDP8XEU8tDN5rhhXoKXDRg
 FwB7Rv2mo8sdINL8aaC4gyWR0yVtEylxQXdt6k5JwxP8kQbfx8r2z3f6akjkF3wapBAZjkBdw
 h9JSXjRoU+C28H8aBLCPUFV1/pv9KkzY9FYgbL/eSPyLRKh0LZIVtWWbMGI/p9YTKbNS4VglF
 DTLfeD+V7xT1ElopjrP80zFeHxo4GozLtUN4IBIR2O9vnLM0nU+hZ5k/aDyI3gcuxWl5jXc0M
 /42ACXEgD0aJtmubC1mltzz12IckHURrntqesehV6NsXBD+fMFaiORWEZMPcPLaZzo7YBX3cc
 +eQZr8Kr4FiJX3Xhwyz2vkTuFGa0XN+Z9vWjATKBbWBV+k1A5hFwTQ+VgKjIVl8X5vtz2Nyj4
 6arUrJ+GIzXReGUrrmEyktJ7rm83/3zJ2liR4Idd1ruWkGSg63Jz9fWUsiBTv6mGejEgoQsmq
 l2pcfUoFpUIWcHMg0Cr9qjXIn9lQX761a8+3wk+rpN5IT4LldASgW/0aSTDCSSiLkf6KXaGLY
 Bz2PSvT8d/miOd6tgGvCRL1Cswg1P+jMIoo1qYQ8Wwinbl/KnJJmzI1yUhrH0Uk17tSgKl70c
 PPYTq8CwdiGv403chBU0TGThegUceU1x7s4LOFt6/fwArYDuRX85s+plCJUC/DPGQwXktgnju
 DZaqZo8xq/Wocj7fgiP4Wc+LTnoITAJzS/l8rLNzeXds9/LoQKFNXslKIr2TZWbx9PfUYCzPj
 fwX2lNpr4Ve5U3J5RirWgZz4z+t+wq/m5j2QEQZ3QPSqyEr8Z6f9qVfaccFW+tpdhNRFETVMh
 Fn7eFb1ZxdoCrG2BcRAKE3MQORPmojpkOmeAyzKBcCyAPBfv2yCECwJ/5smXVQ+KVHP8Q0Cf9
 El0eltDhisoqG6/KS8xYw6s267KxEl6Ft5D/4YwVKqggjxt7Xr3JCqSIYFeMp9kg4svV7wJR+
 7mtwH5+B4uCMxZGOqB7YQ1mTV5vcC+7FVKNtkhwoKTbnZbQI3JfgJvQWyxo4WeEL5zdqR9RW0
 y75NGlpJmfKG13gAZ7YC3UwfnkCwjpvgyfgwHiwFHrn9BsvO7aue/2BBOYlLIFJT0YqlRwTcg
 WWm2WF9SFjUGck=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1470902776-1646923547=:357
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Stolee & =C3=86var,

On Tue, 8 Mar 2022, Derrick Stolee wrote:

> On 3/4/2022 10:12 AM, Derrick Stolee wrote:
> > On 3/4/2022 9:49 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >> Also, as noted in the upthread
> >> <220224.86czjdb22l.gmgdl@evledraar.gmail.com> it might be useful to c=
hat
> >> in a more voice/video medium in parallel (maybe mid-next-week) about =
the
> >> high-level ideas & to get a feel for our goals, conflicts etc. Doing
> >> that over very long E-Mail exchanges (and the fault of "long" there i=
s
> >> mostly on my side:) can be a bit harder...
> >
> > I agree. I we can work out a time in a private thread and I can send
> > you a video call invite.
>
> =C3=86var and I just finished our chat and came away with these two
> action items:
>
> 1. =C3=86var will finish prepping his RFC as-is and send it to the list.
>    It contains several deeply technical optimizations that are
>    critical to how his model works, but could also be used to
>    improve scenarios in the table of contents model.
>
> 2. =C3=86var will then do a round of taking both series and combining
>    them in a way that allows the union of possible functionality
>    to work.
>
> 3. As these things come out, I will make it a priority to read the
>    patches and provide feedback focusing on high-level concepts
>    and ways we can split the future, non-RFC series into chunks
>    that provide incremental functionality while keeping review
>    easier than reading the whole series.

I very much look forward to see the combined work soon!

Thank you, both,
Johannes

--8323328-1470902776-1646923547=:357--

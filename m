Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4873C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 13:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24B06008E
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 13:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhFANud (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 09:50:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:38143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233797AbhFANuc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 09:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1622555326;
        bh=8NLEJ0zHFteiHVmETTqulKAZVXXhfsPq0Q6cel/ur3g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dBizZxrA0rh9aP9yq1BIXnSgT40LX9zsBiLMc1sKgw3+9HwYfn4aC61BnLLeiimmK
         JiF05+lBWfAvUa08OgtKtmwOI+jnLeF3Gm22VJJZTWKDv6nRR9YOWGbyqQJwsOMhY4
         8VQ5I/qFIGWhm2kYolY8tshCygLCjFCYI1UT5OIk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.8.58] ([89.1.215.222]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wuk-1liYyf42HE-005aqi; Tue, 01
 Jun 2021 15:48:46 +0200
Date:   Tue, 1 Jun 2021 15:48:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     ZheNing Hu <adlternative@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: add %(raw) atom
In-Reply-To: <CAOLTT8STkD_2vhL7uCt1umgmfGBRKcuF7nWv+DpQ4H0dBSLJ0A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106011541140.55@tvgsbejvaqbjf.bet>
References: <pull.963.git.1622126603.gitgitgadget@gmail.com> <pull.963.v2.git.1622379718.gitgitgadget@gmail.com> <e44a2ed0db596ab0e0f484c25facb7da7214369e.1622379718.git.gitgitgadget@gmail.com> <xmqqtumjy2e4.fsf@gitster.g>
 <CAOLTT8QFW4UrwZ+OboYqkoT-oKo1Sz3JJ-Fp8b2RWugMOy5Cug@mail.gmail.com> <xmqqlf7ut15w.fsf@gitster.g> <CAOLTT8STkD_2vhL7uCt1umgmfGBRKcuF7nWv+DpQ4H0dBSLJ0A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1426437115-1622555326=:55"
X-Provags-ID: V03:K1:iVA81VQk6to7lxTlADMBx2YPTxz1G94PaAfOBwm1gYMtdKPTkjk
 u4wz/Y+TMqw0IFQpCQwdgAISyn8NU4zS6znaXw6x/b1V6CDIfMjlh5VYvNCsD1TG+L1YrI1
 kifAoQFvMc5Vj6uMqn8ooaN0WKGe4Zm1bbi6bffxnv/4flU2xD3gZhNyZaNsHYlAIGM0b26
 W/Xa3Te9/9aqh51wJ9kVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DWHtw0YIaeo=:dBJfwh3172Ng/mLLTk5U6v
 P3absqKrnOaM7LaGQwPCyNaaBdxXyWujN2bU9xfvWoj41AYJfEuE/3MR2UW/BEl8Rit6V7PMo
 fIUj2Y50wkQQDxCzcMT+Zs8fIXKG6+GQ0KMFxYzRRxUR2MdG14HSSukvn+PtxlJInVLe2yuzE
 qlXj5ENx2s3hmtxAwXhXvIqBkNU0s9/WlSOS/79o6JrhoupPymNlsj85/hOs51p3b6OIijhMM
 jhE9tC967dax5+XKS7eIIayJhgZpXHHAP6YcNJLRQmkBmPb1fK85NgpBu4sByuwVDW9+b+iOM
 vSAnYCKlsjItSadEkxPxju6dda77MR/XA1KOPDtAq3YRJa9sN/3c0GMXHnqpZJzQE/jbJ6qvu
 UnmWi1yYMrASdiz7fE5abPBvvS0low2o3gflQ1N78wLt2jTO3AZ+5VMB/JbiZRXxQAQQhKq3B
 Ps/yZv+it7TydrW/Ay2fe57lVKbRf7kHMFniyLQfhfmkaCXFuwiQ5lRxfsVZC1JOmUg0vngfA
 7K6+Zk+X/18/TBTNEjQGGnpEoKsloR/nWtEv9o2B9aFCWm+C1a56GKeYmCY5NpfVPQ+u+JCS2
 7vhy7G0oFnvX1vOHZPOmwHGep4xBlA8E0SduccZYiXCOBxPmvA10QV8CS8oL1lNrF5XXIJiXv
 5NZrcrV3w9Fio6tHeT8oHYMKv7oLGf2grdpQshCASMlEQIPiqplwjTb6bGgV4hhWcELEedqAs
 js70k7SIdv2twzvmQ38SLVpgAqkWYOR3M5OqjioWH3LJhLqsjy2Qy0MlwgrhI0K9uvkuhgbIX
 hTRuJ/nvmBCAVIJEd91n1gOuw11Ly8Ffm5T4q6FQqn4jRzmY65HS21aA3L4aKyQ6JVfMMTOpP
 jYcd/QRaaF2oZGfzpppLiskw+BjQRtmiLuIqDzG4NMVe1e+lYfSR4c1OX38vQKpm8JKYtMRJC
 nii0gVd2U0ogMWENvLlmaG6sDOOVbyqmqihjyqZ2ldN7e/J5z4XBDFE/2HgoAHZXVzj5srflw
 30gAUQSicTFSLfZ6gxl7JtMnP3RD58lmYOvsFix3wdF6EqYYM408FckKOkr9TGW0qfqK7EMe4
 estgELJBlv17I+Dck+UWig9AKxChEMX6pP13v+4FKyPNz39DRYXtKErSw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1426437115-1622555326=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 1 Jun 2021, ZheNing Hu wrote:

> Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=881=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:54=E5=86=99=E9=81=93=EF=BC=9A
>
> > ZheNing Hu <adlternative@gmail.com> writes:
> >
> > > [...] But if I want to base the current topic on
> > > zh/ref-filter-atom-type, GGG will send past patches
> > > (zh/ref-filter-atom-type) repeatedly.
> >
> > I thought GGG lets you say "this is based on that other branch, not on
> > the 'master' branch" to solve that exact issue?
>
> I'm not sure...I will try it after I rebasing this topic to
> zh/ref-filter-atom-type.

Yes, it should be possible to rebase your patch on top of one of the
[a-z][a-z]/* patches Junio publishes at https://github.com/gitster/git
(and which get mirrored automatically to
https://github.com/gitgitgadget/git via a scheduled Azure Pipeline), and
then to change the PR base (simply click the `Edit` button next to the PR
title, as if you wanted to edit the title, and you can also change the
base branch).

> I just remember that it looked like something went wrong with my base on
> your patch last time.[1]
>
> [1] https://lore.kernel.org/git/pull.870.v6.git.1613739235241.gitgitgadg=
et@gmail.com/

https://github.com/gitgitgadget/git/pull/870 seems to be based on
jc/diffcore-rotate all right.

If you are talking about including Junio's patch in v5
(https://lore.kernel.org/git/fb4bfd0f8b162e51e71711fe5503ca684f980d58.1613=
480198.git.gitgitgadget@gmail.com/#r),
I _think_ that there might have been the simple problem of
jc/diffcore-rotate having been force-pushed just before you sent v5, and
therefore you had a stale branch.

To prevent things like that, it is a good idea to set the upstream of your
local branch accordingly (in this instance, `git branch
=2D-set-upstream-to=3Dgitgitgadget/jc/diffcore-rotate`) and ensure to `git
pull --rebase` before force-pushing and submitting.

Ciao,
Dscho

--8323328-1426437115-1622555326=:55--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798D4C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbhK3ORG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:17:06 -0500
Received: from mout.gmx.net ([212.227.17.21]:41623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242037AbhK3OO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638281481;
        bh=nPvabF5sVbZqm9WTzSpngGC2vooz//EVNaSq+AbKQzc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V3aCp1nFVzM0j+67eQ9PsEXejg+cezAnMvox9lSbeomBKx3PwaCe6R65Ak6nZY68j
         gUY+VacLDyxTWgNJYfoEqLsUFPdD79wZJobD/AGHDZB8RO8fEygwPdXUtJkvTBEnDU
         EbA2Pvg6qA8wScOAv+zR7iXqSf6d9rcFf7gwpP8U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.223]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKy8-1n36Uj1TfE-00SdPo; Tue, 30
 Nov 2021 15:11:21 +0100
Date:   Tue, 30 Nov 2021 15:11:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 00/17] Upstreaming the Scalar command
In-Reply-To: <211130.86mtlleqhm.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111301450030.63@tvgsbejvaqbjf.bet>
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com> <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com> <211130.86mtlleqhm.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1944135619-1638281481=:63"
X-Provags-ID: V03:K1:LiFBUhD8D9Gg+j2Dx6jqFW26gD5yG6s12NwvIntW9QceNNjz8AK
 f9Jv364HrzwPK4r0/xSrAQl0tJVhI5Bdayk8rCBVcydN6q8fYFj6KuAq76C0VGARv8+OFdK
 t3JJxHYx//cDkYdhIMF7FI0uRszRznNQYZomwdBQYzil7GY8/4QroPFwKh/TX1nzH6Oe1Oz
 aw8gVyCX2Reh51RSoy5uA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NFvN02M4Sfk=:tr6RrN401ZYXu8lP0tKlDf
 ur2ojw8hIflsz1U4kZDjLPEVCEji4MWbkN8SJepOdB3urGE3/ccoRiAZUWT0StBEQgEu8gpZm
 onKhkJI4wufiq2hIPC08rDHyNt6j90Axr+zRht1e0L/hTkrpA54ax6yYJOM7aOV3u8FLzuy9v
 9e21qJ+TERXb7lZ1yaMt0sqZFKJ8rxvUZni1zUnsEEJPNaPZT4/NvbJJ9/wqucTH4uLNHqHuv
 Do2tXtEQmpb3aCBBR6EH4Kfgty5brbqWOloX/RZOQvk7BeTuPrYmo4rekqDZciutmVhX10UQI
 D59H72T7viOvtkz5YTztkZj9+wFaXAOz28p8CYmvQ0tSKqk1uEVr5+gd/P/UYTDL0DrQ48uAQ
 mkKJrEpJC0iMMFPbPEeci/NrRtiglZ3Kc8QLBDmJXY9cv0oqhgh77DvU8wOGW6D9guKSN1cmW
 B+N5V7RYwy0QeGF9hqEgSn7DmF2CD1FB8bA0JHQah9P6HFQ8iOUffQG1qUjEF9xa1vNxABpBV
 eExgOeJnhksmn5Mf1Qwdgo07l+A7vJOX5qslnb96zjo9GnH7YFdo/FS2SsmQ8xcTWRf0YeNgz
 75xHWZ00TkkjyWUBfWqm6Nm47fM0hCECJag3T0MVY/YSD4pOEE7SuxDkc63B/anI3JYLi4/zL
 pRQn32KlsQ2fNg2mxGM4XnsyfLh0s+Amv1LTV7lvwPKkFib2yLDliL+3/DfiH9EgEtC7Z8HQL
 aRWLOjJ18rQ/yUemK0OhntCeSMIl2O3uIrPMvZ2xe3t90mJln+yv5R4E/S0MCtm1i4jS/I0AV
 Uhgmx49fHEgA5v1TUwgbpvAX4xK1wA1Utl9LJ2UVF3nBMD15JhuvrYCHtwyJChjXbObyUsb7h
 5UWLiBz2jOX1FpKZZCxqAIlFIaSdOcBAL9XeLk049Cs9WUNjLtcGRSWXqy4hsBTMfYf6cU5dV
 4BXWfBX4lbHnAOHQqSS64O6SHk5dzmNkv6QVKSBU2EHrzNTTW+DIKe3UJJgiz3jpG63fXUPhk
 C6d4CnKjcA+bt2srE/TzcGaVNiThc8JQQuxtbsGYpPXOLPWfwS9VBgo55RjIIJilZa5JpRZJ1
 tGOUAgnnf0BxfU=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1944135619-1638281481=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 30 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Nov 30 2021, Johannes Schindelin via GitGitGadget wrote:
>
> > [...]

Unfortunately, you clipped the most important part, the part that I put in
there mostly for your benefit. So let me repeat it once again:

This patch series' focus is entirely on Scalar, on choosing sensible
defaults and offering a delightful user experience around working with
monorepos, and not about changing any existing paradigms for contrib/.

I do see that you want to drag the conversation back to discussing the
build process, and the CI integration. And on changing the way things are
done in `contrib/`. You've made that point abundantly clear. I just don't
see how that could possibly improve Scalar. I mean, if it failed during
the past 4 months, why expect any different outcome in the future.

Ciao,
Johannes

--8323328-1944135619-1638281481=:63--

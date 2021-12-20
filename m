Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CE0C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 17:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhLTRiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 12:38:14 -0500
Received: from mout.gmx.net ([212.227.15.18]:39125 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhLTRiN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 12:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640021887;
        bh=oa4/xqPmcdmdsauIRVBgoXmLkZh+J8dEXY29LONvleU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YaivNmavDRPxozIJnDvssJ8hUFjgl0TnUwAPjw2rP7K1juc8s/793fAVqF70nDhLr
         BMYQk5hVnyiI0nwdwLxvN1GGnJ0ZWAse9bENNqSF0xqqeD0b5VMf1/Tz5gHroMpoIP
         MaYaOX9aVAcQFwPvs5i4sjbSMz61xBdG//91b5f4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.215.174]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1mzMbv1ioy-0007gs; Mon, 20
 Dec 2021 18:38:07 +0100
Date:   Mon, 20 Dec 2021 18:38:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] CI: remove support for Azure CI
In-Reply-To: <patch-1.1-eec0a8c3164-20211217T000418Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2112201834050.347@tvgsbejvaqbjf.bet>
References: <patch-1.1-eec0a8c3164-20211217T000418Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1930100049-1640021887=:347"
X-Provags-ID: V03:K1:+iJoi2W5lYX0JGYurpuXvw7wQfp43/vPKmZigawjwBoXiGIuuRH
 GXZ0ENUtUr1/wDUvd/+UVzzKwk+MNoNWcKYhZJmACbNe0nm1S8PyB5LS9f8eDFlyfnEP5VF
 rYsj9qZUmllGstbO4fdqknXel0Hd+OXxhoIaUrWxuJ57mHbmwZNW+z9ZBLPeLCkpq/9IO3k
 qQLrseWfb1w14dkft33xA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uuiYEGqH6l4=:0rY5Yt4nMUlgEEWPEspOeA
 HcOpvygPTcSwtAwP6GhGnB/OAKDUT+caKhilSen0jnS4XRjervm7zezrLPg/Wmv8nAEzDUk2l
 4ve7dePUrlYFj6N2ChheX8lJmvlBbe3aZwWUCtCxZ8fMRdCHjS7j8P5kPQespaRekiWlw20FJ
 ibfyskequ/FkBzqfB8pDmAwejmoTr23sx4VgSa7tm0Irw2C3Wc0osV6y2hqKum1s9sxvnB+vt
 nvvanbSbG/b3VOZQyviArqpXVkG9Icxjn4iuRfgYs7QATBCq+98nt59rXzdAQXCXY+nS02YTf
 gnEviiNmkgFL+PeQacCXIAFgsp0J1tU47hDjgcQVJJV1Zz1NxjUY8eCvOMxB36mj2WdpY7Tc7
 dsLFlwUxjvDApMXsdix96fAN82BqedrYGK8A/EL0jRcJR53w6lA2cc3ksJvZOyTnk0yn9A7lF
 YrmuGApEY1lo5xyiyXy8+e4qceAAU3EGjfLTQ7MjzoZVxVZ4hrGKMNCElmezCzqxxoJ40vTvi
 4fz5mOqF9dmXE4RvdYxNOnbng5pE/wFY0iJveaodY1Or0cJVhttiB8ZR/EVi+ZjW0e9MGu8nL
 dlxgP0T98jX6SHcGas05xEEvx2xsh91hAMuCpTuqMViXspana4KXaS26IB8KgpGydYZ3gims4
 gLvvNC5/hKdTlY96o3P1rM2mZnk/trBp4wLuXDojZamOqZrGJ9uG2TX2eVK4qMLTdC8AMb49g
 KPasqGRNjneWfi+N7nFHEg7sc+ezuHDPclWLVx66fi8kTznAX10MeRsoiizNhzCTIQHjRg10g
 lLIfKYKw/BdKDVO0Fk48KjofRe2qUuvPz5h/8liErTqCjR9lDqL/PogQovihrVclq+WN/GRH/
 dTRluq21+CuF3NDDRjye611Hm2zxkW/zwiFGTdKvvVCP2zcsdWcKsuYjBbZz8C3tcXKvQ3VBW
 8ojdhJtA4ee3Tg04WNyHqs6d7axHii8sCudCrKDLB6WBqQTEM9fYH3X2/dA0vi+sGNUAv8CEj
 oloiJnEL+4f8G0zrORvH3F6+Kd2wsIvMC9zgy93KVeWVgcnQSKNVqpWcFXDF9U7LC3rl294Pe
 U9BjcIY7bwKMoI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1930100049-1640021887=:347
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Fri, 17 Dec 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Remove various code required to support Azure CI. Recently in
> 4a6e4b96026 (CI: remove Travis CI support, 2021-11-23) we removed the
> Travis CI support, which was last used in June 2021.
>
> The supporting infrastructure for Azure CI was already partially
> removed in 6081d3898fe (ci: retire the Azure Pipelines definition,
> 2020-04-11). As that commit notes:
>
>     We have GitHub Actions now. Running the same builds and tests in Azu=
re
>     Pipelines would be redundant, and a waste of energy.
>
> This follow-up removes the relevant Azure Pipelines-only supporting
> code. Most of it was added in commits merged as part of
> 57cbc53d3e0 (Merge branch 'js/vsts-ci', 2019-02-06).

It feels premature to remove the remnants of Azure Pipelines support
already now. It would be better to hold off a little, as much fun as
deleting and refactoring code may be for some of us.

The reason is that there are still some things that Azure Pipelines can do
that GitHub workflows cannot, for example:

- present the logs of failed tests in an intuitive manner,

- re-run _only_ failed jobs.

At this stage, I am not convinced yet that we should bet completely on
GitHub workflows.

Ciao,
Johannes

--8323328-1930100049-1640021887=:347--

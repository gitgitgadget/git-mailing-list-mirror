Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DA1C433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 10:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiBVKWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 05:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiBVKWf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 05:22:35 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225557EB36
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 02:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645525319;
        bh=R/IcGrkeHLDxsWAArYAG/pemXRpB6HQhqU5V6rpOI4A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cHaSzjV2B0EXvglVL89HaGXonpF6NoWR4WUNM0dkrtqqbcgoMZDTQsP8N+SLK14ON
         VzK5jxYjemOE2R1kvh2h4EVb3ykBpQQD0Gx0sLqZj+8nu2A/4icGUr1md55zXv64vw
         YGfinKJ2dz29n8uEMp6xwVqawv4MVRgub0MriKdA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59GG-1nLMNH2b24-0017M9; Tue, 22
 Feb 2022 11:21:59 +0100
Date:   Tue, 22 Feb 2022 11:21:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 05/25] CI: remove unused Azure ci/* code
In-Reply-To: <patch-05.25-4738a22a36d-20220221T143936Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221115590.4418@tvgsbejvaqbjf.bet>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <patch-05.25-4738a22a36d-20220221T143936Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1863663076-1645525290=:4418"
Content-ID: <nycvar.QRO.7.76.6.2202221121490.4418@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:/FjynvSw4Ua4ckLQWX0NvvScH4xjK5pzOA6tsPR4j1OLobr+BNC
 GkHcT4OgnfdI4gvl7rms6BUMCkk/UiDiteOch62yD7s5YeHeq9W5N/jBHEdon52D6evWmcQ
 zPwBYvzRZ3YrsywFY3kyFEGII2EgJor1gCuPBWjnzT6qMHU0ybUmwGp/9L3lMS0xCW5Nnc1
 tM59ZaL2mrkdJ2K/5REQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pWpKJpXG4a8=:uM1MbJ3g+P8RSL6fQ4xLaa
 L30lIT9/3dwlDknAjZx5DU4c21i4ES6iH257coudAeZZef8wvUYLXueK4X/865pizKlK67hfP
 QgECp+iaONDnd4jvTM1dHfjJP7WQNzNtSHT2n6tm+w0F3aKlUcbLctICsA8Gp0FEJ2Qp/ldyY
 giX48ekdrnP6whaRQlM815Z/NriHM5eDZ0/8nQshbSbpXFu9Hk/+EhZcAvuhjugeoKprP1m9k
 UusklbxVt4Z2MrPTopR+4q6w9RH6RtwISlcvXrU2k4IXQ3e0NEvdJzReyW7fTNaZUrZCyP+nh
 vGLi9OcaaPukiJ937fGsDkV1pwa2VAlvcsACw2ZLYOGqErP8BqxdTTB36azLegVMzvrCOb1Je
 4FH6QtI6R6k4/AmrDQtBSEEHDStaoMYu9SskAbiYgbqD8n4gGSuHvszQXMflLoTkuaexEMSlk
 +tt4WBybNR7WkTsUZbrMpBGPVic03snNs36M+VMHNTN3xj2zSq9XWR/SNy91SvQCjS5vXYJxK
 +Ap9vNTewM0wZxofsKWdfzSguxdk6Gz8wthf4S/WA6EB2qHAfzcOMGfVvoZLO1rphwCX0zXrM
 e/Hmee9Yn3YOu02/GUlB8+Nq5rvD//tY4Cfp6uLA92yS8tBR+j3C9MSlk2l+H6mr0pKpwaygs
 d4GkXncWTcygYRuIKaIW5LLER3s0WVqMT2uY0hRoNLUVduj0RPRjRvtX4HR4w6r7Z10L5WXfb
 JgBAbrcoCqe1ddkLkOrxi5zVvBgVSUr31bHa+f4OKayBjkBixOBauJeYYcqkBQkL0aJRc+arA
 jrBzUgVAII/EiYdmDhKnGzohtDWpUCRs7J5CBO5F0+1mqULq0NDH08zClPZc2ZVTfY3K0HrAL
 GKc3w89DXCn34LgtuZZtfVJ7lzsXbao12mkmRvQ3Q3DT685Mq+poGuOZVb7797Kcrqh/Z/e/j
 wfq7dpmFsAikSnMd0eA+Ze7ww3VTukOWURgHxA4CYL9+/ewFs528Hxm8VD1B9zhDNX3dJY1nb
 4KlKogSDE1qtTmxWBInrPQPMXYSF/ijllL/Wa3FU9pSAVzcNJc1Tu6ZkdqfKfwvhVVPWWwVQl
 HoLmpS1vumOfH0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1863663076-1645525290=:4418
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2202221121491.4418@tvgsbejvaqbjf.bet>

Hi,


On Mon, 21 Feb 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Remove Azure-specific code that's been unused since 6081d3898fe (ci:
> retire the Azure Pipelines definition, 2020-04-11). As noted in a
> larger removal of all of the Azure-supporting code in [1] (although
> that missed some of this) there is more of it in-tree, but let's focus
> on only the ci/* code for now.
>
> This is needed because in subsequent commits this unused code would
> either need to be changed to accommodate changes in ci/*, or be
> removed.
>
> As we'll see in those subsequent commits the end-state we're heading
> towards will actually make it easier to add new CI types in the
> future, even though the only one we're left with now is the GitHub
> CI. I.e. the "ci/*" framework will be made to do less, not more. We'll
> be offloading more of what it does to our generic build and test
> system.
>
> While I'm at it (since the line needs to be touched anyway) change an
> odd 'if test true =3D=3D "$GITHUB_ACTIONS"' to the more usual style used
> in other places of 'if test "$GITHUB_ACTIONS" =3D "true"'.
>
> 1. https://lore.kernel.org/git/patch-1.1-eec0a8c3164-20211217T000418Z-av=
arab@gmail.com/

This has been discussed before, and I already gave my NAK.

It is sad that I have to repeat myself: it is a good thing to have the
Azure Pipelines definition as a fall-back. In the past, this has served us
very well especially when we had to run a barrage of security fixes, for a
slew of backports to previous release trains.

You seem to have fun to just remove this code, under some assumption that
it is not needed, despite me pointing out that it is needed.

Ciao,
Johannes

--8323328-1863663076-1645525290=:4418--

Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F4FC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 22:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiCIWL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 17:11:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiCIWL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 17:11:28 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB69120E8A
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 14:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646863818;
        bh=EX6zxPr+k3CzKWFvQC0lrAQ+G/GHLx4fRecO2NAm0rs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kAjvzR9Y1tSGyqaws2WpznyBearD1yDw9bPFowGLib10tPWEqnZ5VYNHQacnvn2OX
         6Y1nabafQlaJM8D+Md6tyPQoe8yYI7A3pHOzADtdzmQLqJAO9Nol4iCWU5lmtkzkv5
         K8FXmC+j5/+ERjHxOUa2yWib9DyzcVqwbWiNABfw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFbVu-1nN6yS1SzG-00H675; Wed, 09
 Mar 2022 23:10:18 +0100
Date:   Wed, 9 Mar 2022 23:10:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 00/25] CI: run "make [test]" directly, use $GITHUB_ENV
In-Reply-To: <220223.86pmndb6lj.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203092304320.357@tvgsbejvaqbjf.bet>
References: <cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com> <4d3fecbf-23f9-f6b6-414e-8eaca620aced@gmail.com> <220223.86pmndb6lj.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1753494914-1646863818=:357"
X-Provags-ID: V03:K1:fM6hNwNpCdjmWuBi9eb1+0EyqfL7m9CRMBWvghwB3gz/V4I3snZ
 XxR1uWQVKFMK8rSLSas8hmd3Ecm9I2uJAzRUlau9ss3KJ0wvtQTENWBGLaaHOjg7vhwKTWC
 QltN/+lvl9jGzrDGB+rSw9DiE9kwV1pUPfKRzVPdGcyXoICzPJX8kPduKrYB/j/P0B3lK6q
 pPvMvnItgqF2BdP/6Jngg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ucTU3EPzt8=:zka7vTMRCaY5yXs4cGC+8a
 9N8nVQUJLE0f0a4zyyhXFYP3K4hIGXHY5ew6/TRXIiaTzzhB/UG2epFc+2TEOy46dn3pNLftz
 kQsKJ7CsWhhNMMEJ+u/alA4Dlwr3vm/tpaWRGOY1gFq8ZkptX1hRvbc+i4wSZxVteDwGNS9b0
 vUk3S0P1NzQtDCUJxucDeKrXmtqDytGn32itw5HrGMAn+gbMnt1JFRD7mFBc5zrF8RImg0BfK
 7H9PIDtIjLi1tohbGH3356CVBU8lYtkSDY3W+YRks90AXYR6oHCjbEo05V0Xj5yApNO8hzPHD
 9Q6vlPJ8weFeS4qB/7P8Atqq/K5o7RHP1opHFTHUtp9SHO28UwBiy8JE2bu060EGfEZDTObMa
 ER63etBegM2Pvp8EsNNy9bh3abY8TGhJphJLDRAshWGa1+PfrubTSAqIIOoOXcYUw7d+/sMhG
 5O8zkspFNqyiLqVJU6QAAxA8oETjM4BqiDc92D2lByKW8Fxj4o8b41PIglrePaYmydwrvmHZ+
 0YQkBHycZTmyyH8tZ1LnZ6O/FHNAgPgiTL1Mj8GtE3wYKekSV2OZCLqv+erb/vYA3QXDV5OHg
 f4efIA1PHmUNCtzlOnOWYOYuzL0soyIyCPvY1Uu/tM2pqXALjZGzBZC/rxzzoH7u8CcYFihH4
 Tj6IHVkByDQDLb4O6bz72FZxyekb54ddrUHasBy2S0Xyw8shaKhFIfzDqbxBbIwTvhb6dYYL2
 aHqxXuTU5FBq8YTuo2+M2afS7FrQKmi5s0pD0/O0TCRn7nVat7y4pDWpMkEjUunlRmp49r82W
 bGsNl/4uFxDWliRsiVeOidp1pVb+rTrrxP46lW/QW2w38pqdLLFTf40wQrEomkavJIWD0LYXW
 VgbuAFBGTDWsNRQWN6m8KO5RcWOqZ8b60lflNw+P5kzjHZxVhboKpW5G1i8nf+uv3WV5RTNTO
 c1xH0nOyUxV3G7RRkD3Nfpa3x/SrOgHwElVA7JirZp9kQX7fO+U74+OajZHwmaTBzguZpoNio
 OuI61MGZKux7eDzxtlvcWWbVMiimai63MU6Jzoy5e9lzcIEGy6iUeZi/nFwrwtjr7qxfTJtLd
 hNY4noa8gVcK2M=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1753494914-1646863818=:357
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Wed, 23 Feb 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Feb 23 2022, Phillip Wood wrote:
>
> > If I understand the rest of the message correctly we're left with
> > having to expand print-test-failures and searching for "not ok" to
> > find out what went wrong with this series.
>
> Yes, it's a non-goal of this series to directly improve or change the
> "prove" output, or to replace or change the functioning of
> ci/print-test-failures.sh.

Since it is explicitly _not_ the goal of this series, but of the series I
offered for review in
https://lore.kernel.org/git/pull.1117.v2.git.1646130289.gitgitgadget@gmail=
.com/
(with which this here patch series conflicts rather intentionally), I
suggest that your patch series can wait a little longer and build on top
of mine.

We do have the rule in the Git project to try to avoid conflicting with
patch series that are already in flight. It just makes the lives of all
involved parties so much easier.

Thanks,
Johannes

--8323328-1753494914-1646863818=:357--

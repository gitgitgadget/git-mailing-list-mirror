Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1110EC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 14:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358822AbhLBO5R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 09:57:17 -0500
Received: from mout.gmx.net ([212.227.15.15]:42665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358808AbhLBO5O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 09:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638456815;
        bh=OJHfdG84sjPumuLbZgVOoau6JL+CQkd5lCv0X7PN+aU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VgICe6YrfIaqFWgDQ5Uz7zDWse03Kefp7h6P5zq2h8khiuSsXwpNndF3Agugdaw/e
         yj7XvBMDTbETbpHM+4OMenRW3kyCWl7jJgwQDvg6GR/1BbAzObphnT5GqFRd6c/4Hx
         wo9CCnU9Mh4SkcISTMnwW8gGE7qmJkLqFuGDv/TQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Bk-1mGj5F1gTG-00oG6O; Thu, 02
 Dec 2021 15:53:35 +0100
Date:   Thu, 2 Dec 2021 15:53:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
Subject: Re: [PATCH v9 00/17] Upstreaming the Scalar command
In-Reply-To: <xmqqtufs1a39.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2112021549330.63@tvgsbejvaqbjf.bet>
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com> <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com> <211130.86mtlleqhm.gmgdl@evledraar.gmail.com> <nycvar.QRO.7.76.6.2111301450030.63@tvgsbejvaqbjf.bet> <xmqqtufs1a39.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-94236695-1638456815=:63"
X-Provags-ID: V03:K1:qvJzoX2J3XZMArfh4vMFS2KSqsik7G7HgV3e17AgX5bHuRBbP0S
 krUvLvnoVTOQj+oduJ3O1pTi7CUAK1CyJe8mYaBUnPHsKiDhLq3FeE7VcKasTPoO5OZFeor
 bYdZt/k1GM6/4LPtIzWlVYsr4frvS+eXY8tNOT6t7HQkJfx6f+QjnDkCidIX+9pIQPQ1s/u
 cPpx6DyCHvwL8Eoj3A8qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IAmOci5ueds=:ZuVcCguqJighwHOENxyc7Z
 52QIg2zP4HK+9Hiahes8jUwXD4UzWCnGBsxAmE0hIyI4DJYfoz92zwTugzu2TMt1M3k3LldxX
 H38eZTYo178QoxrT40vmqmFBx9cARHiWpoHs4WudYD2rR6OtDzbUM8gnNrNJEOSw9q54UFPUd
 pstUPQvEP8pAepU7rJLxxVaUMwz/KTjb34JKJFN9VyUNrbSzCgMnMUgn8TZeZBu58NmCEf7pS
 pyC6zbHxHuVM81pV56JXshMVIMJIXo/4u8lAYUVRaV9CW02d+oB0UKtf7PMEZ5TilV9Bg+Kmm
 8lq6sQvmA8GdQymWmwazKumixyYv1Uu2pYEu/tXbTEBXCZFmtmhnZmyZZrpGguSb0iqh9GEAN
 MmVmzLAu4bxjxk/N7h5Iv1Rd+a5R9w/3vdlcECwPflBiiNc/t+/9sciu4Now3l8h+b2xS03eF
 QTeNrz3sjiZx7KW+2ZzuUZ97Te0RqqGngs0cdyuLSnwlvpiP6KoVybn0c55Z5vWLfuBXndcr4
 +s5S/9YevSWgDH1OhV5rlVrJZKgAbH15Wt23qNeOdVJKyA/BhKT7p4aBhJUe+2l9lhpM3LmEV
 DwGpkHmmUBxSR5EwcQqtHRIZjR/FTnoqdNkf/OviJVOg63QZHeIxUeGEhq6VP9kiYeciixoUD
 U+C1HQ+i6/NKaSiEn0adqCPn8LzKNmgLPqb8bMZuixgpEOe1Oc6CRgHl7yfcGg6aQgPqRuX/k
 BFYLgL8HqyRZdUQktKvnO2CuBnyO6k7CtMk3iovFwwU8BRvzMiSYUMYK101xT/l/1u23+BlYw
 t8ha7LchCE5QJ3GSLTuwc4wM6k7TaHYDJfW0rQNvYJP6ogBsYXILYYDocvU8yokD02sFZadWq
 JNf67M7d4IyM9q7sdyzXiukenrLelgGy6Pot2rQF/dQ5G3SbjxXQeMGL29iVsQB3BdO0MQwnW
 /RmtON9cNFAQ/w20qkNL2+wkbE6hGTlup83bwvQAl/NNMK1LTooRkvyaMLsawufhv6AuH9tkM
 +byaPnyrAFpLWpvfVB47tPC3RTEyZh3QMR3nrmQskLF/0aJs6L3UczKb1RlPDeLIasBM/P5vI
 7JS3tRQtd0pdco=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-94236695-1638456815=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Wed, 1 Dec 2021, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > This patch series' focus is entirely on Scalar, on choosing sensible
> > defaults and offering a delightful user experience around working with
> > monorepos, and not about changing any existing paradigms for contrib/.
>
> Sorry, but I am confused.
>
> The change to add "make &&" before testing scalar is a good change
> that allows CI to work with "existing paradigm for contrib/" that is
> "you need to build the top before doing anything in contrib/".
>
> But none of the contrib/ stuff is tested in the pedantic job, but if
> I understand correctly, we start some (namely, scalar) stuff in it
> tested there, deviating from existing practice.  Is that intended?

No, it was not intended. It was not even intended to integrate Scalar this
tightly with Git's CI, but since you did not move along `js/scalar` into
`next` for the past weeks, when no reviewer had anything to add to the
actual code in `contrib/scalar/` nor were there any objections to
integrate it, I made the mistake of assuming that you agreed with =C3=86va=
r
that such a tight integration into Git's CI was desired.

However, I do not want to make the mistake again of assuming what your
thoughts are, so let me ask you directly: from your perspective, what is
stopping the inclusion of `js/scalar` into `next`?

I am patiently and eagerly awaiting your answer,
Dscho

--8323328-94236695-1638456815=:63--

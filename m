Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AB2C433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbhKWLzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:55:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:34181 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235109AbhKWLzm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637668341;
        bh=vaMv2113munUgbAK0RTbV6RdFXXixcOBZdwGnmWS8z8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AP/7KP9KpwLNVWQc/VGDdVy16hbz1Iswl0uvUIpxN2Q6sDEhbIXOSdoKD1stMrQTi
         7nT9j/r4aGjv8JKRbgsAzwNP3kG6epNogbdfUpVj0vsEX9Gvu8jDmvfYIc31GE1p+d
         7J1/BuuOjEFG1Lxgm5xOzlwq5pgq5YikQYuMByHs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1n1Eha2caR-00P4Jt; Tue, 23
 Nov 2021 12:52:21 +0100
Date:   Tue, 23 Nov 2021 12:52:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v8 00/17] Upstreaming the Scalar command
In-Reply-To: <211123.86y25fwxup.gmgdl@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111231249080.63@tvgsbejvaqbjf.bet>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com> <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com> <CABPp-BG=fcKq2Ng2gan3HbBGcT7WCMhtZCP6m2xjA5BSuTekOg@mail.gmail.com> <nycvar.QRO.7.76.6.2111221317390.63@tvgsbejvaqbjf.bet>
 <211122.865yskyw25.gmgdl@evledraar.gmail.com> <nycvar.QRO.7.76.6.2111222304070.63@tvgsbejvaqbjf.bet> <211123.86y25fwxup.gmgdl@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-71259208-1637668341=:63"
X-Provags-ID: V03:K1:Zdof3sGHRY/FDyl/tS/oZMSgEGT5HvW5zPODdV6muQAtffYfiDk
 ivFNJRY1JfvvjS6eh+4Card8Wvi426VHgEt4FyEUNkoja3zvQOIGejFGS+kZ3P0IWYDUwP0
 Q2YwdhAty6u1n2GG7ijrx3bzXQplCIUod5yRIPODr9pNt5q5jp2mXEr01bLRCR8AA2m4GwU
 Uu3z6y+vtnLO5rQawivkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RzUHypRRYD4=:e2+t7BgOtHoQDUARePDuM0
 6pSF6dw/AHYP1/DMH6hb2xHa25xHcO/MDuULd1TW8Cdl3l1LsWuB/7x6rOEioQ5TWpCsKTcJ3
 g94k0eyknWhONoAuRb2rkpdRu9rzdRpgQvatHzt2UbDA1HvX9AryzUkGHjJC5Yi4hkJ+T8hXP
 gB1yDJqG8JYY8M3WLocTtjwr805Wp+Bdkv40OeOZ8otjHrVT1DjvXz/XKUNG1Rvj7Hb0vu9pF
 RNl9NDdNaThGKEos1OSpqKThsn5utxb+MKlO0vwAE77OX9lmE22RrsppI0FT3Uqj0CKs2fu9F
 ZiIZQIkBRQNW52gSVI/1Eb/c4LwjEKYIWfTsq6/hEZQZXrPqyYa0GiCMNMZW+2TF3mY8H4G9C
 4sGPfeMpKAY0obX9Wyw4hxOWBqq/3vRwhaPZUFVJPT9jpDceNeGe9291kcOXznwddZM74hy9K
 VK/d6PXITY6dU7+hR4IbZCcSaK7XEEf4nRMwwQh/2G/CbVdiwe2FvBJQ/DwFODaRfCxVqUjec
 GEecqlGepveSALBy9ruz/gMUV96cXmfC1oMhmQfSLPxfMUnE6u5+W4RmzILKpc5zFlfqohwsb
 43CTr0pQlUnAR+LXK+BJq3vO6U4DEt15+SpUa18QN2G6/Dl4IGA8q1/ICoSVwUhUe7iulG/Lm
 TONQ8iv2Vehfi2/RfB8uWsPR56g1bhdKcagMDBbPSps6dGoObeCkULYqzi6DaAUVId3wcgojL
 TjekP/WoUrx3DkE3xiBcVxGEJY4kyZejiA3JW212fRQAsxyu4lfzaohXzMY8o0v4iEQbBphMt
 Qv1pOBeXfuF3LEahEuKNIrALFaL3axVzcsOqolpX8kHBIy2Kxfw5UJYtgVk1mv4liUNoFMlTg
 jmLGdmimZgfGUyDXOGtr5jRhd39htJIsVEGU5C3jbMyPZ1QdntOYrQeENn5Jd4YFjZgQh4bVe
 CO9qL7/3yK8gGTwiAiipq9z5OjPS17srSJnjvfbLRlChBZvFkHRc0itWds/7EU3DlfejhmMeN
 cUrV9XzKmCEzQ7tRHRieNI+7tHsnUhJ57kB35zTwKsxc4y+XVvEcU0xUg5cJHb9x4ZJ7zYCcg
 /Grntj2+4VRjeE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-71259208-1637668341=:63
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Tue, 23 Nov 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> [...]
>     $ make clean; make -C contrib/scalar test
>     [...]
>         CC hook.o
>         CC version.o
>         CC help.o
>         AR libgit.a
>     make[1]: Leaving directory '/home/avar/g/git'
>         SUBDIR ../..
>     make[1]: Entering directory '/home/avar/g/git'
>         * new link flags
>         CC contrib/scalar/scalar.o
>         LINK contrib/scalar/scalar
>     make[1]: Leaving directory '/home/avar/g/git'
>     make -C t
>     make[1]: Entering directory '/home/avar/g/git/contrib/scalar/t'
>     *** prove ***
>     error: GIT-BUILD-OPTIONS missing (has Git been built?).
>     t9099-scalar.sh .. Dubious, test returned 1 (wstat 256, 0x100)
>     No subtests run

That's cute. You seem to have missed that this is `contrib/`? The
assumption of pretty much _everything_ in there is that Git was already
built.

Try this at home: `make clean && make -C contrib/subtree/ test`

Yep. It "fails" in the same way. "has Git been built?".

So if that was all the evidence in favor of that misinformation "Scalar's
build is broken! Broken, broken, BROKEN!", I think we can now let it rest.
At last.

Ciao,
Johannes

--8323328-71259208-1637668341=:63--

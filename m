Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F038AC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 11:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbiCILuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 06:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiCILuu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 06:50:50 -0500
Received: from mout-xforward.gmx.net (mout-xforward.gmx.net [82.165.159.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C039F25EAE
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 03:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646826583;
        bh=qboTK8AADFgjmCa+vnUWOWGnfvu8DgOsA6UXMzu3FEI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cpL8FZYf7TTyyBe0jDWOXAgaVFyrAjLqlRISLD8+He1RZtqCf2ghBimp03bao2rbV
         tr9udoyim+KpfGAQuQU5B/NZxEIUF+yDSXvPpXI+AZKn+MLicp5SEAxTi2UIY00ME8
         KN1xyECbA5n5m/laxicRSjoFjQGYIAlGDpSyL7dM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9nxt-1nXfZy0Q2n-005mAL; Wed, 09
 Mar 2022 12:49:43 +0100
Date:   Wed, 9 Mar 2022 12:49:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
cc:     Christian Couder <christian.couder@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Community <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: Git in GSoC 2022?
In-Reply-To: <22e484c3-f313-5335-5f34-5df019b7ee98@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203091249060.357@tvgsbejvaqbjf.bet>
References: <439ebfba-d493-2cff-434a-b1073e755688@gmail.com> <9d2e58ab-2d8f-0797-84ed-0c1e8941edaa@gmail.com> <CAP8UFD38WDwMKf3tMKGt6hMxmsuZk2JkDRJaOZsXFqHvbVLRLQ@mail.gmail.com> <nycvar.QRO.7.76.6.2201281114440.347@tvgsbejvaqbjf.bet>
 <22e484c3-f313-5335-5f34-5df019b7ee98@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:e+4e1NmsH0zn80RgCjYU5U2q7r1bTNvlyWFyOqWHDw85GkWvGu/
 67Hv4HV8eCVtWYSRrdEq/dqZdQZxiVLzMhgM1itX/QcwmNPyr+KsnStTf7gyyAmxDS7qoda
 SU9cYms+ll1nxQzRGoEeeK4eCDCHW6ri+3v6GIo/y8pCJNkuOKi07Hdu1AjeuwFEb6wrZtn
 UwGpXw+UyaYjMo3Hvea1Q==
X-UI-Out-Filterresults: junk:10;V03:K0:3Q5WDzNmn8o=:ltg5AK5zmEsCWsdbtf+r3tvv
 /IRbiVp7P6sjMcZjHeuGa868SiqJswarnvXaWKr8/pOlFsv4DjntGyNiI6R/kSGyGfgMdxjOo
 P1PNBdWEVkj6BxmDcemjV/lXh/ZxfkGj2MgMEH9yqlV3jDCuDH/PtZRVhGeb8aYBxX8NEnnkf
 vQ3Y6ZhIzAWfUpkjCpXb9DVXjAp2FV1jtLQx2/3FkqAXga9OEWwL1YrZxNBPBlSuFvdIn8gg2
 AHOXQO4H2oVDs+y0vOnN5nOmtGhcTBl9tDRYq7Cfq6scRrNJyyGE9FowkByc8sgSPHRrQ9+AA
 J4G3BZKixNGRrkzj2an0hxBSnoElmUNRZ8HDeA/i+PVa4PZGHMXnnsuGKjHhL2zGlONwaZARC
 cHnpXZHQozq3vJWPFN1exoYKbJCYmk4/Oz8//th5b4cedPmSV98J6zirClxRK7kQhwWyjM5vS
 oRap/YOnq0Zjamx7QQU6dpSFA7A00HIdpA+vez9ST3mKv7c9ESgcRGxTi8c7fiBp+tDM83zho
 s+fP9rAZS2/dSNm/oOebs5LNmtZGEBSz68EFTgdt1OrB9KllQRSZs1AYJBFRi29cy5zi2lPNb
 S70lsYnR6Xy0RF7KGABs2ARpqHmtArmNxLNTjbAtpt5KoKvYTrprhfyAKlB3Y+lT5B6xn85Ic
 bkNIJv8dTi3GBiUuz2ZgD4jJXJxrFMw7zRcK95GJkItOYzeiMFCYyzF5nALoOyOa+u8RdgH5d
 3wQjf/gWX1mBq30k2XT5j3fMAFTLTQYXOm263Zd+d6EiHhYxqU7CUkEO2YZaRzJcC7/dBUae9
 4Q3ZJhBAvSDtW4FxoCp51qZZAIf0a+eHAvuH0ZmBFL/BvY0Cbb0WhJwkn2hPLCYMU+Ww8/QCn
 X/vL4m1oXlWuUKNJ1fXqo6N8z/nRPxCcDwakbygUbN6f8xmTsRtfn4GtekoSgs1pJ7XfJuqpz
 nkoTkBgDddI2V0WBeeqWFfAj9NyosE6fwdv+vRZ2b92aI0DlFcdLH4jSyTQeI7JkQVJ7v00dT
 TrjFBqE3Q/D/wvpp9OyqQnuX8o83I4wENCtxeoHA5slqA63zNu7c51fYonr4E3+MiJ22dqHHT
 KxHfrRrMlPlQsFqq1yNn66PHhArWO0YTEpIjhqA5lU78j7MkSRYDu7gIOwp5p+K+PfJfefIJo
 4F8rzFEKoS31QEgDi8xq63nH
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kaartic,

On Sun, 30 Jan 2022, Kaartic Sivaraam wrote:

> On 28/01/22 4:15 pm, Johannes Schindelin wrote:
> >
> > A project that I would personally find a lot of fun, with a great impa=
ct,
> > and never really talked about on this list, would be to offer a good
> > replacement for the `git daemon`: its purpose is to make it easy to st=
and
> > up an ad-hoc server, to allow developers to clone/fetch (and even push=
, if
> > that is enabled) via the network, unauthenticated. Now, the git://
> > protocol has served us well in the beginning, but it is increasingly
> > obvious that we should use https:// wherever possible. Wouldn't it be =
fun
> > to have a `git daemon` that talks https:// by default, maybe even
> > optionally offering a real web UI via gitweb? This is not as huge of a
> > project as it sounds, Jeff Hostetler already did a ton of work to that=
 end
> > over in the Microsoft fork of Git: the `test-gvfs-protocol` helper is =
used
> > in the regression tests to offer Git repositories via http:// and the
> > biggest task to convert this to an HTTP-speaking `git daemon` would be=
 to
> > rip out the GVFS parts. After that, HTTPS support could be added.
> >
>
> Sounds interesting. Would you mind drafting this into a project proposal
> for GSoC. Then we could add it to the list of ideas document [1].
>
> Also, would you be willing to mentor a student in case they pick this
> project? Or would you rather leave it to others?

I would _love_ to mentor a student, but my time constraints do not allow
me to do that.

Sorry,
Dscho

>
> [1]: https://github.com/git/git.github.io/pull/540
>
> --
> Sivaraam
>
>

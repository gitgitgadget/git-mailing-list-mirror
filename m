Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DB3C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 19:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbiBXTXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiBXTWz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 14:22:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E259FEFFB5
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 11:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645730535;
        bh=ddlnIZosXDPxq9tY1mN6hMQztahOvtD1sxpBeHqOucI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fqbVPKLz8U0pd/0D48FXBIWCEowuw3JKRp2AV2FpMVOPPpnscjuQ+H/vInw1HQF0I
         fTcAqnLiuv5ka1Swtup/P9afNatm0BFDR9Wo60JQwG017Iki2M8X9WMpZkouj3bvGt
         oA54tE6tkGsZ6qTEQ0G2s9grahPevPBvfA7WzNC8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GQy-1oIK5X0XxY-014Eyf; Thu, 24
 Feb 2022 20:22:15 +0100
Date:   Thu, 24 Feb 2022 20:22:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH 00/12] c99: use more designated initializers
In-Reply-To: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202242017590.11118@tvgsbejvaqbjf.bet>
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-731122540-1645730535=:11118"
X-Provags-ID: V03:K1:d/D3jIoE208gmmiqpZkkxbEXtBY/hwVxF6BDB9A36dCrQxpmaVL
 SDUX+QA5rGAGwx/OMYzrhY79IIV/N7dZRnrY2IJUKY0KxBaNWaKSnGKxLbiz41Urhgz0pGy
 llSVqHcEdCtUMDAJJxo58wLh0LXJtRHzkae+WuS6NBDgeTjJ7HtVDNXOaSr2DgiNbfU9pkz
 xfQwWSQ2k5DBwI3lxJqKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ssDQVkyd3bc=:zaxeNmVxl9ccSpZiwrecyg
 7EOv+v/Jl3OpnKspZ19KzmTQ4EaMjGlY+fvR8m48Sovcmwo2lbRa/Prhbn4FmwSgrZOUmhkTe
 hje1RrE2sBNh1ao+4rdqFo6FykRPUToUu74TV5btS5EwrSbEHB49IF0fTKoeisA2HIkItU2dy
 mBz1MAB/4VXS2zQhUH3n0G2KKcegBGjMdk7N/lCS6gPyYMdXoWl8gCOlsyb6yKATF6qJ0ykVT
 fgH5bbC2IhVaf1EDUKUtkbipfBq7igydbMhjxaKzfNmADz15mXW6XOZ565vtyZK+C3mepIftn
 h7CGj3ADf4qcGEoUQgQoA+yotVYfWs+XZAqOnZcx+YZYu44mVL9JQf1DUupOR6wfL8tHV0TqW
 WaHJEJeuTZYigLlA1+qLYgd9RNRqxu7EcCcc/bnwi7KfroLCOWhcJu7XgIgewahKLo496f/rK
 lHw/uk09AQ8RzwkFtql70os7eX8LY7MJ+kBV2cBpW9z3gZm4JgjFDqtQNCjuGQlBI7PqlTRff
 1ogMT3uL5Cd8lefslipKbE9uY5Tpa1zj2jLhHDtLWCN2N4ZDbcxQlIoy44bvTEX0yCYbTJDHs
 3x3ATC6Cyr6zU1zT9Ha8RbgHVtvVAHxjCLkodL6cSzdAVM5kCL4ifMTrPTNa3QFYPkbZnkZcG
 utFeeMuAgyqA8u0FflGuONjQdytIR6sRZ5MYSUEAveyCj9sOXcrLrEAeoLdk3gBBjaRt8A8fM
 ykz7zZjmjCunqLlUWOg5C64pnWBCyte0ZaKns66D7WWp0kczAH1YZ8UeJ7qhOGmvZGb6ht9ba
 U+fAU7/jvtXVOnZ0M8sNJyr/P9CCjjr2puYQYr+svbwfDAQlQ+SYiHY/HJFF9WsujXAum8qQa
 56ITmCrewnZO8wplk0Z+PErfaYWvG2ifjHq6AvSCTL/Eo86W/8BUpajtEEK0iRkwo6vT2TiPS
 mSDmpKoJXSZ9fuzC5UhFqN+ZAXPdNGcnocepaQk6Cr9hBO+/Fm42IU6N0MkAmXs6ZJUAPgi/z
 r9qTLpkLVq7epSJ3ei24iF43m4/xceXpwO279s68RDF0bl+stiGCpHu15Bk9o2exf438Znvvd
 ukxoQcITctav/4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-731122540-1645730535=:11118
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 24 Feb 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> A follow-up to 404c4a54624 (Merge branch 'ab/designated-initializers',
> 2021-10-11) and a4b9fb6a5cf (Merge branch
> 'ab/designated-initializers-more', 2021-10-18). These code readability
> improvements are something we can allow ourselves now that we have a
> hard dependency on C99.

This is probably a bit premature given that we still are treating the
C99-isms as weather balloons. The idea was to keep things in an
easily-revertable state for at least a couple of major versions.

The referenced changes are only in core Git as of v2.34.0, and we are not
even half-way through the v2.36.0 cycle.

Do not get me wrong, I have nothing against this living in `seen` for now,
but it should wait before it advances, probably at least until v2.36.0 if
not v2.37.0.

Ciao,
Johannes

--8323328-731122540-1645730535=:11118--

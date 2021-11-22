Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF2EC433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 13:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhKVNYc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 08:24:32 -0500
Received: from mout.gmx.net ([212.227.17.20]:33819 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhKVNYc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 08:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637587271;
        bh=4JLAhYi3Bffiiw4GAvpFe9Z4Qm516ulYsPg3jnayukY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BJT3wfiJc8kd1+oWlzORGys2Yt/PNr/LXLLNwANZoo3s3/u32NSGrb6az356NO89+
         pOuXvyU0TiWpIqp4f41+I8uag+6w32gIWMPQbO9rnYLrG3TM0SJmb+G7ZgXcznounO
         L5s4ZyFsh1iMJdEF+hoN61ywVoNK3puu5lHs8l9E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwwZX-1mQ22832j5-00yOIS; Mon, 22
 Nov 2021 14:21:11 +0100
Date:   Mon, 22 Nov 2021 14:21:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Anders Kaseorg <andersk@mit.edu>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v6 0/8] protect branches checked out in all worktrees
In-Reply-To: <20211113033358.2179376-1-andersk@mit.edu>
Message-ID: <nycvar.QRO.7.76.6.2111221417100.63@tvgsbejvaqbjf.bet>
References: <20211113033358.2179376-1-andersk@mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1267870995-1637587094=:63"
Content-ID: <nycvar.QRO.7.76.6.2111221418550.63@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:9ELbqf4cQlO9RskEFWLKl5TNcTUlDhLAFu4Cyi8BihPSSdO8YJI
 3F+WhJQJ2IDW369JUE9+cm9HA7ZUsCKsMD++WxZAp+d7ipNp4L7o2bRw2zzD4lCm7NmJDwu
 msQdCJXLvxVxH5zHFtUyO1/NYxtcPXrV1l2R4u+mS/EZnjNQuK9P3KAP4k0nzlnkwESlJKG
 bWHJg/KeVy6hgU6CuOAXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bt3RmdK9Vr0=:kwr+czmIPXr0AXvxIj4YtP
 SxLDHzHA+MpQUKHLQkjMaRz68qoaDD1+iXs7NoPsw7ISO1fW46jSJRvbg00GHCrQ0wOQrH7cX
 aTrtExNGP78XFP92lMG0hVXybN1XWYRwc3uSQFIWgaJMm1UDO8AaFp1UGzHGHBWZPd1ssfezL
 w7seOrqZW18eRZbyup93zSviT5AkohS2sPDCWfX0ruqeA4Ip6zuXB1bpzkN3RWuvc/gKPB8+w
 OApb4KhByHfFEMmUolpeuqlZcwPRChNrjSC/d1R99wUua4/agRCGCwl/diZmjXbk8Q/qbPtpC
 psRdtQwM/ggucUJMcFBK1B2ZWUfpYYxt6rUzWkEhaE8y9S5cROWzLVjXLz0767Y2i3TXfcBye
 qv9PkBhD3dMmUheU/BFVZ2KWMarmKz6V46mEzs+w2Z34JcFumELuHOtRTIqWedvclm6yyfKgY
 CfIIAYvvar3ixOrGC85Yu1CstRHKwXJY9OcJFLc8XQhlJeAHhiudH9HQ95F8Bq9cfazU643xm
 V/Ztyk/sJjN5RFlvB+Bi5FFZeGLuOll+DeYI7zQoniP2S/R+fMupvHpY/Ak6DBX1E9c37QNvX
 8tshXjB76hdEBnUqM4+5cb2OONpqIsQQ8nPSGrw93W2GMMbLCvkITW5h1Cu4Ipl2LSLNQPrOX
 z/E7U9MQJMktsECI6DAZJvXcPvSGX4OBUSsoNzwzi5Ryjwa4YJaYhLaP3YKet8N1Ennqv7+Ew
 NfjMM8ZwIgD62M5Ti4Qi4SJUwAlJWTS3wBGEJV5pOE7gZnnCalCl8FTP9qakKn4LvvMBG6P1y
 80LWw0XQmAcuN5Gqtqa8jST+zGEnfaKmIY/HRVlNt/64pYxc5LpJqxnHzo8OJR4BGkbpcj1e1
 n0HC2q8ZfvWtmeRfUXiq3Z7XAqV7pOq8yJQjP9W3FyiXvX3xtIhqLWZbATcxcDe/q/yBtkGcP
 bBmIxJ7aB7LUXdIE87LjFIFHl8mc8PZrLdw2g/cQWUvf1fWDpVyLFMfcZe0sWIVTx3lWuJ1Q8
 Ews90Aqv3u3ajvRfaLYsKUi2Wgb3ZML+f5VqmxHcQZVOwCRxrNjCZNEY7vOwLbBROwNnT++Ed
 d2QO+HPa1dlNOY=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1267870995-1637587094=:63
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2111221418551.63@tvgsbejvaqbjf.bet>

Hi Anders,

On Fri, 12 Nov 2021, Anders Kaseorg wrote:

> =E2=80=98git fetch=E2=80=99 (without =E2=80=98--update-head-ok=E2=80=99)=
, =E2=80=98git receive-pack=E2=80=99, and =E2=80=98git
> branch -M=E2=80=99 protect the currently checked out branch from being
> accidentally updated.  However, the code for these checks predates
> =E2=80=98git worktree=E2=80=99.  Improve it to protect branches checked =
out in all
> worktrees, not just the current one.

I read through these patches, and in particular the last three were a real
delight to read, a highlight of my catching-up with the mailing list
today.

I am very much in favor of these patches to advance to `next` as-are.

Thank you,
Dscho

--8323328-1267870995-1637587094=:63--

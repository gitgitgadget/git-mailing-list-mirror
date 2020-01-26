Return-Path: <SRS0=UUNX=3P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C43C35240
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 09:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10CE20842
	for <git@archiver.kernel.org>; Sun, 26 Jan 2020 09:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="c12vg9dQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgAZJVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jan 2020 04:21:37 -0500
Received: from mout.gmx.net ([212.227.15.18]:54909 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgAZJVg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jan 2020 04:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580030490;
        bh=7AaywWuf8eMiTvU6OSEyVsEDgZLViQ+uL+aKoJ1/660=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=c12vg9dQ+82g/sGbn918QAhWVQdZ4aIEBZpQm/NIhETnz+wmTuSqBBYyrL+KyfB67
         R3yFC5hP7ikmn3Tt1NCz7N9uC7iX4LtlsWfZe4JSZfTBHVvKYKpfYVYZ4+Tnsm6/ig
         yEdH3wSCFs8OZBukwK+47aOEdOgBCxjaI3w97Rb8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1jNIMH3tfA-00ptHp; Sun, 26
 Jan 2020 10:21:30 +0100
Date:   Sun, 26 Jan 2020 10:21:27 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Yang Zhao <yang.zhao@skyboxlabs.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
In-Reply-To: <20200125083102.GK6837@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2001261019420.46@tvgsbejvaqbjf.bet>
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com> <20200122235333.GA6837@szeder.dev> <xmqqftg6671g.fsf@gitster-ct.c.googlers.com> <20200123141626.GB6837@szeder.dev> <20200123175645.GF6837@szeder.dev> <xmqq8slx51zu.fsf@gitster-ct.c.googlers.com>
 <CABvFv3+OfzK_2Wo97dusaj5nomSJTNghJHJa3=+HKH=-Sw12qQ@mail.gmail.com> <nycvar.QRO.7.76.6.2001250112171.46@tvgsbejvaqbjf.bet> <20200125083102.GK6837@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1536752130-1580030490=:46"
X-Provags-ID: V03:K1:q+uSATUc+TGpbICUZ9vnjnMsbUWF5aTOuulKE0Zx+BDP+tm89so
 J81m2h+a6fQJJfxRpO56k/T/accx/EW4ft1tONa98LvK4iKJBwZ1/Cg2xcqECqYyRRuHQCQ
 G5WH5eSF8zAkR563dbnqEO7bQM7NxO2FIlt2285khDu+Iwo2I1L1HxElaln7IVx76OG89Ti
 JUXS6im+eDvNyOTRQ78dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RI/4oBWKSoE=:kleYB7ASiUStTEP5qNr23D
 eojBvD8dUlIF4PJHJH+bKK4iuPvuB/9YbfoDNG8ZbPuiNCAe3PsyuB307vdoC7RzUk6NCpn7N
 c8AFm9ss7o84PFsSsXk/rTRqBWPVmDn6kvkCsKt7nkeUjWJG5JqxyhLV9yAW+f+Ib8VKKR3I9
 pEuhS8Qou8lYTgZMYBcgWR4IkGmOXFmBufA3ccE8IytYBDqW34Qku1jPKlSoFG/FrpgCaZKNL
 VS6ANUNCjHcNEMQM+L5LB6BojU3N95xX58Ibvzb2BOVN+YSeKmS8WP6e1CyrQk+Hx+7c9lujv
 B8W7M9Q4dQnzk1os67w9L2yXO20YSoxMi+kmhXVbShV8FiPDXvEiVwkrCj9ACY9aPpHq2gVcf
 Q2R4S9oDWjCtLYN+UqeQGOf+BeVm/wxvLNgxBpve5ezrUCcESmJqrGlCeF3T/qZddTEh4xG2h
 9WWpUQzTV1MufRbDqH2Jm9KL9l+tjB2uJmK7QkXan7qkmK22nwrhwGTeMD7mwzDnZlld5DFA6
 lYrDxhX7g2NZkfS8p4U2T0ifBT1h7SICAe/tEiRw1vxCwq1ugyav1u+gg7CwcOvpk6yS4b/pI
 t4hf36EoYXcQlntpHt95sqDXqQ2EMy4H3OvWWca7SMtSo5v5oW5vy4OQXc8Nt4/gh7AuELsbF
 LniGXlEryM4KG/WNDW54a5bAt0Y2s3VGhe8kmQ6RBWWwN/f646yzkL4mLCLuFDomG0HFNQiDl
 +sPUscF+foVf7dueKXlYugNnQvrfPlWp1cMmDrJdZ+G0KIH3dg9h/Pvt3zxxEdkC+RoFDcLFv
 Bovw05LCR/PjLAUwKUXoBE78HoKWNnPH35/iD1opIs9vlMPBpqr2L+ZA32S5+HNuW9I1wbkNm
 UOEofIBRK87OuMVRI//KdGE1e+BKlSy27sh0QtMvgKHOo4PW0Ss4qcSLNZE+KA1aoATsh7wbR
 8pqEpB0D6K0Jwu1XTq1dJpEbW73DcnbnCcieQ9sGPNMt4crTdqnVKWZnmQtwscEK6msJzeNux
 FEV7Ow22cavBMiVWsy/y9/MG6HbIMTGBcwL2mjcC0PWas/wBW4JUnMtwLf9s7zmIMIMaFQi+H
 NloOq50Cu7hK0gBWtKCWeGVg/JUjshVb7a2Y7l42eUgzuPvprLvKmERiRvYXFs6LwSAXo74ZG
 ck91FsCChET0TYOPdNWTUFJw3MYrjf5I4tL4OhpYpzOWgCQSIcHsJA4FcTj1oiF5tJ45Ia43/
 kgSXASH6um8y+7Qni
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1536752130-1580030490=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Sat, 25 Jan 2020, SZEDER G=C3=A1bor wrote:

> On Sat, Jan 25, 2020 at 01:13:52AM +0100, Johannes Schindelin wrote:
> > > I've done a new rebase on master, did the CI change as discussed, an=
d
> > > pushed the changes to the GitHub PR
> > > (https://github.com/git/git/pull/673). osx-gcc test seems to have
> > > failed something unrelated to these changes, but everything else sti=
ll
> > > passes.
> >
> > This is our good old friend, the flaky test case
> >
> > 	t5516.81 deny fetch unreachable SHA1, allowtipsha1inwant=3Dfalse
> >
> > It has been discussed before, and it seems that G=C3=A1bor has a patch=
 that
> > works, but that he is not completely happy with, yet.
>
> Hehh.  Do I have a what?! :)
>
> This is what you mean?
>
>   https://public-inbox.org/git/20190830121005.GI8571@szeder.dev/

Yep, that's the patch I was talking about.

> Gah, this is not how I wanted to start my Saturday morning ;)

Sorry... FWIW I would be in favor of the reader approach ;-)

Ciao,
Dscho

--8323328-1536752130-1580030490=:46--

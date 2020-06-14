Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0A1C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 15:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1AD020775
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 15:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JMLiCtED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgFNPdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 11:33:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:46565 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgFNPdA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 11:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592148767;
        bh=/W8ETsVcnheRDW1tlB5fC9xCkULzuKGm0tIhUALXB4Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JMLiCtEDN1PtcJGL0lzM7B3WSDkvQHClc4Sp7qa4C6Z/mDQIZ39T8Uin+500dSWD5
         macfkAe2Ze1EZJeNs1D4eo40eXJQepvT8SWlnqhsF/HdNP30r6rFoTXTQRMo0ImWNR
         BKsVR25HjC/I39Y8MywF/V8lZttIPZl9DMqvSXMA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.215.43]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6DWs-1jr7OJ0chM-006dqm; Sun, 14
 Jun 2020 17:32:47 +0200
Date:   Sun, 14 Jun 2020 04:59:32 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Derrick Stolee <stolee@gmail.com>,
        Don Goodman-Wilson <don@goodman-wilson.com>,
        =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
In-Reply-To: <xmqqlfktbpnf.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2006140458200.56@tvgsbejvaqbjf.bet>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com> <20200505231641.GH6530@camp.crustytoothpaste.net> <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva> <20200611115215.GQ21462@kitsune.suse.cz>
 <CAGA3LAfpoXDQryOPGg3g-4brpUcSAhL_2VOw8oy6D2ffp64hag@mail.gmail.com> <f27450d8-59a1-dc0b-f741-c8c883b95fe0@gmail.com> <xmqqlfktbpnf.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-933373225-1592103574=:56"
X-Provags-ID: V03:K1:LGH4yxtcwPkbciDG6B2NuYxWowpDOMBU7wTy/LOHcBfLflRAvcJ
 KiD+OmwtCLEI5KWW2Js22cyWtOxoMD8+FpQsfQUDmegGukgWyOxHbGBySoHNxoGO4ntTzAW
 w5+b5rcit0OMbfOS5GKA4S/hnm3Ag3KXglG769dGzfSmU0Vxf/QF8kOnRJOzEO1Xk0G5Osm
 DtYkD0tsvu5ftOnpCrwGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aIl22T06Cx4=:j15paUTvMXJo9mtbGT2YE9
 xgBrrvRETbq61EYpf6UqAE7Z4XAqkj/MD2tmsSywcYO4TVK16Sa6y26bIZt6dZgLyWUsWVmKv
 b7NouuZnRQd/kTBTErdsyohhVPdHQAdHjctpGxEcr/GprzwD1lGCoETkuHmAjXFoVhujpZq6e
 wFCDVL9Bdzt/BvBqVKg6FOVAJ3MO4mWwtEfDamIEXAHb8KoLyE4vq018OVUrO+Val9ybg5DVl
 G+D4d1t3kpPCpzpbmH6gSOzC4v2PFYPTLWoR0BWmvjIjL7kxfGALQMNvGdpgIiarZ5sNIdXbT
 MfYzeEINsoy0MVm9tktUX8AhqmlU09T+Is8WmF2xcUiVDBXfiDm0VRUe+CxhsY65nD+EQpW1F
 I8W+uzzyVLZwfBaLZOHb5ecGCfp9EuZRzu+r6wg5KbDqlg77+kM6g7WWTYxB8wrzV8PQ1pN4X
 9sfhhmVpEDdRquQFCz11285Ql2wR0CbzvLC8zjVU06JWym40PiMgNQ/+VWRdBr52G3AJxEdfS
 /FpivIufSDQ+M1ED2uASB9+QWuqSSS439h/nBaA/Gk9+ilqIJmhxbER0lbaPUoiV+MwHmPcYx
 r7/0JmVrobdmjfyBzKfph6iTZBCPIFjfKyTpBk6AaABl/DM0D1X+qK+Un+XcxP36X0q56DEQ4
 1qh2VYJwIDwgqx/4yzc9VsIN6CPIc4gMuzh3LOxEvdWfmLlF7SgibwO6koGYPwVgnjozzMoUU
 6Gjqa5UqLadpyrr/bhbnI5Pwt5XVsHSLX7rWzKE4WlpWbqGq6ezMiePANga4xmdenHEOAj/fr
 Am/BXzfi5f8U1NTg16+a2osFsOxwyu//pl38+XtQDFmVfqx2WoXzpf36trpHtiX53DCYvd8vF
 XBHXJmM/b/udXD8ArT5tZbZRCJNis9x/C/0WZkV3eBKyW/b8gBbM6adLxpcs2LaMJkrONIovO
 AYJemQ2pbXzEv3X6Eme+Ig0qngZFpNu413NKNVkELvsaYVYWIYO50RHJBkkGLBtMnSP6TfSj8
 uMNT0lKixEGnfeTj1fNNS2F+8cprPepB/+U4Icgk1RAJDMP+BfeaeeqXkNiXBTskRDafVaRBV
 yZTXh+4dCIxa4fMs0Uld++orJ9ewktSHV0Z5oXhsccRt9fsxY5F6SbGF0RHRAH5BB4KGcgEUO
 s3Bl53CUQKW2pxBlISUudoJh/gYwgNCSvaFzHn7P20OpF8xRgwH6h8q6IQcw/M5t2FvNdCLD3
 KZnU6PvaIRUAfBz6u
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-933373225-1592103574=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 11 Jun 2020, Junio C Hamano wrote:

> Derrick Stolee <stolee@gmail.com> writes:
>
> > On 6/11/2020 7:59 AM, Don Goodman-Wilson wrote:
> >> On Thu, Jun 11, 2020 at 1:52 PM Michal Such=C3=A1nek <msuchanek@suse.=
de> wrote:
> >>> Indeed, the flexibility to choose the name of the default branch can=
 be
> >>> helpful for projects with specific naming, especially non-english
> >>> speaking projects.
> >>>
> >>> To that end I would suggest adding -b argument to git init to be abl=
e to
> >>> choose the default branch name per project. This should select the
> >>> initial branch name and also write the it as the default branch name=
 in
> >>> the repo configuration (if git continues to treat the default branch
> >>> specially).
> >>>
> >>> This can be used in documentation to use the new name immediately
> >>> without breaking existing workflows that rely on the 'master' branch=
.
> >>
> >> I _really_ like this idea (and your reasoning). Seconded.
> >
> > Yes, adding a -b|--branch option would be an excellent addition to
> > the config option.
>
> In the ideal world, users should be able to just set
> init.defaultBranchName in ~/.gitconfig once and forget about it.
> But it is expected that some projects and their tools may heavily
> depend on the assumption that the primary branch is called 'master'.
> Giving a command line override like "init -b" (and do not forget to
> do the same for "clone" as necessary) is a good escape hatch for
> members of such projects.

I agree, and I incorporated this already in the latest version I pushed to
https://github.com/gitgitgadget/git/pull/656.

Ciao,
Dscho

--8323328-933373225-1592103574=:56--

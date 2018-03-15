Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E2B81F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751996AbeCORGG (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:06:06 -0400
Received: from mout.gmx.net ([212.227.17.22]:49063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbeCORGF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:06:05 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcFTN-1eFiiL0pin-00jZ5E; Thu, 15
 Mar 2018 18:05:52 +0100
Date:   Thu, 15 Mar 2018 18:05:38 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>
Subject: Re: [PATCH 3/3] Makefile: optionally symlink libexec/git-core binaries
 to bin/git
In-Reply-To: <CA+55aFwU5fwWx2+DdBp=XCpG2Orx+rA8KxPVtGHxpgHAZs=h2Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803151804390.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180313203935.5084-1-avarab@gmail.com> <20180313203935.5084-4-avarab@gmail.com> <1cabf9c0-674e-c2b3-9977-9c74b929a86d@kdbg.org> <87y3ivdkvp.fsf@evledraar.gmail.com> <CA+55aFwU5fwWx2+DdBp=XCpG2Orx+rA8KxPVtGHxpgHAZs=h2Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1316840730-1521133554=:64"
X-Provags-ID: V03:K0:53LvDV8s8Rqp8atJmp/WcNwZiS6+soGXDkhhrWMMKRwqJfasAgw
 oljaR4dLyCK02qdR8fsAMHdQBFv4X2jq+z5ROEEMmJ5QAdAvi2s65Kc/3pjcbX5PPLIMbes
 KYl0MIQLaumVHwC8mvKrV8spSOJMQNpG56UrqZgsz+op0gBfFpsT2la2SnNkb7s7QFS5vhK
 gV5IKV+nBf6W8SN1WTOZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4Wiagp9LMvs=:b1JLtVUZPGKy3elccBwAkP
 L4oScAnpg0huGj1EbEGvHpIjrYcIAVtLe7HRY/xFCgIQzgjASFOs/EArncbPI2aFQv1uFNdT+
 3dnT+eWSboyJyCAMSJRxQJw8CVq8r8n9aMkJyw686ljfGCIFcdxmeMBlxNi1ueUvIdaRv7PO0
 GqSXaM8kAiOzJ38LJjA6v6q6mzoPbmFDL9pe1HH1JuFjUMSZHWeYa2MLEYTQwTp4kSRXuDlC+
 lvVvOUFtlFO13DqeA01u5lwnuwzLDMm8bou+n2dgqUYx1ZEp4224IphG1CMuhl7KQZwvQqF43
 mJFDwaB7xr7MpQLBpH8X69phojuf226wTYsMtCyfAjsat/KDrUwhyE0Q/QRVdJuRueLtnX+qy
 q/rcngHdPJUIPN0yVpRuSv3ScrKX4cprI8Hp7WlOv0ScC5yN//LKojOfgCA+rP9PVw3S0wboz
 Lk+Hf7EmQrZhN+cpHvsyKCDDARpCHIqaUnAsm7dJ2tQhmyP5Y6j+OFbQXgC1GEWkBTYk4hC4f
 EZmRcPGG0II0A8a0yc/y/3fyRuCdW41IMlzmuEGxpyKzADFzsPjYi2yLGusqh5e4RRiBfdVwa
 ZkpzaApT0GGRM4BpU2JDEeyiELBisEN5g1MmYVurAXiMrXjV/Znb49HZJwWPF9H77Qa3RcJ/M
 E1bQlbR4e+Z9SaOe6S03IrhteaqbRyg1QXGFgmY8WqHbyd+tjH9r6XqWYNai4PZPun2oQ4O4e
 tO1nLH26A4tTsuwErcgE36FJczPeWV6SXyXAovin9p3glqBgPPFpCvzVGgUw1/pHSclgVvmhx
 UHMz9GqE1NvsViSqouJhOJZW4jkw1CllnuKoB3J+pp2ACGJ+y0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1316840730-1521133554=:64
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Linus,

On Wed, 14 Mar 2018, Linus Torvalds wrote:

> On Wed, Mar 14, 2018 at 3:14 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
> > On Wed, Mar 14 2018, Johannes Sixt jotted:
> >>
> >> It is important to leave the default at hard-linking the binaries,
> >> because on Windows symbolic links are second class citizens (they
> >> require special privileges and there is a distinction between link
> >> targets being files or directories). Hard links work well.
> >
> > Yeah makes sense. I just want to add this as an option, and think if
> > it's proven to be un-buggy we could probably turn it on by default on
> > the *nix's if people prefer that, but yeah, we'll definitely need the
> > uname detection.
>=20
> I definitely would prefer to make symlinks the default on unix.
>=20
> It's what we used to do (long long ago), and as you pointed out, it's
> a lot clearer what's going on too when you don't have to look at inode
> numbers and link counts.
>=20
> Forcing hardlinking everywhere by default just because Windows
> filesystems suck donkey ass through a straw is not the right thing
> either.

The most sensible thing, of course, would be to *not* link the builtins at
all. I mean, we deprecated the dashed form (which was a design mistake,
whether you admit it or not) a long time ago.

Ciao,
Johannes
--8323329-1316840730-1521133554=:64--

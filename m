Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4871F42D
	for <e@80x24.org>; Mon, 19 Mar 2018 11:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932257AbeCSLe7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 07:34:59 -0400
Received: from mout.gmx.net ([212.227.15.19]:52549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755291AbeCSLe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 07:34:58 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MC4y8-1ep3NE0GBs-008onD; Mon, 19
 Mar 2018 12:34:44 +0100
Date:   Mon, 19 Mar 2018 12:34:30 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Daniel Jacques <dnj@google.com>,
        Steffen Prohaska <prohaska@zib.de>,
        John Keeping <john@keeping.me.uk>, Stan Hu <stanhu@gmail.com>,
        Richard Clamp <richardc@unixbeard.net>
Subject: Re: [PATCH 3/3] Makefile: optionally symlink libexec/git-core binaries
 to bin/git
In-Reply-To: <87efkkdwcv.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803191228240.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180313203935.5084-1-avarab@gmail.com> <20180313203935.5084-4-avarab@gmail.com> <1cabf9c0-674e-c2b3-9977-9c74b929a86d@kdbg.org> <87y3ivdkvp.fsf@evledraar.gmail.com> <CA+55aFwU5fwWx2+DdBp=XCpG2Orx+rA8KxPVtGHxpgHAZs=h2Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.1803151804390.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CA+55aFz6J2j_o0b1JfPSPUX0t3703oFtrpcot29_cgbKi7EnOg@mail.gmail.com> <nycvar.QRO.7.76.6.1803161248040.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <87efkkdwcv.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2132141009-1521459284=:55"
X-Provags-ID: V03:K0:IDSTqEWajJ+ye6fHhCJkJ3mHvpH689LD9FVJo16SDN5GQ8syo+T
 KPjkT36ZjNMNrLNBdX7jTmrpdUx0q/3jlsgHQfwz1vPGbsE3wLzuJEBqyiBlm6GGZ40bwdN
 1wz0RPZOv65xKyRL41O625rIPbgg+wOGXmK7VQ8iHnphisCvmZpcUQCyqLDMlP7rD7ixAxh
 mvpVdxWLYAdW62F9aTQ4A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:waD1R8PGpYA=:iodpnXPNUM2HdQBRDWu7X9
 HWRvtUSsrmJl8GczgUYKEWTLsIGGyla07z3ni4zyhuMPr9TgDzsTcGyqZ1bqWHQotv4/5VL22
 NWjeQ3IOVZHugEUdSgVdNpPAGs7x1PaxsVI6oWzB0qaIasyvlF7LMuR7NDJpTvnpYHApxhh5r
 jWfrs4xMPpb1OC9967j8SDwUgdsAmXyMCf1keqVFKuTSMfsfF05etmpEovDNZlW7DoAwC5xEn
 QL/DsEtxz05GAFlK6ylxP1DX5a/2BFHWE2QA6C/RS0z2JMFAG2xQPr6Z2NBmXlv98M2zhZMmz
 v1Cz8TGMonnJ8b0lR5nSLJN6uMkELk7UKdFToSU1B4iyW3hFry8sSbguBNuSVvJPX3fre2jB3
 Voh4fReg2PSWZtkIygtLhkZ95JW4pS4lfHTSeY0jVliNIGe4R9ZoGxG+EP40E4JU5oH2Z6Fwy
 SFkrWikhgWH6DUbTzuUx0C8fwdKkEaGItsMtLih7nX2yLrQnxte1dCfi3IPrPRA2pscDSYgST
 X8Dj8nQP/l9XXHZ5xhAzwA15yJtBnT10OjfPrgIX1fDRzztxsaKX/+4YSL+abV3OU+mz+yZD2
 Ty/BUaeGWYBVbeOXKuUA0FTzOz+JHUAbt74sFqrVUB6kVYXE8fa7cWJ+YUTN9cfJHYbZ1/MtH
 xsvttLf3xD84lRv3RaPCSaX3URq6yoP0LXFrgKEbcaIC6zlSvRPHCwtTWZSXgag5Pc+NUIho4
 fPL2gNkAZfR5Fd8w/bkT6bo+fiVqmIrPYXBsIxXzYqJ3AD8dzZ+UwRyzdpohtV9dkxEbZEDYE
 hFF0na2fWEIRjLRkv8ulpvHtCjaud0lw4B2AGSeuTO9VKTMS5s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2132141009-1521459284=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi =C3=86var,

On Fri, 16 Mar 2018, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>=20
> On Fri, Mar 16 2018, Johannes Schindelin jotted:
>=20
> > On Thu, 15 Mar 2018, Linus Torvalds wrote:
> >
> >> We do end up still using the dashed form for certain things, but they
> >> are already special-cased (ie things like "git-receive-pack" and
> >> "git-shell" that very much get executed directly, and for fundamental
> >> reasons).
> >
> > Please do elaborate.
>=20
> If you were to set set "/bin/git shell" in /etc/password it would not do
> the right thing as far as I know. Is that a shell name with a space in
> it, or the "shell" argument to /bin/git?

True. And `git-shell` is not a builtin, so it does not even matter with
regards to this discussion.

> There's also the fully dashed forms of stuff like git-receive-pack is
> part of the over-ssh convention, i.e.:
>=20
>     ssh <host> git-upload-pack ...

Even if upload-pack is not a builtin (and thus still has to be its own
executable), receive-pack *is*, so this does affect our current
discussion.

This is a real problem. And it is our own darned fault because we let an
implementation detail bleed into a protocol. We could have designed that a
lot better.

Of course we should fix this, though. There is literally no good reason
that I can think of why we should not change this to `ssh <host> git
upload-pack ...` (of course with an insanely long deprecation period).

Ciao,
Dscho
--8323329-2132141009-1521459284=:55--

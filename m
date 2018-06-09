Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2721F403
	for <e@80x24.org>; Sat,  9 Jun 2018 20:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbeFIUoP (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 16:44:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:51261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753216AbeFIUoO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 16:44:14 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LxPNC-1gLRqK35Ss-016zHC; Sat, 09
 Jun 2018 22:43:54 +0200
Date:   Sat, 9 Jun 2018 22:43:37 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff King <peff@peff.net>, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [RFC PATCH v1] telemetry design overview (part 1)
In-Reply-To: <900a34bb-4d8b-4a22-a0f5-1d2f6df84945@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1806092241180.77@tvgsbejvaqbjf.bet>
References: <20180607145313.25015-1-git@jeffhostetler.com> <c3ed8128-1184-8199-06e5-a4e96b2bc7c5@kdbg.org> <20180608090758.GA15112@sigill.intra.peff.net> <688240ef-34a1-ee9a-215a-b4f9628e7c72@virtuell-zuhause.de> <9ab3eec1-40c1-8543-e122-ed4ccfd367b4@kdbg.org>
 <87fu1w53af.fsf@evledraar.gmail.com> <900a34bb-4d8b-4a22-a0f5-1d2f6df84945@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-925080269-1528577034=:77"
X-Provags-ID: V03:K1:BmWmdzOIQ6MVEKZ4fJ8i4dtT7PQ3fsFOOCuA0TSTdwH+zpG2SJT
 vNsHE+nPHqMhm3/yRUzzjUBkjmnLY06/I34MPtNfgPBl72X+qt11yi+k5dkND3PXvzjboEg
 NSOJmlk12bog0hCx4Qt0B0ANNY7hqoYbWW/3N2i3FSo7RlK3STLq2hS1Z8xETFz5SpFkCvl
 YGRjcZ35K8+9OMGEQXuFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dguHAYhQpvM=:4Id28jGc/aYwBgKvw2vQ8z
 EvMT1YOlI1sw1Jut/DQ/znn2sNbokFtBGlg09ICZMSX/jVICHPijaVLOdjU/zitkm/ZOYr45o
 pjUmA3w1zUP/rCRdieTKxQ1D/AOibxhltq3tc/TvrG8bnsNIgI/V7sjFemWyKHnSH3ezT7pfI
 IQWuwNUXVs76TzmdmQ9as5azAQhfZgnwGvYwnPOXjGsCe740WXs4jP2qtUvIlArEfcvDhXE8h
 ABOBEkA3GbqsqNGEZh5r0ltDQ9UTdxNm9yesjURANL9txCmzSLZhQeHn63s1pa7N3OophrxKg
 QxUBn03PAJkWsIWOrcSX+cB2I9N6tad3xU1vWyaziJasZUcpBm+SUYzmbKbpDoo8vJliUCyF9
 eAmZkw6n5B/iLwk4y7OozGnCv42J53RJicopT3DXXDn/ecVClNKSepYzHpj4T/5NGFgV7aYor
 Q5GTlwFTNt/AL6kshUboG/KVyJOlgWFZoM27uA/YBl0MuzTU179quML99wA3dVfxt2Nueo7fC
 CDYazykkLPWAAVUEaLfSZHnl4hvl7gYmBAmIva39NWLAoqif5zKgfDJd9qblhfCkIN6i4PFZK
 rcQ9Z5l/ZcsPd/NJi1RtooW/aLFs13GAnlZDMnNbCbR0jl6fYOx9KTanEvGgxAtGexcPaig12
 2aSe2lfEpFdq1JvB5CZcPtJyYkhDB8hQENBr4lJ+JWFOHGwYnjZcxIToclZJfyMMjq9ABFR+Z
 MZ0zI73gKqVmdmXwbznzYdHu/94Kzv5t2HAnaKkKD/Kc1/4bBG5IVcwznxDWhoBc2PjA/4a0Y
 /sgLIFV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-925080269-1528577034=:77
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Hannes,

On Sat, 9 Jun 2018, Johannes Sixt wrote:

> Am 09.06.2018 um 00:20 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> >=20
> > On Fri, Jun 08 2018, Johannes Sixt wrote:
> >=20
> > > Am 08.06.2018 um 18:00 schrieb Thomas Braun:
> > > > I for my part would much rather prefer that to be a compile time
> > > > option so that I don't need to check on every git update on windows
> > > > if  this is now enabled or not.
> > >
> > > This exactly my concern, too! A compile-time option may make it a goo=
d
> > > deal less worrisome.
> >=20
> > Can you elaborate on how someone who can maintain inject malicious code
> > into your git package + config would be thwarted by this being some
> > compile-time option, wouldn't they just compile it in?
>=20
> Of course they can. But would we, the Git community do that?
>=20
> From the design document:
>=20
> > The goal of the telemetry feature is to be able to gather usage data
> > across a group of production users to identify real-world performance
> > problems in production.  Additionally, it might help identify common
> > user errors and guide future user training.
>=20
> The goal to gather usage data may be valid for a small subset of Git
> installations. But it is wrong to put this into the software itself, in
> particular when the implementations includes scary things like loading
> unspecified dynamic libraries:
>=20
> > If the config setting "telemetry.plugin" contains the pathname to a
> > shared library, the library will be dynamically loaded during start up
> > and events will be sent to it using the plugin API.
>=20
> When you want usage data, ask your users for feedback. Look over their
> shoulders. But do not ask the software itself to gather usage data. It wi=
ll be
> abused.
>=20
> Do not offer open source software that has a "call-home" method built-in.
>=20
> If you want to peek into the workplaces of YOUR users, then monkey-patch
> survaillance into YOUR version of Git. But please do not burden the rest =
of
> us.

We already offer hooks. You can do anything with those hooks. Even, if you
do not pay close attention, to transfer all your bitcoin to a specific
account.

I agree with Peff: this is something you as a user need to be aware of,
and need to make sure you configure your Git just like you want. As long
as this is a purely opt-in feature, it is useful and helpful.

We do need it in-house, for the many thousands of Git users we try to
support with a relatively small team of Git developers.

Ciao,
Dscho
--8323328-925080269-1528577034=:77--

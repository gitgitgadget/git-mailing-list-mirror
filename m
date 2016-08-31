Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C9471F859
	for <e@80x24.org>; Wed, 31 Aug 2016 20:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753802AbcHaUhN (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 16:37:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:63662 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753487AbcHaUhM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 16:37:12 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LaFmY-1bFR4n16di-00m3O9; Wed, 31 Aug 2016 22:36:51
 +0200
Date:   Wed, 31 Aug 2016 22:36:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/34] sequencer (rebase -i): learn about the 'verbose'
 mode
In-Reply-To: <1472668767.4265.73.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1608312236210.129229@virtualbox>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>  <68118621a481d786dd57d5c7fd4c3ea0a8e61b07.1472633606.git.johannes.schindelin@gmx.de> <1472668767.4265.73.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-889169325-1472675811=:129229"
X-Provags-ID: V03:K0:QHOSCDDdHdHGOEqg9fI/B3XQ/TrUalKIK/RwpcypXYGq2l8m2io
 bG1k1Eb+c8DmE18EwJAWIqYZu8YQgN20sr7oiNHQU4sTu88HQobCySHoaceWo7wFu3nuX55
 nNH9G/f2+3Zpb+wq/uTPEpufd8+bzPMckn+9bOVgMvill59xqXCjmSCZUGMGf5giTr7Ov5m
 118DHpSzZiRsD+TT/Gfkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nUnGNyYjNFc=:9tCdEs1VtGobYIWArB3qA6
 OM8puFT4o9TlNREhLrccfrbBPhqWxl0bEvCm3XSXpDnZIVpn9kO2fN9dzLCK9qgWBPsjCvMRn
 8p8mhoDdpW2cMWCWGXhFmeQf4TMnkB1S7AJDyYQkMqBrW6a6RwX/nUwb80ic9mvLRCqpTBGca
 bpP4FIzy9dJ6KZ7e/TrpxOqImoxcDz3QAyeIc1S8/BkSIFdQpaWiEhC+N6/JmT47c+mECmc1T
 77UICIBqruiQuWWRMWUu8R1mJBSiOYpyDsODEpvpgmCeLVpiPVlZ1gaMnuUK/bJOzqGitFK/6
 Cte/XQraq4bajBSHmhWpbzVkZNra+ugtOuE/8pklOvR8gjpbn6l2QTkMSDpcFpXO6Jc9AlsXB
 qvPFhfWcnLqEyKZw6DlGDbn+Ou0NIH6ufIKTE6xflqMjcX8KuBiZfggHSxJP92QQVe24PQPho
 nuQ8lopqkKu7R7c9f47fIDuWZUPuv3RR2jj3ZA0dXYg7ZApb7ibAqJ3tCcm/4zyijk+GWh5xL
 n0odcszbl9he9nh2Txk95Jt5jwAra4GxyL5kZMoftE2MYL+2jEECjj/J7MVw2U+dHsBILz4Jd
 D0TqnvyhkKWlyzyxA3ZXldFDoNh/MB1uKihR/fnY5k6X0KnGUpl9Inxki/FqvR+gsSwQvKjp+
 69unpEN1i8aLX6w7iQQKDzTU/lQogVLTij9/6CTKKV/eq5qi/TV573l7HSHXY0ULsN3s7sWSD
 3mX5kVlKSuKxp7mxlc0s1BVv244Sr3jG2Q9LnYH264TXjV5D2m5bOtczhlFnVlpPdCPQZjuT/
 4rnVMRA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-889169325-1472675811=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Dennis,

On Wed, 31 Aug 2016, Dennis Kaarsemaker wrote:

> On wo, 2016-08-31 at 10:54 +0200, Johannes Schindelin wrote:
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (file_exists(rebase_path_verbose()))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0opts->=
verbose =3D 1;
>=20
> I don't see anything in this series that creates this file, will that
> be part of a later series?

No. The sequencer does not write that file, but just consumes it. `git
rebase` writes it.

Ciao,
Dscho
--8323329-889169325-1472675811=:129229--

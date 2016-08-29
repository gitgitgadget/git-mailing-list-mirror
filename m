Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F56F1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 10:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756801AbcH2K7D (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 06:59:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:57174 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756700AbcH2K7C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 06:59:02 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MMGWH-1bk5RK2z53-0085mA; Mon, 29 Aug 2016 12:58:55
 +0200
Date:   Mon, 29 Aug 2016 12:58:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/22] sequencer: future-proof remove_sequencer_state()
In-Reply-To: <1472462696.4265.23.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1608291258280.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>  <2245e7db4d4c028f63b2f4c41097559f91756f2c.1472457609.git.johannes.schindelin@gmx.de> <1472462696.4265.23.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1425638870-1472468335=:129229"
X-Provags-ID: V03:K0:nPHAPH7sMVGmMEKPW9lp/hcuHefXk54lj6GNRhkNkGTlSg4PTTS
 K8K6NCQU9lco1HH9srT5lbR9Y5BgF1BikEFXjTQj+euqv5eXlnghDiLcd9dJuDyCE0lnEH1
 9Lizs1Yjl6rUSVTHqZZ6Ex/yrT6xWbXUofr60xsySY1SU/VzgTFmJU3fK8qAy935sovwAU3
 Y+H3QUy6wJHAjqoDgwExg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+JpR/mXyRpg=:0iTvXx/lAMGAG56Nqq5Epd
 oC2jspuvlspqk3D748zWVyl4BpHT5V9uW00v4FbutPfz+edLWGX7s8toVhP/BmRhmPInhsgFu
 6HfU7+JbRRaKij3TACSur4C3NOjEk/7UzcIXyEkylPcJLtic/lyg99uVe9eUtwJKd2o5it4Y7
 t8Tvk30HByOmXslfj6aJDhvI4G2BRI6rKGZZ88UMK5WTQpwtz137+4zLCkhcPIfA8jC1n2Ype
 8qqyx7mQjrPldw+JV6V4CHBBCXN/CAVqSYBdB8cszs00RYtagUhSM0OSiedRf6klyzuGgYhEF
 7JKtTiHD3OrNhvYlD2Bp6YaaJaLnt0I3Xp4YYZ+tZ5StzCPDea28an7U5MGoN9su2xP4Ut+aF
 nuPoSptTUCwUIW/8gK2k11yNO6wvadRygFBa+J1YBd7rTP04g+wZhaLzqgXHIXpwR286m0Yg0
 xseadQ+Kp3iUmwcpTfGa/6sH/mqRR81arOfarmVozAGvTZrG7QuXnEcWLkpCISHOwjhnmcQX8
 BQSWH6MaDE7pnF3Im0LiFkZLsGHYbbOqq7PcE9vTxaCIz/AZ/b1BeKRQL2gIThDenS0SRz5CN
 iQ5eKShnM8Kt2BLv4hG7DJc1BVpjZBLAmuM7H/CnysBSJCnFQAGKnryKFpyxeTcLDWli/wRVZ
 hSItdybIgAJ+LEpxV3NNYuoFyMtAZ0ItOZ6wBeSg5ZYUIc4R4DdWDmAlJa9wybqMbpYr9bC+D
 GrqC23THvTidg7Si9Xe69itj4D7QbEGVDktwqZv8tsFW1vfPb+5/aLIf+tLnSh2BdJWhX+iWs
 kCQyFVp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1425638870-1472468335=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Dennis,

On Mon, 29 Aug 2016, Dennis Kaarsemaker wrote:

> On ma, 2016-08-29 at 10:04 +0200, Johannes Schindelin wrote:
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (read_and_refresh_cache(o=
pts))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -1;
> > +
>=20
> This doesn't seem to be related to the get_dir changes?

Good eyes.

Let me investigate why I have it here...

Ciao,
Dscho
--8323329-1425638870-1472468335=:129229--

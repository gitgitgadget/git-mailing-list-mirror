Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126FF1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 15:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755151AbcHSPAd (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 11:00:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:56223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754245AbcHSPAd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 11:00:33 -0400
Received: from virtualbox ([37.24.141.212]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LwaQZ-1b6Rli2IW7-018JCd; Fri, 19 Aug 2016 17:00:21
 +0200
Date:   Fri, 19 Aug 2016 17:00:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] cat-file: introduce the --filters option
In-Reply-To: <20160819085700.GA23254@tb-raspi>
Message-ID: <alpine.DEB.2.20.1608191656080.4924@virtualbox>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <f1e188907f31abef9e82bd6b0da120ab7d9bd4a7.1471524357.git.johannes.schindelin@gmx.de> <20160819085700.GA23254@tb-raspi>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2002993359-1471618821=:4924"
X-Provags-ID: V03:K0:k6Q3Yr7qbtxNAMj9x2jngCkBlCmu0XzCT79OBiH+wfPOdH1R7l6
 gDpNzPJ0QIhzoNCnh8g5Y28rXBjaBt7cZIbLil1e8g+mF/owaTI+44o8RX+/hVafXdBSh5h
 NAUelAjVb656iNgcPiTSYxveAVFR2vrqXUGrfu2j0L7dQVKy8lOyo9V2exN0e57sHojaCqR
 lf5uogAQUkBLpx0Ds68hQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1DXiwMFPhCA=:EvKye3kRuehilN1s9V3Gwf
 nitm0evxxTE20Md5fuC8od42BL6GVoGTWAUZFr3aeEdYcV4mgClfq/jXlQEBz6ziyIz6f453C
 ay2kc3HqoWRDgdn7gBLVlXUlshAWtNbQxbw3Q83nLl1AwCgRr3MKnXyt0RxeWVSjpnu3L893d
 UaqXsoiJ5BYTebV77eysv3c1BJe9e48g+mArbNbsKy3QdBLSUFwJ89izIST/dBHplGib9Y8LG
 fME0xJoDe8WhlfPJT80l8pG5577n7/5ia+ybR08jpTeavj5S9nzx2m1yH9maB58vlgDwNUj2E
 6Pf7vs+6Ik+d5eixqIACZgE1niHWzjMbE8fLeZvkI1TCykhaaHcvu5gd+5eDAq0Bgmau7ReAA
 Cde+hQm99TtFxPitYKzSQ46IsJNQclGjDD+i+AcAKtmbePUxQWRssQX/UHKlCv+je84EMGJtK
 PPddTVZYZ2j6k6ruL2q4YIj8bLwbJ/nLXzQgj1NE4LaJJOLPK2ug535bwDK3alg3HDj9F3t/C
 /Dyk8jHb7D7RlMnJJz8sXv9X8wlorV13+CjUHe9KjeE3DNgDRvKge6qBO/7P2wlScANr9J00W
 xNij/YCxP6mJvWwzm0PD/GUVVess+yiat2W8eQc8Qa2mFVm+hL71HairA3+QVXnKdvCO/Vhd6
 vPSsku5CdpAiMb2o1vccKx7kzcSbTNrHR2nJr6vQd/y0SL8Lz3T7LPCOt6BjYWN2PQL1VgWru
 /UFOBnfb6FpHvcrJLt9UsTAmcbOJZ8IDc1G74gREUSCSWyHTJxUryVMFKYZaLE2NOaitfMPt7
 JnmMDPI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2002993359-1471618821=:4924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Torsten,

On Fri, 19 Aug 2016, Torsten B=C3=B6gershausen wrote:

> On Thu, Aug 18, 2016 at 02:46:17PM +0200, Johannes Schindelin wrote:
>=20
> > +--filters::
> > +=09Show the content as transformed by the filters configured in
>
> Minor comment:
> s/transformed/converted/ ?

Sure.

> Does it make sense to be more specific here:
> The order of conversion is
> - ident
> - CRLF
> - smudge

I do not think it makes sense to complexify the documentation in that
manner. The filters should always be applied in the same order, methinks,
and it would only clutter the man page to repeat that order here.

Ciao,
Dscho
--8323329-2002993359-1471618821=:4924--

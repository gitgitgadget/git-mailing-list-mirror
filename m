Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CE3420986
	for <e@80x24.org>; Tue, 27 Sep 2016 15:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932674AbcI0Ped (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 11:34:33 -0400
Received: from mout.gmx.net ([212.227.17.22]:62609 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754640AbcI0Peb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 11:34:31 -0400
Received: from virtualbox ([108.198.118.51]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LjuR3-1bDeli0wEz-00bs17; Tue, 27 Sep 2016 17:34:23
 +0200
Date:   Tue, 27 Sep 2016 17:34:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Paul Smith <paul@mad-scientist.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git 2.9.2: is RUNTIME_PREFIX supposed to work?
In-Reply-To: <1474982294.3190.32.camel@mad-scientist.net>
Message-ID: <alpine.DEB.2.20.1609271732440.129229@virtualbox>
References: <1474925524.4270.35.camel@mad-scientist.net>         <CAPc5daU_nnHRjtC02bxqRaoU+0Rgi7pS6e912Fqk-Xy=qdKWFA@mail.gmail.com> <1474982294.3190.32.camel@mad-scientist.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-58138269-1474990463=:129229"
X-Provags-ID: V03:K0:5VyxG3kPv8nuKlLfx32bLqoaKLnrrijtixrooEKUy1q1uCG4/dA
 BW8o3qFpkuXlL+yijpMKK/B60o1byiBRg8Zi1JIcC+pkMBtTxMwzIVd/EtOqrtGRNWT3vV4
 817OQ5mh4Q4pyibHUSQZqzEbO50whc3JCiDWZYBANrymeHV1uMgi7ftoRw5iHYg5fBoNNQX
 +UC8kttpgfdqTDQuQOEMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aXz+PVQG+mU=:jHK4GDT2DjHy1gz9vPkyRD
 BQ/4hGeMy2L4tGtW56ZMnzNCzDkaU0jd3KMM41oIJNxQMdR0ww2guGFk6QFzZ/QPA6BJXlgiF
 M1++Q6dRlRCq0nfvwFXqmGvqDx0BVFrIrFuFImp0u3nWKBPGJvwVCCzaXbQTCw1VFsEHD2bxU
 Y/k0CI09W3ycfCyeUy944DFKo4jj3GzSgIHvKaYB6u9PBuuZXzVsvaUTFOmXjLfOfch+QDrSn
 vbMZBX/lFrk+dUsYuJVD3KryxoExpOeW9cXlABihwEdxLb9e6TmBGYSIwgvUpBDmVvTqFbusv
 lTgBln5mqJaIOsOEUbTV3K+TCDrh7P2pyPScplcmqYFIXrDZKsT5js1QvYMb03j5tqYMt0RIa
 G6xIJXqkX1uGlE8q2xTkB37FyrStkdR/yLoDEc9O0l3YJGViqqFM8/JfZvlzSbfbBjlw6d5L0
 49bhjgU6QLiVgsKpk/9G3nQw9VKd2pfOmfLnZ9FJsXfMJBszg4MK5vQcmKOmQd4JCZRnxn6ML
 fEUpi9h0jZOcISNvZ05OoXXdYO4HS0s3dsosNIFIjQga3KoRiuB4It0DbBe21ZDGjiupWxsrr
 d+zCPHagKTIEQm/Zqeb/WTh7Y4QMtBsAOQenbcK0IJ68ioarMWKzs09Isbg98VXpmEGE+sEH5
 LH1gCzq3wBNGELR08wDZOEeg/WL3OtxMFpV5gcqFZZZA9Mhn2ohvRpQw98Nx1T0cYk9BKp+Ia
 AsKXLRdjXK/LeLW/IvhKo4NsW0ING0XA2yYEOXgF8NBXU6v8MruTCJ0fcpx3EPvfOh2dRFrHC
 yl/oGwu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-58138269-1474990463=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Paul,

On Tue, 27 Sep 2016, Paul Smith wrote:

> On Mon, 2016-09-26 at 14:57 -0700, Junio C Hamano wrote:
> > On Mon, Sep 26, 2016 at 2:32 PM, Paul Smith <paul@mad-scientist.net> wr=
ote:
> > >=20
> > > Hi all.  I'm trying to create a relocatable installation of Git 2.9.2=
,
> > > so I can copy it anywhere and it continues to run without any problem=
=2E
> > > This is on GNU/Linux systems, FWIW.
> >=20
> > I had an impression that the setting was only to support MS Windows.
>=20
> Hm. =C2=A0You may be right. =C2=A0If so that's too bad, because a relocat=
able Git
> is very handy even on UNIX systems.

I see no reason why we have to keep the RUNTIME_PREFIX functional for
Windows only. Paul, how about giving it a try to fix things? I can make
sure that your changes do not break anything on Windows.

Ciao,
Johannes
--8323329-58138269-1474990463=:129229--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E58962092F
	for <e@80x24.org>; Tue, 24 Jan 2017 11:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbdAXLo3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 06:44:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:62666 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbdAXLo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 06:44:28 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MId0S-1cYBNM2pHk-002FAI; Tue, 24
 Jan 2017 12:44:12 +0100
Date:   Tue, 24 Jan 2017 12:44:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] string-list: make string_list_sort() reentrant
In-Reply-To: <20170123235445.qsejumltutd2vrhd@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1701241233390.3469@virtualbox>
References: <67ac53cd-3fc0-8bd0-30f4-129281c3090f@web.de> <20170123235445.qsejumltutd2vrhd@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-34491082-1485258161=:3469"
Content-ID: <alpine.DEB.2.20.1701241243510.3469@virtualbox>
X-Provags-ID: V03:K0:DkNzQF5m6424NpBDes71QtyLnFLFyVEifYJpcBQBvDgPLALj4y6
 +FZ+SfskXy/4wWHeqyV3ULgJ2EwUEUW77BiWoc6kgIA1/s+BIyh79MgXUHMqJMeUsqgJeaH
 estkNf7tbk5KJj86jVtBj8gv5suS8SaXZZrRWxtW8FJbzZoiCvHobqE8FCZ5LvBX8Ge1HIf
 awIK8Jld552H2Lh8urMsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XSVUPm3/DF0=:9Zx6iysb2fajhyAxa2MpqC
 5/gjp8woyZS7gogdzxCHDB5imev1Qpt1pVypPS7+nzcPDfNztzoDG8t5WvuP6WQrU0ENgrgxV
 lswT7PaR/kAaCzUMx5e8GlneZVmTjA8T4CxSAppNEViVr3kM5/vyg4VRTmwy43ZZkr5tzm8wF
 OP1eiT2vYYlKmZT6WMcjs3DSiPi8f/a12Wxq3IkUI62DYWOPLEq50G6G/9Urtw5I7Udhy8Wxi
 NsC6fnZuIbEfmHIHW0hvpQaydJNK1950asPd82gUpKgi1QGH+aFTY+YS6QRkYQO13KB0P08O+
 cGp52ZrChhFV0UpnS9aPqSl5mVT1p+m0Gz5h2bNjPKYIqqAKX+Fg9xAQI+Ufo8T9B55UNR847
 A65ndNRjTUiXKhGGMBcXMKgTlfbxfv49ORgtFaUI6zcwuNIBHnAC5fzvdvHEjl/wyE2HtK4Mu
 Gqje29rmCbYnsiVDdROdTPosziPdeN81rn54fNZjWbmuZMABaWQWj9FvmxjhbQXEtDdUDJQLI
 R3hqbgTUY6u2wUSYzOh15I1UmY8bXb6gWarFQlBQBcw37Y9rn1tPSZPKkxHXLZo/q5m/+vsTw
 xiYshyCfj2bdpJA/VUMFEjbip97ZZfOs48+EGK2StfV3laWR4vaah6kdVp8X8FdlNgHhLmDjl
 fqYku2YFIAyxH3rOmRhnAzVodOCAmszyrrcuzXcbdmHo0uGbxaK4o3sndzcskVKCDeXhe6fRa
 L4daT8cz/IlYnqAWRDcmI11c1AmwyiU51bqN9BImsgW1y7vEV11w0zUWUTDJKo2yrR0+F5WxJ
 ji5opXF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-34491082-1485258161=:3469
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.20.1701241243511.3469@virtualbox>

Hi Peff,

On Mon, 23 Jan 2017, Jeff King wrote:

> Is there any interest in people adding the ISO qsort_s() to their libc
> implementations? It seems like it's been a fair number of years by now.

Visual C supports it *at least* since Visual Studio 2005:

https://msdn.microsoft.com/en-us/library/4xc60xas(v=3Dvs.80).aspx

With Ren=C3=A9's patch, we have an adapter for GNU libc, and if anybody com=
es
up with the (equally trivial) adapter for BSD libc's qsort_r(), we have a
lot of bases covered.

Ciao,
Johannes
--8323329-34491082-1485258161=:3469--

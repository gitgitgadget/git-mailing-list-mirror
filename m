Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B39B202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 12:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751036AbdJYMOD (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 08:14:03 -0400
Received: from mout.gmx.net ([212.227.17.22]:64082 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750957AbdJYMOC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 08:14:02 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mb8HX-1dspzM451P-00KdGx; Wed, 25
 Oct 2017 14:13:56 +0200
Date:   Wed, 25 Oct 2017 14:13:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: Consequences of CRLF in index?
In-Reply-To: <20171024190234.GA21077@tor.lan>
Message-ID: <alpine.DEB.2.21.1.1710251412100.6482@virtualbox>
References: <D0A67AD8-2D63-4683-9F2A-20B0E8E65D4B@gmail.com> <20171024181415.3tvmc36aqi335v66@aiede.mtv.corp.google.com> <20171024190234.GA21077@tor.lan>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1216931068-1508933635=:6482"
X-Provags-ID: V03:K0:b50e9vc0ICl837cTutozoFJuNm/vJZqRRpVGRYv/ZWACzX2Leal
 YMPTwPw7/t3c8AjOY9QyurkzldbMWGP2N7+wuRilvhY4KBLGKdX6ATli3tPVhGS+L/U74b9
 Z8fB74EtXzXG42R17bkW75jz613b2HUypUAAEjfsvc9jylRvIyq+iRYa/gDqtQI5bHZkBfo
 URhtrgaT8herfPRW44Sog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:toM1CCeHuNk=:8iglG6ZdK8ZtmFoKC6ssnn
 ZybaZwB9NRJdTzKFPolVl87fRINFmM97FicEW1L5mUs+75yfMLbG/u/rpEO3ib4iqnPZVYiiR
 CHv4TAxOKLWpcWR1GpBK1bLC77tQVmOv64W04HwRIK2kLhsGrL2qOuYSl4BE7qMtFHguG5ARq
 soKSiVRFj/oex9fXCF2F0WwXLXSP2hwo0O1ohzOoZwhkmjJv/7yNnsdTYEB6a/PGVYW7SkMW9
 Ix8yfMNhQxuvzOr03OcHz6d2T/9we/gCD6IHCy5SmYvAWBqMMeqOtBWUqWwpo918H30y8Ikou
 6eXREvtHIEoFYDtcZFUeXGyaV+oRoQm1svqlHgEIDPhdHTbW0fRGL/FrrYEw7ikfzDD9SqXWV
 K1RM6k+B7DZ4IeeA+eEWq0cvYKz6hBG8ykgrvBqroF3+JFLEYQzCaW1jI+FxBrklPfWaeswLY
 iDfvaQq/iU6jQWNM5v7cs6XB4keEun+Uohr+oVvEHz0lkf4rlAqdKtEuSuNq+HiLqMGIfX4m7
 +jZP/X73XMBtRybLWP7dZK7IMIlPqxq35PZSnqqrz0aq9D5ejDk5BG0VXiT4riNhU31j0en41
 4g9xLVh3fTrrHymjCHFHCD3TMN3j+qqg/f/Tfi/kIHBzLC9deqTpnwCqSMgRH4GN44PvpFBEL
 n0SmYUC2ZpkijRK3BL4tYPFLxTZrtKxRkMxS7RWldA0kvwQ/QKu7iC4Kc9CAYksDfFwQfW88q
 QJli5ETZ76AM0rlnOIiyO6p0g3shOFbNiQTmBs34lGOv5CeVlt6IAQRlz1CNeZbJ4K2uK3qEb
 D4Q82nUGyckAEcGcEwae65rIbSsd+vV1/UsU3MFj1gGPILbry3HBXi80lM7P4PRoWKdZDUv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1216931068-1508933635=:6482
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 24 Oct 2017, Torsten B=C3=B6gershausen wrote:

> The penalty may be low, but Dscho once reported that it [line endings
> conversion] is measurable & painful on a "big repo".

Yes, I do not remember the details, but it must have been around 5-15%
speed improvement to prevent the autoCRLF stuff from doing its thing.

At work, we always switch it off, for that reason.

Ciao,
Dscho
--8323329-1216931068-1508933635=:6482--

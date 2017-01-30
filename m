Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F021FAAD
	for <e@80x24.org>; Mon, 30 Jan 2017 16:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932410AbdA3QM0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jan 2017 11:12:26 -0500
Received: from mout.gmx.net ([212.227.17.20]:55599 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753686AbdA3QMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2017 11:12:25 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUHbK-1cxynK3iFe-00Qymf; Mon, 30
 Jan 2017 17:04:56 +0100
Date:   Mon, 30 Jan 2017 17:04:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] diff: use SWAP macro
In-Reply-To: <84944ecd-d14e-b5e9-7566-9ab2b68c02fb@web.de>
Message-ID: <alpine.DEB.2.20.1701301704110.3469@virtualbox>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de> <84944ecd-d14e-b5e9-7566-9ab2b68c02fb@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1351472784-1485792296=:3469"
X-Provags-ID: V03:K0:dYcY6qtiOQCaNeGF95o93v+Yfv+fWn4oUpCtoW1H/b3fIQud9Qt
 Whb1jVzRzhsJx7O+X8FdE6b/0jM4MZd4Os0ag4cNt/IS4hl1vUjPDUa4Z2n6lD8gTCxJ1GM
 yV7kSo7z3xVY4ri+6mpf4y1NHaoOES8Ua5FFEbmjtp+PhXAjlV1M0ksKPaZvW/u0fBfSbTP
 i+R73IKvh4VrIoLSjk2Rg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:w5wSRZ012/w=:HTZg93c0JerFqS0QiqmWlO
 3ngXA2r7YDWY+1qMPfnfnfs50xJLxtHvvsKpnMzpXqCpigvt3XK+yTN93gbQlaE/rlGL7/QlH
 VgL++sY2QZkJVPF3JjRo11jCDMe9hToA6iPOXCi4Jek0HJ7A4ZtGWiV2SboZupe4LfW4D9x0y
 1NNW0cjxYP4rZzUfw072lY7RtqcuuqbbsJ2T9cUlHhhemT5dHVNe7aWPO3aeuLwwxs5biDJdF
 KcPFPKn5y5/sH5hptbkPR6yfS4oZByjm4rOV6dK76zaoZMjiKlt+5VPPHn0Z7T0vkU1vI9z6j
 LO2OI0qiUZ4cOnD2oiXXa/flUgxIdVT+lPdkVIOSaoObP02NzgqBP9Cj1YDCllxKphrsnrV3b
 klgtqS1ScDBwlboHMtf0HMBrquPGE/bjp/T+Ul93pN2Z6eL6GafqAUF+hK0DWCfOiy0TsL84H
 9ZIODuXXWDnzURIMSwrk9XYSGARoWzahYoA1ZKmwU8eeceqRqKhucEpoJgpft+1URDDby1w6P
 /jBZbCy3kyZr6FkEF7ZVMeMNmDMr2zY6cBddCChY7GYA/r8NvcI8LaAsEp4x2vfHqpSL/IJOA
 gm8I6osxK8SPaYy+gKh36/d/ISaOuUWI6IaLblyA0kICFVNkUVtAtOeiBigjDRdUYTt/W/6ir
 Lj8noSRtEeQHg3WfXPOOKSY6/k5Hx47kDNQnz+vsneSUa6OYKmlTD7DgKF6seu9Bdfci+8F+N
 AGb1w5d1SdDutxWqwEo2roTZXHiG07y30Uo1wZEB5beBBrbK+Qm4Hh+ce6b+tdTvA7SIkM0tG
 zUsz59B7cyX6uXv/HVrShfdqelhmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1351472784-1485792296=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Sat, 28 Jan 2017, Ren=C3=A9 Scharfe wrote:

> Use the macro SWAP to exchange the value of pairs of variables instead
> of swapping them manually with the help of a temporary variable.  The
> resulting code is shorter and easier to read.
>=20
> The two cases were not transformed by the semantic patch swap.cocci
> because it's extra careful and handles only cases where the types of all
> variables are the same -- and here we swap two ints and use an unsigned
> temporary variable for that.  Nevertheless the conversion is safe, as
> the value range is preserved with and without the patch.

One way to make this more obvious would be to change the type to signed
first, and then transform (which then would catch these cases too,
right?).

Ciao,
Dscho
--8323329-1351472784-1485792296=:3469--

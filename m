Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4F78207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 09:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1955576AbdDZJqq (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 05:46:46 -0400
Received: from mout.gmx.net ([212.227.17.20]:59107 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1956309AbdDZJcx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 05:32:53 -0400
Received: from virtualbox ([95.208.59.147]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVsUW-1daDK50vZQ-00X6rq; Wed, 26
 Apr 2017 11:32:41 +0200
Date:   Wed, 26 Apr 2017 11:32:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 8/9] Use uintmax_t for timestamps
In-Reply-To: <xmqqvapsszoo.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1704261131500.3480@virtualbox>
References: <cover.1492721487.git.johannes.schindelin@gmx.de> <cover.1492771484.git.johannes.schindelin@gmx.de> <b59a414793492786937e910f6cd588b8e1751b4b.1492771484.git.johannes.schindelin@gmx.de> <xmqqinlu1o8u.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1704241226440.3480@virtualbox> <xmqqr30hw31s.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1704252208520.3480@virtualbox> <xmqqvapsszoo.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1908769681-1493199161=:3480"
X-Provags-ID: V03:K0:8YL24BsaNVwfdT6eYIOyUHI4lodLqg9KZ5eQDjP6ZhuFHZBjGkl
 zu1G0VR5RKMHY+4KN/UGRpI2nLOnEO9iZeXJMZiIwnbVg3QWqA2Nh3qnA/tc96W8ob/P/Xg
 KE5peYyG1kItFoiakI/HXXtoAKJ2OHHu29XDkg4n0J1NZ19SzbZidbi3kvkXbWWSbto7E9r
 ZCP4BkfeLFGY83CTghrSA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Dq7Qk/nOYAw=:q9YC5bmMho1wyARK32qVxo
 c3ctZymNzxACCgaiXkbnqRvbqhIuvDOGaNbkLoCPOoCY6dIQ95xBA51pMdn9CHBeBaaHygR3D
 aOF79ZxR7BWPkcJaTWgBoabsnLAzRTh/ZAaG/L6Z7r+qFx7h1rgYShxwihZQYVwyK6jgzJ55o
 bkhJIAFF2pgYkA99azXOybncL595+wr4mSI57mglcBcoQFgRT2FoFrpOedLqdILQ9lb1PrGPA
 h4QBmU6QUvYx4BrcbtGhk8462ur/c1f53R8Ti80FYDWYQrw9qKJ8unABg7yPlGuy9Gvi33gfh
 p6ARSVEgqSJ9l5DsM0MmBJg4UX66tjfMFZNTq5Nf1/oxhZ4LBnSmIh9ZlS6QL1HEuQMsaRsNJ
 s0pV/kXUkyfqc1moKcjTIVVWM8AT24kZUbVEu5E1BB1MGF1bbgtw8WZGL0elDWiZipTsjTFJf
 g0xbegDR7H96hPdgLixcklmLiDKwWEj2V45JqxaifiSYZk5IBLRc+MBjJnYFhyh3Uy+Tx2JWv
 fN97aI2tP+Lg26w+MyflK+EUWWo+Pxmz/5LY8JTHFoP67Ldofdj9kYYhL0jieIwKbLCrfjtOv
 LFM2yTePLXoGbIawRS7+ZWcc3EZtCNzNtvmbinFyqfpqSK8CwZdrt8iTQh8V2faJbEQqdN52B
 HW2Kpw66db1d5rGxBhzDMkkVvc8hYzZunsWlQhhPda0+tLW2UVdEMHz39GFLARKpyFG6A7eM5
 mMvAE4In4GFN+M2herEq8Xs1WHTBl3fl66DdGcnn7rkQCbJofnar5khr+2leagkOiII2xuCDs
 3lO5tiV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1908769681-1493199161=:3480
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Tue, 25 Apr 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > In any case, it is a question unrelated to the work I performed in
> > this patch series: the raison d'=C3=AAtre of these patches is to allow
> > timestamps to refer to dates that are currently insanely far in the
> > future.
>=20
> Yes, but the job of the maintainer is to prevent narrow-focused
> individual contributors from throwing us into a hole we cannot dig out
> of by closing the door for plausible future enhancements.

You make it sound as if I made the code stricter in any way, or even
introduced a check that was not there before.

As I did no such thing, you may want to reword your statement?

Ciao,
Dscho
--8323329-1908769681-1493199161=:3480--

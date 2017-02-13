Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C31C1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 16:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbdBMQXZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 11:23:25 -0500
Received: from mout.gmx.net ([212.227.15.15]:51396 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751626AbdBMQXY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 11:23:24 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lxxw4-1cIDhv1cpA-015LdW; Mon, 13
 Feb 2017 17:23:15 +0100
Date:   Mon, 13 Feb 2017 17:23:14 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fixup! bisect--helper: `bisect_next_check` & bisect_voc
 shell function in C
In-Reply-To: <128b4de6-7b8e-27b9-414d-c6c6529cb491@web.de>
Message-ID: <alpine.DEB.2.20.1702131722350.3496@virtualbox>
References: <a1b9143bb29a8a5979dd733ed20161e6769b2b83.1486736391.git.johannes.schindelin@gmx.de> <128b4de6-7b8e-27b9-414d-c6c6529cb491@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1683491521-1487002995=:3496"
X-Provags-ID: V03:K0:2JNI9/KR2xdcGKM4mtzUPXpg9S0Xn7NLlsFYgffTvx9hXM+4+NF
 Wt8jLBWckOqQln8p26CD4Nck1dBMYIK9I3ZKNNaWNlwf5FIeUedgcXF8OKM2sHqtACwjVek
 Z7sbI7f7MrU0zY2hb56rNkEW7TecLMLMmJPlQ9qSAPi6lgXpfjRTtRoi/ruHn0b8HOfzwmt
 ILf5VqsD4zce86v5nCDZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Sxrj2G1JB+c=:hhjikNGeGo/Te/2b83HlP2
 X0fvjVUtf4m+QUwA0KlmmqO7+I71Ycs6apc/r+fdKQyQPXEzEeyQeYxg97eHs06wTjWL7xkDo
 7a5RMKyuXFajjTF6aaVWR0RlaeutcILBJu9ZlGaYqvKiPKSQx0RMS03ijH40Qad/dG7mpiPyq
 k0CBm6whUwxR9xQONBr2IJQrqYrXH8nZzSsKyW5F7dmcujX1FKkf6o+hPzctuOQHSWhaHHLeB
 TTUdFGLY4CR1ONMiCYmGi37qJZY2ZGWR4t4qVbX1+vqKiKtpzTDz+cuFsGhKvSJt3yILanzT3
 m8YG+4ySFRhB/KE7L8rST+Tpu11qAw0sYVX0K+c+/XQr20dWBvXCpQx2YCrT8aO860WPAFn9A
 KFdKDmtZqqIJpcNyozjn5d7TV7xKOpo6QsL7BV37aDOp3ERQgg7WHQHpNxZ8C6N7WLTQEbK23
 UuP6IHFW9uQF3EF1PubOU3zTr+KjmtR6mljpaPts89SMu2nly1XoRUzQBm2R8gci8z5csG6PO
 RW8dyNubVYXwh+b2pT/iD/7brhhC+B0yHPPWcOy0l5jbUebblWAL49qYw4mdktjMQOY8mCQyU
 MJKkrNFHnfVsHwjfuBA870OY63QWvxgI9G28dtqdhWoCzv0Y3DFOxrl1dpPjNkuY9hjRnCPMs
 NBNCExAChKWmqBRJjhesE44h9mBj7Ujw+yopeRPvJkFx1rtSPkxKXmgxJwYPDqHXiUgEtySyk
 gV4kWlgXjEAkD7HC87LkrSOUf2oJf5rqxrHZPpqYlNT7NFHtqD0NbUQmeJa75uIman+DDRqpd
 iE2JLe9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1683491521-1487002995=:3496
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

On Fri, 10 Feb 2017, Ren=C3=A9 Scharfe wrote:

> Am 10.02.2017 um 15:20 schrieb Johannes Schindelin:
> > It is curious that only MacOSX builds trigger an error about this, both
> > GCC and Clang, but not Linux GCC nor Clang (see
> > https://travis-ci.org/git/git/jobs/200182819#L1152 for details):
> >
> > builtin/bisect--helper.c:299:6: error: variable 'good_syn' is used
> >   uninitialized whenever 'if' condition is true
> >   [-Werror,-Wsometimes-uninitialized]
> >         if (missing_good && !missing_bad && current_term &&
> >             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > builtin/bisect--helper.c:350:7: note: uninitialized use occurs here
> >         if (!good_syn)
> >              ^~~~~~~~
>=20
> The only way that good_syn could be used in the if block is by going to t=
he
> label finish, which does the following before returning:
>=20
> =09if (!bad_ref)
> =09=09free(bad_ref);
> =09if (!good_glob)
> =09=09free(good_glob);
> =09if (!bad_syn)
> =09=09free(bad_syn);
> =09if (!good_syn)
> =09=09free(good_syn);
>=20
> On Linux that code is elided completely -- freeing NULL is a no-op.  I gu=
ess
> free(3) has different attributes on OS X and compilers don't dare to opti=
mize
> it away there.
>=20
> So instead of calling free(3) only in the case when we did not allocate m=
emory
> (which makes no sense and leaks) we should either call it in the opposite
> case, or (preferred) unconditionally, as it can handle the NULL case itse=
lf.
> Once that's fixed initialization will be required even on Linux.

Exactly, free(NULL) is a no-op. The problem before this fixup was that
good_syn was not initialized to NULL.

Ciao,
Dscho
--8323329-1683491521-1487002995=:3496--

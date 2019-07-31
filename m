Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E667C1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 11:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfGaLAQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 07:00:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:40159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfGaLAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 07:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564570801;
        bh=WQ2paOEESXWOY7LWsa01sLgCvSV5DviRSGal5asmW4M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Is3YKhUmzEKNx2xJFTBnn3e8l0p+QFe5pEBw7CoCukJJpO40PGwfXhBRD0lYF3ZPg
         VanZ9xPqmXVpGeIdhEwvEZ+75M3VucXasc6jBufbwC6DWIt2OPzU5OojpTa9ucopjz
         8vXBG9hjvgW4xKJPml9RoyUACTRnR9l243Gv9CM0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MF4iR-1i8PeN3SOJ-00GGwL; Wed, 31
 Jul 2019 13:00:01 +0200
Date:   Wed, 31 Jul 2019 13:00:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, git@jeffhostetler.com, avarab@gmail.com,
        peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
In-Reply-To: <20190726135318.GN20404@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1907311256030.21907@tvgsbejvaqbjf.bet>
References: <cover.1560295286.git.steadmon@google.com> <cover.1564009259.git.steadmon@google.com> <20190725234229.GM20404@szeder.dev> <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet> <20190726135318.GN20404@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-310960021-1564570802=:21907"
X-Provags-ID: V03:K1:5tHf17gNVl8juw8pY9g/vIkGvYaw+4tYpFA4pBFU/g++GITSuN9
 XFNcRYTeZFQCJMCGpxVURkdo1uJ459Wxzb+M2FsxWThQXk7BzqCFoHFLHcHVvJpu5YSMzdX
 4vEMbxbFWUfdXQK/KGv4OlofzK2nrLVdKMOk76dHivJUwou0djdQjbp+5h75gnOk0Jhuyjf
 3VER1G8re4OHUqd5PGiow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tq/ZQrMz9/c=:zGdOWzYeto0m9HPv8VCX9m
 0j5tW6V74OSobf1xmS9QNCyjBBg1Xe4qRxPJzTfzY8H4YV6EyG6ffIJ9hjz4oW6ZRbrLhAqnX
 ErSTFHntgdnkeF6CcEiOsGZUnqxxdVTvs/vM3etygTUlS1fiAl7sm3E4Kv+VVvt+3MCbuEqYX
 dSIGX16723nt8zto/ntalDAxUr9qdfbk/abnCgqoLJkDFiUubjcGEB3tqZZhE+c74PRrTbeLD
 ilE5bDO/j35d2R38rMRutW/haU82KYRiVFaQGpD/DY6OgC2H/jdl4QWYaOoEfrn6TSMGVrV9Q
 Z0tal20J8pBJtCOWPEBTp7NDRngHeld5m/2kzMzq1Z+ff5peE5nQrKH5Qes/3S1MEDJhwovL8
 ci5tIONmTycHg95w7QKAf/AoDeGYk20f+UKNmbsFtjOvPoseM391Vc5zGfIJg/KgWvjkabZHS
 QG2MJYt0TFXMuZMPdwBHrJimDhaum4Eli1iBAqFRcp4zPbKibeYPvn/9stc32Dyu4XQfgLzMv
 +/PcWiQToXQLQ9g5pQnGuxGBjKZ053NtQQKicbcnSQHT7seFV2G7wvCXda3PcPvXytTKyn/DM
 ENvNiqVFzfsMG3SkSDQ5W5PVfp6DaNdbc9TmIFji9So/+3zR2dZPAlPlBRll6byEzmqt1R6kp
 ufqNMRAYRjvrnJsirhQiYAom7hK8pmY+zkmePk4lksjO7k/fI6TTOnL7xLmB8hE62dVt4nuUf
 Mwvx0jToOkGmGOzRnpSSfzluERl8kM+vDAfDmzWRyNAypr8pmnfRV4x+f/DliTYSagcEfhEBj
 sKzIugfA7r74ovRH4/DAz7NSfQ0DiXLBVmO2Pj3dyr2V4iB1Gb35Z8C3MAGQkdF+utjO7SnkW
 xJHrjKwGydHsnvS9mZKFzDnyhBUSuDp8ItqyNKmfYAATyn2i8KRSHyT0yrB2kmgB+5AY2OmVT
 zGgryqUGu9y47nO83GhxaobKHhaQ0eiAaj1y6ZUZqb4v9XoEiiXv2EtCvBcMQLSbH2qrFKfjX
 w0/fT6rxv5DW/PmS4QrGeRqMkVaqOUexjxMLWy6XkWI8eYsr5WMAFpYu5DzVbiF2JvgOA8bR3
 C+Neo3FcXDT6xAc0MmxjVARHVKCP5eZtvp9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-310960021-1564570802=:21907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Fri, 26 Jul 2019, SZEDER G=C3=A1bor wrote:

> On Fri, Jul 26, 2019 at 02:12:39PM +0200, Johannes Schindelin wrote:
>
> > Besides, I have to admit that I am quite disheartened to see these lin=
es
> > in the log:
> >
> > -- snip --
> > 2019/07/26 11:39:28 Validated items: 0
> > 2019/07/26 11:39:32 Validated items: 10000
>
> These are necessary for Travis CI, which aborts the build if it
> doesn't receive output for 10 minutes, thinking that the tests hang
> somewhere.  Yeah, less lines like these would be sufficient to avoid
> that timeout, but, of course, the real solution would be to not
> validate all of 'make test'.

To be crystal clear: I was not disheartened by seeing the *amount* of
lines, but by the sheer amount of time burned up just to verify
a feature that only very, very few users will ever need.

The entire validation's runtime rivals the one of a full run of the
entire test suite. (Which _already_ takes too long to be effective. Just
look how even at least one long-time contributor often simply skips
running it before submitting patches, most likely because they don't
want to wait.)

Ciao,
Dscho

--8323328-310960021-1564570802=:21907--

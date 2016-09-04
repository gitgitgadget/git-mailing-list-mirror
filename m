Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327F31FBB0
	for <e@80x24.org>; Sun,  4 Sep 2016 07:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbcIDHz0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 03:55:26 -0400
Received: from mout.gmx.net ([212.227.15.15]:52065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751721AbcIDHzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 03:55:25 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M3RVA-1apRyS3f96-00qywv; Sun, 04 Sep 2016 09:46:32
 +0200
Date:   Sun, 4 Sep 2016 09:46:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] compat: move strdup(3) replacement to its own file
In-Reply-To: <89725a44-8afa-1eb1-732a-23b1e264616c@web.de>
Message-ID: <alpine.DEB.2.20.1609040941210.129229@virtualbox>
References: <89725a44-8afa-1eb1-732a-23b1e264616c@web.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1515587073-1472975192=:129229"
X-Provags-ID: V03:K0:z8Az1hv1fDNoSNkf7B4+08Eq3EsT9rA9mTsgvT65GhrJg3+MOwo
 JUFyu4OAeU/PGgwPUqJwHS1RIRFwM5Jw4PCfy6iIfj3Ast1tjsbivIfGPFgSfYYdN++0fia
 sRPS5WVfGFicLwNkJeZZf9bB1lGt9tsBTYJ1DfMNEzL9bZOPVJfpNIwCEPRgYoIGNm/V9Lc
 E+FdYJh0ID2c2vDbJunTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JYpUAjQK8PI=:SCac9DnkKxMVIkOpRzEqr7
 UHYmwBOYg1ZcyhoCeNtCguoyh5DOv/eHIKNLdBr4HiZ83531+W6tY+An06RTaWewqncz3m61O
 7e2HKDn7UaWyUNTChfFHaCCfIIO51yNcC6T4/RtkRcKZqj3wxg8Vf6MTTO4gSVC1zSEC6o+iR
 Hk60rth71jTjcgzlVzhhAebkucxWw8lRaMvkI+jFzSh30UMxnV36yvMNl3DyFqBbJ9Ox91V7U
 haymXoeKlxzWP0K4R0n8tHc34R2riKmse5youGjDzxtJu7GwGgpCRKiIe7n2HzFdcK4qihly1
 zKRs5j/V7j84VidrCYVJ2RqXEE2elRb2MW2RyTWcC6jX5lx4iPDM9yoHSzr+X1SgOBFteJhF0
 JIWowXdpmq07eSM+k8kM30jtfEWX1MOKhsYbpCQgK0wYSAAY/xsm79s5xIxbMOIyH6VMss8X1
 ej+aNB/BuIqd2SGT+w7vOAmNZM3LQ9QkgBQ737EUKG+Bkx+yiqbvWdl4eo6ytI8RITsr99yeO
 49wXbI0qSFlE+p4FHXMsngR4yTcQHTIri8yUU9HlSfqQY16yZAkn/5hBjCb97dF9kdoLlxr/5
 oaLHrYItoGPaXyeqq16X9tFHVJhXRZnAJbmvESFSVFK8ZEdADVEG8kgLuKyVU3Ti7roQGqxlU
 bDcMMspvatZp8gOLR1Htee2V0jx6yRoB4vaYMjZhL+M4pol561LYFj1J2+hFEJwJKG9KYcEmU
 H+HlzxTp/VOArw9l1DTWgkS1ywJHb0oQMDCUviFPjRpUJ1PIxiDprlGPjLF5su/JEPB3HQPFB
 8Y4FzId
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1515587073-1472975192=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Ren=C3=A9,

I imagine you Cc:ed me because the nedmalloc stuff came in via the Windows
port, contributed by Marius (who is no longer active on the Git project
because it works well enough for him)?

On Sat, 3 Sep 2016, Ren=C3=A9 Scharfe wrote:

> Move our implementation of strdup(3) out of compat/nedmalloc/ and allow
> it to be used independently from USE_NED_ALLOCATOR.  This reduces the
> difference of our copy of nedmalloc from the original, making it easier
> to update, and allows for easier testing and reusing of our version of
> strdup().

I would like to suggest an additional paragraph to explain why we do not
need to #include "git-compat-util.h" in nedmalloc from now on:

=09Please note that nedmalloc never actually uses strdup() itself,
=09therefore we need not enforce gitstrdup() usage in nedmalloc.c.

The patch looks quite straight-forward otherwise. (Junio, if you want an
ACK from me, you hereby got it).

Thanks!
Dscho
--8323329-1515587073-1472975192=:129229--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8937B1FD99
	for <e@80x24.org>; Sun, 28 Aug 2016 08:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755275AbcH1Iit (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 04:38:49 -0400
Received: from mout.gmx.net ([212.227.17.20]:52144 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755220AbcH1Iis (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 04:38:48 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LjN0F-1b7czh4Bxv-00daov; Sun, 28 Aug 2016 10:38:39
 +0200
Date:   Sun, 28 Aug 2016 10:38:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, meta@public-inbox.org,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
In-Reply-To: <5e480a5b-3752-55c0-65ed-52ca5802851f@gmail.com>
Message-ID: <alpine.DEB.2.20.1608281036460.129229@virtualbox>
References: <CAGZ79kasebzJb=b2n=JQiVMrSfJKaVfZaaoaVJFkXWuqKjfYKw@mail.gmail.com> <alpine.DEB.2.20.1608181430280.4924@virtualbox> <20160819150340.725bejnps6474u2e@sigill.intra.peff.net> <alpine.DEB.2.20.1608221450250.4924@virtualbox>
 <CACsJy8BG63oaLbw0f7try3OpzdphLC7UGAaJ=vgikEB36Pagqg@mail.gmail.com> <5e480a5b-3752-55c0-65ed-52ca5802851f@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-615837168-1472373519=:129229"
X-Provags-ID: V03:K0:CNoKLRIU2V1a3xsaedosGzqG8kDz3JMAYFP/b2m53UuHk3zHBO6
 XlQ38yLr7lhDG2uJNzUmjxnOxqF62SHsQ/J5iv2eZKp3QGOLSTgRe8x16EOP7kO9C19C0iN
 +FqZBhXw4AdohEJAyLdcWHuYpfS1eLhdyUYuM3lgCaQ28DrAEzrNg8kbA/yL9SXKGX/C9kU
 eIR1BdLx8vbp32De9S7JQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hzmhGYxgfAA=:5jDTFep8Z78Qci4KQH2vz/
 X+x9Hgbq5MWJSx3OsXNFYT/sffP5ebhJqdS0CWxeQBOpiEi4eunfjSO21vfGtePpTkPB7rKGD
 D8wCaXoRvoQUvmyLbUr3QPihLkPeW/9PB8LcJHvwe43fHg//BU03PTiiKCbyx6dKIBpZ2W0lY
 zCeDJD832HwGkvrfw9gPisbDS5piqLSWgEj5hO8wYz0z0AI6s+XZb7C4JaxLmt/gisYU9t8LW
 MzawfoD6JjOM3wTQcNIgRM0mnlYIZ5JBIg5DVgYtrF6haviOQ0PHmRnYGiZJ+3pmaI0u9ev/b
 8htozQJ7nMCo5VzHG2Ma6L6p8cS6SVhtOQnQK+3+d3eKhIdvOYgv1GL8fMpzWCAOL1jxLTojv
 gbP9OXoqiy925W7KXQ/88YncsDn3kCCpyBYpbI7LalKYRAu1hk+LcE5rMHJqikJ0yjHws2ycB
 +1thxlJQoQc6XrcV6cMlAjv56pKnrJ6os2vp8eifDoQ6+m9fEa4C5LuIt1KIZwKBm3bFScC6l
 f5V0GaCps3VBuptSbXlpxHM8lNHpX8LK71LxQU4+5Qmhyzo5E7/YuRcW07CuC5Z9SCCKJqlYQ
 UWQoa3QPAPjqNSiHZvyQM8RMfcV0N+CmZWOiTaDAUQ7mf57+0142w2dLL7CJouhipXJBBHvxU
 r4bF74QBR9i1++XjuqGKorAXQDPMWQ7P/Sr8aQ3ZmCvIMMF6Ab+G1TvNKPcQDvgQoPLGfgxMh
 gY+0/EaaZ5KsP5MgQ3eFIjaRb8xbC5BYwg3rbObwfnwjw02yoWOHWUvscIPrLiHgtjY+djROO
 OUBYF5M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-615837168-1472373519=:129229
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Kuba & Duy,

On Sun, 28 Aug 2016, Jakub Nar=C4=99bski wrote:

> W dniu 22.08.2016 o 15:15, Duy Nguyen pisze:
> > On Mon, Aug 22, 2016 at 8:06 PM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >>
> >> My point stands. We are way more uninviting to contributors than
> >> necessary. And a huge part of the problem is that we require contribut=
ors
> >> to send their patches inlined into whitespace-preserving mails.
> >=20
> > We probably can settle this in the next git survey with a new
> > question: what's stopping you from contributing to git?
>=20
> Added to second take on proposed questions for Git User's Survey 2016
> https://public-inbox.org/git/ae804c55-d145-fc90-e1a9-6ebd6c60453a@gmail.c=
om/T/#u
> '[RFCv2] Proposed questions for "Git User's Survey 2016", take two'
>=20
> Message-ID: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>

I would like to strongly caution against putting too much stock into this
users' survey. It is the best we have, granted. Yet I have not heard from
anybody that they participated in the survey, unless they were also
subscribed to the Git mailing list.

Ciao,
Johannes
--8323329-615837168-1472373519=:129229--

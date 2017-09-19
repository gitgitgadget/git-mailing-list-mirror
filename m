Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92BE120A2A
	for <e@80x24.org>; Tue, 19 Sep 2017 19:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751728AbdISTyF (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 15:54:05 -0400
Received: from mout.gmx.net ([212.227.15.15]:63709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751715AbdISTyE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 15:54:04 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MQzUc-1dpLhl3mmc-00UN8M; Tue, 19
 Sep 2017 21:53:48 +0200
Date:   Tue, 19 Sep 2017 21:53:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Michael Haggerty <mhagger@alum.mit.edu>
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 00/21] Read `packed-refs` using mmap()
In-Reply-To: <cover.1505799700.git.mhagger@alum.mit.edu>
Message-ID: <alpine.DEB.2.21.1.1709192047450.219280@virtualbox>
References: <cover.1505799700.git.mhagger@alum.mit.edu>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1862387965-1505850827=:219280"
X-Provags-ID: V03:K0:xiHBLMIFjZDMdSgEbFZsnnKe/oQDoH2Sxd8QWWtYhRiuUuo9+M5
 faKZGpymnGwiQ5FN17CLJXBpU8BJuRn6uRY6LzoiYYtzG8iG8OqzwJC3E/3OekNgIE8jEFt
 5AX/IrGcEPeGq0LoNunL8TVtsiwuosXhb34TLoRZbGHmJ9UoCmK3enJWU+hDpzDEjS1YIA4
 tfXdIqwavCwv+0ahB+YKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:myHLpRCcz+U=:715RULQcIfLnFmvKfAIHfr
 kx5GHzuL7QcbhrBVnlsHVhze4dYVWdz/ceyUQT6ngLS4HXhJ1SyAUpgVVL+cLlGXhw6zmrirq
 A1zK+YVKfs3bE0UciNqpiTT/JQSGNhKQM0VkLssjla8ljUhnGTzI4b9NJWihK0f6WnFh/HUaS
 UjpunnXC6MtuTPQkESpBy4SVj1uV3GoS4xqsvDvKgTIjbP9F2rdbN4/a7k4wa4zgAd5g5Uaa7
 XML68dEXSZjt9KS1MsbCbKTt5lQLrcjpLwRGYjbns/Wxzl0Hh+XizNwvzC1LsBrBmiayFnh43
 +dTGYciNd7ri/P+3OA9gTelPmk+bzF/dwxVDLw7az/QSITlIYebzgnwgv+hDEYLM0VOBZg1WC
 Zgk6anUbV5Cb/hrCx5tiMmcC6gkASthjXWpDLikIT2YKGKJz9CLy+p5QGDDkeQ385GMns/kL/
 mKlYlFAfXhrfKCbr7RkBfVBKPvtVkBWgg1sJoS+o3gcPtiU27qNGnaSCjcVn5UwJGtu2feNxm
 4hyO9jOEgScZLlDpicYUDRFKHnPEoX/I6XJKko5Q8816mTyTpKYWlcSdZOjcTlpApj8o7qMro
 +EjwHIZIWKuWLjcSPMB/pciYYiCJ8QIo3P4w+YGiNqexNJPccQaYREAOfzLFRawOKGmLJThLL
 AR1tjcuR5ok02UOUZb44adHLUR1VWLg9xn1Hq0H6yn5STDjINKt4N7wMaylUk04jJDaQWF4w9
 P8seJEWZkDKhhXy5AXKL5QdBP5DQ+62CY14KLRw/MGp+sp4pyc2w5aRxOshiXgRH/6srMSNgZ
 lGiRV0rYo28WBZFgX9ezSUlXGwSAuqoEhnzz2QqBpY5cLJp7CM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1862387965-1505850827=:219280
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Michael,

On Tue, 19 Sep 2017, Michael Haggerty wrote:

> This is v2 of a patch series that changes the reading and caching of the
> `packed-refs` file to use `mmap()`. Thanks to Junio, Stefan, and
> Johannes for their comments about v1 [1].

Thank you for the new iteration.

> The main change since v1 is to accommodate Windows, which doesn't let
> you replace a file using `rename()` if the file is currently mmapped.
> This is unfortunate, because it means that Windows will never get the
> O(N) =E2=86=92 O(lg N) improvement for reading single references that mor=
e
> capable systems can now enjoy.

Triggered by your enquiry, I looked into passing the FILE_SHARE_DELETE
flag which I hoped would let us delete the file even if it still is open
(and mapped). In my tests, this did not work. If anybody wants to have a
look at what I did (and whether they can make it work):
https://github.com/dscho/git/tree/replace-wopen

> The background was discussed on the mailing list [2]. The bottom line
> is that on Windows, keeping the `packed-refs` lock mmapped would be
> tantamount to holding reader lock on that file, preventing anybody
> (even unrelated processes) from changing the `packed-refs` file while
> it is mmapped. This is even worse than the situation for packfiles
> (which is solved using `close_all_packs()`), because a packfile, once
> created, never needs to be replaced=E2=80=94every packfile has a filename=
 that
> is determined from its contents. The worst that can happen if a
> packfile is locked is that another process cannot remove it, but that
> is not critical for correctness. The `packed-refs` file, on the other
> hand, always has the same filename and needs to be overwritten for
> correctness.
>=20
> So the approach taken here is that a new compile-time option,
> `MMAP_PREVENTS_DELETE`, is introduced. When this option is set, then
> the `packed-refs` file is read quickly into memory then closed.

Another approach would be to imitate close_all_packs() and rely on the
Windows-specific code that retries renames in a staggered fashion, waiting
a little longer and longer before retrying, and finally telling the user
that some file cannot be overwritten:
https://github.com/git-for-windows/git/blob/v2.14.1.windows.1/compat/mingw.=
c#L2439-L2441

This is not a new problem, by the way. If a file is in use while you try
to run `git checkout` with a different version of that file, we have the
exact same problem on Windows. And we deal with it using that
retry_ask_yes_no() function.

For this to work, the current process really would need to be able to
release all snapshots in one go (for simplicity, I would not even check
the filename but simply blow them all away when we want to overwrite
packed-refs).

I guess I should set aside some time to implement that on top of your
series (I *really* want our in-house users to benefit from that O(lg n)
improvement). In the meantime, I think this can go forward with the
current design.

Ciao,
Dscho
--8323329-1862387965-1505850827=:219280--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F199207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 10:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbcJEKuQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 06:50:16 -0400
Received: from mout.gmx.net ([212.227.17.22]:51368 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751803AbcJEKuP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 06:50:15 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MVIva-1bOWyv1pug-00YhCo; Wed, 05 Oct 2016 12:49:51
 +0200
Date:   Wed, 5 Oct 2016 12:49:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     writeonce@midipix.org
cc:     musl@lists.openwall.com, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: RE: [musl] Re: Regression: git no longer works with musl libc's
 regex impl
In-Reply-To: <20161004200057.dc30d64f61e5ec441c34ffd4f788e58e.efa66ead67.wbe@email15.godaddy.com>
Message-ID: <alpine.DEB.2.20.1610051243530.35196@virtualbox>
References: <20161004200057.dc30d64f61e5ec441c34ffd4f788e58e.efa66ead67.wbe@email15.godaddy.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:c5EjhnIrtFZOI5WTEGnHVQEOoAVkMrgL5dfcxCqZqAbHGbcDk68
 njTyUQzKqXCOshgJO82bMJQMEL1KlghUGssv+Q1uQL/kfoboqCqrYC+98dkfaNDyLthg/3v
 718aDVG531SEnRc2OGvs5RDuAYglaoYFXG+FdAm8TSRKvAzmz8pElgtqa+iHg215myxXbim
 ZcPayQsEfmBEZnOC4Dl5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EYgfrucGVoE=:xu66oXZPAgFRkiZmVKmcV3
 hB/RsQpzekIm8jawI4T+TX/19aYwEWRJ4II7Em/GcAIU9pQ3zTQptPbNx1a2QQfcDd0pL3Frm
 Axf0eNfvnexdsP5KSklbtpDWDRaO6t+CrLghKQpv9tI0ZdchB7wGbjSvusyx+lwQClPEjXGFR
 ZhnnK7TUo20t2YK9lAeBRQQWqht6mgXmdXtoQMNWvRb8v+WX4lnUqC5zL1J1PloVv8eDksYyl
 A16TlOV9IEJ376Dl23xrqUgtnN84mrsZ/QV/Z2SJ01iorbuHcOBiK2brYRC+aAUrzJxBZ5BwR
 4+HFNlZaVgAfRoWvW1srGcWHRVdIAEBoSjnCONFRiu5+S/UOMwqxeHkHw5nztMZX/EbaQn64a
 vbmXw5LZYVh2Qr5LoFmKvRLIr63yk3uFfTzfSgLmj18nQ1k0/WAX8faPAfMzCg9Bhut9vrTwv
 gukWLjCPaWZ1Ej7NYSiFgiBsqa9M+TxMhkmeyJn20LvX4YUj41wqiJ0qw5S6ZLlBQQeF4+kd+
 7JJWLEldIDAqwf36cb6vEIbiJxn6CiS4EoUDbNRpH/WOw6MDIDAHF+t1fELJjBROQMRIc1TVb
 qJw8vMbZNfkJ5w0gkcRxUzd8xCC3oIsHB9jNb/4BEayBwyviotbO+D2G3OcdkotBWxn4C5YZU
 0ZLB1aOiLxQWYU1Y+gnFXA/sXrFqd37UgTQPUFS53gSNH8helZFYfodcVNWGB6kfERgcD10yo
 bP7tzuJFRuvJ7chJqbG31LkjUCHt1IO0MuPvIYnqR4/7HrypOSa8geX1opXo4xd5wdl/OToE9
 et+b3vw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi writeonce,

On Tue, 4 Oct 2016, writeonce@midipix.org wrote:

> < On Tue, 4 Oct 2016, Rich Felker wrote:
> < 
> < > On Tue, Oct 04, 2016 at 11:27:22AM -0400, Jeff King wrote:
> < > > On Tue, Oct 04, 2016 at 11:08:48AM -0400, Rich Felker wrote:
> < > > 
> < > > > 1. is nonzero mod page size, it just works; the remainder of the
> < > > > last page reads as zero bytes when mmapped.
> < > > 
> < > > Is that a portable assumption?
> < > 
> < > Yes.
> < 
> < No, it is not. You quote POSIX, but the matter of the fact is that we
> < use a subset of POSIX in order to be able to keep things running on
> < Windows.
> 
> As far as I can tell (and as the attached program may help demonstrate),
> the above assumption has been valid on all versions of Windows since at
> least Windows 2000.

And since W2K is already past its end of life, it would be safe for
practical considerations.

However, I have to add two comments to that:

- it is *not* guaranteed. The behavior is undefined, even if you see
  consistent behavior so far. Future Windows versions might break that
  assumption freely, though.

- some implementations of the REG_STARTEND feature have the nice property
  that they can read past NUL characters. Granted, not all of them do
  (AFAIU one example is FreeBSD itself, the first platform to sport
  REG_STARTEND), but we at least reap the benefit whenever using a regex
  that *can* read past NUL characters.

> In this context, one thing to remember is that the page-size for the mod
> operation is 4096, whereas the POSIX page-size (for the purpose of mmap
> and mremap) is 65536.

Indeed. A colleague of mine spotted the segfault when diffing a file that
was *exactly* 4,096 bytes.

> Note also that in the case of file-backed mapped sections, using
> kernel32.dll or msvcrt.dll or cygwin/newlib or midipix/musl is of little
> significance, specifically since all invoke ZwCreateSection and
> ZwMapViewOfSection under the hood.

Right. It's all backed by the very same kernel functions.

Ciao,
Johannes

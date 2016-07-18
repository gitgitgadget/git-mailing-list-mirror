Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C03B41FEAA
	for <e@80x24.org>; Mon, 18 Jul 2016 07:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbcGRHAc (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 03:00:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:59383 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbcGRHAb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 03:00:31 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M6wWn-1bB4303vfR-00wmSd; Mon, 18 Jul 2016 09:00:08
 +0200
Date:	Mon, 18 Jul 2016 09:00:06 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	"brian m. carlson" <sandals@crustytoothpaste.net>
cc:	Herczeg Zsolt <zsolt94@gmail.com>, git@vger.kernel.org
Subject: Re: Git and SHA-1 security (again)
In-Reply-To: <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
Message-ID: <alpine.DEB.2.20.1607180853300.28832@virtualbox>
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com> <20160716201313.GA298717@vauxhall.crustytoothpaste.net> <alpine.DEB.2.20.1607170949360.28832@virtualbox> <20160717142157.GA6644@vauxhall.crustytoothpaste.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fERF8xglGnWApCmZcOrnkvsgH7t5vQ7IYB8JweBw4+vnqaC/BPx
 KzZaXM/4lJ0KUuCgoNXCsIjEp7nq8dnYywMG8ZfDqZat6a4zDpdw08w3ywJcJ8VG8jauemt
 q5H51ndkJLmNpj+9xJoBmJAi79WDOKbcr2u4o4ussTnBijF/X4aO5lfXL/BQFXDOax0ULl+
 psRgHotOXbO4RSWpy/RpQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:fx2jUDQzBGs=:WHXbK4w144/nsmuV8KF0hI
 XFOTIgnaTrtmsGjS7ZP0gE1Z2rsLpJ5BNk+XX/Qu0Zbmmi9guWrLr38g6k4MN2rS8Y9pnPR3I
 QDUT+BANDvcLvDPJI/8J9GT8KLMz4YZagYENZMMeIwxCePYcyowLcOI34FqLCkR/9Lvd7WBmo
 zfq9zR53zTRVCYwX65amFZWzKu7YfUSUtN+Usdm+nYCGSAHOhy1bJaqozetT1pMGV0jciEwEZ
 tY0WpiXL/XfomOS0l+nAKkx9/qpQ2SNlucnH34jiB61EwnSkhFarIQxjmBmJF9WYr0GPkYeoI
 6IR+WCEWQ53+2lAY78TvJuRm1Uj/TD5xBoaM3XMQxjKeE6DSN96+nlOiwkmX0ZM7Mqj1jl4bz
 b5f8JZvrar8mWtbDuM9VpgmVlRSEexxRboTD3jNp4MTtWOs4t8X8GdQGow2WEAFWK6wtrQeqe
 +Ya3Gb2s0lUVAATgm6dizrG9+aKlwHwM4Th8zR3ltC/sxdbh9ETb6Sqd9CyC1hHDtoVIn39TB
 zxchNXa0k6X9eqX4dFf8Z5czYV5xbvyZCKnvt0PkU+OHxdKlHmanzhzN3SUKZ/DOjufj/vUSq
 0sGH4GkItdRb1H5O9NU3YwdsYU6bCmYeGaAB3ghq+DaUipxN4MB/IB4kYTlbnGJ3B4jwElPYh
 jTgMUgaWo5nQlHu98Umn0Ao8ryXCUYfJePP3klAJVbwPxZucBxbAkP7dyEAq8AM0MBy6cqW4q
 9Se1LQWvHqTuU2l17xZJVdvA4dR9d09k2FjuXQ5qX71fsGYqTETbMo0KAvHKLlWtX2lgnEmk2
 AURXpNE
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Brian,

On Sun, 17 Jul 2016, brian m. carlson wrote:

> On Sun, Jul 17, 2016 at 10:01:38AM +0200, Johannes Schindelin wrote:
> > Out of curiosity: have you considered something like padding the SHA-1s
> > with, say 0xa1, to the size of the new hash and using that padding to
> > distinguish between old vs new hash?
> 
> I'm going to end up having to do something similar because of the issue
> of submodules.  Submodules may still be SHA-1, while the main repo may
> be a newer hash.  I was going to zero-pad, however.

I thought about zero-padding, but there are plenty of
is_null_sha1()/is_null_oid() calls around. Of course, I assumed
left-padding. But you may have thought of right-padding instead? That
would make short name handling much easier, too.

FWIW it never crossed my mind to allow different same-sized hash
algorithms. So I never thought we'd need a way to distinguish, say,
BLAKE2b-256 from SHA-256.

Is there a good reason to add the maintenance burden of several 256-bit
hash algorithms, apart from speed (which in my mind should decide which
one to use, always, rather than letting the user choose)? It would also
complicate transport even further, let alone subtree merges from
differently-hashed repositories.

Ciao,
Dscho

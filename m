Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 344CC203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 15:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbcGUPrt (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 11:47:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:62870 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121AbcGUPrs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 11:47:48 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MZTbR-1blLzB351J-00LBLq; Thu, 21 Jul 2016 17:47:28
 +0200
Date:	Thu, 21 Jul 2016 17:46:43 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Jeff Hostetler <git@jeffhostetler.com>,
	Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
	gitster@pobox.com
Subject: Re: [PATCH v1 4/6] Expanded branch header for Porcelain Status V2
In-Reply-To: <20160720205411.GB578@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607211745050.14111@virtualbox>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com> <1468966258-11191-5-git-send-email-jeffhost@microsoft.com> <20160720160635.GC24902@sigill.intra.peff.net> <578FC0E8.4010102@jeffhostetler.com>
 <20160720205411.GB578@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6YE6t84o1eNwJ0m6KRuRSxaG016svautNrwYH5neOIo8KqltD4D
 f/5WhcO7u4uF7ZvwYOTKokIs0y6fxj+2E9kaQ5VLE7t2MqdGt+KU/o1hAcLvkfIGiIRlQ2Y
 /tYvVydnHybKeNAG5TQRDllUznGibv5q7Fpa9RGuuk5enpmkUj4hLmAUx+KZWaAhSkp5tV/
 IsvHf5d+8EHlWnkvMZlEw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:fE78o3pSAAE=:s1an6NNAz8oeO5RzoeRV6d
 hZD3zMHOwTVl5c4ff4RFkdu0V6ag0qhm+qQmqZD6F2xZJruaeQU6AGGatvMGni1Zy/kYBxVT9
 EtPCHmRqm7Q8qJCydDkMSoNh8y4hApCQJw90s7x/MSKgt1siNZZUjkPCH52VsHe3pgmoc//DP
 RatKMpp2vHkG8i2V6wWawYZrHD7V3zTLuCuHRwsw6YFwt/V4HF/To/HGBDUeTIpvHhM7j8h5R
 5084RTHcbluzX2On8rcAht2DitXNyvag5YGzSm0ZtzM8n4fPblEhXtyxprC0q7vTC2y6M/iTO
 DY+YdSyX9nKjBeoYMYUYUsLrdNtnm2lA7YFSsgiSGHkUPkis1wUEX189npUUmCPCaZMVNu+5d
 QMJwju4fCtfpmk6EN61Vbk+GrFy0Wi1PpCY5vQZn9FTyQ0ea1UEVfovFvVuvtRRQgAZehs1HS
 9iKFjt8LfgPTKQnQMUYLVwKAOWgEEZZA99HU5+/UBT+D3a5YVdbNedbtYcoXJIaI2uaLHJZqw
 uyKgRDzBgtOtFru2WwBoync1uSdW75MU686WVAja69jEfLto23ugUh14I8tTDSmFgbfyNZN9N
 0J9KMEOn0wbTiV/yDy/NKV1E/4VK/cfggdSgbW1kW6uZ5poM/kHuYCNnqhNBaIczhveNGc2e8
 MdB2nudJqC5OOeI0nfitvY7dsOvzVHgEXRsLz6r0HrEsskTwKpqfN0rxh6ogU8r7j+MOmsXyN
 1Oi/P0YIRkRaKZUAK3s/coXt0bxLdB7qjJ1cLBeDHDMzbH+yIiZIfhOlADeJxceB+bXFpcdM8
 ipCQLZ2
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff & Jeff ;-)

On Wed, 20 Jul 2016, Jeff King wrote:

> On Wed, Jul 20, 2016 at 02:20:24PM -0400, Jeff Hostetler wrote:
> 
> > > IIRC, it happens when HEAD points to a broken ref. So something like:
> > > 
> > >    git init
> > >    echo broken >.git/refs/heads/master
> > > 
> > > would cause resolving HEAD to return NULL.
> > 
> > That worked and I see "(unknown)".
> > 
> > This is a bit of a nit, but is there a value we'd like
> > to see there, such as "(unknown)" or "(broken)" or "(missing)"
> > in that case?  (And make it clear that this is a different
> > case from "(detached)".)
> > 
> > I'm thinking it would be nicer to always have a field
> > there for parsing.
> 
> My gut feeling is to err on the side of being vague, like "unknown".
> This is something that _shouldn't_ ever happen, and if it does, it could
> be a broken on-disk ref, a transient syscall error, or some other
> weirdness. I don't think we need to get too specific in this context
> (we'll likely have said something else useful on stderr already, I
> think).

FWIW I think "unknown" is a nice conservative way to shrug Git's
shoulders.

When we call `git status --porcelain=v2` and read "unknown", we could
always try to find out more using additional low-level tools and/or disk
access: this is such a rare case that it does not *really* matter all that
much.

Ciao,
Dscho

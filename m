Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E7701F744
	for <e@80x24.org>; Wed, 13 Jul 2016 11:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbcGML0V (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 07:26:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:51076 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956AbcGML0T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 07:26:19 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M23zf-1b7pwK3kXj-00ty26; Wed, 13 Jul 2016 13:25:36
 +0200
Date:	Wed, 13 Jul 2016 13:25:33 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Andreas Schwab <schwab@linux-m68k.org>
cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <mvmd1mjdluz.fsf@hawking.suse.de>
Message-ID: <alpine.DEB.2.20.1607131324121.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607120927410.6426@virtualbox> <mvmtwfve22e.fsf@hawking.suse.de>
 <alpine.DEB.2.20.1607121249390.6426@virtualbox> <mvmh9bvdnae.fsf@hawking.suse.de> <alpine.DEB.2.20.1607121520310.6426@virtualbox> <mvmd1mjdluz.fsf@hawking.suse.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:D783rpdYqtJY9TPN7xlvKmJ2EEfgBlpStkiKyEEc4OLYyeUtiFw
 K8P9JcQ8NWXwlp3OLOFd5HuU6zlSf2UOAXUIiBe5WZACmLxc+hNo90rhZExP5RFAKliyIjX
 UtdYvJUc3CVg2VLQaDYuHHJbpsn8hdJfiKGsfW91Be+RIIygaVY2t6uMRt73pAh168B0E0B
 LC4XaEwJ54zeyJc7BVJcA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:EtsPA/ie0UQ=:gRSK+HXlTOYAw7wnvlUhvZ
 7oZeLc4lKHZ1+2hNBbEkH+cdbPTlc+kngip/qxTvo+ddp8qMb59PuFbFakWEzyaT7cwitlTmV
 cqVzHJ0YjFmw+QkbJjXtYoyn5wpDW734uXmHtaEfGdoTujHFancQGHIxu8KMlHRamaUl4a7y1
 ZZobJPqeqL5eW8aetBfevlFLsBk5MdKQwD92eyGytgfTd81aTe8o6pr5UC1XJ4B67JiWl+9UY
 YzIxGT1W0HLMynPEjAFLpoL2TjiRHxBWBpDi+uhxr4OMaL2b7k6oRiFMu+0u3KZPZwUemVQxe
 znNTjbZCwDey0cS8Ha2EOWAN/i3ak/yRNBIxuSs90kJLHKgl5MaoJxVnrmpXoXpd6qIWRFH25
 N/DRxysbpIPdKN6YS5t8p2zu1bqgjShJojN/dHaDVjSO7zskeDLLpfaNVeYJk0D+7DG3IHAYV
 mkK0j8gautf9JL3SaUxpi3/y7m74s6rTJk8SnGfUhAdygKLnbBvR+A50wAeuRlVUTZLU7+dr3
 YfYwECzzKNoofvFFJx8glHPHLum4yur+MKTUYGNllMjt9knLJFYL888pSH9+kND56pracWEXC
 ++FfMjB3PVt7WmjuBXGpES8SnOXEIJ6up4TzerfLfIT4+J9QZdvkMp3B8LtLQwPo/UfNNISKw
 yhHmTceuSD495r4NGg8n3AqiZgEzVQ0uHZvdI14y32xT7XwY88vdgs/ej+HncwZjhfr43kwgU
 /tb/yq414hs5dZ+CsGu3Z6OTvHTbPZTVE+AR7BiWApV1kz3EYtJ7msbYtjUrtqXtZUcqeEFSD
 M6+/Rsu
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Andreas,

On Tue, 12 Jul 2016, Andreas Schwab wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 12 Jul 2016, Andreas Schwab wrote:
> >
> >> Johannes Schindelin <schindelin@wisc.edu> writes:
> >> 
> >> >> PRIuMAX isn't compatible with time_t.
> >> >
> >> > That statement is wrong.
> >> 
> >> No, it isn't.  PRIuMAX is for uintmax_t, and time_t is not uintmax_t
> >> (even if they happen to have the same representation).
> >
> > Sigh.
> >
> > So if it is wrong, what is right?
> 
> The right thing is to add a cast, of course.

This was not helpful.

Ciao,
Johannes

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7C121F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 12:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753524AbcIIMVy (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 08:21:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:49522 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbcIIMVx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 08:21:53 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MHH6Z-1bmRYH0WJP-00E7gW; Fri, 09 Sep 2016 14:21:46
 +0200
Date:   Fri, 9 Sep 2016 14:21:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ralf Thielow <ralf.thielow@gmail.com>
cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase -i: improve advice on bad instruction lines
In-Reply-To: <CAN0XMO+diDLXUrxjNGnUi6oUEwkcGavEX8vyGWy2+Wju-N4WJQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1609091421010.129229@virtualbox>
References: <20160906180838.865-1-ralf.thielow@gmail.com> <20160906185918.21286-1-ralf.thielow@gmail.com> <1473240491.20551.1.camel@kaarsemaker.net> <CAN0XMO+diDLXUrxjNGnUi6oUEwkcGavEX8vyGWy2+Wju-N4WJQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FR3hVKO/Wi/iySYbz0r7gfXsztq/vwy/6AROd2f4F3iSTSbs3YN
 HnXpSx6ba/LKXJNWESHZqDWzpDb/Kl6QiVkjKgnSIu9F7es8d39LJ6P+tRt4PeuY8GPbyHj
 aotLrgysKYi3GYZflYWOdvzgqYNIQmQwRi23fXunjshvQbfFNNX/TMpbdG4QvHydgSOKzVk
 WavWCKmid4gY1h4sxb6MQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bXMnsAbruLM=:MQQQ95Su7iZN+jaKlX9iTY
 b6fmVAKNDhgXhoBYmFkKqvkp4XoQucZuY0vdgz+U0j/F1OIaziITHZebxR7M+C0F6J66/YSDq
 fW8HlrCcPhZzycpiNwKgMua/wxq+GI6z8qQHXGuUOe+9qhinhKOQ7VwRPK49NEFY5HA50gU0t
 LKrlNSIOVlxfi9SKj7yQ2xwhDas8unBV4RfSNXYh4i8Iruu8EXnpAQZIfado3ISWY17DAXEp5
 uMf78UjZ8VOUJfaEzW0YQZlcEpi7sC+2XcI5LqsYr0cyXq+rlnCUsLBdrA+rzDeddZwCMPhUy
 96kk5Ux+YrfP5D8SDcm40QBbDVR1bfq+PrB3uRCqwX6xkvqkYyiPuya7f4IhC2DsES3WAwu4O
 PWdAMtTX5AsVrVchueARrUYNEyH5CDAjX173/SEdUBBmtkYzFfvoCJg3BxyHjXy+AaNQVC8J1
 SMrpCfcpv2X+Hhp+gO36k5Z3jPyazj4Hu3FUICBHW/cj0D6jwA8a62WQlaUgheAedrYexLXkd
 koDrlXYS6bZ5liXjZuzBrL4qUB3EFFYP/HGCYd7O8eNnuW+dksLfgeAcS8YGJCtcptoFC4EvD
 X5zmGVIma/tVzaGW2cZKOrHX8QI8QYVhqMR1hdU5NbdOB5IyD/t6YwhrJfbYfrxBaaCU4gVsx
 jg3VmrVFvCr/6PoagF8YGjWlJn0fEghwWPYJkUG9XRQhBJs3eQj73EukfZnqD3GzID+c8RvQr
 pbqQsWVJWGLE9e0G5EMfATJ68X1q4H6a3KI9r5Fr6y3PZRgvyEY1OYU7Z9/L3PVoh0cb9ZK0+
 CGOZndC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

On Wed, 7 Sep 2016, Ralf Thielow wrote:

> 2016-09-07 11:28 GMT+02:00 Dennis Kaarsemaker <dennis@kaarsemaker.net>:
> > Hi Ralf,
> >
> > There are quite a few patch series in flight these days around
> > interactive rebase. Have you checked for conflicts with those?
> >
> 
> Thanks. I did not check against 'pu' when I created this patch but I'm able
> to apply without any conflicts.

Yeah, rewrites in C won't conflict with your patches. If you rebase
interactively, the worst that will happen is that you update code that was
moved into contrib/...

Ciao,
Johannes

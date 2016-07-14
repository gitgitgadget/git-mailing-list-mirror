Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CF0520195
	for <e@80x24.org>; Thu, 14 Jul 2016 07:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbcGNH7F (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 03:59:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:56878 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750912AbcGNH7D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 03:59:03 -0400
Received: from virtualbox ([89.204.154.227]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MDFB2-1bbxXI040i-00GXqj; Thu, 14 Jul 2016 09:58:48
 +0200
Date:	Thu, 14 Jul 2016 09:58:45 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: 32-bit Travis, was Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <xmqqmvllz2t7.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607140952160.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <xmqqmvllz2t7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/O9FtB6ONgehaRilHS4hsxA+a3I6mmU7fJEpPFlaxpI7S90ZMom
 AXFLwq95CnZFew7tiu8N05iJuUNsez9EjoOqdWEnSY9MIRZhv+fSNsTGk7dWTbMJlvEV6pr
 B2AicaJi3qfmVx3Qgj6F85PkUq6nkwpd1ZrRlqxJi66o3w3Rn5TlwtK75QvG1C1ryah4q68
 6utlnfPLFiGrX5mmgoddg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:iKTnIcV2EOY=:NVcqPF9Vll+BgempGTCHUS
 9Joqjh4W2bFNwKTZ8fvXPqdLCN+126utnLYpDv7gSQPjXDmekChE6VbY8QF+h4cUuDRlI+gUv
 aDHAPMMT/yPBpAhAJVHxiq/JEBqMwOQhjzi40R/QlTQo/lDaRK/kI97Bp/9i7WTUCjIUHn+pL
 e08HvueGXLK7ojn5nylSRM8zlnKddubcfmc6Rq5lmoLFPEUsv6fuBVdzJX9EzpXQyCe7Jv1FT
 Jdc5Ualpw0T842sxbt+FcS5fg1nrFOmoXMCu6FayxBxlB+/lWDpEDtezplf9xm8WvC2zkDVNp
 zaH/dyWMU3ol0BeLRS5/8kmaxXhyDU37x0AWDaulj6mSe90FQIJO6MlLYJpNJJBWeVm8pTFL/
 I8KyH0fis/vjX3j2u2pr4gyvY+7mtOsZA2MzDTfAl63Mh0NhhNmd1wJw/0SZ2lNSqGmdoTvvz
 pQp4JHhIQDBmDsQhBZz4qdv3Xi+33HABw/Iy0wNTnlTYzhSeNmv9ayDNMAiFzD2PQTIvAzKFI
 kDIiGq5HzuXQCkB1xVHU6liM76172uvkYynY81aIMKD0uJ7v4QcW9eWz4EqsnpemEN2k7KTh6
 QBTYMxBYdz9Y+pSwEPcleaBDaBlJs1fcSaOSbYHo1pnmg3/bUGjYWOiCEPZHpKqiicZp4eqjX
 K6gLWpPPlpW2tJK2jSLjtL+tpiTypeRJXOROyQjoxhKP+PXUxfWyk4f84th+ZeqGmdb/2b7Zh
 2k+KpcibANZFyF6+p5WyRsUKjyUTzoSC0GYBMcmoG/BFWETEYTamx0L3NGHJ101KiadORi7Xh
 s2oDeiO
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 13 Jul 2016, Junio C Hamano wrote:

> Does Travis CI testing have an option to run our tests on some
> 32-bit platforms?

AFAIR Docker does not support 32-bit, and IIRC that's what Travis uses.

However, it is possible to install a 32-bit toolchain and use that to
compile Git.

It would be even easier with MacOSX because XCode's gcc can target both
architectures. Simply adding the -m32 CFLAG/LDFLAG might be enough.

Sadly, I lack the time to investigate further. Sounds like a fun project.

Ciao,
Dscho

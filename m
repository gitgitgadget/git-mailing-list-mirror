Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BFD51F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 11:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757234AbcH2LKj (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 07:10:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:61695 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756914AbcH2LKh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 07:10:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Mecqq-1bTNAv49cW-00OEyV; Mon, 29 Aug 2016 13:10:10
 +0200
Date:   Mon, 29 Aug 2016 13:10:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] Prepare the sequencer for the upcoming rebase -i
 patches
In-Reply-To: <1472464596.4265.29.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1608291309480.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <1472464596.4265.29.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tIvp0YfLvdWwED1CjI6Ds+iq7vuXj0+jvQxP06LKhhkr/1R43WZ
 oh+7iqyjob4LUJLumckaorUNRHWT7TCUp3jbGdiRfpS6Ne5xf7+vEFc4uEzjqXmoX7V++wf
 aSTGqJ6OiCRVy+p+jiZfEUlSMHrk+Q6a6d0on6GXF3w+nVFbuQfUYt05CTEsstQ/0HAfQhY
 qHnRbeVM+ubeH2zrBuy8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pJp1MkYDphM=:Z6NsENtyzOOzGXJGroyCYd
 M6qwjyKT5RkmdxFd2ES0SrIlkY7xogCzRIEXuL9X7vlcbyOgE41uXT4MVTffZZUIoMTeMDCvj
 QGT1KVrBD/Fx39W+mW0I/U/ko4wkIT5wxO4Iml5JwcpSZt0BuqvUURVzxsJZlFpI3Wo/6fNmc
 OGeqvQBQsbfy0m5RxCA7dJoyTUIg2D5v065Fr8Th0npKZP4QBfHFa9LZfbgrSlnmPhkTkBQxs
 vCQzxICk+qWNFd0cn+fNvIA+iH5kvvIjhVBO9tYZdEV7CQU2myU/H3JEC+aOeLKalANua5Wrq
 lSdbERT1VnxC6kivymWy72g/Syl4Ddkl/RQXpJC1jvz4+fNiQ3hF4Z7t4vKcnWAXKWCgVh/MV
 yuZiJsf6mn5vNp5E4I+rHUCoZ/nXYsvzY8C+MmAaqvPLsbiBjzbrjgm26yc0dW93CxlpQ//cc
 HKtvVyuFuP24IQ+dMtoKG9IkWbnd0DBQ3zUx0xur1uu6qqR2EgrLljoT13RN6/Efuqh94Tvla
 ARcExgwjLJEpV/oEdptG6479WH99YjWYYpkxYqPast+7IRx7mfkmQH8Kl+R0hRnOJ3zRm755Z
 OzIIDdbZnzkC1zTfC0Q/ck6fUlf7fq5Dtt8daD7ae4kSrHh3WoC5t5+OYR61xPRu0S+SvlIXZ
 LdC//OdoK6MRd4EMPwbQWQ16t8e4H/h4XXqQS/gnOcRJtxOVRQEwcy9/VlIL0TfK7wW/K80yF
 QBaXw3AJysMcwJeVVbtoSu2+9+5kKSivjMguTwIAbPAMw+k0KwgXAsZqw6iQjMO49OHbNzfWS
 FNEDnNu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dennis,

On Mon, 29 Aug 2016, Dennis Kaarsemaker wrote:

> On ma, 2016-08-29 at 10:03 +0200, Johannes Schindelin wrote:
> 
> > Therefore I would be most grateful for every in-depth review.
> 
> Tried to do that, but could come up only with a few nits. I think the
> approach is sensible.

Thank you for the review!

Ciao,
Dscho

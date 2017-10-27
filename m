Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C2F01FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 14:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbdJ0O4s (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 10:56:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:51113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752152AbdJ0O4a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 10:56:30 -0400
Received: from virtualbox ([2.247.243.12]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mc9U3-1dqi451OWl-00JdHG; Fri, 27
 Oct 2017 16:56:26 +0200
Date:   Fri, 27 Oct 2017 16:26:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 4/3] t/Makefile: introduce TEST_SHELL_PATH
In-Reply-To: <20171025215015.irnyvk7kvmxqkniy@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1710271625190.6482@virtualbox>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net> <20171020225340.6qgybldewi7knxvz@sigill.intra.peff.net> <alpine.DEB.2.21.1.1710231258451.6482@virtualbox> <20171024013130.5nuxmjlwnm2l3zrq@sigill.intra.peff.net> <alpine.DEB.2.21.1.1710252334000.6482@virtualbox>
 <20171025215015.irnyvk7kvmxqkniy@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:34bYTqzpRURsMJQcUwc76KtOCRis6EPXYFg6HO758C6/bfpe3/V
 G3Obp2X21iJc0bTMBVykEysW+5kkY+SIb/Ocw3IsiEqvE+dy2FSL+Zuoz+pWYJ0OXexy8Fw
 KM1jiDrbhDZ59M9i0ZkQ6x9oIVkaTgd8eCrZ2s6wySlTsEANmuRw0f00zHXkRBqCwn5u39R
 aIaxLA86D3a4hj2o8uyPg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+HmQktr15uk=:EZBBIGlG2P1om1XGphhAah
 QTH5TI8HRW8SmTJ8n2rZvlyVANMcK2WTiKG4rgxEiPV7iP+8POm8KIo8DeKk6i6qrZGPUFk38
 EcxHIF6nsI8AW0vdbWG+qC+yltc5QS2u8i5IdPkhg+D9RLUfnpZ8OPTYaELuZZaMlrYpKJ0gq
 ZcbZ0T4URTe4pI9dThmvOkxz5wXvGgeW39ZN860Yi/YrRw2Z00TbZUip6m12FS6w4hSIIB3tj
 s6AHomthokopBzFEt6Ea9/CfNRp5oDpcMyfa+euZAuL/9xe2H3VF5TOUQYliExaCqzqGYkCjJ
 jNjKIPM3sHHAy32CTfsQNL9QTDNBCw6hrf29M1H8ZCbIAwrickYFb6/B+GrPeb1yrTY+wI+oq
 8fOZBG6dSE+8HoxkipmUVpJdDJYb8YVuH4AGPi7dKupDXm+8SI+a3BrScegktGZWIviEq0I+b
 aYmFOKgzNxrGTDsNfYn/WiNILCLC1I5oDwCIh8N5Nna4P8NRZPwpiif7cb3YXnN2hn0HS7gAm
 Ase/2aDiOVCSxb5dBzD9qWlRYwkuLTzLoITfFNnNvOIUMC7jJhG4r7swqd0OOglDaWTZPqZ7B
 jkyvFKheWVLEgpIzIcvDa9odHDvYOhRNSyWtQZqAmL8D+GBt4HxJvEgE5jYevOHe0vkxLDssY
 Gf9msUIhhGnce9X4jEq0dYZm7PjCgZT8fnYyL8Rn1WhdzkD5whLr7nZvGQMcZ/Wc/CiUuXyoR
 w3KVYCypj5KqTWL0f7/KLc/4utR+OnVmDCHfbIgH/X26N3tUuhFgGp59BQN1dvKo9GhUlFr9V
 q646hY6I/+7CNZh63Z39m/IUgmkobakV5bkY+GMbB3J+KV9u3c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 25 Oct 2017, Jeff King wrote:

> On Wed, Oct 25, 2017 at 11:35:44PM +0200, Johannes Schindelin wrote:
> 
> > > > Or alternatively we could prefix the assignment by
> > > > 
> > > > 	test -n "$TEST_SHELL_PATH" ||
> > > > 
> > > > or use the pattern
> > > > 
> > > > 	TEST_SHELL_PATH="${TEST_SHELL_PATH:-[...]}"
> > > 
> > > I'm not quite sure what this is fixing.  Is there a case where we
> > > wouldn't have TEST_SHELL_PATH set when running the tests? I think there
> > > are already other bits that assume that "make" has been run (including
> > > the existing reference to $SHELL_PATH, I think).
> > 
> > The way I read your patch, setting the environment variable differnently
> > at test time than at build time would be ignored: GIT-BUILD-OPTIONS is
> > sourced and would override whatever you told the test suite to use.
> > 
> > I guess it does not really matter all that much in practice.
> 
> Right. I find that behavior mildly irritating at times, but it's
> consistent with other items like NO_PERL, etc. E.g., you cannot do:
> 
>   make NO_PERL=
>   cd t
>   NO_PERL=Nope ./t3701-*
> 
> and disable perl. It's testing what got built.

The difference between NO_PERL and TEST_SHELL_PATH, of course, is that
NO_PERL affects the build and the test phase, while TEST_SHELL_PATH really
has no impact whatsoever on the build phase.

Ciao,
Dscho

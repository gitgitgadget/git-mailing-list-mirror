Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 293B21F516
	for <e@80x24.org>; Thu, 21 Jun 2018 07:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbeFUHDL (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 03:03:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:42969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbeFUHDK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 03:03:10 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LtVLE-1gF5k40FyW-010rDo; Thu, 21
 Jun 2018 09:02:56 +0200
Date:   Thu, 21 Jun 2018 09:03:05 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] sequencer.c: plug mem leak in git_sequencer_config
In-Reply-To: <20180604045122.GE14451@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1806210857520.11870@tvgsbejvaqbjf.bet>
References: <20180601200146.114919-1-sbeller@google.com> <20180601200146.114919-2-sbeller@google.com> <xmqq8t7v6zpd.fsf@gitster-ct.c.googlers.com> <xmqqmuwb5i7k.fsf@gitster-ct.c.googlers.com> <20180604035637.GA15408@sigill.intra.peff.net>
 <xmqqin6z5g8e.fsf@gitster-ct.c.googlers.com> <20180604045122.GE14451@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:mBCiTrIWuosuHXc7RBcTeJqrLjiUgemRpaEkxe8GJmvZMQHy51Y
 hiMI2a5VuQ8pAs2zlYlSNNb0lLJNVMJELT6/qLyzhchYHTP/rZhJYS8aLfaOqhA9ZB1M8zl
 4pqAmHmQc7vYA9sjeozObWEyRU3zxDyE41xI9Ffm7LxmaWDpZIO4hNTSbgd8X0hOpTgv3HA
 +PxE+0DYc/J1hRbpxIIgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lP75oPAh0/s=:Q/eR8XwYPRRcXZck3Q4y8s
 gyBsjaKwy+/ML9tCY61m1tym4k8sl6/AmWTUba5WxTYebE66ak2eUcZ6gmH4BbqCBjL3WA/3O
 hVXm2Oqn3+6m813EU82uWPVLIu3yEA7TkeJlWBWUPrWLjpgmrNIstCa9t13IkF98GYQLM6Hle
 0TgRmJmtdKxoHsFvQRndvaw/cj2Ngjc5+O+2IZdbCTT9XON2qrudgNlZjE9WiLekAsQOge4xX
 t07kHdOik28pQIDdVtVIwq8p1MTXLSzrIcxd0BGpE12g2L64WoU60PFTWb2nPp9pLSU4AqheT
 9llyvQTRQay6KZjwuKsdN5kJi7sqgpxXuV7e47pphVe1BrNq/0kRZF5EbL81Olv4vCfQChNHU
 JI0VhRDuMSKMXG8ZqYQMGC9QKfrnGKcWst7NXB0Exa7WRhZ+gwWewTFMGTynQLBHM881Wrvz9
 zcGRhDZpt7y/wEAN97zjhM00deRoeC4p0xLOeEXTyGjshA3RSSdXe6fD8/z7mTBVmT3QikDMx
 ze26+rRYWpWgvqEO9FHh4QOpC25ib50J2KGsKfkUgTlMYOwH1bjHifMxuJIE0euY7JSepkM5g
 rXVvKbblNU+KEg+0wHrsxYHwTB2v3GoGoZaXjnSbrXQOq97OXknX6R8G2PObMOEZEDCHX6V4Z
 xdp3iCcW3WxKeVjT1uto7dsTIaBZfXZMPMgggOyy1VY1XSD7kQ0uOx6MTKhZaT/IM0TCVNKdW
 ee2PCeY01Nd/5lJAnAopSYKpnXjWptcTUcXL5ygbXay1bitDM/oHtVOZniufi1bva83qHn0iN
 C5cowks
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 4 Jun 2018, Jeff King wrote:

> On Mon, Jun 04, 2018 at 01:26:57PM +0900, Junio C Hamano wrote:
> 
> > And at that point, maybe
> > 
> > 	char *some_var = xstrdup("default");
> > 	git_config_string(&some_var, ...);
> > 
> > that takes "char **" and frees the current storage before assigning to
> > it may be simpler than the two-variable approach.
> 
> That _is_ much nicer, but you cannot use xstrdup() as the initializer
> for a global "static char *some_var", which is what the majority of the
> config variables are. It's this "static initializer sometimes, run-time
> heap sometimes" duality to the variables that makes handling it such a
> pain.

This makes me think of Michael's proposal to teach strbuf some sort of
STRBUF_INIT_CONST("default") which would set the appropriate len and set
alloc to 0.

That way, we could turn those settings into strbufs that only allocate
memory when/if needed.

We would need to be careful to revisit all strbuf_*() functions to make
sure that they test not only for enough space when growing the string, but
also when reducing it (unless reducing to len 0, in which case we can
reassign strbuf_slopbuf to the buf field).

We also would need to revisit strbuf_*() to understand alloc < len to mean
that we cannot realloc(), but have to malloc() && memcpy().

As a bonus, the pattern used for

[section]
	var = 1
	var = 2
	var = 3

would change from three times strdup() and two times free() to one time
malloc().

Ciao,
Dscho

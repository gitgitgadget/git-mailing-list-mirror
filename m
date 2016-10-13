Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5B6D1F4F8
	for <e@80x24.org>; Thu, 13 Oct 2016 10:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754010AbcJMKt6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 06:49:58 -0400
Received: from mout.gmx.net ([212.227.17.20]:63384 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754006AbcJMKt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 06:49:56 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M7ojs-1azWZB0kjo-00vMWP; Thu, 13 Oct 2016 12:41:49
 +0200
Date:   Thu, 13 Oct 2016 12:41:48 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 12/25] sequencer: remember the onelines when parsing
 the todo file
In-Reply-To: <xmqqbmyp5ycw.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610131241030.197091@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de> <f22bdcda3f748813e6b9fd08dc65f11c6f9f4b1e.1476120229.git.johannes.schindelin@gmx.de> <xmqq1szmaemr.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610121347361.3492@virtualbox> <xmqqbmyp5ycw.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5ECQnUXxNCjAfps4APPZs5bNIQegy9HxAsNNM4iGxXGpG3YzbIF
 kjf7xn4mI/Ix39gJo2v9XfvjklUUh+bwI6+Nbdzr7CdU1t3bGwYKTce1SWQ2IViZkjfF2rV
 9dBKXypRh6olv41GB76tbbzM4G8IsZHaVU5AERAmOc6inExszACi9XyQhrUWLqEIPZjQacd
 ajasCNCkdTcO/jNvplcQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wjoZU0P6Av8=:975VBtmIFqr+mOlGz1nOgm
 HZM8qRjEbxQpsDxy6RmLq4zmwL5NSOkmQXBZr9RUcbJCeckVK1hwzd37JjocaUbv1E6TT4Crd
 81joudKDfAYAgqLtM9ESqT08//YQh0hmtJ0uBP1yat4fK5KKGqs6lrvhZFGI/vLQ89KUsU+vu
 sGAqqinmsV51KpkgWm//JGJYSvIcfysR/+r9MbcTl4u5JaoBeJ1GMmW225dIOGec8NCR4+t7Z
 gPTtBxd1VAe6ihmyC+JW6otBCcGM7EkJtGvTSkMuotAQlS/Ryg2iz8540XKXSYWuZ2y4eWfOB
 deIyjOFEb5YSg8V17d8420+Ul71g6WriDXW6fFS4aQlPfflvx6DII24T93JQjzpRLH0iQJP9x
 SEUQ2mXQZ7hMX13QE5l77rBgM0mRuhx5myD5eQVMWfFHAJ/8V9uUzREmVMnq3nsymyi6d8M/u
 fJOF1ilHxVXTTyyuuoBWHo7PfpzAnBWWtLoF7q2dcB9yPQp+98OYTzNZFadpGp5NY9CziKAJ4
 2dByemAyaAUvER7POgeM9UmMefAZUN04fN8/dF94IqibULIAZdclqW376ythKY4N979DogVeN
 M+SZBqA7Ft0K2wKh+tWtj0v0rs1X+uNvH8XKuDv0c4mOoiI7bB1q7EjrdyjRM4j9V2tSzby90
 W8gHu0uRfrF/KsJuYaI5zk0j4u6lzBodWSltEL60EfkXpejQ+VUzEsWGDVbTX3TAiz/pvzXCV
 79lmw+Xcv/OkndJi6CDF3ai08tHWu41gwONTnNWyqG/Qnt+p05Q8tCZSMBcIdObGRbUY4xKn4
 mGoLyr7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 12 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > +	const char *arg;
> >> > +	int arg_len;
> >> >  	size_t offset_in_buf;
> >> 
> >> micronit: you can make it to size_t and lose the cast below, no?
> >
> > No. The primary users of arg_len call a printf() style function with %.*s,
> > expecting an int. So your suggestion would lose one cast, but introduce at
> > least four casts in return.
> 
> Actually my point was not the number of casts required, but more
> about using the correct type to store things.  Granted, I do not
> expect each of the lines would ever get too long to exceed "int"
> (but fit in "size_t") in practice, and from that point of view, one
> may be able to argue that "int" and "size_t" are both correct types,
> but that argument applies equally to offset_in_buf, so...

You cannot make it a size_t without changing the printf() standard to
expect size_t for %.*s, because that is the intended usage of that field
in these here patches.

Ciao,
Dscho

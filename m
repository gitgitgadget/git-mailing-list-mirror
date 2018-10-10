Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D2EC1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 12:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeJJUTl (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 16:19:41 -0400
Received: from mout.gmx.net ([212.227.17.21]:53283 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJJUTl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 16:19:41 -0400
Received: from [10.49.78.48] ([95.208.58.46]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LoJDJ-1fU0TU06xt-00gKDG; Wed, 10
 Oct 2018 14:57:33 +0200
Received: from [10.49.78.48] ([95.208.58.46]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LoJDJ-1fU0TU06xt-00gKDG; Wed, 10
 Oct 2018 14:57:33 +0200
Date:   Wed, 10 Oct 2018 14:57:35 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: builtin stash/rebase, was Re: What's cooking in git.git (Oct 2018,
 #01; Wed, 10)
In-Reply-To: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1810101203571.2034@tvgsbejvaqbjf.bet>
References: <xmqq8t36mk4t.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9hN9juWIvlfmC1gdKlBPBSRrxpujRp65LEk41W+9VDH+XqQuwVo
 70STNOZjw/s5nG8WjW3Xur3zpuq7JSSWdinWtSuofeDeu8tEdTZjjQhrRWkaZrkgWePX8MX
 uZ2qQNlRfNGFyzh5Ar8//vkbZYEyM2Ef32qrMX3H4JqMjjs4GSzr1rXKnuDy8cYOypIMEfw
 ZQPhz5RklLPUdfPgy9dcg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IdtfRE5rHVw=:lBvFK+Ky+yI9JPHX5UAI4v
 Ajp54loH99Ykae3PKA19x05sgEsH4eyyfxzLuPLg48NjgguGDia0QtuHm6XUzDTWo9OeyL15f
 uLJmvvDEtK/rTjYj4UR3qAmjLs780u0C0cts0qTHbm0oYhAE8rKEDb4mIeYEuDRvPi4wiwQCN
 1HNKFmuTOfL93ihbtCWdczWn6Dhpln5gYyaPebvU77G8/rNzC6eBzsENadSfs/gNlRJRl1d8g
 IASHecFTyTkv+Kc8d7f/8IDl1MInzT9nJ5UEr/dyM7iSfaXFe93nJQddh9YTlgjA3cbyjmhyr
 k0Sqpdr6iZoSPDoh8loyfRFmHDUCM7Zsp59M71nzZkuniQAf2gIcgXjaGVFt0S7KV9F+fwM1e
 priISwKSRCbUPFBMh1duFRP3VKQf6Lg2W1kCx5cKdxT+2g2OJHMbZ4XbXs/MRi5YokQ/vhywS
 ukMKep9pW87YmkAkkBBQsagAYyjbt58OtE+AnivQ65l6jlPAqdT77CJMNla3EvjylBjGqPdsv
 e2jwJSIXvD01O9uUIYbeWgmBeLMQxzNoCUk/nQtzI3pObmo6Ey7791H0ovWIc/4SYizJu4G+1
 4ARVFYSQn0js4SmPdhGEaS1x9AdqhkSyumansA+GZQgZWJK3N5BhV0xEt3I2cXl3FPXUNCJkP
 PEhjea8iWFH0y69RsRgBdla1bIr+f1/VmT3zgavXB5UipheOGT4rsnvVA0LQWSPR0aNh0hkFq
 gRkVJk6+W2C00FvT+aAIYBC0gDo+zOJ7Ai8ZwQfKes8kRhdsyaoPUB9XwPBs3WaSVCxx5sl3T
 S3gS5F9wO06D0BWu0lvzv4VfznUsQzOwtefGTwVUYYVYKcTDng=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 10 Oct 2018, Junio C Hamano wrote:

> We haven't seen much complaints and breakages reported against the
> two big "rewrite in C" topics around "rebase"; perhaps it is a good
> time to merge them to 'next' soonish to cook them for a few weeks
> before moving them to 'master'?

I would be in favor, as long as the fixup patches I have in Git for
Windows made it in:

https://github.com/git-for-windows/git/commit/6bc7024aecdb1aeb2760c519f7b26e6e5ef21051
    fixup! builtin rebase: support `-C` and `--whitespace=<type>`

https://github.com/git-for-windows/git/commit/1e6a1c510ffeae5bb0a4bda7f0528a8213728837
    fixup! builtin rebase: support `--gpg-sign` option

https://github.com/git-for-windows/git/commit/ddb6e5ca19d5cdd318bc4bcbb7f7f3fb0892c8cc
    fixup! rebase -i: implement the main part of interactive rebase as a builtin

https://github.com/git-for-windows/git/commit/2af24038a95a3879aa0c29d91a43180b9465247e
    fixup! stash: convert apply to builtin

It seems that Alban picked up the `rebase -i` one, but the other three
have not made it into `pu` yet (the two `rebase` ones are really my fault,
I did not yet find time).

Speaking about the two `rebase` ones: they are simple fixup! commits,
could I trouble you to fetch and cherry-pick them into `pu`, or would you
prefer if I sent another iteration of `rebase-in-c-4-opts`?

Ciao,
Dscho

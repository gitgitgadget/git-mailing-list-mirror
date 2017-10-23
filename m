Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31A301FF72
	for <e@80x24.org>; Mon, 23 Oct 2017 10:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751383AbdJWK4e (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 06:56:34 -0400
Received: from mout.gmx.net ([212.227.17.21]:56648 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751268AbdJWK4d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 06:56:33 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcEPJ-1dN7FR1O9V-00jdKH; Mon, 23
 Oct 2017 12:56:20 +0200
Date:   Mon, 23 Oct 2017 12:56:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 3/3] test-lib: make "-x" work with "--verbose-log"
In-Reply-To: <20171019210812.lje3o64v4qdnzcuc@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1710231255450.6482@virtualbox>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net> <20171019210812.lje3o64v4qdnzcuc@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:XpPC531xpoPlT5rLEvG4h6GivfUiYdYVLOQXzY36eAuBxoREgy8
 wO4+/sOTPnhklxBuXjTogEwNbofPu0mwF7BagRzoDYZ/87w8d2m8NQKvBC5JOWpB/e/zYvc
 T5MmERgh6yc+GL0b8w4IgjKXMwRNlpibw1dY8mP0EHQsZGyXFz/P/vdK+5LnEa75g+iLHdM
 H1LF/6MRrTGL6ObinjdrQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bkd/r5uyR6I=:kN7IHbrm8VWcUe6+DNalOi
 puSMjlokiImkzlzO6O939HKRRMIwAqvK6/wWNg6qwbSsB+clZofThco/JBcDpdw+HQmtE3ieA
 T4oVddGR3/1qXylpAoYPOTbSeU/zP/+hcwIcsxhDOHo4/deaz8KUE7jqOLZLnZ6D10qzR8wqD
 tLTdAQz29Q9E5M9UhhplIqBzFMXaCY7UmVf528+G39emQDLt78ZRgWBxpdO2DVCdE/JjMFqpa
 u73PUh2ORsDU2rTW3TwWjqlJj/OIFakwJpcZeYaeN9AGzmc/AQsdt6puHKkrbigWABZx2aOQH
 xaDxvYbAKUkwF3N6AYWZ0bjmV9ymzA0+ixBXq8tONQyZCe7LN4pXua5UWU6nrZsH6sKFU3xNU
 N8DfySjL1oWmAc8dQF5Fw1vQBsVc4zEwelCEhO5FtUKjKaPZrmUxUHHgykExS2lBDivYethkF
 S20aV8YN0gJlQxB8/NX9/0XumtuK+gFsYaqio8T1muDVkjF5TFzTL9z2jbW1Hukz2/K5O5x26
 VyL8lS2XUgHt9LERrP5GnNciWdWgwVOR/V4sEplyo6rxLOqEcJQgp+mAGsM80PWEip7/v5k0F
 uXWjbRCXanzIjOG9fmUz+Jxc92AjTi8fkWdVkoFGeP4F9fYaXHnMTrM0yy8tgvQSwJi63/CKd
 ZeKtd0geOZ9mMpcmBc0LVCNDx11OwmtBJQzhwtxs2+yYQTfkSYG/oIAuiWWzUKxNzoV1oFfZ8
 BHWxjsiLEJr9vAAM+891fUAuQUzdLBTkOnCiiG3Fm3+75Pe6tQtxXuox7SXSX8364BoXBkuYn
 +ZrsAWLo3sgkZY0qEHNhULWg9oaOkHUdEQaOClBjiGzh5pFmGpaGplV8ZZH3wJvXQPzv++E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 19 Oct 2017, Jeff King wrote:

> [...]
> override --verbose-log, 2017-09-05). Namely, let's enable
> --verbose only when we there isn't a more specific verbosity
> option indicated.

s/we there/we know that there/

Thanks,
Dscho

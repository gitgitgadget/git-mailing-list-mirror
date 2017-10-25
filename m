Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72EC92055E
	for <e@80x24.org>; Wed, 25 Oct 2017 21:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbdJYVgD (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 17:36:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:60758 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751775AbdJYVgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 17:36:02 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MLelb-1e7kBm48vr-000tub; Wed, 25
 Oct 2017 23:35:54 +0200
Date:   Wed, 25 Oct 2017 23:35:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH 4/3] t/Makefile: introduce TEST_SHELL_PATH
In-Reply-To: <20171024013130.5nuxmjlwnm2l3zrq@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1710252334000.6482@virtualbox>
References: <20171019210140.64lb52cqtgdh22ew@sigill.intra.peff.net> <20171020225340.6qgybldewi7knxvz@sigill.intra.peff.net> <alpine.DEB.2.21.1.1710231258451.6482@virtualbox> <20171024013130.5nuxmjlwnm2l3zrq@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:csUAjgoLHrjQH258l7JlT5iUC1Hjj2J6qBDZ0fjDhHuDqm3HK9v
 BUndWF8uSUqNHhPQe+AV8vRjbHZUHoEp+WG/zEWG37dhJHrR7b3MJVwW5zQdtQ9W3rI6VrU
 rExU8LYLwf8pmsnH3b3CyMBx295t/YI7dZJFsoAZH0byesokAqu9QCEGvLxBpTfoL6Jwrmx
 VzfwatNBT91nqzM4uwrVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JdBlV/+Bmiw=:DzT7NjXwjo9409NSL3l2af
 DH9qnYn0RJTL8FJD4kC0bmG3RbekwX4iJVP1ZHD9V4XIinq5Howw3pyatnL/lAP6VdMY/Igmj
 z/m2PCoiGeE+asykKMv3V4upBbWWLCxE/XIkp/85y47k6r7RAOApxLNu0LtLcYlC281NU4H0C
 FuLFtqbqoGy7lOM0dED1LHgmHj/lE0s9ZBiEapaz+CNsouHW1a798G0oVrLkFH0lSK/URuB8I
 Z3FPk1pnxKaTesUce+KqosgYC9ZCP9RU1wr9y48F+AihekctqeiAqMcpwMU41DSnYzMHuEtkV
 7GqhJ5eypVAnthNsOcRa5ChOorwZtWSGSkzaru4k9xboyKTovOr7kQC1uVWBJwKQyapL+WsVW
 3836+Y/GI4weG6epS5PRH0dCqcAuWCR5XcOTwFBy9K8ZC3ESt5prQE9U08dCAfUxcZhZYQ3Bp
 JE4mEOBpRw5UvY0bdMjFvoifm9DOyF725amctQwtS0kjmUwEQ+OAM7q/W19M8OKHsXzMiUT+J
 TRoraW/+Azv5NOHIAx9gnwirBJHM3VpiZ9ZENr1v20XoVhZSSudpbxZvLGtdMgy+b4hvdFfPS
 mC5zQw5Ma4RMI6sxU2IiOnx6A4lhJVWuEv4fn2gbmjsL9U3V6Cs/PRoo+sTo6K5702DSeHaZv
 bnwSqsZck44ZJd4nSLfOjzVqMi7yCcnJLJ9N1den+EI2Dsvc1JVT+g/WnuAmiCbshKGY5jtFI
 dfNuN0Dfaldgw2ldsIPPS2sTDqRrDJA8o5A++gKvko1bDmHMMJJvEUezjN63K6knkt7V1UESV
 q6LUOLBAUecqV7WpKtfSLxzEyHzQxD0+HtXmQVm4rvsUkhATPYSad+5WvA3BOYLMRgWVzgx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 23 Oct 2017, Jeff King wrote:

> On Mon, Oct 23, 2017 at 01:01:42PM +0200, Johannes Schindelin wrote:
> 
> > On Fri, 20 Oct 2017, Jeff King wrote:
> > 
> > > @@ -2350,6 +2357,7 @@ GIT-LDFLAGS: FORCE
> > >  # and the first level quoting from the shell that runs "echo".
> > >  GIT-BUILD-OPTIONS: FORCE
> > >  	@echo SHELL_PATH=\''$(subst ','\'',$(SHELL_PATH_SQ))'\' >$@+
> > > +	@echo TEST_SHELL_PATH=\''$(subst ','\'',$(TEST_SHELL_PATH_SQ))'\' >$@+
> > 
> > Do we really want to force the test shell path to be hardcoded at runtime?
> > It may be a better idea not to write this into GIT-BUILD-OPTIONS.
> 
> My intent was to make it work "out of the box" in the same way as
> SHELL_PATH does now. So that:
> 
>   echo TEST_SHELL_PATH=whatever >>config.mak
>   make test
>   cd t && ./t1234-*
> 
> both respect it. Without going through BUILD-OPTIONS, I don't think it
> makes it into the environment via config.mak (it _does_ if you specify
> it on the command-line of "make", though).
> 
> For my purposes it would be fine to just use the environment, but I was
> trying to have it match the other variables for consistency.

Makes sense.

> > Or alternatively we could prefix the assignment by
> > 
> > 	test -n "$TEST_SHELL_PATH" ||
> > 
> > or use the pattern
> > 
> > 	TEST_SHELL_PATH="${TEST_SHELL_PATH:-[...]}"
> 
> I'm not quite sure what this is fixing.  Is there a case where we
> wouldn't have TEST_SHELL_PATH set when running the tests? I think there
> are already other bits that assume that "make" has been run (including
> the existing reference to $SHELL_PATH, I think).

The way I read your patch, setting the environment variable differnently
at test time than at build time would be ignored: GIT-BUILD-OPTIONS is
sourced and would override whatever you told the test suite to use.

I guess it does not really matter all that much in practice.

Ciao,
Dscho

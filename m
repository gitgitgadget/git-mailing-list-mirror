Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222561F859
	for <e@80x24.org>; Wed, 24 Aug 2016 07:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754504AbcHXHsO (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 03:48:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:62282 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753431AbcHXHsL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 03:48:11 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MMHaL-1bUUAD2hUz-007ynC; Wed, 24 Aug 2016 09:47:56
 +0200
Date:   Wed, 24 Aug 2016 09:47:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Ralf Thielow <ralf.thielow@gmail.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Joseph Musser <me@jnm2.com>,
        Philip Oakley <philipoakley@iee.org>,
        John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 1/2] help: introduce option --command-only
In-Reply-To: <CAN0XMOLTc5zzjXwnpDwhs-coP9BVD659CpYEJYp_v4789M2CpQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1608240947380.4924@virtualbox>
References: <20160816162030.27754-1-ralf.thielow@gmail.com> <20160818185719.4909-1-ralf.thielow@gmail.com> <20160818185719.4909-2-ralf.thielow@gmail.com> <alpine.DEB.2.20.1608190954461.4924@virtualbox>
 <CAN0XMOLTc5zzjXwnpDwhs-coP9BVD659CpYEJYp_v4789M2CpQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:e2UkG07T3kwFilLGt3arcRyue8uABiRvsmhky5lgIfuQqF+OOWk
 /UhkZ9i7qTIA4aAFCK3fAFMFawi4JkjcuZfzsHkcb9qA71SQXnpr8S5NjgPvM5zcrKYOXsK
 Ibyhd/gvwXqd3oY7OB9/2pxS/HNvvt0hTyx+N/3Pv1zENFL5eHw7xI7nEuKHFxN3qK/S4FH
 p3PBpoklqnqyNehrVRbIw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HnNagrGte0g=:WbAKRkSeRaZUeYIZgfc109
 0Ry+uwsnvvWybCW2L4HNLIOqv42rD7/SU5dFiOP+Zemeb5Ewr3O1iEIgpyRz8bpy2CFQbEGV4
 b4si3cmVO7PigdpAHq8HXjhIR/v0PKc5dV2Nsg6vFiUd/gKWfV3MtqjGG1DaxdQjUKjP8EZgN
 C+2XbzdjDYW5Iuf/Mk1vvEyjWmu+gl3sml3hVchn6kvWHz+lfd/tGyECR68k3M0riHrGwKniV
 vRCZf6hJw26nyorutctXUsdK1ujxfc9K+inz0BvaIOVNwHL2hVB2rJlCssugTFAR9NiUZWr/L
 jNghMyGSH6aHFRWdpZdLq+IbBEO9Y11T3bDp++lpqbV42efbZVyZvkmqrUm5ILqz4dKRTnbZM
 mm+ZnOLkrT0KU5azn2VQfm4j2EAfGg8zeZ/L+5RRsPGRzvsDUCOimlJfgmqwq9aNuig2Pv4Fj
 MYv7WjmaRjCI4PmD9WaOSA6hT3emx4JRJLCvqgy9U4yiH833jdYTWIaCm5vLmtdmNL4p3QcEm
 dSIqvLVraKnQXshP0ab+zTRRbwpC5Q3AF/KaOSIAezP63eT5THNExHKbTYrU5HfGliXfZT1Io
 mUv0bfBoUyzv+abfZZgnYoGxVnsUjqsz1Q1xX78/hD4Tl+8abQX0TqXNQgUc6E2dgiVsBvMyH
 ht9wCa9x7QzkXHmyHEoL//+nnBUnj2grbqLbp/w3y5PnKtzKTe0UbGVRauqX/IQHv+IuTiQh6
 cjmqLA1Zd8Vp0lhYE8sp2dgcmaa2Ya3U1sevAqNZhiaPsEGgT4M9S9XC2JZxY/LAK7yzgxmBo
 LGEqeu0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ralf,

On Tue, 23 Aug 2016, Ralf Thielow wrote:

> 2016-08-19 10:32 GMT+02:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> 
> > So how about fixing that? I would suggest to do it this way:
> >
> > - configure help.format = html (for "man", the current code would always
> >   add $(prefix)/share/man to the MANPATH when testing, not what we want,
> >   and hacking this code *just* for testing is both ugly and unnecessary).
> >
> > - configure help.htmlpath to point to a subdirectory that is created and
> >   populated in the same test script.
> >
> > - configure help.browser to point to a script that is created in the same
> >   script and whose output we can verify, too.
> >
> > The last point actually requires a patch that was recently introduced into
> > Git for Windows [*1*] (and that did not make it upstream yet) which
> > reverts that change whereby web--browse was sidestepped. That sidestepping
> > was well-intentioned but turned out to cause more harm than good.
> >
> 
> So I'll pickup the patch you sent [1] to my series and prepare the test cases
> the way you described to verify that the 'help' command works.

Thanks!

Ciao,
Johannes

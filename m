Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3DF41F516
	for <e@80x24.org>; Fri, 29 Jun 2018 11:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755254AbeF2L3g (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 07:29:36 -0400
Received: from mout.gmx.net ([212.227.15.15]:35469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932280AbeF2L3g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 07:29:36 -0400
Received: from [192.168.0.129] ([37.201.195.74]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBnvD-1fOjNz2Kn9-00AjMK; Fri, 29
 Jun 2018 13:29:24 +0200
Date:   Fri, 29 Jun 2018 13:29:08 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] Makefile: fix the "built from commit" code
In-Reply-To: <20180628174721.GD31766@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1806291326500.74@tvgsbejvaqbjf.bet>
References: <pull.7.git.gitgitgadget@gmail.com> <e0e41d0b88b4104737b9ee80710c1bec91c9d759.1530190395.git.gitgitgadget@gmail.com> <20180628132314.GA14026@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1806281809060.73@tvgsbejvaqbjf.bet> <xmqqa7reyg6z.fsf@gitster-ct.c.googlers.com>
 <20180628174721.GD31766@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Cv5kHBitIbRgMW4Gg26GZRjUqtzswRBGERPNvggVZvA7dxE2Z3Q
 ReVuqOCRzGt5P294hXwE0Z4jmfnM3oqzNJKOFqc8abYd2GHoD2/TbjtuLfbLW9mWFV3cWgz
 70iiIEmzGxvopsUSZDK+jMsDhAWywBh8EhTgkD6/Rcb1fotwZ5ATLb0wE1zJPVU2BDe0+AS
 yM8XxW5fHMrahfCfs1atQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8evOM+QAaKI=:7/eKEjIMIb0UZZSu0eckJB
 +qnoqygmHxpNxcb7bu6q25EXu38d5X18Of36k8vUFqTpY6D3sEn/V2vV0Uq00HGeQYVzxuKxQ
 a7obhWc259es5pLBbZcjV27ztnFCgf3NMuzHByzB6K2aY+HG32iG1hJaY3OG4qZqMRqQKL8H1
 0svI4DEcKSIy5T26laJZDMNkXm9/E8Bp8pzufYLub2UG0wpvH+3PPxWdc7tS90s6a0wCOVAkM
 oJBUkVcChKJcvm9rJcQJSFRcLtM8/Usc7w/dnH0pYubY/B6HLjK5HYKwc393sEc726sYNN8X+
 MtrT9hHGQDObLZwubJJvupdTLPhEVc2HoPxbY1JDIQYdr/o4CnXFY8qjB6Y0l0tgaBVV4Q1/u
 ceFejswiknA67XvvdENNoZXkexP1MsNMbp5pwzYCoiOOrt8GfMwqCd2cGvMNseN0VEgZ7GJ/b
 qodvoEFsOMmzXP6+9Uq2b6smwZ7WBTUQEAohS5CWwGb9k51vfiix5s1q1uFcmuAeJ+rVtPhMY
 bbcrFWLOgRkMmDUTGXPBDjAPll9WYAMekdwQISwWNCWF2J37U/IjCj1DZKrmZQ15t2jEiu7C1
 1NKHq/flK2g+dUjGxAP5TJy3/7gcMT7y2B/OG93AYvoQeVnt1ScmbL2KvVVOKNEzL3p/2JYcr
 QARlcX6xOXvKt2TdBz0nZP3b5PT5AMwEIa1nR3m2PBuvRGXOIYVNBncZVH1iW+k9KQo0had0o
 4Pf4K5TrCiXxxa8Kwl7pEhl/CzWZH3SY+aPbKIygJ3qx3y19nOPABzQLi9PbpZZKKJ8cxoG8a
 4NXylgR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Thu, 28 Jun 2018, Jeff King wrote:

> On Thu, Jun 28, 2018 at 10:27:32AM -0700, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > >> I.e.:
> > >> 
> > >>   FOO='with spaces'
> > >>   BAR=$FOO sh -c 'echo $BAR'
> > >> 
> > >> works just fine.
> > >
> > > 	$ x="two  spaces"
> > >
> > > 	$ echo $x
> > > 	two spaces
> > >
> > > Maybe we should quote a little bit more religiously.
> > 
> > Both of you are wrong ;-)

Technically, you did not contradict anything I said.

> > Of course, the lack of dq around echo's argument makes shell split
> > two and spaces into two args and feed them separately to echo, and
> > causes echo to show them with a single SP in between.  Peff's
> > exampel should have been
> > 
> > 	BAR=$FOO sh -c 'echo "$BAR"'
> 
> Yes, that's a better example. I was primarily trying to show that the
> outer shell did not barf with "spaces: command not found".
> 
> > But that does not have much to do with the primary point Peff was
> > talking about, which is that in this sequence:
> > 
> > 	$ x="two  spaces"
> > 	$ y="$x"
> > 	$ z=$x
> > 	$ echo "x=<$x>" "y=<$y>" "z=<$z>"
> > 
> > assignment to y and z behave identically, i.e. dq around "$x" when
> > assigning to y is not needed.
> 
> I actually had to test it to convince myself that one-shot assignments
> behaved the same way, but they do.

The mere fact that you had to test it out to convince yourself suggests to
me that my suspicion "Maybe we should quote a little bit more religiously"
was 100% spot on.

After all, almost *none* of the reviews on this mailing list involve
anything like "testing it out". It happens in the mailing program, and it
stays in the mailing program.

Ciao,
Dscho

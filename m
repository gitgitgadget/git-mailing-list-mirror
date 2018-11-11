Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B6E1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 10:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeKKUFH (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 15:05:07 -0500
Received: from mout.web.de ([212.227.15.3]:42567 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbeKKUFH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 15:05:07 -0500
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2MZY-1fWIdj11S0-00s2kn; Sun, 11
 Nov 2018 11:16:51 +0100
Date:   Sun, 11 Nov 2018 11:16:50 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Upcast size_t variables to uintmax_t when printing
Message-ID: <20181111101650.GA4471@tor.lan>
References: <20181111070504.12858-1-tboegi@web.de>
 <20181111072835.GL30850@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181111072835.GL30850@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:5gP2qyKjJPEA+NML7e4QXKtQcQA2nQuXT4OSPK6HB2rASUgrWwK
 7pBlG7qNObLMj+hC4pfRdTjdezedIQsIXzce8YlEgr0GG3I+wB0Om51B88NFRUDNsWWaDMp
 EqXmDBihFUINIzNkT9t4yiUUA9eFFAWR7XG4hyq0R2uf2ADwiZCEKSE5XI+4pJF/eLo4Zof
 GwyAlnFicHbOSziGQgqyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zwNj9ANCVKQ=:vdbzzhT1t9qJFWJccYwjV8
 D6Mntf58bPFXBeE69udBWezsazskGtMgL1Lh+/luNmebQZpdJ3fNGOXSud7aF7ZVUAlxhWrbQ
 QGYTkiapfh0AWZ7sRZtU/iBX9kWnwJ58J5K2dJ8LJxpYCYfwPCV7iqgoL5j/3835rZPFkzXCl
 A34LBSQEA3PPDnqdvDEdApK4GHCTZ5ZuN29oEzNYcRf3XladsSXE13FMTzKNRLtq8W+hTIeHT
 mJi4B3b8B6+byCqx4weT8zvihmCX4lx1LeUy/xyA8KokdkXds82FOGiGMg9cdpkFPrg7d3qn9
 UPckinU0iNkmYlJi2maSJa1goRf5oyQf8B68f1XxkO6cCY6/vvqKpJHn53klRRjaLNvmTS+rd
 8ORHtSveLP9WZFe0vorwgXoFAEdAEyne2o88TiPML334ezwUTUpum9SvpCkgCfdSrVjb+uURz
 ftdCamSCZwkrawn6hM7zFa5T3fuRcK4pAelmI8EFjU/u72RDr9p6G1G/CpHnlgvrfZ7rRoHjC
 fNLkFjZbFHzKxmIazdm2uok5uda/STpaAJmc2EZue6wet5bhGgUkgqFUakczBS976tbZC1pHA
 Ymzlq8k41COJxEGwt+9LJw8Of32AvalMEgkCAEjUPF5PQgMz1iPgUPgfaN+m9UpzzSXGdIKql
 XO6iVBl3W2CI3E+rOXUt0IB93U239yyDH6msV9HPiDIMkrQ0F0WfoLuj2Dk7OxH9ZvH0tR/zb
 zgRD1CAD7lpWSoMH1reB7F4rCZMA2WW4W6um/Ak7wTmUP8aI6jNNp9s17xxyx9U+vDlt4m7MX
 npSrFYwKSRjNNCFEuMgbPr2KPVQomvVLziu7Gf9fbaGYeJrsC4qYc323SNU304MAA08SunOjl
 1VqGCgPxBR0/TdZ7Lw+58lmbgM/5+/qKqdLTYF4PM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 02:28:35AM -0500, Jeff King wrote:
> On Sun, Nov 11, 2018 at 08:05:04AM +0100, tboegi@web.de wrote:
> 
> > From: Torsten Bögershausen <tboegi@web.de>
> > 
> > When printing variables which contain a size, today "unsigned long"
> > is used at many places.
> > In order to be able to change the type from "unsigned long" into size_t
> > some day in the future, we need to have a way to print 64 bit variables
> > on a system that has "unsigned long" defined to be 32 bit, like Win64.
> > 
> > Upcast all those variables into uintmax_t before they are printed.
> > This is to prepare for a bigger change, when "unsigned long"
> > will be converted into size_t for variables which may be > 4Gib.
> 
> I like the overall direction. I feel a little funny doing this step now,
> and not as part of a series to convert individual variables. But I
> cannot offhand think of any reason that it would behave badly even if
> the other part does not materialize
> 

Hej all,
There may be some background information missing:
- I did a 2-patch series based on this commit in pu:
    commit 37c59c3e8fac8bae7ccc5baa148b0e9bae0c8d65
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Sat Oct 27 16:42:25 2018 +0900

        treewide: apply cocci patch

(that patch was never send out, see below)
....
The week later, I tried to apply it on pu, but that was nearly hopeless,
as too much things had changed on pu.
I had the chance to compile & test it, but decided to take "part2" before
"part1", so to say:
Fix all the printing, and wait for the master branch to settle,
and then do the "unsigned long" -> size_t conversion.
That will probably happen after 2.20.

At the moment, the big "unsigned long" -> size_t conversion is dependend on
 - mk/use-size-t-in-zlib
 - sb/more-repo-in-api,
 - jk/xdiff-interface'
 (and probably more stuff from Duy and others)

How should we handle the big makeover ?

> -Peff

And thanks for reading my stuff

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 397C91FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 15:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753546AbdC0PML (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 11:12:11 -0400
Received: from mout.gmx.net ([212.227.15.18]:53165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752432AbdC0PMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 11:12:09 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MA91t-1cynh02Pmr-00BItl; Mon, 27
 Mar 2017 17:11:35 +0200
Date:   Mon, 27 Mar 2017 17:11:34 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Inaw Tham <pickfire@riseup.net>
cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: Re: Re: GSoC Project | Convert interactive rebase to C
In-Reply-To: <20170325021703.Tjq7i-hO7%pickfire@riseup.net>
Message-ID: <alpine.DEB.2.20.1703271700130.14958@virtualbox>
References: <20170320164154.xBcU6rG0C%pickfire@riseup.net> <CAGZ79kbF+O6tgn-4ivmOza3QGA4oFyJS=9eGHYZ1HQgw6+rEtQ@mail.gmail.com> <20170321060526.sXz0cdJwc%pickfire@riseup.net> <alpine.DEB.2.20.1703231827060.3767@virtualbox>
 <20170325021703.Tjq7i-hO7%pickfire@riseup.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:OGxo3GmKZZ8THFVm7wEbV0baCuCS4Jv6BlHN5O39V3xPjKSY20b
 HTpqgXcANgN9TyavG5EObYlmyQxICSHtk1hmEmYfdI4KOAcXm2UIRZdrLR3/mmybWM/9JZu
 dZ3jPZaaWPGj/KmRmSV2e3zR/R6U4kkLUxwS8xxmiuloHTUAk0cE8gHZOuvTFvCUwIenbYO
 1jvEt+7A6usmycW/k/GCg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+YxrXdjfIlg=:8yPd4BdCACKlnMXbYUgOHD
 IftkGjFwZoA3axmnMfuEkL8z7ge9l7s9FcDvLoWMsS+dT0OehVXoWRm8rzxDegUyucnvN+WMY
 0CVgDXraUheXEMDZDiUDzm9RMiBL1woTdcZ1J9XqMx2V5eWiPH9AZkN5BtkNnKoo6iXgS/OJy
 m+048vHq1l3sPHFyFWDA6c5MhzsgZhRNBtCxyIht+LIE6bT8ItGFlMxjAoNNTO0vPGBnWG8AD
 FGtHchX9+glbKOtP/2FycPMrHrBfmfaQ/FTJq1yvbO1otU1LAB5ykPCvTUiyb8sXC97UBzJmn
 2VmfYn8Iz1QLdjmue4RElk42LSZh0xvTHhFHiKKwGaUTgqS+t2tI59X9lS8yWxbMdeuL5/K7g
 RPRLIz+Aoi1Sl4jHb8vHeetLLDQTyErPz+UbttViGhgddZQkZB0WcdHZa+Mx2546qtFAqNPFR
 WJkHXlNGT2Yab8/o8m1YMNI+B2EUWC4FqYetM92dKLKDUu3vfoDnbU1AQkIV9TDROX//sxerg
 auR/e+gOmcfETSvc+wFdjcsUAHM0vUTRKvwDH9fIidbj8VFm7Cf37GhJQLtrTte7DUcJdCudf
 AxCXQHIlqwt0u/gc4X1Iw0nSG6vjw9sOhjNL6sHhwqv9GMOGBPyhankr4AfdoSolqrCUq5C4S
 4BlfyQ47/FFDc/JZLJzTTSkz3pH/yTzooxz/TOqJSKfL3i9+cOtgRUpDWlw4MgaH46TaGgDxh
 n7tXdIur3wTOgPXFaTcDBLW0bmBFti0roZD0RVoVn0oqGMjl35iPO+oqYjXCmZBMW85+I3p3j
 Ot8J2HO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ivan,

On Sat, 25 Mar 2017, Inaw Tham wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 21 Mar 2017, Ivan Tham wrote:
> > > Stefan Beller <sbeller@google.com> wrote:
> > > > On Mon, Mar 20, 2017 at 9:41 AM, Ivan Tham <pickfire@riseup.net> wrote:
> > > >
> > > > > I am interested to work on "Convert interactive rebase to C"
> > > >
> > > > +cc Johannes, who recently worked on rebase and the sequencer.
> > 
> > Glad you are interested! Please note that large parts of the
> > interactive rebase are already in C now, but there is enough work left
> > in that corner.
> 
> Glad to hear that, I would really like to see interactive rebase in C.

Please note that a notable part already made it into C in v2.12.1. There
are still a few loose ends to tie, of course; it still makes for a great
head start on your project, methinks.

> > > > > aiming to port most builtins stuff to C in which we can reduce
> > > > > the size of git. Additionally, I would also like to convert
> > > > > scripts to builtins as an additional milestone.
> > 
> > Careful. It is a ton of work to get the rebase -i conversion done, and
> > then a ton of work to get it integrated. That will fill 3 months, very
> > easily.
> 
> My main aim is to reduce the extra dependency of perl, but planning to
> start with rebase, can I make that an optional task where I can help out
> after I had completed my main task during gsoc?

Sure, you can make it an optional task, and I would be very happy if you
followed up on it even after GSoC!

As far as the Perl dependency is concerned, I actually think there is only
one serious one left: git add -i.

Granted, there is send-email, but it really does not matter all that much
these days *except* if you want to use Git to contribute to projects that
still use a mailing list-based patch submission process (the ones that
come to mind are: Git, Linux and Cygwin). Most Git users actually do not
submit any patches to mailing lists, therefore I tend to ignore this one.

The rest of the Perl scripts interacts with foreign SCMs (archimport,
cvsexportcommit, cvsimport, cvsserver, and svn). I *guess* that it would
be nice to follow up on the remote-svn work (which has not really gone
anywhere so far, AFAICT the main driving contributor pursues different
projects these days), but IMHO none of these are really needed to run Git.

Ciao,
Johannes

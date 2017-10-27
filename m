Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB7D91FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbdJ0PGK (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:06:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:61932 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751001AbdJ0PGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 11:06:09 -0400
Received: from virtualbox ([2.247.243.12]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LzblK-1d3fij1Vpa-014i6p; Fri, 27
 Oct 2017 17:05:39 +0200
Date:   Fri, 27 Oct 2017 17:05:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/6] Create Git/Packet.pm
In-Reply-To: <xmqq4lqmfoy7.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710271626410.6482@virtualbox>
References: <20171019123030.17338-1-chriscool@tuxfamily.org> <alpine.DEB.2.21.1.1710260008270.37495@virtualbox> <xmqq4lqmfoy7.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:HqLbTdVhAhdI4vAF0/lHIck8HKBx3DnmNzVWLtDyVUq6sCGvfZR
 nqpm+yoi1NyJPiTtH3F1YU2uTo/nN4JC1f3Ixh9/lQNPloaAhrBNgTFRaHIFXIwUnboxwFG
 EVOBbhmVwZjRxCKGL/0001+vB7Km5axv+XsE2Tpn1IozbeHKnPYRMJOLat/cQ4z8496sbAo
 ulEuXNcHGuPo/DjgOOeIA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9heKaW2wrBI=:e2cDOkm4n5w63h4IRnBDgA
 ahsW3OuU6KsH6SFR0GvJuLJwYyLT4/ja+E50o8XN1YdnqpXgvB0OJF7sbtmaNc2H+ixRYoIUL
 Z/vsdxQ7gIw9bHeTrD3JToG/0V98TVeloiUzXjXNVbeu8UzqjH/MFtrVkRTuxjamdC72emV5n
 bMYaiSBJ697kE6br9QujYwq07MZmjV/QWHs9orPlJCLDMnikF9/boAZ/TP46yKi4zaymswCrN
 xJbqU0roW0U2GRpL3jQlV0NtzGva5rrSAZgTIP22BIxJmRoWoSIyx4NCm1hHrZYfSYxrPoGXn
 BrdlsztXhnEnZBIa6AFGmX0lBDgXs7VNRHTlVci41ATLhYP96ViL/027n+2loRXohyPid5n2D
 LzlYfjIXUVm9mkCcj+A6EsgHFR4hlNnQaffbsPFRT7io9eKr4391c2w52wOBocm6MWMqq/Ldz
 PpBger/MzGg/gbKoUR5ZPEvDC8nC27utZ1KNkHoTMeIyRd4CbW9M6I5TM1ZExzD3UuC9HvXqS
 PuYe/Vze9sFd7uefZ4bzBkbn2dObYgwNfioSDeU1BzwThrTRKqq7WnI5/mkgrpelTSFSTihVb
 l6xot84gdFBWYG20is+38fEqLjnoW6eOIxe1r6EAJitdcX4lYnsWLZvw5bQgZgT1ks4qHPnK1
 +4pIxB215WoZ/dMIwvTATIbJGXAOjvPG476kxFyQZLA3c5JXaTmQrY7I1Jblov4CXiqtd7pDo
 rLS+JM02MfxEuHjjf6hyTCyxwpSDma/DfZnD9j5V6OryPD5fcbq7pqzMhOZUYyGdJVt+27rt6
 p5xG9n5vtaMhYseZMP/RwpNJ4ppBXOoi6z0qiQ4dIJDvCTazT8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 26 Oct 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Note that the correct blib path starts with `C:\BuildAgent\_work` and
> > the line
> >
> > 	use lib (split(/:/, $ENV{GITPERLLIB}));
> >
> > splits off the drive letter from the rest of the path. Obviously, this
> > fails to Do The Right Thing, and simply points to Yet Another Portability
> > Problem with Git's reliance on Unix scripting.
> 
> In our C code, we have "#define PATH_SEP ';'", and encourage our
> code to be careful and use it.  Is there something similar for Perl
> scripts, I wonder.
> 
> I notice that t/{t0202,t9000,t9700}/test.pl share the same
> split(/:/, $ENV{GITPERLLIB}); forcing this specific variable to use
> the non-platform convention to accomodate the use of split(/:/)
> certainly is a workaround, but it does feel dirty.

It is not only dirty, it *still* does not work with that workaround: Note
that GITPERLLIB is *also* set in the bin-wrappers/*...

And even then, it does not work: somewhere along the way, the path is
converted to a Windows path with backslashes, and for some reason MSYS2
Perl fails to handle that.

The best workaround I found in Git's source code (yes, it took me 2h to
investigate this littly problem, but at least I got an in-depth
understanding of the issue) was to pass BLIB_DIR instead, and not perform
a split but generate the two paths to include in Perl instead. Of course,
that would break out-of-tree usage of GITPERLLIB...

That's why I settled on the out-of-tree workaround that Windows
contributors will have to somehow figure out (as if it was not hard enough
already to contribute to Git for Windows...).

> It is hard to imagine that we were the first people who wants to
> split the value of a variable into a list, where the value is a list
> of paths, concatenated into a single string with a delimiter that
> may be platform specific.

No, the test suite has plenty of use cases for that. It usually works.

The problem is that t0021 contains very complex code that goes back and
forth between the C layer and the scripted layer. At one stage, the
pseudo-Unix paths are converted to Windows paths, with drive prefix and
backslashes, separated by semicolons. And somewhere along the lines, this
cannot be converted back.

I *think* that it happens when the bin-wrapper for git.exe is executed
from inside Git itself, or some such.

> I wonder if we are going against a best practice established in the Perl
> world, simply because we don't know about it (i.e. basically, it would
> say "don't split at a colon because not all world is Unix; use
> $this_module instead", similar to "don't split at a slash, use
> File::Spec instead to extract path components").

We go against best practices by having crucial parts of Git implemented as
Perl scripts. But you knew that ;-)

Ciao,
Dscho

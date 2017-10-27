Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7EF91FAED
	for <e@80x24.org>; Fri, 27 Oct 2017 15:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751811AbdJ0PLp (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 11:11:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:55113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752664AbdJ0PJf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 11:09:35 -0400
Received: from virtualbox ([2.247.243.12]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnPnu-1dXOeg1zyg-00hgMb; Fri, 27
 Oct 2017 17:09:16 +0200
Date:   Fri, 27 Oct 2017 17:09:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Bryan Turner <bturner@atlassian.com>
cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/6] Create Git/Packet.pm
In-Reply-To: <CAGyf7-EjKaHgwkN9trO4mFvba9odbWCzA9Jh0Pk6ZE6FOskOYg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710271707290.6482@virtualbox>
References: <20171019123030.17338-1-chriscool@tuxfamily.org> <alpine.DEB.2.21.1.1710260008270.37495@virtualbox> <xmqq4lqmfoy7.fsf@gitster.mtv.corp.google.com> <CA+P7+xpcC7Daw5k3=XFyZRsqiBib6yY2YzLpjYfcS7yqfUzTpg@mail.gmail.com>
 <CAGyf7-EjKaHgwkN9trO4mFvba9odbWCzA9Jh0Pk6ZE6FOskOYg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:17rUhPIjNHqyfBLXhtsAeX1v4/Hy3nDK8LZ1RnB8ifN4JHTn5hI
 UEqa746/JpJDksE+CW7IGMqXgsiJkbyfEoqDVEP9WwMGCQzImV3HblmDMWWX/lAMzjIL34C
 v48l8mH9IuNwn92lQh4BtdSsqiM4OYUzDQnA8nJ5+8dJSz8qUKLjnQV6sAWH3fChMrzml5V
 ClHpn2wUNtYt9GJuxmu+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fOQcpJv+KfU=:ZKOhZHc+iUC38Q1HWO+qSD
 VKkq4z4xJEmPDlmAr23XvxEGBP9XUUUh99Q3LnvCsOanESAPpqlFnmDFJl4i3FwMVdlvtOWzI
 EQq6WPFC9HEyP9OG1TPvNGledCqqQEWARnQ/8svNK+dxS7AXRyJdqSIvPdGnAq4RPmExeVjcS
 3/iYoUHhtCNrsRpTEoLdTjK8kyg+WS000G/5RRGSlgVpTCQWl/Sl0MCJsH6o4gQEE9xxRlqYT
 nMP5eSbSetNsjZAMRitq82phgM3XnP8B2al2UTJAGW6XLP/APUT7E4zAKA4OTnCGxp9OgFMFC
 HEaB1+fYLoYPxzc1q24rlyk3UQ+MmRZlW08md0TsCbbzFmv9O454OFvap9wZSS43Lf2TCWAxh
 g439oAmD+w9yRqYAadx9NL9PcykBxSN7AJMELbL0t8ZzG/puuRTBXnxgvSFrGxS2X1T0Tz1iU
 iNPVMiw/gsxZ0b5ONMcx/cCBLM4P7dxMJo5molaPtATfkAd+RspYzsa9o2GwWtesYmRIR21tn
 a9CAOfS0VvtO9zRKFJWVSIHnIVG8mUbtrr5GtedZzEEO0eax+rCIWYQ9hH5gZDEdPPY3LIvGz
 GC9r4+9+vBmkE3FR+2uE2/mLzRxa0doOr/2zYyt+JCrfo7al2d7TvK8oHHJOg7BSTiVDNtUF8
 9Kw5gp2LSMq4+l8Cf6tubnEQO2Y1jYGUJPi4OqsVKtAbTRnoQkGUeIdmgf0wBAoUUXqlyt0o4
 r2zrNkGpcmk+5YMW0K3ZLHhI30VGJ3yWEjLOBGi6r5FO7MjDvgA0IjWq/PWquw4NTgx2pCbQs
 GWrbeRcl2Wn0kv8YBMNDn7L4z97yrWmVk3aSLnPjM0pSNUg/I0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bryan,

On Thu, 26 Oct 2017, Bryan Turner wrote:

> On Thu, Oct 26, 2017 at 2:07 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> > On Wed, Oct 25, 2017 at 10:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >>
> >>> Note that the correct blib path starts with `C:\BuildAgent\_work` and
> >>> the line
> >>>
> >>>       use lib (split(/:/, $ENV{GITPERLLIB}));
> >>>
> >>> splits off the drive letter from the rest of the path. Obviously, this
> >>> fails to Do The Right Thing, and simply points to Yet Another Portability
> >>> Problem with Git's reliance on Unix scripting.
> >>
> >> In our C code, we have "#define PATH_SEP ';'", and encourage our
> >> code to be careful and use it.  Is there something similar for Perl
> >> scripts, I wonder.
> >>
> >> I notice that t/{t0202,t9000,t9700}/test.pl share the same
> >> split(/:/, $ENV{GITPERLLIB}); forcing this specific variable to use
> >> the non-platform convention to accomodate the use of split(/:/)
> >> certainly is a workaround, but it does feel dirty.
> >>
> >> It is hard to imagine that we were the first people who wants to
> >> split the value of a variable into a list, where the value is a list
> >> of paths, concatenated into a single string with a delimiter that
> >> may be platform specific.  I wonder if we are going against a best
> >> practice established in the Perl world, simply because we don't know
> >> about it (i.e. basically, it would say "don't split at a colon
> >> because not all world is Unix; use $this_module instead", similar to
> >> "don't split at a slash, use File::Spec instead to extract path
> >> components").
> >>
> >
> > I thought there was a way to do this in File::Spec, but that's only
> > for splitting regular paths, and not for splitting a list of paths
> > separated by ":" or ";"
> >
> > We probably should find a better solution to allow this to work with
> > windows style paths...? I know that python provides os.pathsep, but I
> > haven't seen an equivalent for perl yet.
> >
> > The Env[1] core modules suggests using $Config::Config{path_sep}[2]..
> > maybe we should be using this?
> 
> I was testing this recently on the Perl included with Git for Windows
> and it returns : for the path separator even though it's on Windows,
> so I don't think that would work. The Perl in Git for Windows seems to
> want UNIX-style inputs (something Dscho seemed to allude to in his
> response earlier.). I'm not sure why it's that way, but he probably
> knows.

MSYS2 Perl is essentially Cygwin's Perl ported over to MSYS2. And Cygwin
tries to keep everything as pseudo Unix as possible, to make it easier to
port software (if you think Git's source code is the only source code
woefully unprepared for semicolons as path separators, you just need to
buy me a few beers to hear plenty of war stories).

Ciao,
Dscho

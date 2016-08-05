Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D79D42018E
	for <e@80x24.org>; Fri,  5 Aug 2016 08:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934915AbcHEIZ3 (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 04:25:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:61977 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759510AbcHEIYu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 04:24:50 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MNIO5-1bcT7I3txB-006uwT; Fri, 05 Aug 2016 10:24:02
 +0200
Date:	Fri, 5 Aug 2016 10:24:00 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Eric Wong <e@80x24.org>
cc:	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16] merge_recursive:
 abort properly upon errors
In-Reply-To: <20160804201751.GA9592@starla>
Message-ID: <alpine.DEB.2.20.1608051023560.5786@virtualbox>
References: <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de> <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com> <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox> <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com> <20160804201751.GA9592@starla>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vm6SypbDMRXE3UyK7MlhrqpeUogEDOBP8Gw4qiqGnar6VW1dycl
 7VeE4Rv+XD5lGPK46Y+td6noWCyEFT9umG/4vg8LY3Z8EPM2wPA28Hjqh1s58s6LmOj7xK8
 T5mDRzSIo84t4Xz6vlu2e0AaGzN/JpM8cPZ1XNt20CIsq4GDVZpUfamEEgDIX10xqhtFTks
 7fBZoDt8yrhfcEeazZ4Sw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Z2XuivVSUBs=:/iX9cQG08uS0NGUcqltTEb
 +c+QgRxIwlvk5Xw1mOo35e5QLY1N5rtXHdb0EcDyGiw2E5ChgPD6zIIeZKd3Yd0WR+0NXDhIi
 BX0lZwvwWzt83oeGr4KbFV3Kp/qrxyHmmLrw4+DY/RMDglnOmRGVGmdcFstXrLceD/wcIrrjU
 akJRE54xQFxVyyRxAlNj66yTD90XqdcD+wdS853pZBnOtHG5N7gPQX+DdScHvjeRZQni+zd79
 6Kx5MEBXPgdAnudvNSjxuSm34KgkRboXxUCB/6m1vjWrQhOSZv8oF8pUzNdVvXyYR6Fo67vta
 0z3pVXzS2Ou+Se3Coa012PgNfRFKOTb8vTlYmX4RmyIWR9Fzi9InGJirNS2ikrUvO1zwtTJn6
 okLtggCb2DEMwgkLTCgFzk4EWlx/2HXzQQ356o2c30Cw/dQ+ruFG47TPnKo9vBWUc+xfd/0zT
 Q+8dYKdgbO21/n89T0dXhid5mxFFQhWvwnMHIAkQLgzfck4T8jed9jcJ1LJIWkmRrMkan3Siu
 rEDC2fUiXXSmU8fMxgdBt5VNhjT+ecR1OAYyCwYuU+c2j0omIGABtaJUqQtQmC1Cfz54bzwn3
 50eYYBopesIt8mAJQTA/m4l8a5u5DIpnj2xH7gwysHjx7spiX89zO8JWVXKHDZXpeR1iuXHNe
 XkGfz1bwbQJDdO/7q9UsBPFdKfC4ba7nbGif0dJipfG2TEB/ihxPYQDg/ogk8VWhUHolMzkX8
 yJKvtEf22sqmfRJoNX8XpXOauzqKXNAptaqilSYKOhlk7sLO0tKMvBRR84qvu9MfLQ3tup08H
 RV/8UGT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Eric,

On Thu, 4 Aug 2016, Eric Wong wrote:

> Stefan Beller <sbeller@google.com> wrote:
> > On Thu, Aug 4, 2016 at 8:58 AM, Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > > I guess I have no really good idea yet, either, how to retain the ease of
> > > access of sending mails to the list, yet somehow keep a strong tie with
> > > the original data stored in Git.
> > 
> > Does it have to be email? Transmitting text could be solved
> > differently as well.
> 
> I've thought a lot about this over the years still think email
> is the least bad.

Not only that: people are *familiar* with it. And they have *access* to
it.

> Anti-spam tools for other messaging systems are far behind,
> proprietary, or non-existent.  bugzilla.kernel.org has been hit
> hard lately and I see plenty of bug-tracker-to-mail spam as a
> result from projects that use web-based bug trackers.

Plus, they are all centralized. Do you want to *require* contibutors to
register with a new service?

> I guess a blockchain (*coin) implementation might work (like
> hashcash is used for email anti-spam), but the ones I've glanced
> at all look like a bigger waste of electricity than email
> filters.

I am not even so much concerned with ecological considerations here. Just
the price of entry would be prohibitive.

> Of course, centralized systems are unacceptable to me;
> and with that I'll never claim any network service I run
> will be reliable :)

Hehehe. I guess that's why the public-inbox is backed by a Git
repository... BTW is it auto-mirrored anywhere?

Ciao,
Dscho

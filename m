Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF95B1F859
	for <e@80x24.org>; Sat,  6 Aug 2016 22:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbcHFWbs (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 18:31:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:50228 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbcHFWbq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 18:31:46 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MEGIi-1bTkJ83jEu-00FWd7; Sat, 06 Aug 2016 10:45:15
 +0200
Date:	Sat, 6 Aug 2016 10:44:56 +0200 (CEST)
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
In-Reply-To: <20160805184656.GA463@starla>
Message-ID: <alpine.DEB.2.20.1608061038460.5786@virtualbox>
References: <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox> <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox> <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com> <alpine.DEB.2.20.1608041730130.5786@virtualbox> <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
 <alpine.DEB.2.20.1608050925240.5786@virtualbox> <20160805184656.GA463@starla>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nEro38qv55qbUP/0H74O542DLdadlMQKP4xpGhF+Z1Josmw/1di
 GqxnVIISGfoWk6Z3JXHPHChPHRhajG/qv0ovi5niuupQkYixBTP9fd5kQUaNvsg+m09LikK
 c0e0xhQRYLeqcqRxNz4MjFNFdXLPGyvakUOBflYnuQS4Hk+A3nRFrZXWs6YBTT6MCAc0N8+
 oOh/pjs7ROfzzS/Aqyu3A==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:xPpMhSjxmJQ=:L4M/GiHBCX/qkUwrJny1ee
 /vUvJ05JdbEfo2UsjHc+BviQCdVmOLGWCMCy/vhIgr8ry+d+tuF9YbrrvWJ00D8x2+eqB6k3H
 D641Dp4vDvQehAEv1sp+bPanmJMppWVe1hn5sLGZm+nOs1EERMC2lR5WDQjRY37wcQVSLB0Dh
 ESxdS+ADE1hGyv1QHL/TVpqowmF0IT1U6mI5hqdVINW/FwilscJSlDbkGPRuL9L5AXaS4YkiT
 kq6R1mWOVuspuhoWlDbF1zK6H3RojD32IsYpVtBDciZkoA0ETjxtOHLA1ABRfBEMj2VNiNNiZ
 pHPOZtvm91o8FJv37J/EiYZmlBgJhIeZufLuulIEFICVZ61gkEzIXYIACjRHNp5QjdlOTIKHI
 n08CYhE+qHw2ValAZ9nzOlsi1wYx9B1RBt2QKuclocWZ/25vTDUDbvjmWrl4KQy8hcZ0qe+XJ
 efmi37MtE2165TDxVisid7mxf8BMYyMsXM0qkr2vvfUL9WOOOmP5zloEdJcNUaLEGdb+GrM7q
 0ah/GmZ1QTm3yExut0QiXhJFfUyFGFO33IbWHOTtHM+R3WazJ/N2X0GlSIpO8FqhsI2fx76d1
 DOyIvBS1jhGwmIaq6V7u3Nu24tWoANMciqWUd/e/Hv/scsmoVLm0Qs/xTDQcgb1WVFAaTldAX
 nV965yOEH/i80ZUWXmtU10c6Rb0lDXrS+oo00+vgUIK+B9DiW/lMMC/RT/JEPXaAwB3LRoQdI
 n8qQKIa29Qa8/3o71duhTt6ibk3Chd34SBAkN/Gk20jW+T7ntSruxt/IOjhhKbZqyci4rxOL9
 Q57WEgw
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Eric,

On Fri, 5 Aug 2016, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 4 Aug 2016, Stefan Beller wrote:
> > > git send-email/format-patch recently learned to include a base commit
> > 
> > You may have noticed that my mail-patch-series.sh-generated code
> > submissions contain that base commit. But they still do not contain the
> > SHA-1s of my local commits corresponding to the patches, and even if they
> > did, the replies with suggested edits would most likely have lost said
> > information.
> > 
> > I also hate to break it to you that git-send-email is not going to be part
> > of any solution.
> 
> I think it ought to be.  Some reasons I like emailing patches are:
> 
> [...]

What I said is that *git-send-email* is not going to be part of any
solution.

Note that I said *git-send-email*, not "emailing patches".

What many people on this list forget is that few email users *ever* touch
their email configuration. Asking them to figure out their SMTP settings
and then to make git-send-email work is, uhm, quite a bit unrealistic.

Ciao,
Dscho

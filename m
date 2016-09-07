Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A051F859
	for <e@80x24.org>; Wed,  7 Sep 2016 01:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755322AbcIGBIW (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 21:08:22 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41066 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755253AbcIGBIV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 21:08:21 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 89F8D1F6BF;
        Wed,  7 Sep 2016 01:08:20 +0000 (UTC)
Date:   Wed, 7 Sep 2016 01:08:20 +0000
From:   Eric Wong <e@80x24.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Philip Oakley <philipoakley@iee.org>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Nicola Paolucci <durden@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
        Johannes Sixt <j6t@kdbg.org>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        meta@public-inbox.org
Subject: Re: Draft of Git Rev News edition 18
Message-ID: <20160907010820.GA26951@dcvr>
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
 <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley>
 <9f3b254f-451e-4f6d-233c-7e995d8e369e@gmail.com>
 <20160816093027.GA27347@dcvr>
 <20160816093412.v3tenw4vyxipunah@x>
 <20160816212704.GA25034@dcvr>
 <20160816223215.GC17195@cloud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160816223215.GC17195@cloud>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> wrote:
> On Tue, Aug 16, 2016 at 09:27:04PM +0000, Eric Wong wrote:
> > As for other projects, I'm not aware of anybody else using it,
> > yet.  I have some small projects using it, but most of those are
> > one-off throwaways and I'm not comfortable promoting those along
> > with public-inbox.  I admit: I'm not comfortable promoting
> > anything I do, really.
> 
> Please take this as encouragement to do so.  I'd love to see the
> public-inbox equivalent to the main page of https://lists.debian.org/ ,
> as an example.  (And I'd love to have public-inbox archives of Debian
> mailing lists.)

Just pushed out some POD (which should build to manpages),
so maybe early adopters can start hosting mirrors themselves(*).

   https://public-inbox.org/meta/20160907004907.1479-1-e@80x24.org/

I hope public-inbox-overview(7) is a good starting point
(along with the existing INSTALL) and there'll be more docs
coming at some point...


Writing documentation tends to make my attention span drift all
over the place; so maybe parts don't make sense or were glossed
over, but I'll be glad to help clarify anything.  (Responding
to emails is generally easier for me since I can answer things
specifically, tough to do for generic docs)


I'll try to get a tarball release out soonish,
but my schedule is unpredictable.


(*) None of the code has had any security audit, yet;
    and there's no warranty of course.

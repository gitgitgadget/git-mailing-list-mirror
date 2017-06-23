Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395A620282
	for <e@80x24.org>; Fri, 23 Jun 2017 16:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbdFWQxv (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 12:53:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:50662 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753926AbdFWQxu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 12:53:50 -0400
Received: (qmail 1508 invoked by uid 109); 23 Jun 2017 16:53:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 16:53:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16046 invoked by uid 111); 23 Jun 2017 16:53:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 12:53:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 12:53:48 -0400
Date:   Fri, 23 Jun 2017 12:53:48 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Simon Ruderich <simon@ruderich.org>,
        Patrick Lehmann <Patrick.Lehmann@plc2.de>,
        Jessie Hernandez <git@jessiehernandez.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: your mail
Message-ID: <20170623165347.s6byszwdps34ntzv@sigill.intra.peff.net>
References: <7c277ac1cfb40b9b362d468a94dfb4fe.squirrel@mail.jessiehernandez.com>
 <20170622124803.45sduodpfbwuuq52@ruderich.org>
 <0092CDD27C5F9D418B0F3E9B5D05BE080102A3D5@SBS2011.opfingen.plc2.de>
 <20170622134708.fcc4zxakga6p255x@ruderich.org>
 <0092CDD27C5F9D418B0F3E9B5D05BE080102A423@SBS2011.opfingen.plc2.de>
 <20170622204628.eintlap4uchlncub@ruderich.org>
 <xmqq8tkjiu3d.fsf@gitster.mtv.corp.google.com>
 <878tkjk7m7.fsf@gmail.com>
 <20170622232156.vptuoafdtglokujw@sigill.intra.peff.net>
 <xmqqshirffay.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqshirffay.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 10:23:17PM -0700, Junio C Hamano wrote:

> Otoh, "community" page does not encourage subscription as a way to
> ensure you'll see follow-up discussion, which may be a good thing to
> add.
> 
> A tangent I just found funny is this paragraph on the "community"
> page:
> 
>     The archive can be found on public-inbox. Click here to
>     subscribe.
> 
> Of course clicking does not take you to a subscription page for
> public-inbox, even though the two sentences appear to be related.
> 
> Perhaps swap the order of the two, like so, with a bit richer
> explanation taken from Ævar's version:
> 
> 	... disable HTML in your outgoing messages.
> 
> 	By subscribing (click here), you can make sure you're not
> 	missing follow-up discussion and also learn from other
> 	development in the community.  The list archive can be found
> 	on public-inbox.

Yeah, I think that's a good suggestion. Do you want to phrase it in the
form of a patch? :)

-Peff

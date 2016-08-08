Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD3C81FD99
	for <e@80x24.org>; Mon,  8 Aug 2016 04:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbcHHEfK (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 00:35:10 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57654 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbcHHEfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 00:35:09 -0400
Received: from mfilter33-d.gandi.net (mfilter33-d.gandi.net [217.70.178.164])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id EEA28FB89F;
	Mon,  8 Aug 2016 06:35:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter33-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter33-d.gandi.net (mfilter33-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id BOWRDcpN_7ox; Mon,  8 Aug 2016 06:35:05 +0200 (CEST)
X-Originating-IP: 98.150.198.107
Received: from x (cpe-98-150-198-107.hawaii.res.rr.com [98.150.198.107])
	(Authenticated sender: josh@joshtriplett.org)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id F3C1DFB882;
	Mon,  8 Aug 2016 06:35:03 +0200 (CEST)
Date:	Sun, 7 Aug 2016 18:34:59 -1000
From:	Josh Triplett <josh@joshtriplett.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] format-patch: Add a config option format.from to
 set the default for --from
Message-ID: <20160808043458.jrgkoy2i65hxsaeo@x>
References: <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>
 <20160730191111.cd6ay3l4hweyjf7f@x>
 <20160801173847.qph2tora75h6ebsk@sigill.intra.peff.net>
 <20160807225701.ucv2xunq5vs4uedk@x>
 <xmqqtwewggwi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtwewggwi.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Aug 07, 2016 at 06:59:09PM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> 
> > I'd actually seriously considered this exact approach, which I preferred
> > as well, but I'd discarded it because I figured it'd get rejected.
> > Given your suggestion, and Junio's comment, I'll go with this version.
> 
> Sorry, but your response is soo delayed that I am not sure what you
> are agreeing with

I'm on vacation right now.  I was agreeing with your comment that you
didn't care for the change in v2 to use an enum.

> and also am not sure if you are planning to reroll
> what has already been happily accepted to 'next', which is not quite
> welcome.

I didn't realize you had already taken the patch series into next; I'd
assumed from the various comments that you expected me to reroll it
before you'd take it.

Would you like me to write something up for the release notes regarding
plans to change the default?

- Josh Triplett

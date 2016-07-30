Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24BE11F855
	for <e@80x24.org>; Sat, 30 Jul 2016 05:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbcG3F51 (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 01:57:27 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:44326 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbcG3F50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 01:57:26 -0400
Received: from mfilter49-d.gandi.net (mfilter49-d.gandi.net [217.70.178.180])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 5E080A80C6;
	Sat, 30 Jul 2016 07:57:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter49-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter49-d.gandi.net (mfilter49-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id V6QhGE2CEz6F; Sat, 30 Jul 2016 07:57:20 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 6F749A80BF;
	Sat, 30 Jul 2016 07:57:19 +0200 (CEST)
Date:	Fri, 29 Jul 2016 22:57:17 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC] git-format-patch: default to --from to avoid spoofed mails?
Message-ID: <20160730055717.i7rtgswbi6q2cdsg@x>
References: <20160728211149.GA371@x>
 <xmqq8twlqwan.fsf@gitster.mtv.corp.google.com>
 <20160728215603.GA22865@sigill.intra.peff.net>
 <xmqq4m79qujr.fsf@gitster.mtv.corp.google.com>
 <20160729001618.GA9646@sigill.intra.peff.net>
 <20160729020801.GA14892@x>
 <20160729225800.GA23268@sigill.intra.peff.net>
 <20160730045055.e3t6tpgi6zch4epo@x>
 <20160730054742.iwmr4pavdy5z73rw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160730054742.iwmr4pavdy5z73rw@sigill.intra.peff.net>
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 01:47:42AM -0400, Jeff King wrote:
> On Fri, Jul 29, 2016 at 09:50:55PM -0700, Josh Triplett wrote:
> 
> > I would propose the following then:
> > 
> > - I'll write a patch adding a config option format.from, along with
> >   documentation, without changing the default.
> > - The release notes for the version of git introducing that config
> >   option should mention, prominently, the plan to change the default in
> >   a future version of git.
> > - A subsequent release can change the default.  No major rush to do
> >   this.
> > 
> > Does that sound reasonable?
> 
> That sounds fine to me.
> 
> I do have to admit that after reading through the "format.*" section of
> git-config(1), there is quite a bit that is configurable in it. So
> perhaps we do not need to be as careful about behavior changes as I
> thought.
> 
> So if you wanted to squish steps 2 and 3 together, that would also be OK
> by me.

I'll send two separate patches, and I'll leave it up to Junio whether to
apply the second one right away or wait a release.

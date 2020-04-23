Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E06C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 05:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE41206B9
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 05:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDWFln (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 01:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbgDWFln (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 23 Apr 2020 01:41:43 -0400
Received: from vps892.directvps.nl (unknown [IPv6:2a02:2308::216:3eff:fede:83d0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAA6C03C1AB
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 22:41:42 -0700 (PDT)
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 98DC44400E1; Thu, 23 Apr 2020 07:41:39 +0200 (CEST)
Date:   Thu, 23 Apr 2020 07:41:39 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Dennis Clarke <dclarke@blastwave.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>, git@vger.kernel.org
Subject: Re: minor patch required to compile git 2.26.1 on Oracle Solaris 10
 with Oracle Studio
Message-ID: <20200423054139.GA1838755@alpha>
Mail-Followup-To: Kevin Daudt <me@ikke.info>,
        Dennis Clarke <dclarke@blastwave.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Jeffrey Walton <noloader@gmail.com>, git@vger.kernel.org
References: <6bf94982-71c4-78e9-0f4d-7fa4e485c417@blastwave.org>
 <xmqqzhb8rqa6.fsf@gitster.c.googlers.com>
 <20200422080950.GA464427@coredump.intra.peff.net>
 <20200422081156.GB464427@coredump.intra.peff.net>
 <f0beedfb-b50b-51b9-d996-155e0178a90d@blastwave.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0beedfb-b50b-51b9-d996-155e0178a90d@blastwave.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 08:09:46PM -0400, Dennis Clarke wrote:
> On 2020-04-22 04:11, Jeff King wrote:
> > On Wed, Apr 22, 2020 at 04:09:50AM -0400, Jeff King wrote:
> > 
> > > Which implies that NO_INET_NTOP should not be set in the first place.
> > > I think this is the same issue discussed in:
> > > 
> > >    https://lore.kernel.org/git/CAH8yC8m3JFvEcfFF3z1rrRnEPK-adHGObmkOhNZiph7QJKUWqA@mail.gmail.com/
> > > 
> > > with a patch (which needs at least a signoff added) in:
> > > 
> > >    https://lore.kernel.org/git/CAH8yC8kaWXbN+RYMJnM9em7KKW54+N07JtyS1MZk0qppD=m2BA@mail.gmail.com/
> > > 
> > > Dennis, does building with:
> > > 
> > >    make NO_INET_NTOP= NO_INET_PTON=
> > > 
> 
> I will give that a try today and see what happens. There seems to be a
> 2.26.2 release from yesterday and may as well get that going. What was the
> changelog reason for the bump from 2.26.1 to 2.26.2 ?
> 
> Dennis
> 
> 

Hello Dennis,

There was another CVE disclosed:

https://lore.kernel.org/git/xmqq4kterq5s.fsf@gitster.c.googlers.com/

Kind regards, Kevin

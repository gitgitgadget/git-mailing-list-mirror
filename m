Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E2811F403
	for <e@80x24.org>; Sun,  3 Jun 2018 14:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeFCOSR (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 10:18:17 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41054 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751228AbeFCOSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 10:18:16 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w53EIEGu004161
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 3 Jun 2018 16:18:14 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w53EIEBM004160;
        Sun, 3 Jun 2018 16:18:14 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w53EI2qp009306;
        Sun, 3 Jun 2018 16:18:02 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w53EI1tJ009305;
        Sun, 3 Jun 2018 16:18:01 +0200
Date:   Sun, 3 Jun 2018 16:18:01 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
 <87y3hlecod.fsf@evledraar.gmail.com>
 <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
 <87vab087y2.fsf@evledraar.gmail.com>
 <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
 <87tvqk81qp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvqk81qp.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 02:59:26PM +0200, Ævar Arnfjörð Bjarmason wrote:
> I'm not trying to be selfish, I'm just trying to counter your literal
> reading of the law with a comment of "it'll depend".
> 
> Just like there's a law against public urination in many places, but
> this is applied very differently to someone taking a piss in front of
> parliament v.s. someone taking a piss in the forest on a hike, even
> though the law itself usually makes no distinction about the two.

We have huge companies using git now. This is not the tool used by a 
few kernel hackers anymore.

> In this example once you'd delete the UUID ref you don't have the UUID
> -> author mapping anymore (and b.t.w. that could be a many to one
> mapping).

It is not relevant whether you have that mapping or not, it is enough 
that with additional information you could obtain it. For example, say, 
you have 5000 commits with the same UUID. Now your delete the mapping. 
But your friend still has it on his local copy. Now your friendly 
merely needs to tell you who is behind that UUID and instantly you can 
associate all 5000 commits with that person again.

The GDPR is very explict about this, see recital 26. It says that 
pseudonymization is not enough, you need anonymization if you want to 
be free from regulation.

In addition, and in contrast to my proposal, your solution doesn't 
allow verification of the author field.

> I think again that this is taking too much of a literalist view. The
> intent of that policy is to ensure that companies like Google can't just
> close down their EU offices weasel out of compliance be saying "we're
> just doing business from the US, it doesn't apply to us".
> 
> It will not be used against anyone who's taking every reasonable
> precaution from doing business with EU customers.

I think you are underestimating the political intention behind the 
GDPR. It has kind of an imperialist goal, to set international 
standards, to enforce them against foreign companies and to pressure 
other nations to establish the same standards.

If I would read the GPDR in a literal sense, I would in fact come to 
the same conclusion as you: It's about companies doing substantial 
business in the EU. But the GDPR is carefully constructed in such a way 
that it is hard not to be affected by the GDPR in one way or another, 
and the obvious way to cope with that risk is to more or less obey the 
GDPR rules even if one does not have substantial business interests in 
the EU. 

> What do you imagine that this is going to be like? That some EU citizen
> is going to walk into a small business in South America one day, which
> somehow is violating the GPDR, and when that business owner goes on
> holiday to the EU they're going to get detained? Not even the US policy
> against Cuba is anywhere remotely close to that.

Well not if he's locally interacting with that business, a situation 
which I am sure is not regulated by the GDPR.

However, if a large US website accepts users from the EU and uses the 
data gathered in conflict with the GDPR, perhaps selling it for use in 
political campaigns, and it gets several fines for this by EU 
authorities but ignores them and doesn't pay them, and the CEO one day 
takes a flight to Frankfurt to continue by train to Switzerland to get 
some cash from his bank account, then he will most likely not reach 
Swiss territory.

Best wishes
Peter
-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE

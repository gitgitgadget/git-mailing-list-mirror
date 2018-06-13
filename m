Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D07C41F403
	for <e@80x24.org>; Wed, 13 Jun 2018 14:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935642AbeFMOM2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 10:12:28 -0400
Received: from imap.thunk.org ([74.207.234.97]:36978 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935481AbeFMOM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 10:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wIL4Z+eYj/YbbmYU70ECGhubQdm1NRtEN2biwkyspRI=; b=pGINu5EJ3hIAOLWPdELBdoFn/M
        NIdkeqHeklaA3ILzmgMziLWoKU4OZv1vVOxJrXl/13nkibbfsSeiia8hWvsVDlV725Th3rhVvHw4Y
        uwEf1XsSiGRUetrKPXKJJo5X03SGlObS4aDhiKDdMrWSrCUSyfc87t+e1tpGOEwPcx8Y=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fT6VX-0006Kh-TX; Wed, 13 Jun 2018 14:12:19 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DBF8D7A447A; Wed, 13 Jun 2018 10:12:18 -0400 (EDT)
Date:   Wed, 13 Jun 2018 10:12:18 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     David Lang <david@lang.hm>, Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180613141218.GA28384@thunk.org>
References: <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
 <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071651310.27871@nftneq.ynat.uz>
 <20180608061656.GA9383@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1806080040060.4962@qynat-yncgbc>
 <20180608115842.GA12013@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806081148030.14286@nftneq.ynat.uz>
 <alpine.DEB.2.02.1806121152530.10486@nftneq.ynat.uz>
 <20180612191219.GA17935@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612191219.GA17935@helen.PLASMA.Xg8.DE>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 09:12:19PM +0200, Peter Backes wrote:
> This incorrect claim is completely inverting the logic of Art. 17.
> 
> The logic is clarly that if ANY of lit (a) to (f) is satisfied, the 
> data must be deleted.
> 
> It is not necessary for ALL of them to be satisfied.
> 
> In particular, if the data is no longer necessary for the purpose for 
> which it was collected, then THAT ALONE is grounds for erasure ((1) 
> lit. a). It does not matter at all whether processing was consent-based 
> or whether such consent was withdrawn.

Sure, but given that you are the one trying to claim that people need
to do all sorts of extra development work (I don't see any patches
from you) and suffer performance degredation, the burden of proof is
on _you_ to show that this is a problem that github, et. al., are
likely run into.

In particular, keep in mind that distribution of open source code can
only be done under the terms of an open source license --- and a
license is a contract.  So in particular, your claim that the data is
no longer necessary (point a) is at the very least going to be subject
to dispute and is a legal question.  I can think of any number of ways
that this could considered necessary in order to assure open source
license compliance, the public interest in terms of allowing forking,
etc.

The bottom line is I'm sure the lawyers at github and Microsoft have
very carefully done their due diligence, and if they are concerned,
I'm sure we'll see patches from them, since after all, they would not
be interested in seeing the imperial European bureaucrats trying to
assess 4% of Microsoft's world-wide revenues --- that's $3.6 billion
dollars, by the way.  I'm sure if they think it's a concern, their
programmers will be right on it.

					- Ted

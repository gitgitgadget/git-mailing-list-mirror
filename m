Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E0F21F403
	for <e@80x24.org>; Sun, 10 Jun 2018 01:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeFJBln (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 21:41:43 -0400
Received: from imap.thunk.org ([74.207.234.97]:53374 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753548AbeFJBlm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 21:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FJYtwOWfh1WtoVWTLM1QcoZWQsucFUNCIqu+DcHvK7M=; b=Ti3TVLGWsFX8Dyomff80kGvOYW
        QAlBA6/vOV/qjNZX7xsEf+6RnabT0DpxI/Zs2RnMh+cjYqlur9frV8p4qWBNlmKG4ezjuQOfxes73
        2XrV7UfeiIbjvdAqMP93PnLQe82Oz/wfp/7QHUKzT4PO5Tsb6C5VxycX4kUn7Cjo5wYc=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fRpMM-0004R5-AP; Sun, 10 Jun 2018 01:41:34 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9734A7A4474; Sat,  9 Jun 2018 21:41:33 -0400 (EDT)
Date:   Sat, 9 Jun 2018 21:41:33 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>, David Lang <david@lang.hm>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180610014133.GB5020@thunk.org>
References: <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
 <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
 <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
 <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
 <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
 <20180608025313.GA12749@thunk.org>
 <059CBAEFB9D945EE9D54BF515E963798@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <059CBAEFB9D945EE9D54BF515E963798@PhilipOakley>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 09, 2018 at 11:50:32PM +0100, Philip Oakley wrote:
> I just want to remind folks that Gmane disappeared as a regular list because
> of a legal challenge, the SCO v IBM Unix court case keeps rumbling on, so
> clarifying the legal case for:
> a) holding the 'personal git meta data', and
> b) disclosing (publishing) 'personal git meta data'
> under various copyright and other legal issue scenarios relative to GDPR is
> worth clarifying.

And I suspect the best way of clarifying things is for laywers at the
major corporations (e.g., Red Hat, Microsoft now that it owns github,
Google since it publishes Android sources at sources.android.com,
Canonical, etc.) to figure it out.

Those situations may very well differ depend on whether they have a
CLA or Copyright Assignment Agreement which they require of
contributors.  But fortunately, those organizations are also best set
up to send patches.   :-)

If those organizations are not choosing to send patches, I suspect
that might be a strong hint as to what those lawyers have concluded.

						- Ted

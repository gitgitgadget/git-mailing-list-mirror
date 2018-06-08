Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B849E1F403
	for <e@80x24.org>; Fri,  8 Jun 2018 02:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752642AbeFHCxV (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 22:53:21 -0400
Received: from imap.thunk.org ([74.207.234.97]:48760 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752415AbeFHCxU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 22:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LcMH4B+UpCUHGVkPWsTShgzvE5eoWQtn+CnjgDA53tc=; b=JsEz309K5eb8P9FjdKBTt/hvSG
        rtLAY8GM1tLHtLyA7cj0ZJW1VR8nZiTPdqjFidtsmPHHA2QkVYl4+MLP6eggttjl+eUH1WnYBO8gw
        R5QaXpOWkV4ixiZzf89UQDq3gj6wUXqgfcRCyLKDiahAUCiE635sWfEaPCBtBlxVNsOQ=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fR7Wb-0000ge-WA; Fri, 08 Jun 2018 02:53:14 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3C3497A417D; Thu,  7 Jun 2018 22:53:13 -0400 (EDT)
Date:   Thu, 7 Jun 2018 22:53:13 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
Cc:     David Lang <david@lang.hm>, Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180608025313.GA12749@thunk.org>
References: <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
 <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
 <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
 <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
 <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 08, 2018 at 01:21:29AM +0200, Peter Backes wrote:
> On Thu, Jun 07, 2018 at 03:38:49PM -0700, David Lang wrote:
> > > Again: The GDPR certainly allows you to keep a proof of copyright
> > > privately if you have it. However, it does not allow you to keep
> > > publishing it if someone exercises his right to be forgotten.
> > someone is granting the world the right to use the code and you are claiming
> > that the evidence that they have granted this right is illegal to have?
> 
> Hell no! Please read what I wrote:
> 
> - "allows you to keep a proof ... privately"
> - "However, it does not allow you to keep publishing it"

The problem is you've left undefined who is "you"?  With an open
source project, anyone who has contributed to open source project has
a copyright interest.  That hobbyist in German who submitted a patch?
They have a copyright interest.  That US Company based in Redmond,
Washington?  They own a copyright interest.  Huawei in China?  They
have a copyright interest.

So there is no "privately".  And "you" numbers in the thousands and
thousands of copyright holders of portions of the open source code.

And of course, that's the other thing you seem to fundamentally not
understand about how git works.  Every developer in the world working
on that open source project has their own copy.  There is
fundamentally no way that you can expunge that information from every
single git repository in the world.  You can remote a git note from a
single repository.  But that doesn't affect my copy of the repository
on my laptop.  And if I push that repository to my server, it git note
will be out there for the whole world to see.

So someone could *try* sending a public request to the entire world,
saying, "I am a European and I demand that you disassociate commit
DEADBEF12345 from my name".  They could try serving legal papers on
everyone.  But at this point, it's going to trigger something called
the "Streisand Effect".  If you haven't heard of it, I suggest you
look it up:

http://mentalfloss.com/article/67299/how-barbra-streisand-inspired-streisand-effect

Regards,

						- Ted

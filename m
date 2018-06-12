Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F29891F403
	for <e@80x24.org>; Tue, 12 Jun 2018 19:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933254AbeFLTMq (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 15:12:46 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41514 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932731AbeFLTMp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 15:12:45 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w5CJCVVf007441
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 12 Jun 2018 21:12:31 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w5CJCVY7007439;
        Tue, 12 Jun 2018 21:12:31 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w5CJCJ1Q018095;
        Tue, 12 Jun 2018 21:12:19 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w5CJCJYv018092;
        Tue, 12 Jun 2018 21:12:19 +0200
Date:   Tue, 12 Jun 2018 21:12:19 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     David Lang <david@lang.hm>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180612191219.GA17935@helen.PLASMA.Xg8.DE>
References: <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
 <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
 <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071651310.27871@nftneq.ynat.uz>
 <20180608061656.GA9383@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1806080040060.4962@qynat-yncgbc>
 <20180608115842.GA12013@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806081148030.14286@nftneq.ynat.uz>
 <alpine.DEB.2.02.1806121152530.10486@nftneq.ynat.uz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1806121152530.10486@nftneq.ynat.uz>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 11:56:13AM -0700, David Lang wrote:
> [quoting github]
> 
> It's important to remember that the Right to Erasure only applies to
> personal data, not all data. It only applies to data a controller (GitHub,
> for example) is processing _solely_ on the basis of consent.

This is very obviously wrong. See Art. 17 GDPR. Consent is only one of 
the explicitly mentioned grounds for deletion (it is (1) lit b, but 
there's also a and c to f).

> And it only
> applies when there's not another legal reason to keep the data -- for
> instance, if the data is no longer necessary for the purpose for which it
> was collected.

This incorrect claim is completely inverting the logic of Art. 17.

The logic is clarly that if ANY of lit (a) to (f) is satisfied, the 
data must be deleted.

It is not necessary for ALL of them to be satisfied.

In particular, if the data is no longer necessary for the purpose for 
which it was collected, then THAT ALONE is grounds for erasure ((1) 
lit. a). It does not matter at all whether processing was consent-based 
or whether such consent was withdrawn.

> We do not process Git commit history on the basis of consent. We have a
> legitimate business purpose for collecting Git commit history: to maintain
> the integrity of the Git commit record. It remains necessary for its purpose
> for as long as a commit needs to be attributable to its committer.

Right, but this merely justifies storing the data, not publishing it, 
or keeping it published, as I already explained at length.

> At GitHub, as part of our Privacy By Design work, we offer ways for users to
> set their own Git commit email data, so if an individual wants to remain
> anonymous or pseudonymous, he or she can do so.

Not only is this contradicting fundamentally what they just said in the 
previous sentence, it is not a justification for ignoring the right to 
erasure either. It is exactly the purpose of the right to erasure to 
get the data erased *after* the fact.

> We also explain, in our
> [Privacy
> Statement](https://help.github.com/articles/github-privacy-statement), that
> we are not able to delete personal data from the Git commit history once it
> has been recorded.

Privacy Statements are not a justification under GDPR for processing 
data or ignoring the right to erasure.

And oh yes they are able. Rewriting history is a possibility, though an 
inconvenient one.

I have pointed towards more convenient solutions.

> I'll point out that not only did the Github lawyers need to sign off on this
> stance, but the Microsoft lawyers would have looked at it as well as part of
> their purchase of Github.

So? If a thousand lawyers claim 1+1=3, it becomes a mathematical truth?

Best wishes
Peter


-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E8511F403
	for <e@80x24.org>; Wed, 13 Jun 2018 14:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935851AbeFMOsp (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 10:48:45 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41552 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935345AbeFMOso (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 10:48:44 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w5DEmWA3010616
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Jun 2018 16:48:32 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w5DEmWvs010615;
        Wed, 13 Jun 2018 16:48:32 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w5DEmIK6029029;
        Wed, 13 Jun 2018 16:48:18 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w5DEmIOs029003;
        Wed, 13 Jun 2018 16:48:18 +0200
Date:   Wed, 13 Jun 2018 16:48:18 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     David Lang <david@lang.hm>, Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180613144818.GA28829@helen.PLASMA.Xg8.DE>
References: <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
 <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071651310.27871@nftneq.ynat.uz>
 <20180608061656.GA9383@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1806080040060.4962@qynat-yncgbc>
 <20180608115842.GA12013@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806081148030.14286@nftneq.ynat.uz>
 <alpine.DEB.2.02.1806121152530.10486@nftneq.ynat.uz>
 <20180612191219.GA17935@helen.PLASMA.Xg8.DE>
 <20180613141218.GA28384@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613141218.GA28384@thunk.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 10:12:18AM -0400, Theodore Y. Ts'o wrote:
> Sure, but given that you are the one trying to claim that people need
> to do all sorts of extra development work (I don't see any patches

No. I am not. I said it is desirable to have a convenient solution for 
the problem. I did not demand development work or patches from anyone, 
just kindly asked for a comment on a possible solution.

> from you) and suffer performance degredation, the burden of proof is
> on _you_ to show that this is a problem that github, et. al., are
> likely run into.

*You* claimed there was performance degradation, not me.

That github et. al. will sooner or later receive such erasure requests 
is a practical certainty. Google receives them every day in large 
quantities. Just think about someone who committed smelly code on 
github and now wants to get a new job and wants to get rid of all 
associations with those smells.

> In particular, keep in mind that distribution of open source code can
> only be done under the terms of an open source license --- and a
> license is a contract.

Not that it would be relevant here, but, depending on jurisdication, it 
is highly controversial whether open source licenses really constitute 
contracts (or, for example, promissory estoppel).

For the right to erasure, it does not matter whether a contract exists 
or not.

The GDPR explicitly prohibits any use of contracts in a way that 
undermines the GDPR. Making it an irrevocable contractual obligation to 
publish the data is not going to be an excuse thus. And Free Software 
licenses have nothing whatsoever to do with repository metadata. Such 
software has existed long before version control became so popular.

> So in particular, your claim that the data is
> no longer necessary (point a) is at the very least going to be subject

No, it is github's claim that it must no longer be necessary for being 
erased, not mine!

I clearly stated that if ANY point (not: ALL points) is given, the data 
must be deleted.

Thus, point b, c, d or any other are just as good as point a.

> to dispute and is a legal question.  I can think of any number of ways
> that this could considered necessary in order to assure open source
> license compliance, the public interest in terms of allowing forking,
> etc.

To claim that the data is necessary (which is, as I said, irrelevant) 
and then say it's not because you can as well use a dummy user string, 
is self-contradicting.

> The bottom line is I'm sure the lawyers at github and Microsoft have
> very carefully done their due diligence, and if they are concerned,
> I'm sure we'll see patches from them, since after all, they would not

Why should they be concerned? They can rewrite history if necessary. 
They have a solution, though an inconvenient one. As far as the lawyers 
are concerned, that solution is pefectly fine.

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE

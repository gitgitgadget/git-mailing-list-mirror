Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 671591F403
	for <e@80x24.org>; Tue, 12 Jun 2018 18:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754047AbeFLS4Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 14:56:25 -0400
Received: from lang.hm ([66.167.227.134]:44177 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753979AbeFLS4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 14:56:24 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id w5CIuEVL015936;
        Tue, 12 Jun 2018 11:56:14 -0700
Date:   Tue, 12 Jun 2018 11:56:13 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@asgard.lang.hm
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
cc:     Philip Oakley <philipoakley@iee.org>,
        =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
In-Reply-To: <alpine.DEB.2.02.1806081148030.14286@nftneq.ynat.uz>
Message-ID: <alpine.DEB.2.02.1806121152530.10486@nftneq.ynat.uz>
References: <20180603174617.GA10900@helen.PLASMA.Xg8.DE> <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz> <20180607063225.GA28343@helen.PLASMA.Xg8.DE> <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley> <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz> <20180607232128.GA5879@helen.PLASMA.Xg8.DE> <alpine.DEB.2.02.1806071651310.27871@nftneq.ynat.uz> <20180608061656.GA9383@helen.PLASMA.Xg8.DE> <nycvar.QRO.7.76.6.1806080040060.4962@qynat-yncgbc>
 <20180608115842.GA12013@helen.PLASMA.Xg8.DE> <alpine.DEB.2.02.1806081148030.14286@nftneq.ynat.uz>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-435430296-1528829774=:10486"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-435430296-1528829774=:10486
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

Adding one more datapoint here, I reached out to Github to find out their 
stance.

Here is what I got back

Quote:

Thanks for reaching out to us about this.

It's important to remember that the Right to Erasure only applies to personal 
data, not all data. It only applies to data a controller (GitHub, for example) 
is processing _solely_ on the basis of consent. And it only applies when there's 
not another legal reason to keep the data — for instance, if the data is no 
longer necessary for the purpose for which it was collected.

We do not process Git commit history on the basis of consent. We have a 
legitimate business purpose for collecting Git commit history: to maintain the 
integrity of the Git commit record. It remains necessary for its purpose for as 
long as a commit needs to be attributable to its committer. At GitHub, as part 
of our Privacy By Design work, we offer ways for users to set their own Git 
commit email data, so if an individual wants to remain anonymous or 
pseudonymous, he or she can do so. We also explain, in our [Privacy 
Statement](https://help.github.com/articles/github-privacy-statement), that we 
are not able to delete personal data from the Git commit history once it has 
been recorded.

End Quote

I'll point out that not only did the Github lawyers need to sign off on this 
stance, but the Microsoft lawyers would have looked at it as well as part of 
their purchase of Github.

David Lang

--680960-435430296-1528829774=:10486--

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38C5B1F403
	for <e@80x24.org>; Thu,  7 Jun 2018 06:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752568AbeFGGcy (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 02:32:54 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41234 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeFGGcx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 02:32:53 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w576WfgY018462
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 08:32:41 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w576Wef5018461;
        Thu, 7 Jun 2018 08:32:40 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w576WQ9o028675;
        Thu, 7 Jun 2018 08:32:26 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w576WPpp028673;
        Thu, 7 Jun 2018 08:32:25 +0200
Date:   Thu, 7 Jun 2018 08:32:25 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     David Lang <david@lang.hm>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE>
 <87y3hlecod.fsf@evledraar.gmail.com>
 <20180603092736.GA5510@helen.PLASMA.Xg8.DE>
 <87vab087y2.fsf@evledraar.gmail.com>
 <20180603112557.GA6564@helen.PLASMA.Xg8.DE>
 <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE>
 <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley>
 <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

thanks for your input on the issue.

> LEGAL GDPR NOTICE:
> According to the European data protection laws (GDPR), we would like to make you
> aware that contributing to rsyslog via git will permanently store the
> name and email address you provide as well as the actual commit and the
> time and date you made it inside git's version history. This is inevitable,
> because it is a main feature git.

As we can, see, rsyslog tries to solve the issue by the already 
discussed legal "technology" of disclaimers (which is certainly not 
accepted as state of the art technology by the GDPR). In essence, they 
are giving excuses for why they are not honoring the right to be 
forgotten.

Disclaimers do not work. They have no legal effect, they are placebos.

The GDPR does not accept such excuses. If it would, companies could 
arbitrarily design their data storage such as to make it "the main 
feature" to not honor the right to be forgotten and/or other GDPR 
rights. It is obvious that this cannot work, as it would completely 
undermine those rights.

The GDPR honors technology as a means to protect the individual's 
rights, not as a means to subvert them.

> If you are concerned about your
> privacy, we strongly recommend to use
> 
> --author "anonymous <gdpr@example.com>"
> 
> together with your commit.

This can only be a solution if the project rejects any commits which 
are not anonymous.

> However, we have valid reasons why we cannot remove that information
> later on. The reasons are:
> 
> * this would break git history and make future merges unworkable

This is not a valid excuse (see above). The technology has to be 
designed or applied in such a way that the individuals rights are 
honored, not the other way around.

In absence of other means, the project has to rewrite history if it 
gets a valid request by someone exercising his right to be forgotten, 
even if that causes a lot of hazzle for everyone.

> * the rsyslog projects has legitimate interest to keep a permanent record of the
>   contributor identity, once given, for
>   - copyright verification
>   - being able to provide proof should a malicious commit be made

True, but that doesn't justify publishing that information and keeping 
it published even when someone exercises his right to be forgotten.

In that case, "legitimate interest" is not enough. There need to be 
"overriding legitimate grounds". I don't see them here.

> Please also note that your commit is public and as such will potentially be
> processed by many third-parties. Git's distributed nature makes it impossible
> to track where exactly your commit, and thus your personal data, will be stored
> and be processed. If you would not like to accept this risk, please do either
> commit anonymously or refrain from contributing to the rsyslog project.

This is one of those statements that ultimately say "we do not honor 
the GDPR; either accept that or don't submit". That's the old, arguably 
ignorant mentality, and won't stand.

The project has to have a legal basis for publishing the personal 
metadata contained in the repository. In doubt, it needs to be consent 
based, as that is practically the only basis that allows putting the 
data on the internet for everyone to download. And consent can be 
withdrawn at any time.

The GDPR's transitional period started over two years ago. There was 
enough time to get everything GDPR compliant.

It might be possible to implement my solution without changing git, 
btw. Simply use the anonymous hash as author name, and store the random 
number and the author as a git-notes. git-notes can be rewritten or 
deleted at any time without changing the commit ID. I am currently 
looking into this solution. One just needs to add something that can 
verify and resolve those anonymous hashes.

Best wishes
Peter


-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE

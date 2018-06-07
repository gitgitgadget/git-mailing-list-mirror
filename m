Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402041F403
	for <e@80x24.org>; Thu,  7 Jun 2018 01:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752322AbeFGBrS (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 21:47:18 -0400
Received: from lang.hm ([66.167.227.134]:41170 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752423AbeFGBrR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 21:47:17 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jun 2018 21:47:17 EDT
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id w571ctXA014717;
        Wed, 6 Jun 2018 18:38:55 -0700
Date:   Wed, 6 Jun 2018 18:38:55 -0700 (PDT)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@asgard.lang.hm
To:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>
cc:     Philip Oakley <philipoakley@iee.org>,
        =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
In-Reply-To: <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
Message-ID: <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
References: <20180417191549.GA1199@helen.PLASMA.Xg8.DE> <87y3hlecod.fsf@evledraar.gmail.com> <20180603092736.GA5510@helen.PLASMA.Xg8.DE> <87vab087y2.fsf@evledraar.gmail.com> <20180603112557.GA6564@helen.PLASMA.Xg8.DE> <87tvqk81qp.fsf@evledraar.gmail.com>
 <20180603141801.GA8898@helen.PLASMA.Xg8.DE> <6BE308009FFA4CCDB5B3B47C2AC53E20@PhilipOakley> <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm going to take the risk of inserting actual real-world data into the mix 
rather than just speculation :-)

Here is an example of that the Rsyslog project is doing (main developers based 
in Germany). I'll say as someone who's day job has been very involved with GDPR 
stuff recently, this looks like a very reasonable statement to me. But I am not 
a lawyer. I will also say that I think it would be very reasonable for projects 
to not accept code from someone who doesn't give them any way to contact them 
later in case there is a question about authorship or licensing.

David Lang


https://github.com/rsyslog/rsyslog/pull/2746/files

LEGAL GDPR NOTICE:
According to the European data protection laws (GDPR), we would like to make you
aware that contributing to rsyslog via git will permanently store the
name and email address you provide as well as the actual commit and the
time and date you made it inside git's version history. This is inevitable,
because it is a main feature git. If you are concerned about your
privacy, we strongly recommend to use

--author "anonymous <gdpr@example.com>"

together with your commit. Also please do NOT sign your commit in this case,
as that potentially could lead back to you. Please note that if you use your
real identity, the GDPR grants you the right to have this information removed
later. However, we have valid reasons why we cannot remove that information
later on. The reasons are:

* this would break git history and make future merges unworkable
* the rsyslog projects has legitimate interest to keep a permanent record of the
   contributor identity, once given, for
   - copyright verification
   - being able to provide proof should a malicious commit be made

Please also note that your commit is public and as such will potentially be
processed by many third-parties. Git's distributed nature makes it impossible
to track where exactly your commit, and thus your personal data, will be stored
and be processed. If you would not like to accept this risk, please do either
commit anonymously or refrain from contributing to the rsyslog project.

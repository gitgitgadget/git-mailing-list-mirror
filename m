Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE32C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 08:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E247A2074D
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 08:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgFPIuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:50:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:33858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgFPIuI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 04:50:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6A5B2AF4D;
        Tue, 16 Jun 2020 08:50:10 +0000 (UTC)
Date:   Tue, 16 Jun 2020 10:50:04 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Simon Pieters <simon@bocoup.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, don@goodman-wilson.com
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616085004.GB21462@kitsune.suse.cz>
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
 <20200505231641.GH6530@camp.crustytoothpaste.net>
 <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOAHyQx=+fM1FpAv+g3M+j7j4MgLJA03=MGFmXLvZcfJKAEpGg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Tue, Jun 09, 2020 at 05:16:57PM +0200, Simon Pieters wrote:
> Thank you for your encouraging response, Brian, and the research of
> what the change entails for git.
> 
> I've added Don to the cc, who started to work on implementing this change:
> 
> https://twitter.com/DEGoodmanWilson/status/1269931743320182784
> https://github.com/git-for-windows/git/issues/2674
> 
> Although I think it's reasonable to move away from 'master' regardless

I think it's not. The word 'master' on its own without pairing it with
'slave' does not automatically imply slave master.

As has been pointed out it may mean central person to an organization, a
skilled person (as in a person who has mastered a skill or teching) and
most applicable to VCS something alike master document, master copy,
master mix, etc.

Implying the worst possible meaning points to bias and prejudice.

Fighting bias and prejudice (ie racism) with another bias and prejudice
might seem to provide relief short time.

However, so long as bias and prejudice remains no progress is made.

If we embark on the misson to eradicate all and any words that can be
undurstood as offensive in any context from all general language
regardless of context we will soon have no language left.

People keep repeating that words have weight. That's certainly true.
However, there is the other side of the argument. We are not completely
powerless to the weight the words carry for each of us, personally.

Great minds have came up with the option to reclaim words that we feel
are offensive in our personal vocabulary by examining where the offense
comes from and if there is positive meaning we can attach to the word in
question.

The effort should be spent on both sides. Otherwise this becames
childish, immature rampage. Some of the changes suggested as part of
this kind of acticism already look that way.

> of its origin, today Tobie Langel pointed me to
> https://mail.gnome.org/archives/desktop-devel-list/2019-May/msg00066.html
> where, one year ago, Bastien Nocera made the case that git's 'master'
> is in fact a reference to master/slave.
As has been pointed out already even in BitKeeper the use of
master/slave it the exception rather than the norm.

It is common terminology used in database replication schemes and
BitKeepr being a sort of database it has been used to describe similar
schemes in the documentation. It has nothing to do with the naming of
the master branch in git.

With databases the suggested replacement is primary/repllica. With git
the replicas are made with the clone command which lends itself to
naming the replicas as well.

That all said there is nothing preventing projects using git today to
use different branch names. Many projects exist that don't have a
'master' branch either for reasons of activism or simply beacuse it is
not fitting to their development workflow, they use localized branch
names, or whatever. Also the master copy meaning is typically not what
non-native English speakers would understand.

What is brewing as response to this request is a feature that makes
creating and using projects without a 'master' branch work more smoothly
for the general user which is a good thing.

Kudos to git maintainers for handling this sanely. In the past not well
thought out responses to requests like this caused a lot of grief and
negativity towards the software in question and this kind of activism in
general.

Thanks

Michal

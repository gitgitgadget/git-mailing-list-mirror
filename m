Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308A81F463
	for <e@80x24.org>; Fri, 20 Sep 2019 17:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393049AbfITRn1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 13:43:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63496 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729414AbfITRn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 13:43:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DCA4B2F300;
        Fri, 20 Sep 2019 13:43:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fCfd00vVptdAyP34V25NKEpYysw=; b=A5PhKG
        LbVQGvb2LM6ImztMd6I90NznwybBpEggFD3s44XGpFtfiSeGzXUVHj0SYUPizIQS
        m+mIqYjdc+sEI9MNYhacXlUQ6WeI3OxgBuyjNxaoVH+HTTzCDTZqbMTK2Q3Kz4FY
        Bb6b7yzDCANZ5bLfUvQGR7zHTjIhVsVevIviI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TZK3v8+3yvHuE7XX/FeapUSqlUCSSo/9
        ra1SLjbV+gcdGd+KYfuooPeH6Q1CqZivzpcc+v3PLK/QD/y92fmxC1CHnakb7jUm
        fe2GP9pdye6vdcaquJqh+89pJ2LQ8eDu4ZUG+CQzepoWW6dbf50lZs3extjrXm3C
        kcMeKn/z8Q0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D37BF2F2FF;
        Fri, 20 Sep 2019 13:43:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 335132F2FD;
        Fri, 20 Sep 2019 13:43:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        garimasigit@gmail.com
Subject: Re: [DISCUSSION] Growing the Git community
References: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com>
Date:   Fri, 20 Sep 2019 10:43:23 -0700
In-Reply-To: <71fba9e7-6314-6ef9-9959-6ae06843d17a@gmail.com> (Derrick
        Stolee's message of "Thu, 19 Sep 2019 12:30:13 -0400")
Message-ID: <xmqqsgoqvp6s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2504A80C-DBCE-11E9-86AC-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I. Goals and Perceived Problems
>
> As a community, our number one goal is for Git to continue to be the best
> distributed version control system. At minimum, it should continue to be
> the most widely-used DVCS. Towards that goal, we need to make sure Git is
> the best solution for every kind of developer in every industry.

I have quite a lot of problem with this attitude to place the world
domination as the ultimate goal, even though it may call for the
need for sub-goals, one of which is this one,

> The
> community cannot do this without including developers of all kinds. This
> means having a diverse community, for all senses of the word: Diverse in
> physical location, gender, professional status, age, and others.

that I can 100% agree with.  Also I agree that the tactical moves
listed like improved onboading and documentation (omitted from this
response) are all good.

> After we put items 1-4 in place, we should reach out to the
> general tech community that we are interested in new
> contributors. It's not enough to open the door, we should
> point people to it.

I am also somewhat negative on this.

I want to see our system to support the use cases of its users well,
which would lead to its users being happy to use the system.

I think that (and in the remainder, I won't write "I think that" for
brevity) it should be the primary goal.  By being a system that is
useful and pleasant to use, we may gain more users, and we may gain
users from many more different fields and industries and make these
new users happy.  But it should merely be a result, consequence of
being a good system for its users, and not a goal of its own, to
acquire new users from new industries.

And by being a project that works on such a good system for its
users, with welcoming atmosphere to those who are prepared to
reciprocate the same respect while interacting with us, the
community may attract more new members, developers, advocates, tech
writers, etc.  It should merely be a result, consequence of being a
good community for its members, and not a goal on its own, to
acquire new community members.

We first should make sure that we serve existing users and existing
community members well.  So well that other people who are not yet
our "existing" users and members would want to become part of us, in
order to join the fun and share the benefit.  If we cannot serve
even the existing members well, we shouldn't be talking about
acquiring new members.

Growth and the world domination may come as a consequence, and I
would not reject it when it happens, but we should not be actively
seeking it.

It follows that "in this quarter, we acquired these high profile
projects as users", "we have this many new contributors this month",
"the acceptance rate of the patches from contributors with less than
3 months experience dipped by 20% this month" etc. are not best
measures of success.  What's preferable would be yardsticks to gauge
the community-member happiness (e.g. "This many percent of total
community member population have been active this month").

Thanks.

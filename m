Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AACB11F404
	for <e@80x24.org>; Tue, 10 Apr 2018 23:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755813AbeDJXB1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 19:01:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:47821 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755551AbeDJWf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 18:35:29 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfXmv-1ehdOX0Rsv-00p3Jv; Wed, 11
 Apr 2018 00:35:24 +0200
Date:   Wed, 11 Apr 2018 00:35:08 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
Subject: Re: git remote rename problem with trailing \\ for remote.url config
 entries (on Windows)
In-Reply-To: <xmqqo9y6dj1s.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1804110020380.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <da730b21-58ae-bfa8-705f-7669c0f56764@syntevo.com> <xmqqo9y6dj1s.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6fE39wjmr9xDkvWH9suUr+MdQPf/RFWRj1SSvA987pNXQfWXxtM
 KpfZruQNe1l8h6LGnz/eSXigwO5q+J8h+aqXXiqN6py9MNhnWTEg2WhDncsFui8nZ8X/2b3
 w30fURdIkdeVbxnLpoN9nIJIJOazMJ+LRAjzVzY8qKIKNk0z/lHFSpXVDMI31AyjFoMwrJQ
 rn5DhEHet+qfu5r6Ihw5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YpvK9k6HX6o=:TE0qmiXNENxi3zStRUy7CZ
 6QQ/H/np/4E4LxnLDK0Lhq6zC/VCx79ncWgGoDDsTeihJEksZ9qpAA/kndhzDyU1oPW1W6KDu
 HtBzRB/zBehBp35b8KGUD7Acmav9NXmpgOtgbW2CRHmgdE0swEiWDBCkpR4MRsYYLP06ZcCVt
 /IjnfXfv9H3AK0PYZ2PyyYuPtX1T7ZPM1RbA2f48ZLLOfOHNJdRhQleYM+HzMDKXfG1lthyC5
 wENqCPjk1KaHaboPS7we4KA1RAQwxNdIVvfNNCnSV2/WWgppuea8H240Ez+aW555SG3C/4IQQ
 jSCJzi42R2Y+mmjWJMOWNd1DRx5k87k7urUTPsrQzzy4VHZrXtyhNcmgesz4kZnnaXexGHmRo
 u1gA1IJmTBJXwfnRhQ/BPygJbR2J/3De59ne6DI7B7fLhrgGrspnq9bQojBdK0NM/ACICjFZ2
 2bialLg3/bNyjrL/7yphxH7ZdykA8MMT/veYJwHYa6kzwXLRQFAXbhmbOig5JKC8bHYkLPra/
 hBxCJW+PmkMHwwOethPqs7K77hUOGRlFf8aFgwjCG3fpkqQzCOAV4//cRje1DWkOkSJkpHM8u
 qv6wsjJQwIOu2//+XI0whjvfZeXn2wlNovS3OQV6eBFg7zvgf5hXxvqu1Zqlfizgn2TkoecHC
 U48zdqxy2e373g4pq9Xm03wCXg9Nlw/JMrNzkvkGUMFHVe+Vf6ofAhPoH7+WOEYUaXXeZPgYN
 Ez54GbdCnc6vrtrvRY7B5ThWgmjtMCcd0jvWijxqr+KYcv8DkZbvgIMOAqmu1TO8QlDiLpv9S
 dQpJ7NIrP2rOrbDEesjpFY8DvqGtDEpnhju6u0xPxRz401gi9A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

[I know, blast from the past...]

On Mon, 13 Feb 2017, Junio C Hamano wrote:

> Marc Strapetz <marc.strapetz@syntevo.com> writes:
> 
> > One of our users has just reported that:
> >
> > $ git remote rename origin origin2
> >
> > will turn following remote entry:
> >
> > [remote "origin"]
> > 	url = c:\\repo\\
> > 	fetch = +refs/heads/*:refs/remotes/origin/*
> >
> > into following entry for which the url is skipped:
> >
> > [remote "origin2"]
> > [remote "origin2"]
> > 	fetch = +refs/heads/*:refs/remotes/origin2/*
> >
> > I understand that this is caused by the trailing \\ and it's easy to
> > fix, but 'git push' and 'git pull' work properly with such URLs and a
> >
> > $ git clone c:\repo\
> >
> > will even result in the problematic remote-entry. So I guess some kind
> > of validation could be helpful.
> 
> If you change the original definition of the "origin" to
> 
>         [remote "origin"]
>                url = "c:\\repo\\"
>                fetch = +refs/heads/*:refs/remotes/origin/*
> 
> or
> 
>         [remote "origin"]
>                url = c:\\repo\\ # ends with bs
>                fetch = +refs/heads/*:refs/remotes/origin/*
> 
> it seems to give me a better result.  I didn't dig to determine
> where things go wrong in "remote rename", and it is possible that
> the problem is isolated to that command, or the same problem exists
> with any value that ends with a backslash.  If the latter, "git clone"
> and anything that writes to configuration such a value needs to be
> taught about this glitch and learn a workaround, I would think.
> 
> Dscho Cc'ed, not for Windows expertise, but as somebody who has done
> a lot in <config.c>.

So... I finally had a look at this, and while I agree that the quoted
version is better, I also agree that the backslash is mistaken for a
continuation character (which is not even allowed in section headers).

A quick test with my `empty-config-section` patch series shows that it
addresses this issue. A quick bisec confirms that the patch with the
online "git_config_set: make use of the config parser's event stream" is
responsible for this fix.

At first, I was puzzled by this, because I expected `git remote rename` to
be backed by the `git_config_copy_or_rename_section_in_file()` function
(which my patch series does not touch).

But then I looked at the code of the `mv()` function in builtin/remote.c
and it uses `git_config_set_multivar()` and `git_config_set()`. And those
functions were indeed touched (and fixed) by above-mentioned commit.

Ciao,
Johannes

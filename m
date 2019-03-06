Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEF3920248
	for <e@80x24.org>; Wed,  6 Mar 2019 10:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfCFKNw (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 05:13:52 -0500
Received: from smtp-3.orcon.net.nz ([60.234.4.44]:38452 "EHLO
        smtp-3.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbfCFKNw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 05:13:52 -0500
Received: from [150.107.172.103] (port=19710 helo=[192.168.20.103])
        by smtp-3.orcon.net.nz with esmtpa (Exim 4.86_2)
        (envelope-from <psainty@orcon.net.nz>)
        id 1h1TYa-0000X6-Fy; Wed, 06 Mar 2019 23:13:48 +1300
Subject: Re: [RFC PATCH 0/4] Add alias option to git branch
To:     Kenneth Cochran <kenneth.cochran101@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Sahil Dua <sahildua2305@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
References: <47CA9077-E8C1-4093-8B36-2D5D3DE2D886@gmail.com>
 <xmqqa7i9v4mv.fsf@gitster-ct.c.googlers.com>
 <CAJ145vW3HPaP2GeSL65q5C1XhYpiE+7=apU1ia=17eNWPfRj_g@mail.gmail.com>
From:   Phil Sainty <psainty@orcon.net.nz>
Message-ID: <b490c79b-37e0-7c6d-8643-3ec2343411ac@orcon.net.nz>
Date:   Wed, 6 Mar 2019 23:13:48 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAJ145vW3HPaP2GeSL65q5C1XhYpiE+7=apU1ia=17eNWPfRj_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I can only concur about the genuine usefulness of symbolic refs as
branch aliases.  I wrote my shell script for this 5 years ago, and
I've made use of the facility almost every working day since.

I jump around branches frequently, and my feature branch names always
start with an issue/bug number followed by a short description -- which
is perfect for listings and seeing at a glance what a branch is about,
and terrible for tab-completion.

Those long branch names are useful and informative for the developers
on the project, but being able to also have a 2-3 letter alias in my
working copy for the lifetime of a branch -- something which is trivial
for me to remember and type -- gives me the best of both worlds, and
I find it to be a tremendous convenience.

It's really not dissimilar to why so many people find shell aliases
to be so handy.

The nice thing is that all the plumbing is already there and working.
I've used it happily for 5 years, and other people use it similarly.
This feature just adds some protective porcelain over it, so that
people can more easily make use of the existing benefits without any
of the potential dangers.


-Phil

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A651C2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 22:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbdBOWTl (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 17:19:41 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:55563 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbdBOWTl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 17:19:41 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id e7vHcevfuHGLwe7vHctEcl; Wed, 15 Feb 2017 22:19:40 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=uPZiAMpXAAAA:8 a=5rxgeBVgAAAA:8 a=cknCivPPAAAA:8
 a=wfXgXtNeUAN-X1wavz0A:9 a=wPNLvfGTeEIA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=xts0dhWdiJbonKbuqhAr:22 a=svzibyHiZmA4t4YY0eFS:22 a=PwKx63F5tFurRwaNxrlG:22
 a=6dIZNVGIe6rtUBgokTih:22
Message-ID: <74FD91647E574D02BFDF4AD5D8EF52C6@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Christian Couder" <christian.couder@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        <git-for-windows@googlegroups.com>, "git" <git@vger.kernel.org>
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox>        <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com>        <alpine.DEB.2.20.1702142150220.3496@virtualbox>        <xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com>        <CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com>        <E2C1B7A8FBF94C8CB1C9C5754D882800@PhilipOakley> <xmqqshng5osz.fsf@gitster.mtv.corp.google.com>
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
Date:   Wed, 15 Feb 2017 22:19:39 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfPZ1n2uRUfvkLvBDOt09l/bNc+xBVNhA+yqX306eupjkO0Tl94HfMnzO8t5+ro9CIBvyFRCDXVQjv08HCxIhPdfWvEG1sJnNOqFzRpIlwryfDop1U9Sv
 lXSXLL6vIjX8LwxA44aq1hLSxZ0bLAJVKVQ04vuwOIkrZbBVXB+VWdeXjD7DFj/kMX6qk2yy1iwMdB+yxSR4vHNCVC3jZwKMypUBygnCzFWTzZkVgHwAqOaC
 UqLE+293dWCGnHTEeqIy6Kzrk/QO7OPr3sJ/1CI7SPRt5hrDFy971QELwNfqaJQ//lUB00kzxa4COhU9GbJvLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> There are also a few ideas at the SO answers:
>> http://stackoverflow.com/a/5652323/717355
>
> I vaguely recall that I saw somebody said the same "mark tips of
> topics as good" on the list and answered with why it does not quite
> work, though.
>
I think you may mean
https://public-inbox.org/git/7v8vyam5la.fsf@alter.siamese.dyndns.org/

I think we are thinking of opposite abstractions.

For regular bisect, the assumption (to a first order) is that there is a
single point of infection of a single persistent bug with a well defined
test, and that the goal is to find the point of first infection, as all
other incidents of the bug are in successor commits, which are all infected.
The fail-fix-break again sequence you mentioned in that thread is to my mind
a red herring as it contradicts the normal bisection assumptions (but see
below).

In the next..pu case the abstraction is in the other direction, we have
potentially multiple points of infection (from feature branches), and a
broad test (the whole test suite). In this case I believe we would like to
investigate initially the --first-parent line with a classic bisect for the
first point of failure (obviously including feature branch merges). This
would identify which feature merge, or regular commit, created the first
breakage.

Once the first point of failure has been identified, for the next..pu case,
each of the post-fail second parents of merge commits _could_ then also be
checked (which is a linear search, not a bisection), to identify any
additional feature branches that need attention. This second stage search
would probably be an option, but if the merging sequence onto pu is
generally from good to bad, then the search is likely to be short. At least
for a CI system this 2nd stage could provide useful feedback to the authors
of their mistakes...

I haven't looked back at the actual patches in that thread, so they may not
have followed my expectation of the --multi-bug (TM) search algorithm.
--

Philip



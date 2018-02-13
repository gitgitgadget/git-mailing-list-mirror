Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 619571F404
	for <e@80x24.org>; Tue, 13 Feb 2018 13:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935175AbeBMNKV (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 08:10:21 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:49166 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935116AbeBMNKU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 08:10:20 -0500
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:38360 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1elaLj-0000YT-7W; Tue, 13 Feb 2018 08:10:19 -0500
Date:   Tue, 13 Feb 2018 08:10:17 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Christian Couder <christian.couder@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: totally confused as to what "git bisect skip" is supposed to
 do
In-Reply-To: <CAP8UFD0hRS_VFpHT-S=Sn7mr4pE+FseUm9nTVEOvLBF-dG9FPA@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1802130810001.17912@localhost.localdomain>
References: <alpine.LFD.2.21.1802091431360.10982@localhost.localdomain> <xmqqo9kyvthx.fsf@gitster-ct.c.googlers.com> <alpine.LFD.2.21.1802120522580.17810@localhost.localdomain> <CAP8UFD03TDGBU3t3+m2OmhyJt6sNcPhMZ2ejzufX3x-_1EEDHA@mail.gmail.com>
 <alpine.LFD.2.21.1802130712260.15482@localhost.localdomain> <CAP8UFD0hRS_VFpHT-S=Sn7mr4pE+FseUm9nTVEOvLBF-dG9FPA@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 13 Feb 2018, Christian Couder wrote:

> On Tue, Feb 13, 2018 at 1:28 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >
> > p.s. i suspect i should RTFS to see exactly how git bisect does its
> > work.
>
> You might want to read
> https://git-scm.com/docs/git-bisect-lk2009.html before reading the
> source code.

  ah, excellent, thanks very much.

rday

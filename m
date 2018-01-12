Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 855C21F406
	for <e@80x24.org>; Fri, 12 Jan 2018 19:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965161AbeALT1k (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 14:27:40 -0500
Received: from smtp3.cs.stanford.edu ([171.64.64.27]:56310 "EHLO
        smtp3.cs.Stanford.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964998AbeALT1j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 14:27:39 -0500
X-Greylist: delayed 1862 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jan 2018 14:27:39 EST
Received: from theory.stanford.edu ([171.64.78.10]:33442)
        by smtp3.cs.Stanford.EDU with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <csilvers@CS.Stanford.EDU>)
        id 1ea4VM-0004Tt-5C; Fri, 12 Jan 2018 10:56:41 -0800
Received: from csilvers by theory.stanford.edu with local (Exim 4.89)
        (envelope-from <csilvers@CS.Stanford.EDU>)
        id 1ea4Ui-0005qJ-3s; Fri, 12 Jan 2018 10:56:00 -0800
From:   csilvers <csilvers@cs.stanford.edu>
To:     Jeff King <peff@peff.net>
CC:     avarab@gmail.com, jrnieder@gmail.com, drizzd@aon.at,
        git@vger.kernel.org, gitster@pobox.com
In-reply-to: <20110706064012.GA927@sigill.intra.peff.net> (message from Jeff
        King on Wed, 6 Jul 2011 02:40:12 -0400)
Subject: Re: [PATCH 0/4] Speed up git tag --contains
References: <1307819051-25748-1-git-send-email-avarab@gmail.com> <20110706064012.GA927@sigill.intra.peff.net>
Message-Id: <E1ea4Ui-0005qJ-3s@theory.stanford.edu>
Date:   Fri, 12 Jan 2018 10:56:00 -0800
X-Scan-Signature: a1ccd6d2fa83ef575f7b7817ead66a1e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This is a resubmission of Jeff King's patch series to speed up git tag
> --contains with some changes. It's been cooking for a while as:

Replying to this 6-year-old thread:

Is there any chance this could be resurrected?  We are using
phabricator, which uses `git branch --contains` as part of its
workflow.  Our repo has ~1000 branches on it, and the contains
operation is eating up all our CPU (and time).  It would be very
helpful to us to make this faster!

(The original thread is at
https://public-inbox.org/git/E1OU82h-0001xY-3b@closure.thunk.org/
)

craig

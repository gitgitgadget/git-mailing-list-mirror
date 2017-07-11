Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E789202DD
	for <e@80x24.org>; Tue, 11 Jul 2017 04:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbdGKEqE (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 00:46:04 -0400
Received: from continuum.iocl.org ([217.140.74.2]:51432 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdGKEqD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 00:46:03 -0400
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id v6B4jsF04509;
        Tue, 11 Jul 2017 06:45:54 +0200
Date:   Tue, 11 Jul 2017 06:45:53 +0200
From:   Andreas Krey <a.krey@gmx.de>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>
Subject: Re: Flurries of 'git reflog expire'
Message-ID: <20170711044553.GG3786@inner.h.apk.li>
References: <20170704075758.GA22249@inner.h.apk.li> <20170705082027.ujddejajjlvto7bp@sigill.intra.peff.net> <20170706133124.GB1216@inner.h.apk.li> <CAGyf7-FnaWM=XNb_Skb1qR4vu_jAw-5swkgWpEDQqwM0NNq3YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyf7-FnaWM=XNb_Skb1qR4vu_jAw-5swkgWpEDQqwM0NNq3YQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 06 Jul 2017 10:01:05 +0000, Bryan Turner wrote:
....
> Do you know what version of Bitbucket Server is in use?

We're on the newest 4.x.

...
> - Run "git config gc.auto 0" in

Going that route.

...
> I also want to add that Bitbucket Server 5.x includes totally
> rewritten GC handling. 5.0.x automatically disables auto GC in all
> repositories and manages it explicitly, and 5.1.x fully removes use of
> "git gc" in favor of running relevant plumbing commands directly.

That's the part that irks me. This shouldn't be necessary - git itself
should make sure auto GC isn't run in parallel. Now I probably can't
evaluate whether a git upgrade would fix this, but given that you
are going the do-gc-ourselves route I suppose it wouldn't.

...
> Upgrading to 5.x can be a bit of an undertaking, since the major
> version brings API changes,

The upgrade is on my todo list, but there are plugins that don't
appear to be ready for 5.0, notable the jenkins one.

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800

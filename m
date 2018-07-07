Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5BB81F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 23:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754335AbeGGXEc (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 19:04:32 -0400
Received: from mxin.vub.ac.be ([134.184.129.114]:46511 "EHLO mxin.vub.ac.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754295AbeGGXEb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 19:04:31 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Jul 2018 19:04:31 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HsAQDIQ0Fb/wsxuIZbGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYUYEiiDM4kqjVyXLAsrAYRAAoJPOBQBAgEBAgEBAgICaSiFOQEFOj8?=
 =?us-ascii?q?QCxgJJQ8FKCEThQgDFas+iEaBOopEP4QeglaCBAEBg1CCJAKZTwmPGYgShVaSE?=
 =?us-ascii?q?IFYIoFSTSAYgySQVD0wegEBjGeCOQEB?=
X-IPAS-Result: =?us-ascii?q?A2HsAQDIQ0Fb/wsxuIZbGgEBAQEBAgEBAQEIAQEBAYUYEii?=
 =?us-ascii?q?DM4kqjVyXLAsrAYRAAoJPOBQBAgEBAgEBAgICaSiFOQEFOj8QCxgJJQ8FKCETh?=
 =?us-ascii?q?QgDFas+iEaBOopEP4QeglaCBAEBg1CCJAKZTwmPGYgShVaSEIFYIoFSTSAYgyS?=
 =?us-ascii?q?QVD0wegEBjGeCOQEB?=
Received: from igwe11.vub.ac.be (HELO igwe.rave.org) ([134.184.49.11])
  by smtp.vub.ac.be with ESMTP/TLS/AES128-GCM-SHA256; 08 Jul 2018 00:54:45 +0200
Received: from kgybels by igwe.rave.org with local (Exim 4.84_2)
        (envelope-from <kgybels@infogroep.be>)
        id 1fbw6H-0002Xw-3D; Sun, 08 Jul 2018 00:54:45 +0200
Date:   Sun, 8 Jul 2018 00:54:45 +0200
From:   Kim Gybels <kgybels@infogroep.be>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Subject: Re: What's (not) cooking
Message-ID: <20180707225445.GA6152@infogroep.be>
References: <xmqqlgaogeff.fsf@gitster-ct.c.googlers.com>
 <CABPp-BFs1gYzBY5+QrrLEB5kJTaierSGDnYWs=5HKRcPksx9cw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1807071411090.75@tvgsbejvaqbjf.bet>
 <CABPp-BHRE5ygBaXEkrmB_2-YKhq2Mr_Hr9Mg4PbUK_8-EmYU+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHRE5ygBaXEkrmB_2-YKhq2Mr_Hr9Mg4PbUK_8-EmYU+Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On (07/07/18 08:34), Elijah Newren wrote:
> Hi Dscho,
> 
> On Sat, Jul 7, 2018 at 5:11 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi Elijah,
> >
> > On Fri, 6 Jul 2018, Elijah Newren wrote:
> >
> >> On Fri, Jul 6, 2018 at 3:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> > I'll be pushing out the integration branches with some updates, but
> >> > there is no change in 'next' and below.  The following topics I gave
> >> > a quick look and gave them topic branches, but I had trouble merging
> >> > them in 'pu' and making them work correctly or pass the tests, so
> >> > they are not part of 'pu' in today's pushout.
> >> >
> >> >     pk/rebase-in-c
> >> >     en/dirty-merge-fixes
> >> >     en/t6036-merge-recursive-tests
> >> >     en/t6042-insane-merge-rename-testcases
> >> >     ds/multi-pack-index
> >>
> >> It looks to me like the main problem is that pu itself has lots of
> >> test failures.  It seems to bisect down to
> >> kg/gc-auto-windows-workaround.  If I revert commit ac9d3fdbebbd ("gc
> >> --auto: clear repository before auto packing", 2018-07-04), then pu
> >> passes tests again for me.
> >
> > Is this the segmentation fault about which I just sent a mail?
> 
> Yes, this is is a gc segfault issue.  It looks like every test calling
> git gc will fail because of it, I even saw a "nothing to pack" message
> or something like that followed by a segfault.

Sorry, I forgot to run the tests for v2 of my patch. I'll be more
careful in the future.

-Kim

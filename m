Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66F431FD99
	for <e@80x24.org>; Tue,  9 Aug 2016 09:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbcHIJRq (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 05:17:46 -0400
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:36082 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751454AbcHIJRp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 05:17:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 11727462F96;
	Tue,  9 Aug 2016 10:17:43 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nt7UnLkf16dS; Tue,  9 Aug 2016 10:17:41 +0100 (BST)
Received: from salo (82-70-136-246.dsl.in-addr.zen.co.uk [82.70.136.246])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id C92BF4608B3;
	Tue,  9 Aug 2016 10:17:40 +0100 (BST)
Date:	Tue, 9 Aug 2016 10:17:22 +0100
From:	Richard Ipsum <richard.ipsum@codethink.co.uk>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160809091722.GA1983@salo>
References: <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <CACsJy8DeSv_ALHR+HrViEptgYCYhXu2ZczMmhzZfHGAwZumnzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8DeSv_ALHR+HrViEptgYCYhXu2ZczMmhzZfHGAwZumnzg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 06:22:21AM +0200, Duy Nguyen wrote:
> On Tue, Aug 9, 2016 at 12:20 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> > On 08/04/2016 05:58 PM, Johannes Schindelin wrote:
> >> [...]
> >> Even requiring every contributor to register with GitHub would be too much
> >> of a limitation, I would wager.
> >> [...]
> >
> > Is it *really* so insane to consider moving collaboration on the Git
> > project to GitHub or some other similar platform?
> 
> In the very unlikely event that github is shut down, how do we get all
> review comments out of it, assuming that we will use pull requests for
> review?

For what it's worth this is exactly why I think it would be worthwhile for git
to establish a common review format, services like Github/Gitlab could then
start storing reviews and comments in the git repo rather than in a separate
sql database.

Gerrit is already doing this with notedb, which literally gives you a
git log of a review. Admittedly with Gerrit the change metadata
sits in a separate git repo, still,
this is much better than the current situation with
Github and Gitlab in my opinion.

I apologise once again if my comments here are somewhat unrelated,
but I feel there is at least some overlap, since the existence of a
common review format for git could potentially make Github/Gitlab a more
attractive option, if Github/Gitlab chose to adopt such a format.

Really I think that reviews shouldn't be stored on mailing lists,
and they shouldn't be stored in sql databases,
they should be stored in git.

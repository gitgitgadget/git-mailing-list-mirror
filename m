Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 062461F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 09:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbcHAJyR (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 05:54:17 -0400
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:60317 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbcHAJyM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 05:54:12 -0400
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 56250463585;
	Mon,  1 Aug 2016 10:54:09 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rMpL6mKms+BX; Mon,  1 Aug 2016 10:54:07 +0100 (BST)
Received: from salo (82-70-136-246.dsl.in-addr.zen.co.uk [82.70.136.246])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 6ACA846053A;
	Mon,  1 Aug 2016 10:54:07 +0100 (BST)
Date:	Mon, 1 Aug 2016 10:53:51 +0100
From:	Richard Ipsum <richard.ipsum@codethink.co.uk>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Eric Wong <e@80x24.org>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	dborowitz@google.com, Omar Jarjur <ojarjur@google.com>,
	Harry Lawrence <hazbo@gmx.com>
Subject: Re: [ANNOUNCE] git-series: track changes to a patch series over time
Message-ID: <20160801095351.GA27496@salo>
References: <20160729064055.GB25331@x>
 <20160729101011.GA3469@salo>
 <CAP8UFD12Jk0s0HPPWS3CqFcB37gzhzZZi-V0PfqrRhZO4zhHOA@mail.gmail.com>
 <20160801075554.GA22222@starla>
 <20160801085928.lw3ltdksyrjujutu@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160801085928.lw3ltdksyrjujutu@x>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 01:59:29AM -0700, Josh Triplett wrote:
> On Mon, Aug 01, 2016 at 07:55:54AM +0000, Eric Wong wrote:
[snip]
> > 
> > I'm not convinced another format/standard is needed besides the
> > email workflow we already use for git and kernel development.
> 
> Not all projects use a patches-by-email workflow, or want to.  To the
> extent that tools and projects use some other workflow, standardizing
> the format they use to store patch reviews (including per-line
> annotations, approvals, test results, etc) seems preferable to having
> each tool use its own custom format.

I concur, for better or for worse many projects have abandoned
mailing lists in favour of github, gerrit, gitlab and the like.
The problem being, with the exception of gerrit, most of these
tools store review data in sql databases, which is bad for obvious reasons.

> 
> > I also see the reliance on an after-the-fact search engine
> > (which can be tuned/replaced) as philosophically inline with
> > what git does, too, such as not having rename tracking and
> > doing delayed deltafication.
> 
> Storing review data in git doesn't mean it needs to end up in the
> history of the project itself; it can use after-the-fact annotations on
> a commit.

Exactly.

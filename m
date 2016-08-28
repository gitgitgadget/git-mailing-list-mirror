Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E12741F859
	for <e@80x24.org>; Sun, 28 Aug 2016 21:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756158AbcH1V5r (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 17:57:47 -0400
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:50814 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755862AbcH1V5q (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 17:57:46 -0400
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 686D5352191;
        Sun, 28 Aug 2016 21:57:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sky50_437e5be086d27
X-Filterd-Recvd-Size: 2388
Received: from XPS-9350.home (unknown [96.251.125.34])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun, 28 Aug 2016 21:57:43 +0000 (UTC)
Message-ID: <1472421462.26978.134.camel@perches.com>
Subject: Re: [Ksummit-discuss] checkkpatch (in)sanity ?
From:   Joe Perches <joe@perches.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        git <git@vger.kernel.org>
Cc:     "Levin, Alexander" <alexander.levin@verizon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <levinsasha928@gmail.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 28 Aug 2016 14:57:42 -0700
In-Reply-To: <1472419498.4265.16.camel@kaarsemaker.net>
References: <1472330452.26978.23.camel@perches.com>
         <20160828005636.GB19088@sasha-lappy>
         <20160828075632.GA1852@p183.telecom.by>
         <alpine.DEB.2.10.1608281152080.3321@hadrien>
         <1472413969.26978.108.camel@perches.com>
         <1472419498.4265.16.camel@kaarsemaker.net>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2016-08-28 at 23:24 +0200, Dennis Kaarsemaker wrote:

> > There are some that want an ncurses only version of git blame
> > that could use arrow-key style navigation for historical commit
> > line-ranges.
> > 
> > git gui blame kind of works, but it's not ncurses/text based.
> > git-cola kind of works too, but it's not text based either.
> > 
> > Are there other existing tools for blame history viewing?
> tig has a neat way of doing blame history digging: do a `tig blame
> filename`, select a line and hit the comma key to re-blame from the
> parent of the commit that was blamed for that line.

Thanks, of course I neglected to mention tig.

What I think some here want is the ability to view
back and forth from old to new rather than just split
the window horizontally with the commit content.

Basically, apply the patch hunks for a specific range
to see color coded changes rather just show the entire
patch in a separate view.

Sure, seeing the commit log and patch is useful.

Seeing the block of code pre and post patch for the
specific section can be more useful.


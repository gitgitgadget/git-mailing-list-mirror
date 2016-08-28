Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C95131F859
	for <e@80x24.org>; Sun, 28 Aug 2016 19:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755855AbcH1Twy (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 15:52:54 -0400
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:44722 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754218AbcH1Twx (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 28 Aug 2016 15:52:53 -0400
Received: from filter.hostedemail.com (unknown [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 5858912BA15;
        Sun, 28 Aug 2016 19:52:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brick17_8d40b60291352
X-Filterd-Recvd-Size: 2065
Received: from XPS-9350.home (unknown [96.251.125.34])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 28 Aug 2016 19:52:50 +0000 (UTC)
Message-ID: <1472413969.26978.108.camel@perches.com>
Subject: Re: [Ksummit-discuss] checkkpatch (in)sanity ?
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        git <git@vger.kernel.org>
Cc:     "Levin, Alexander" <alexander.levin@verizon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <levinsasha928@gmail.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 28 Aug 2016 12:52:49 -0700
In-Reply-To: <alpine.DEB.2.10.1608281152080.3321@hadrien>
References: <1472330452.26978.23.camel@perches.com>
         <20160828005636.GB19088@sasha-lappy>
         <20160828075632.GA1852@p183.telecom.by>
         <alpine.DEB.2.10.1608281152080.3321@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2016-08-28 at 11:59 +0200, Julia Lawall wrote:
> On Sun, 28 Aug 2016, Alexey Dobriyan wrote:
[]
> > The problem is that c-h.pl generates noise in the commit history and
> > makes git-blame less useful than it can be.
> 
> Could it be that this is a problem with git blame, rather than with
> checkpatch?  Last year there was a discussion on this list about how there
> is an option to git blame that will cause it to step through the history,
> and not show only the most recent patch that has modified a given line.

It is more or less an ease-of-use limitation of git blame.

There are some that want an ncurses only version of git blame
that could
use arrow-key style navigation for historical commit
line-ranges.

git gui blame kind of works, but it's not ncurses/text based.
git-cola kind of works too, but it's not text based either.

Are there other existing tools for blame history viewing?

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 628461FD99
	for <e@80x24.org>; Sun, 28 Aug 2016 09:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755292AbcH1Jts (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Aug 2016 05:49:48 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40632 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755236AbcH1Jtr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Aug 2016 05:49:47 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7A5C01FD99;
        Sun, 28 Aug 2016 09:49:46 +0000 (UTC)
Date:   Sun, 28 Aug 2016 09:49:46 +0000
From:   Eric Wong <e@80x24.org>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Doug Rathbone <doug@dougrathbone.com>,
        David Bainbridge <david.bainbridge@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC] Proposed questions for "Git User's Survey 2016"
Message-ID: <20160828094946.GA11722@dcvr>
References: <91a2ffbe-a73b-fbb9-96da-9aea4d439e5a@gmail.com>
 <20160826061500.GA22213@dcvr>
 <6d171c23-65f6-5f67-7d80-051f2dfe8678@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d171c23-65f6-5f67-7d80-051f2dfe8678@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> wrote:
> W dniu 26.08.2016 o 08:15, Eric Wong pisze:
> 
> > Not directly-related to the survey questions, but can you ensure
> > it's accessible to folks without JavaScript/graphics, and
> > perhaps also ensure it is on a host that is Tor-friendly?
> 
> I plan on using Survs.com (where we have Premium account for free,
> thanks to Survs admins).  It has good online analysis tools, allows
> to download results in easy parseable format[1], and has support
> for multiple channels.
> 
> [1]: https://github.com/jnareb/GitSurvey-scripts
> 
> 
> It is possible to have a channel without JavaScript and without
> cookies (anonymous), at the cost of having to fill the survey
> in one go (without cookies and JavaScript you cannot go back
> to fill more questions, or change your mind about answers).
> The main page of survey would have a link to JavaScript-free
> version, and all announcements (by me) would include it.

Thanks.

> There would be no graphics that are not purely optional
> (decorative); probably there would be just a logo.
> 
> I'm not sure how Tor-friendly is this host.

I was able to get to Survs.com using Tor (maybe it was just luck
with a new exit).

> > Graphics setups often require non-Free firmware or drivers for
> > acceptable performance; and there are also visually-impaired
> > users who will need screen readers or Braille.
> 
> A question: would it be better to have the whole survey one one
> large page, or have it split into pages (with fever questions
> per page)?

I prefer single. One could get one page, take take time and let the
connection drop/fail, and send it over all in one go.  With multiple
pages, one would have to reconnect for every POST.

(fittingly, my connection failed writing this message a few
 days ago and I only got back around to it)

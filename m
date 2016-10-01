Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF8020987
	for <e@80x24.org>; Sat,  1 Oct 2016 20:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbcJAUN3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 16:13:29 -0400
Received: from ikke.info ([178.21.113.177]:33804 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751025AbcJAUN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 16:13:27 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id A3DCC4400BF; Sat,  1 Oct 2016 22:13:25 +0200 (CEST)
Date:   Sat, 1 Oct 2016 22:13:25 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Konstantin Khomoutov <kostix+git@007spb.ru>, git@vger.kernel.org,
        Santiago Perez De Rosso <sperezde@csail.mit.edu>,
        Daniel Jackson <dnj@csail.mit.edu>,
        Greg Wilson <gvwilson@third-bit.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@mat.umk.pl>
Subject: Re: "Purposes, Concepts,Misfits, and a Redesign of Git" (a research
 paper)
Message-ID: <20161001201325.GA29588@ikke.info>
References: <20160930191413.002049b94b3908b15881b77f@domain007.com>
 <481910fd-5a5f-ffc6-b98c-61d48b4a2e49@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <481910fd-5a5f-ffc6-b98c-61d48b4a2e49@gmail.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 01, 2016 at 12:24:57AM +0200, Jakub Narębski wrote:
> 
> | 7.2.1 Discussion
> [...]
> | There could be other use cases for the
> | staging area that Gitless doesn’t handle well but we expect
> | these to be fairly infrequent.
> 
> Like handling merge conflict...??? Infrequent doesn't mean
> unimportant.
> 

For me the most important thing is that the lack of staging area leads
on commits that have no clear goal, people just commit everything they
have changed at some point, as a sort of checkpoint.

Although lots of people still do this with git currently, they don't
even have the possibility[1] to improve on this.

This makes history and features like git bisect less useful.


[1] At most they can specify the files they want to commit, but this is
still a very crude way to group together changes.

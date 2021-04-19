Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1267FC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 13:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14FC61245
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 13:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241944AbhDSNh1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 09:37:27 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52570 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241641AbhDSNge (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 09:36:34 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13JDZgVk022427
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 09:35:43 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C083F15C3B0D; Mon, 19 Apr 2021 09:35:42 -0400 (EDT)
Date:   Mon, 19 Apr 2021 09:35:42 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Wong <e@80x24.org>
Cc:     Son Luong Ngoc <sluongng@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: Pain points in Git's patch flow
Message-ID: <YH2HLtZY/KjrYrng@mit.edu>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <YHhfsqfTJ9NzRwS1@C02YX140LVDN.corpad.adbkng.com>
 <20210419025754.GA26065@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419025754.GA26065@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 02:57:54AM +0000, Eric Wong wrote:
> >   But for folks who don't have a dev environment ready at hand (new
> >   comers, during travel with only phone access), it would be nice to
> >   have a way to run tests without a dev environment.
> 
> Fwiw, the GCC Farm project gives ssh accounts for all free
> software contributors, not just gcc hackers: https://cfarm.tetaneutral.net
> Perhaps there's other similar services, too.
> 
> Slow down and enjoy travel :)  There's very little in free
> software urgent enough to require constant attention.  Email is
> well-suited for asynchronous work, and nobody should expect
> instant replies.  The always-on nature of the modern Internet
> and smartphones increases stress and dangerous situations; so I
> hope free software hackers aren't contributing to that.

FWIW, I find the disconnected, e-mail based workflow using a
command-line interface to be *ideal* for working while travelling on
an airplane.  I'm mostly disconnected from the internet, because the
airplane wifi is so slow that you *really* don't want to use a
web-based interface, but I can use offlineimap to sync my e-mail onto
my laptop, and using the command-line interface and the lack of
distractions is great since you really can't surf the web on the
gogoonline's pathetically slow 'net access.

This also means I have an excuse to work on open source projects which
are using e-mail and off-line git, as opposed to $WORK which mandates
the use of gerrit.  :-)

(All of the above applies pre-pandemic, of course.  I've been working
from home and not travelling for the past year+, sigh.)

     	      	  	     	     	  - Ted

P.S.  Also, while working on the road, I find that web-based
interfaces are much more tolerable when I'm at my desk with a 40"
screen.  When I'm using a 13" laptop screen, I much prefer CLI
interfaces.  YMMV, of course.

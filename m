Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91AC61FBB0
	for <e@80x24.org>; Sun, 23 Oct 2016 12:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbcJWMuj (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 08:50:39 -0400
Received: from fw.sigpipe.cz ([213.192.55.98]:1492 "EHLO isis.sigpipe.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751963AbcJWMui (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 08:50:38 -0400
Received: by isis.sigpipe.cz (Postfix, from userid 1001)
        id 37D611130A4C3A; Sun, 23 Oct 2016 14:50:35 +0200 (CEST)
Date:   Sun, 23 Oct 2016 14:50:35 +0200
From:   Roman Neuhauser <neuhauser@sigpipe.cz>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org
Subject: Re: git clone --bare --origin incompatible?
Message-ID: <20161023125035.GB1486@isis.sigpipe.cz>
References: <20161023110338.GA1486@isis.sigpipe.cz>
 <87y41f8czg.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y41f8czg.fsf@linux-m68k.org>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# schwab@linux-m68k.org / 2016-10-23 14:29:55 +0200:
> On Okt 23 2016, Roman Neuhauser <neuhauser@sigpipe.cz> wrote:
> 
> > what is the reason clone --bare prohibits --origin?
> >
> >   % git clone --bare -o fubar anything anywhere
> >   fatal: --bare and --origin fubar options are incompatible.
> 
> Since a bare clone maps remote branches directly to local branches,
> without any remote-tracking branches, --origin doesn't make sense.

is it going to break something though?  i can still go and rename
the remote in the bare repo's config file afterwards.

-- 
roman

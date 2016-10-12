Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D6BE209F6
	for <e@80x24.org>; Wed, 12 Oct 2016 19:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755936AbcJLTfb (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 15:35:31 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:34290 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932307AbcJLTfa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 15:35:30 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
        id A40131C0198; Wed, 12 Oct 2016 21:33:36 +0200 (CEST)
Date:   Wed, 12 Oct 2016 21:33:36 +0200
From:   Stepan Kasal <kasal@ucw.cz>
To:     Jeff King <peff@peff.net>
Cc:     John Keeping <john@keeping.me.uk>, git@vger.kernel.org
Subject: Re: Bug with git merge-base and a packed ref
Message-ID: <20161012193336.GA23072@ucw.cz>
References: <20161012103716.GA31533@ucw.cz>
 <20161012163209.oadmm7xsmm7oeumr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161012163209.oadmm7xsmm7oeumr@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Wed, Oct 12, 2016 at 12:32:09PM -0400, Jeff King wrote:
> The --fork-point option looks in the reflog [...]
> On Wed, Oct 12, 2016 at 12:37:16PM +0200, Stepan Kasal wrote:
> > Could you please fix merge-base so that it understands packed refs?

I bet you nailed it; nothing with packed refs.
Thanks for correcting me.

Stepan

Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0E6C1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 16:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbcGKQuD (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 12:50:03 -0400
Received: from imap.thunk.org ([74.207.234.97]:46296 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753613AbcGKQuD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 12:50:03 -0400
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=8B8sXBfqx9q7LBEgp7jgXGTs+hE7bhM2rEG7bkaC+ug=;
	b=lcK4hahwahcDGwDdwNGco1efbWlilcCSL9qft9cTXCy33gcYn8QAV2UlEpsOAcErmXtvB04sOuedA4SPacrFApXdir5zJT8khg6/GBcxMzIXBGF4S0a+oBkZh+6UqXGf3//HSEz/UchMbFbZo7MVdq9e3enak9zZ5fEEWWTrkHg=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84_2)
	(envelope-from <tytso@thunk.org>)
	id 1bMePB-0007ZZ-PJ; Mon, 11 Jul 2016 16:50:01 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 075A0828F74; Mon, 11 Jul 2016 12:50:01 -0400 (EDT)
Date:	Mon, 11 Jul 2016 12:50:00 -0400
From:	Theodore Ts'o <tytso@mit.edu>
To:	Jeff King <peff@peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] date: document and test "raw-local" mode
Message-ID: <20160711165000.GD3890@thunk.org>
References: <20160711050201.GA18031@sigill.intra.peff.net>
 <20160711050617.GD32514@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160711050617.GD32514@sigill.intra.peff.net>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 11, 2016 at 01:06:17AM -0400, Jeff King wrote:
> 
> The documentation claims that "raw-local" does not work. It
> does, but the end result is rather subtle. Let's describe it
> in better detail, and test to make sure it works (namely,
> the epoch time doesn't change, but the zone does).

Maybe add an editorial statement that in most cases this isn't
particularly useful?  Documenting raw-local implies that someone might
want to consider using it, and it's not clear to me folks should ever
try --- they're more likely to confuse themselves more than anything
else.

					- Ted

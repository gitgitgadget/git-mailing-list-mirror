Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EEC92022D
	for <e@80x24.org>; Fri,  4 Nov 2016 16:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936511AbcKDQ4h (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 12:56:37 -0400
Received: from sym2.noone.org ([178.63.92.236]:37298 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936456AbcKDQ4g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 12:56:36 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 3t9SRS624pzQWbr; Fri,  4 Nov 2016 17:47:00 +0100 (CET)
Date:   Fri, 4 Nov 2016 17:46:58 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] diffcore-delta: remove unused parameter to
 diffcore_count_changes()
Message-ID: <20161104164658.GB819@distanz.ch>
References: <20161104102436.23892-1-tklauser@distanz.ch>
 <20161104163714.zwzfbmrklzwuaw6u@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161104163714.zwzfbmrklzwuaw6u@sigill.intra.peff.net>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2016-11-04 at 17:37:14 +0100, Jeff King <peff@peff.net> wrote:
> On Fri, Nov 04, 2016 at 11:24:36AM +0100, Tobias Klauser wrote:
> 
> > The delta_limit parameter to diffcore_count_changes() has been unused
> > since commit c06c79667c95 ("diffcore-rename: somewhat optimized.").
> > Remove the parameter and adjust all callers.
> 
> Sounds like a good idea to get rid of an unused parameter, but I think
> this went away in ba23bbc8e (diffcore-delta: make change counter to byte
> oriented again., 2006-03-04).

Ugh, I must have fat-fingered the commit id. Will update the description
accordingly for v2.

Thanks!
Tobias

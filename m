Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8714C1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 02:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbeJCJEf (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 05:04:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:39398 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726407AbeJCJEf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 05:04:35 -0400
Received: (qmail 28645 invoked by uid 109); 3 Oct 2018 02:18:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Oct 2018 02:18:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8740 invoked by uid 111); 3 Oct 2018 02:17:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Oct 2018 22:17:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2018 22:18:17 -0400
Date:   Tue, 2 Oct 2018 22:18:17 -0400
From:   Jeff King <peff@peff.net>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 3/3] git-help.txt: document "git help cmd" vs "git cmd
 --help" for aliases
Message-ID: <20181003021816.GC20553@sigill.intra.peff.net>
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <20181001112107.28956-1-rv@rasmusvillemoes.dk>
 <20181001112107.28956-3-rv@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181001112107.28956-3-rv@rasmusvillemoes.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 01, 2018 at 01:21:07PM +0200, Rasmus Villemoes wrote:

> This documents the existing behaviour of "git help cmd" when cmd is an
> alias, as well as providing a hint to use the "git cmd --help" form to
> be taken directly to the man page for the aliased command.

Good idea.

> diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
> index 83d25d825a..37e85868fd 100644
> --- a/Documentation/git-help.txt
> +++ b/Documentation/git-help.txt
> @@ -29,6 +29,10 @@ guide is brought up. The 'man' program is used by default for this
>  purpose, but this can be overridden by other options or configuration
>  variables.
>  
> +If an alias is given, git prints a note explaining what it is an alias
> +for on standard output. To get the manual page for the aliased
> +command, use `git COMMAND --help`.

Funny English: "what it is an...". Maybe:

  If an alias is given, git shows the definition of the alias on
  standard output. To get the manual page...


-Peff

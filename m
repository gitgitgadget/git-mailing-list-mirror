Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0D9920437
	for <e@80x24.org>; Fri, 13 Oct 2017 16:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751586AbdJMQj0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 12:39:26 -0400
Received: from ikke.info ([178.21.113.177]:41758 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751138AbdJMQjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 12:39:25 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id E5BFA4403A1; Fri, 13 Oct 2017 18:39:23 +0200 (CEST)
Date:   Fri, 13 Oct 2017 18:39:23 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, J Wyman <jwyman@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] for-each-ref: let upstream/push optionally remote
 ref name
Message-ID: <20171013163923.GA5598@alpha.vpn.ikke.info>
References: <cover.1506952571.git.johannes.schindelin@gmx.de>
 <cover.1507205895.git.johannes.schindelin@gmx.de>
 <7da6c7e2563d14cb7cd7ff2637c79c51896a9788.1507205895.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7da6c7e2563d14cb7cd7ff2637c79c51896a9788.1507205895.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 05, 2017 at 02:19:15PM +0200, Johannes Schindelin wrote:
> From: J Wyman <jwyman@microsoft.com>
> [..] 
> 
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 39f50bd53eb..22767025850 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -142,8 +142,9 @@ upstream::
>  	encountered. Append `:track,nobracket` to show tracking
>  	information without brackets (i.e "ahead N, behind M").
>  +
> -Also respects `:remotename` to state the name of the *remote* instead of
> -the ref.
> +Also respects `:remotename` to state the name of the *remote* instead
> +of the ref, and `:remoteref` to state the name of the *reference* as
> +locally known by the remote.

What does "locally known by the remote" mean in this sentence?

>  +
>  Has no effect if the ref does not have tracking information associated
>  with it.  All the options apart from `nobracket` are mutually exclusive,
> @@ -152,9 +153,9 @@ but if used together the last option is selected.

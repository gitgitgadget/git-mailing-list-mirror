Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 509A01F43C
	for <e@80x24.org>; Sat, 11 Nov 2017 13:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750784AbdKKNoc (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Nov 2017 08:44:32 -0500
Received: from ikke.info ([178.21.113.177]:43610 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750735AbdKKNob (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Nov 2017 08:44:31 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 6D29B44080B; Sat, 11 Nov 2017 14:44:30 +0100 (CET)
Date:   Sat, 11 Nov 2017 14:44:30 +0100
From:   Kevin Daudt <me@ikke.info>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] bisect: clarify that one can select multiple good commits
Message-ID: <20171111134430.GA30635@alpha.vpn.ikke.info>
References: <alpine.LFD.2.21.1711110820370.8941@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1711110820370.8941@localhost.localdomain>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 11, 2017 at 08:26:00AM -0500, Robert P. J. Day wrote:
> 
> Current man page for "bisect" is inconsistent explaining the fact that
> "git bisect" takes precisely one bad commit, but one or more good
> commits, so tweak the man page in a few places to make that clear.
> 
> rday
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
>   i also exercised literary license to reword an example to look for a
> commit where performance was *degraded* rather than improved, since i
> think that's the sort of thing that people would be more interested
> in.
> 
>  In fact, `git bisect` can be used to find the commit that changed
>  *any* property of your project; e.g., the commit that fixed a bug, or
> -the commit that caused a benchmark's performance to improve. To
> +the commit that caused a benchmark's performance to degrade. To
>  support this more general usage, the terms "old" and "new" can be used
>  in place of "good" and "bad", or you can choose your own terms. See
>  section "Alternate terms" below for more information.
> @@ -58,7 +58,7 @@ $ git bisect bad                 # Current version is bad
>  $ git bisect good v2.6.13-rc2    # v2.6.13-rc2 is known to be good
>  ------------------------------------------------
> 

I think this example was meant to suggest that it's not only possible to
find bad things (bugs, performance degradations), but also the opposite
(when was a bug fixed, what caused the performance to change). 

So I think it's good to keep the example like it is.

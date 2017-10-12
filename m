Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB3020467
	for <e@80x24.org>; Thu, 12 Oct 2017 10:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753036AbdJLKpB (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 06:45:01 -0400
Received: from ikke.info ([178.21.113.177]:48560 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755880AbdJLKpB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 06:45:01 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 9202E4403A1; Thu, 12 Oct 2017 12:44:59 +0200 (CEST)
Date:   Thu, 12 Oct 2017 12:44:59 +0200
From:   Kevin Daudt <me@ikke.info>
To:     "W. Trevor King" <wking@tremily.us>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/merge-options.txt: Add -S/--gpg-sign
Message-ID: <20171012104459.GA31559@alpha.vpn.ikke.info>
References: <406769a31421cb26a0e1bcf6e15bcf7ab48617c8.1507798709.git.wking@tremily.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406769a31421cb26a0e1bcf6e15bcf7ab48617c8.1507798709.git.wking@tremily.us>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 12, 2017 at 02:02:17AM -0700, W. Trevor King wrote:
> Pull has supported these since ea230d8 (pull: add the --gpg-sign
> option, 2014-02-10).  Insert in long-option alphabetical order
> following 7c85d274 (Documentation/merge-options.txt: order options in
> alphabetical groups, 2009-10-22).
> 
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
> This patch is based on maint.  It will have trivial conflicts with the
> --signoff docs which landed in 14d01b4f07 (merge: add a --signoff
> flag, 2017-07-04, v2.15.0-rc0~138^2).
> 
>  Documentation/git-merge.txt     | 6 ------
>  Documentation/merge-options.txt | 6 ++++++
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index f90faf7aaa..1d97a17904 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -64,12 +64,6 @@ OPTIONS
>  -------
>  include::merge-options.txt[]
>  
> --S[<keyid>]::
> ---gpg-sign[=<keyid>]::

Shouldn't the options self be removed here too, not just the
explanation?

> -	GPG-sign the resulting merge commit. The `keyid` argument is
> -	optional and defaults to the committer identity; if specified,
> -	it must be stuck to the option without a space.
> -
>  -m <msg>::
>  	Set the commit message to be used for the merge commit (in
>  	case one is created).
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 5b4a62e936..6d85a76872 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -42,6 +42,12 @@ set to `no` at the beginning of them.
>  	current `HEAD` is already up-to-date or the merge can be
>  	resolved as a fast-forward.
>  
> +-S[<keyid>]::
> +--gpg-sign[=<keyid>]::
> +	GPG-sign the resulting merge commit. The `keyid` argument is
> +	optional and defaults to the committer identity; if specified,
> +	it must be stuck to the option without a space.
> +
>  --log[=<n>]::
>  --no-log::
>  	In addition to branch names, populate the log message with
> -- 
> 2.13.6
> 

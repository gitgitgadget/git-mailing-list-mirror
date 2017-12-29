Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C7041F406
	for <e@80x24.org>; Fri, 29 Dec 2017 06:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbdL2GAU (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 01:00:20 -0500
Received: from ikke.info ([178.21.113.177]:60740 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750836AbdL2GAU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 01:00:20 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 6818044079B; Fri, 29 Dec 2017 07:00:16 +0100 (CET)
Date:   Fri, 29 Dec 2017 07:00:16 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Keith Smiley <k@keith.so>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Add shell completion for git remote rm
Message-ID: <20171229060016.GA25718@alpha.vpn.ikke.info>
References: <01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a106f37f1d9-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01020160a0004473-277c3d7c-4e3b-4c50-9d44-4a106f37f1d9-000000@eu-west-1.amazonses.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 29, 2017 at 02:01:00AM +0000, Keith Smiley wrote:
> From: Keith Smiley <keithbsmiley@gmail.com>
> 
> Previously git remote rm did not complete your list of removes as remove
> does.

Your signed-off-by[1] is missing, could you please add that?

[1]:
https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L278

> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 3683c772c5586..3e9044087e6ba 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2665,7 +2665,7 @@ _git_config ()
>  _git_remote ()
>  {
>  	local subcommands="
> -		add rename remove set-head set-branches
> +		add rename remove rm set-head set-branches
>  		get-url set-url show prune update
>  		"
>  	local subcommand="$(__git_find_on_cmdline "$subcommands")"
> 
> --
> https://github.com/git/git/pull/448

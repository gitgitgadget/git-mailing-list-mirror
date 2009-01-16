From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH resend] bash completion: add 'rename' subcommand to
	git-remote
Date: Fri, 16 Jan 2009 14:12:03 -0800
Message-ID: <20090116221203.GP10179@spearce.org>
References: <200901162254.58300.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 16 23:13:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNwwT-0004Jr-Iv
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 23:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764472AbZAPWMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 17:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763857AbZAPWMG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 17:12:06 -0500
Received: from george.spearce.org ([209.20.77.23]:57170 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763318AbZAPWMF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 17:12:05 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id AE9B638210; Fri, 16 Jan 2009 22:12:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200901162254.58300.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106001>

Markus Heidelberg <markus.heidelberg@web.de> wrote:
> 
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

> 	I've just accidently read in the completion file itself, that
> 	Shawn is the maintainer, so I give it a third try. The first two
> 	haven't been sent to him.

Sorry, I must have missed the other two attempts.  :-)

 
>  contrib/completion/git-completion.bash |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 049ded0..6623344 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1384,7 +1384,7 @@ _git_config ()
>  
>  _git_remote ()
>  {
> -	local subcommands="add rm show prune update"
> +	local subcommands="add rename rm show prune update"
>  	local subcommand="$(__git_find_subcommand "$subcommands")"
>  	if [ -z "$subcommand" ]; then
>  		__gitcomp "$subcommands"
> @@ -1392,7 +1392,7 @@ _git_remote ()
>  	fi
>  
>  	case "$subcommand" in
> -	rm|show|prune)
> +	rename|rm|show|prune)
>  		__gitcomp "$(__git_remotes)"
>  		;;
>  	update)
> -- 
> 1.6.1.35.g0c23
> 

-- 
Shawn.

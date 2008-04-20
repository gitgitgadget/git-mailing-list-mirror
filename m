From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] completion: allow 'git remote' subcommand completion
Date: Sun, 20 Apr 2008 15:22:59 -0400
Message-ID: <20080420192259.GI29771@spearce.org>
References: <1208712525-1747-1-git-send-email-dpmcgee@gmail.com> <1208712525-1747-2-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 21:23:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnf8g-0007pW-Po
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 21:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042AbYDTTXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2008 15:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756020AbYDTTXD
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 15:23:03 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47808 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755890AbYDTTXD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 15:23:03 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jnf7k-0006qk-Ns; Sun, 20 Apr 2008 15:22:52 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 247D920FBAE; Sun, 20 Apr 2008 15:22:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1208712525-1747-2-git-send-email-dpmcgee@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79978>

Dan McGee <dpmcgee@gmail.com> wrote:
> After typing 'git prune ', the subcommand options were not shown. Fix it.

That's not really what this change does.  It fixes the subcommands
for 'git remote ', which were broken without this __gitcomp call
in this location.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

but I'd like to see a more accurate commit message for this fix.
 
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> ---
>  contrib/completion/git-completion.bash |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 3f78630..6012047 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1052,6 +1052,7 @@ _git_remote ()
>  	local subcommands="add rm show prune update"
>  	local subcommand="$(__git_find_subcommand "$subcommands")"
>  	if [ -z "$subcommand" ]; then
> +		__gitcomp "$subcommands"
>  		return
>  	fi
>  
> -- 
> 1.5.5
> 

-- 
Shawn.
